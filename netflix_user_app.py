"""
Team Netflix - customer-facing app.

Front page is Sign in / Create account. Once logged in you can:
  * browse every film and TV show (and mark them watched / liked)
  * see your Watched list and your Liked list
  * add, edit and delete profiles on your account

Setup:
    pip install flask
    python netflix_user_app.py
Then open http://127.0.0.1:5001   (the admin app keeps using port 5000)

Reads the same team_netflix.db as netflix_app.py, so accounts are shared.
"""
import hmac
import os
import sqlite3
from datetime import datetime
from functools import wraps
from pathlib import Path

from flask import (Flask, abort, flash, g, redirect, render_template, request,
                   session, url_for)
from jinja2 import DictLoader
from werkzeug.security import check_password_hash, generate_password_hash

DB_PATH = Path(os.environ.get("NETFLIX_DB",
                              Path(__file__).parent / "team_netflix.db"))
MAX_PROFILES = 5
DEFAULT_AVATARS = ["avatar_red.png", "avatar_blue.png", "avatar_green.png",
                   "avatar_yellow.png", "avatar_panda.png"]

app = Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY", "change-me")

# What differs between films and TV shows
KINDS = {
    "film": {"table": "film", "col": "film_id", "label": "Film",
             "actors": "film_actors", "directors": "film_directors"},
    "tv": {"table": "tv_show", "col": "tv_show_id", "label": "TV Show",
           "actors": "tv_actors", "directors": "tv_directors"},
}
# The two per-account flag tables
FLAGS = {
    "watched": {"table": "watched", "col": "is_watched"},
    "liked": {"table": "liked", "col": "is_liked"},
}


# ---------- database helpers ----------
def get_db():
    if "db" not in g:
        g.db = sqlite3.connect(DB_PATH)
        g.db.row_factory = sqlite3.Row
    return g.db


@app.teardown_appcontext
def close_db(_exc=None):
    db = g.pop("db", None)
    if db is not None:
        db.close()


def ensure_schema():
    """Add the account.is_admin column the first time (existing accounts become non-admin)."""
    con = sqlite3.connect(DB_PATH)
    try:
        cols = [r[1] for r in con.execute("PRAGMA table_info(account)")]
        if "is_admin" not in cols:
            con.execute("ALTER TABLE account ADD COLUMN is_admin BOOLEAN NOT NULL DEFAULT 0")
            con.commit()
        # make sure film / tv_show have a poster column (filled by fetch_posters.py)
        for table in ("film", "tv_show"):
            tcols = [r[1] for r in con.execute(f'PRAGMA table_info("{table}")')]
            if tcols and "poster" not in tcols:
                con.execute(f'ALTER TABLE "{table}" ADD COLUMN poster TEXT')
                con.commit()
    finally:
        con.close()


if DB_PATH.exists():
    ensure_schema()


def next_id(db, table, col):
    """These tables use plain INT primary keys, so assign MAX + 1 ourselves."""
    return db.execute(
        f'SELECT COALESCE(MAX("{col}"), 0) + 1 FROM "{table}"').fetchone()[0]


def catalog(db, account_id, kind):
    """Every film or show, with this account's watched/liked flags and credits."""
    k = KINDS[kind]
    sql = f"""
        SELECT t.id, t.title, t.genre, t.duration, t.poster,
               EXISTS(SELECT 1 FROM watched w WHERE w.account_id = ?
                      AND w.{k['col']} = t.id AND w.is_watched = 1) AS watched,
               EXISTS(SELECT 1 FROM liked l WHERE l.account_id = ?
                      AND l.{k['col']} = t.id AND l.is_liked = 1) AS liked,
               (SELECT group_concat(a.first_name || ' ' || a.last_name, ', ')
                  FROM {k['actors']} x JOIN actor a ON a.id = x.actor_id
                 WHERE x.{k['col']} = t.id) AS actors,
               (SELECT group_concat(d.first_name || ' ' || d.last_name, ', ')
                  FROM {k['directors']} y JOIN director d ON d.id = y.director_id
                 WHERE y.{k['col']} = t.id) AS directors
        FROM {k['table']} t
        ORDER BY t.title
    """
    return db.execute(sql, (account_id, account_id)).fetchall()


def avatar_choices(db):
    used = [r[0] for r in db.execute(
        "SELECT DISTINCT profile_picture FROM profile "
        "WHERE profile_picture IS NOT NULL AND profile_picture != ''")]
    return sorted(set(used) | set(DEFAULT_AVATARS))


@app.template_global()
def avatar_hue(name):
    return sum(ord(c) for c in (name or "")) * 7 % 360


# ---------- auth ----------
def verify_password(stored, given):
    """Accepts hashed passwords and the plain-text ones already in the database."""
    stored = stored or ""
    if stored.startswith(("scrypt:", "pbkdf2:")):
        return check_password_hash(stored, given)
    return hmac.compare_digest(stored.encode(), given.encode())


@app.before_request
def load_account():
    g.account = None
    account_id = session.get("account_id")
    if account_id is not None:
        g.account = get_db().execute(
            "SELECT id, email, is_admin FROM account WHERE id = ?", (account_id,)).fetchone()
        if g.account is None:
            session.clear()


def login_required(view):
    @wraps(view)
    def wrapped(*args, **kwargs):
        if g.account is None:
            flash("Please sign in first.")
            return redirect(url_for("home"))
        return view(*args, **kwargs)
    return wrapped


def safe_next(target, fallback):
    if target and target.startswith("/") and not target.startswith(("//", "/\\")):
        return target
    return fallback


# ---------- front page: sign in / create account ----------
@app.route("/")
def home():
    if g.account:
        return redirect(url_for("browse"))
    plans = get_db().execute(
        "SELECT id, subscription_type, subscription_price FROM subscription ORDER BY id"
    ).fetchall()
    return render_template("home.html", plans=plans, avatars=avatar_choices(get_db()))


@app.route("/login", methods=["POST"])
def login():
    db = get_db()
    email = request.form.get("email", "").strip().lower()
    password = request.form.get("password", "")
    row = db.execute("SELECT id, password FROM account WHERE lower(email) = ?",
                     (email,)).fetchone()
    if row is None or not verify_password(row["password"], password):
        flash("Incorrect email or password.")
        return redirect(url_for("home"))
    if not (row["password"] or "").startswith(("scrypt:", "pbkdf2:")):
        # Quietly upgrade an old plain-text password to a hash
        db.execute("UPDATE account SET password = ? WHERE id = ?",
                   (generate_password_hash(password, method="pbkdf2:sha256"), row["id"]))
        db.commit()
    session.clear()
    session["account_id"] = row["id"]
    return redirect(url_for("browse"))


@app.route("/register", methods=["POST"])
def register():
    db = get_db()
    f = request.form
    email = f.get("email", "").strip().lower()
    password = f.get("password", "")
    phone = f.get("phone_number", "").strip()
    plan = f.get("subscription_id", "")
    profile_name = f.get("profile_name", "").strip() or email.split("@")[0]

    error = None
    if "@" not in email or "." not in email.split("@")[-1]:
        error = "Please enter a valid email address."
    elif len(password) < 6:
        error = "Password must be at least 6 characters."
    elif password != f.get("confirm", ""):
        error = "Passwords do not match."
    elif not plan.isdigit() or db.execute(
            "SELECT 1 FROM subscription WHERE id = ?", (plan,)).fetchone() is None:
        error = "Please choose a subscription plan."
    elif db.execute("SELECT 1 FROM account WHERE lower(email) = ?", (email,)).fetchone():
        error = "An account with that email already exists."
    if error:
        flash(error)
        return redirect(url_for("home"))

    account_id = next_id(db, "account", "id")
    try:
        db.execute(
            "INSERT INTO account (id, email, password, phone_number, subscription_id, "
            "account_created) VALUES (?, ?, ?, ?, ?, ?)",
            (account_id, email, generate_password_hash(password, method="pbkdf2:sha256"), phone or None,
             int(plan), datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
        # Every account starts with one profile
        db.execute(
            "INSERT INTO profile (account_id, profile_id, profile_name, profile_picture, "
            "is_kid_profile) VALUES (?, ?, ?, ?, 0)",
            (account_id, next_id(db, "profile", "profile_id"), profile_name,
             DEFAULT_AVATARS[0]))
        db.commit()
    except sqlite3.Error as e:
        db.rollback()
        flash(f"Could not create account: {e}")
        return redirect(url_for("home"))

    session.clear()
    session["account_id"] = account_id
    flash("Welcome to Team Netflix! Your account is ready.", "ok")
    return redirect(url_for("browse"))


@app.route("/logout", methods=["POST"])
def logout():
    session.clear()
    return redirect(url_for("home"))


# ---------- browse + watched / liked ----------
@app.route("/browse")
@login_required
def browse():
    db = get_db()
    return render_template("browse.html", active="browse",
                           films=catalog(db, g.account["id"], "film"),
                           shows=catalog(db, g.account["id"], "tv"))


@app.route("/<which>", endpoint="flag_list")
@login_required
def flag_list(which):
    if which not in FLAGS:
        abort(404)
    db = get_db()
    films = [i for i in catalog(db, g.account["id"], "film") if i[which]]
    shows = [i for i in catalog(db, g.account["id"], "tv") if i[which]]
    return render_template("flag_list.html", active=which, which=which,
                           films=films, shows=shows)


@app.route("/toggle/<kind>/<which>/<int:item_id>", methods=["POST"])
@login_required
def toggle(kind, which, item_id):
    if kind not in KINDS or which not in FLAGS:
        abort(404)
    k, fl = KINDS[kind], FLAGS[which]
    db = get_db()
    if db.execute(f'SELECT 1 FROM "{k["table"]}" WHERE id = ?', (item_id,)).fetchone() is None:
        abort(404)

    where = f'account_id = ? AND "{k["col"]}" = ?'
    current = db.execute(
        f'SELECT 1 FROM "{fl["table"]}" WHERE {where} AND "{fl["col"]}" = 1',
        (g.account["id"], item_id)).fetchone()
    exists = db.execute(
        f'SELECT 1 FROM "{fl["table"]}" WHERE {where}',
        (g.account["id"], item_id)).fetchone()

    if exists:
        db.execute(f'UPDATE "{fl["table"]}" SET "{fl["col"]}" = ? WHERE {where}',
                   (0 if current else 1, g.account["id"], item_id))
    else:
        db.execute(
            f'INSERT INTO "{fl["table"]}" (account_id, "{fl["col"]}", "{k["col"]}") '
            f'VALUES (?, 1, ?)', (g.account["id"], item_id))
    db.commit()
    return redirect(safe_next(request.form.get("next"), url_for("browse")))


# ---------- profiles ----------
@app.route("/profiles")
@login_required
def profiles():
    rows = get_db().execute(
        "SELECT profile_id, profile_name, profile_picture, is_kid_profile "
        "FROM profile WHERE account_id = ? ORDER BY profile_id",
        (g.account["id"],)).fetchall()
    return render_template("profiles.html", active="profiles", profiles=rows,
                           can_add=len(rows) < MAX_PROFILES, max_profiles=MAX_PROFILES)


@app.route("/profiles/new", methods=["GET", "POST"], defaults={"pid": None})
@app.route("/profiles/<int:pid>/edit", methods=["GET", "POST"])
@login_required
def profile_form(pid):
    db = get_db()
    existing = None
    if pid is not None:  # only ever touch profiles that belong to the logged-in account
        existing = db.execute(
            "SELECT profile_id, profile_name, profile_picture, is_kid_profile "
            "FROM profile WHERE profile_id = ? AND account_id = ?",
            (pid, g.account["id"])).fetchone()
        if existing is None:
            abort(404)
    else:
        count = db.execute("SELECT COUNT(*) FROM profile WHERE account_id = ?",
                           (g.account["id"],)).fetchone()[0]
        if count >= MAX_PROFILES:
            flash(f"An account can have at most {MAX_PROFILES} profiles.")
            return redirect(url_for("profiles"))

    avatars = avatar_choices(db)
    if request.method == "POST":
        name = request.form.get("profile_name", "").strip()
        picture = request.form.get("profile_picture", "")
        is_kid = 1 if request.form.get("is_kid_profile") else 0
        if not name:
            flash("Profile name is required.")
        elif picture not in avatars:
            flash("Please choose an avatar.")
        else:
            if existing:
                db.execute(
                    "UPDATE profile SET profile_name = ?, profile_picture = ?, "
                    "is_kid_profile = ? WHERE profile_id = ? AND account_id = ?",
                    (name, picture, is_kid, pid, g.account["id"]))
                flash("Profile updated.", "ok")
            else:
                db.execute(
                    "INSERT INTO profile (account_id, profile_id, profile_name, "
                    "profile_picture, is_kid_profile) VALUES (?, ?, ?, ?, ?)",
                    (g.account["id"], next_id(db, "profile", "profile_id"),
                     name, picture, is_kid))
                flash("Profile added.", "ok")
            db.commit()
            return redirect(url_for("profiles"))

    return render_template("profile_form.html", active="profiles", profile=existing,
                           avatars=avatars)


@app.route("/profiles/<int:pid>/delete", methods=["POST"])
@login_required
def profile_delete(pid):
    db = get_db()
    count = db.execute("SELECT COUNT(*) FROM profile WHERE account_id = ?",
                       (g.account["id"],)).fetchone()[0]
    if count <= 1:
        flash("You need to keep at least one profile.")
    else:
        db.execute("DELETE FROM profile WHERE profile_id = ? AND account_id = ?",
                   (pid, g.account["id"]))
        db.commit()
        flash("Profile deleted.", "ok")
    return redirect(url_for("profiles"))


# ---------- templates ----------
BASE = """
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{% block title %}Team Netflix{% endblock %}</title>
<style>
  :root { --bg:#f6f7f9; --card:#fff; --text:#1d2330; --muted:#667085; --line:#e3e6eb;
          --accent:#d81f26; --danger:#c62828; --flash:#fdecea; }
  @media (prefers-color-scheme: dark) {
    :root { --bg:#141414; --card:#1f1f1f; --text:#ececec; --muted:#9b9b9b; --line:#333;
            --accent:#e50914; --danger:#ff6b6b; --flash:#3a1f21; }
  }
  * { box-sizing: border-box; }
  body { margin:0; font-family: system-ui, -apple-system, Segoe UI, sans-serif;
         background:var(--bg); color:var(--text); }
  header { background:var(--card); border-bottom:1px solid var(--line); padding:0 1.5rem; }
  .bar { max-width:1100px; margin:0 auto; display:flex; flex-wrap:wrap;
         align-items:center; gap:0 1.5rem; }
  .brand { padding:.9rem 0; color:var(--accent); font-weight:800; letter-spacing:.08em;
           text-decoration:none; }
  nav { display:flex; flex-wrap:wrap; gap:.1rem; flex:1; }
  nav a { padding:.9rem .75rem; color:var(--muted); text-decoration:none; font-size:.9rem;
          border-bottom:2px solid transparent; }
  nav a.active { color:var(--accent); border-bottom-color:var(--accent); font-weight:600; }
  .who { display:flex; align-items:center; gap:.75rem; font-size:.85rem; color:var(--muted); }
  main { max-width:1100px; margin:1.5rem auto; padding:0 1.5rem; }
  .card { background:var(--card); border:1px solid var(--line); border-radius:10px;
          padding:1.25rem; margin-bottom:1.5rem; }
  h1 { font-size:1.4rem; margin:0 0 1rem; }
  h2 { margin:0 0 1rem; font-size:1.1rem; }
  label { display:block; font-size:.85rem; color:var(--muted); margin-bottom:.3rem; }
  input, select { width:100%; padding:.55rem .65rem; border:1px solid var(--line);
                  border-radius:6px; background:var(--bg); color:var(--text); font:inherit; }
  input[type=checkbox] { width:auto; }
  .field { margin-bottom:1rem; }
  .check { display:flex; align-items:center; gap:.5rem; color:var(--text); }
  button, .btn { padding:.55rem 1rem; border:0; border-radius:6px; background:var(--accent);
                 color:#fff; font:inherit; cursor:pointer; text-decoration:none;
                 display:inline-block; }
  button.ghost, .btn.ghost { background:none; color:var(--muted); border:1px solid var(--line); }
  button.ghost.on { color:var(--accent); border-color:var(--accent); font-weight:600; }
  button.link { background:none; color:var(--danger); padding:0; }
  button.small { padding:.3rem .7rem; font-size:.85rem; }
  .two { display:grid; grid-template-columns:repeat(auto-fit,minmax(300px,1fr)); gap:1.5rem; }
  .grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:1rem; }
  .item { background:var(--card); border:1px solid var(--line); border-radius:10px;
          padding:1rem; display:flex; flex-direction:column; gap:.5rem; }
  .item h3 { margin:0; font-size:1rem; }
  .meta { color:var(--muted); font-size:.85rem; }
  .item .poster { width:100%; aspect-ratio:2/3; object-fit:cover; border-radius:6px; background:#222; }
  .actions { display:flex; gap:.5rem; margin-top:auto; padding-top:.5rem; }
  .avatar { width:64px; height:64px; border-radius:12px; display:flex; align-items:center;
            justify-content:center; font-size:1.6rem; font-weight:700; color:#fff; }
  .profile { display:flex; align-items:center; gap:1rem; }
  .profile .grow { flex:1; }
  .badge { font-size:.7rem; background:var(--line); color:var(--muted); padding:.1rem .5rem;
           border-radius:99px; margin-left:.4rem; }
  .row { display:flex; gap:.75rem; align-items:center; }
  .empty { color:var(--muted); }
  .flash { background:var(--flash); border:1px solid var(--danger); color:var(--danger);
           padding:.7rem 1rem; border-radius:8px; margin-bottom:1rem; }
  .flash.ok { border-color:var(--accent); color:var(--accent); background:transparent; }
  form.inline { display:inline; margin:0; }
</style>
</head>
<body>
<header>
  <div class="bar">
    <a class="brand" href="{{ url_for('home') }}">TEAM NETFLIX</a>
    {% if g.account %}
    <nav>
      <a href="{{ url_for('browse') }}" class="{{ 'active' if active == 'browse' }}">Browse</a>
      <a href="{{ url_for('flag_list', which='watched') }}" class="{{ 'active' if active == 'watched' }}">Watched</a>
      <a href="{{ url_for('flag_list', which='liked') }}" class="{{ 'active' if active == 'liked' }}">Liked</a>
      <a href="{{ url_for('profiles') }}" class="{{ 'active' if active == 'profiles' }}">Profiles</a>
    </nav>
    <div class="who">
      {% if g.account.is_admin %}<a href="/admin/" style="color:var(--accent)">Admin</a>{% endif %}
      <span>{{ g.account.email }}</span>
      <form class="inline" method="post" action="{{ url_for('logout') }}">
        <button class="ghost small" type="submit">Sign out</button>
      </form>
    </div>
    {% endif %}
  </div>
</header>
<main>
  {% for category, msg in get_flashed_messages(with_categories=true) %}
    <div class="flash {{ 'ok' if category == 'ok' else '' }}">{{ msg }}</div>
  {% endfor %}
  {% block body %}{% endblock %}
</main>
</body>
</html>
"""

MACROS = """
{% macro item_card(item, kind, next_url) %}
  <div class="item" id="c-{{ kind }}-{{ item.id }}">
    {% if item.poster %}<img class="poster" src="{{ item.poster }}" alt="{{ item.title }} poster" loading="lazy">{% endif %}
    <h3>{{ item.title }}</h3>
    <div class="meta">
      {{ item.genre or '' }}{% if item.genre and item.duration %} &middot; {% endif %}
      {% if item.duration %}{{ item.duration }} min{% endif %}
    </div>
    {% if item.directors %}<div class="meta">Directed by {{ item.directors }}</div>{% endif %}
    {% if item.actors %}<div class="meta">Starring {{ item.actors }}</div>{% endif %}
    <div class="actions">
      {% for which, label, on_label in (('watched', 'Mark watched', 'Watched'), ('liked', 'Like', 'Liked')) %}
        <form class="inline" method="post"
              action="{{ url_for('toggle', kind=kind, which=which, item_id=item.id) }}">
          <input type="hidden" name="next" value="{{ next_url }}#c-{{ kind }}-{{ item.id }}">
          <button type="submit" class="ghost small {{ 'on' if item[which] }}">
            {{ on_label if item[which] else label }}
          </button>
        </form>
      {% endfor %}
    </div>
  </div>
{% endmacro %}
"""

HOME = """
{% extends "base.html" %}
{% block title %}Sign in - Team Netflix{% endblock %}
{% block body %}
<div class="two">
  <div class="card">
    <h2>Sign in</h2>
    <form method="post" action="{{ url_for('login') }}">
      <div class="field"><label for="li-email">Email</label>
        <input id="li-email" name="email" type="email" required autofocus></div>
      <div class="field"><label for="li-pw">Password</label>
        <input id="li-pw" name="password" type="password" required></div>
      <button type="submit">Sign in</button>
    </form>
  </div>
  <div class="card">
    <h2>Create account</h2>
    <form method="post" action="{{ url_for('register') }}">
      <div class="field"><label for="r-email">Email *</label>
        <input id="r-email" name="email" type="email" required></div>
      <div class="field"><label for="r-pw">Password * (6+ characters)</label>
        <input id="r-pw" name="password" type="password" minlength="6" required></div>
      <div class="field"><label for="r-confirm">Confirm password *</label>
        <input id="r-confirm" name="confirm" type="password" required></div>
      <div class="field"><label for="r-phone">Phone number</label>
        <input id="r-phone" name="phone_number" type="tel"></div>
      <div class="field"><label for="r-plan">Subscription plan *</label>
        <select id="r-plan" name="subscription_id" required>
          <option value="">-- choose --</option>
          {% for p in plans %}
            <option value="{{ p.id }}">{{ p.subscription_type }} - ${{ '%.2f' % p.subscription_price }}</option>
          {% endfor %}
        </select></div>
      <div class="field"><label for="r-profile">First profile name</label>
        <input id="r-profile" name="profile_name" placeholder="Defaults to your email name"></div>
      <button type="submit">Create account</button>
    </form>
  </div>
</div>
{% endblock %}
"""

BROWSE = """
{% extends "base.html" %}
{% from "_macros.html" import item_card %}
{% block title %}Browse - Team Netflix{% endblock %}
{% block body %}
<h1>Films</h1>
<div class="grid">
  {% for i in films %}{{ item_card(i, 'film', request.path) }}{% endfor %}
</div>
<h1 style="margin-top:2rem">TV Shows</h1>
<div class="grid">
  {% for i in shows %}{{ item_card(i, 'tv', request.path) }}{% endfor %}
</div>
{% endblock %}
"""

FLAG_LIST = """
{% extends "base.html" %}
{% from "_macros.html" import item_card %}
{% block title %}{{ which|capitalize }} - Team Netflix{% endblock %}
{% block body %}
<h1>Your {{ which }} list</h1>
{% if not films and not shows %}
  <div class="card"><p class="empty">
    Nothing here yet. Head to <a href="{{ url_for('browse') }}">Browse</a> and
    mark some titles as {{ which }}.</p></div>
{% endif %}
{% if films %}
  <h2>Films ({{ films|length }})</h2>
  <div class="grid">
    {% for i in films %}{{ item_card(i, 'film', request.path) }}{% endfor %}
  </div>
{% endif %}
{% if shows %}
  <h2 style="margin-top:2rem">TV Shows ({{ shows|length }})</h2>
  <div class="grid">
    {% for i in shows %}{{ item_card(i, 'tv', request.path) }}{% endfor %}
  </div>
{% endif %}
{% endblock %}
"""

PROFILES = """
{% extends "base.html" %}
{% block title %}Profiles - Team Netflix{% endblock %}
{% block body %}
<div class="row" style="justify-content:space-between; margin-bottom:1rem">
  <h1 style="margin:0">Profiles ({{ profiles|length }}/{{ max_profiles }})</h1>
  {% if can_add %}<a class="btn" href="{{ url_for('profile_form') }}">Add profile</a>{% endif %}
</div>
{% for p in profiles %}
  <div class="card profile">
    <div class="avatar" style="background:hsl({{ avatar_hue(p.profile_picture) }},55%,45%)">
      {{ p.profile_name[:1]|upper }}
    </div>
    <div class="grow">
      <strong>{{ p.profile_name }}</strong>
      {% if p.is_kid_profile %}<span class="badge">Kids</span>{% endif %}
      <div class="meta">{{ p.profile_picture }}</div>
    </div>
    <a class="btn ghost small" href="{{ url_for('profile_form', pid=p.profile_id) }}">Edit</a>
    {% if profiles|length > 1 %}
    <form class="inline" method="post"
          action="{{ url_for('profile_delete', pid=p.profile_id) }}"
          onsubmit="return confirm('Delete this profile?')">
      <button class="link" type="submit">Delete</button>
    </form>
    {% endif %}
  </div>
{% endfor %}
{% endblock %}
"""

PROFILE_FORM = """
{% extends "base.html" %}
{% block title %}{{ 'Edit' if profile else 'Add' }} profile - Team Netflix{% endblock %}
{% block body %}
<div class="card" style="max-width:480px">
  <h2>{{ 'Edit profile' if profile else 'Add profile' }}</h2>
  <form method="post">
    <div class="field"><label for="name">Profile name *</label>
      <input id="name" name="profile_name" required
             value="{{ profile.profile_name if profile else '' }}"></div>
    <div class="field"><label for="pic">Avatar</label>
      <select id="pic" name="profile_picture" required>
        {% for a in avatars %}
          <option value="{{ a }}" {{ 'selected' if profile and profile.profile_picture == a }}>{{ a }}</option>
        {% endfor %}
      </select></div>
    <div class="field"><label class="check">
      <input type="checkbox" name="is_kid_profile"
             {{ 'checked' if profile and profile.is_kid_profile }}> Kids profile</label></div>
    <div class="row">
      <button type="submit">Save</button>
      <a class="btn ghost" href="{{ url_for('profiles') }}">Cancel</a>
    </div>
  </form>
</div>
{% endblock %}
"""

app.jinja_loader = DictLoader({
    "base.html": BASE, "_macros.html": MACROS, "home.html": HOME,
    "browse.html": BROWSE, "flag_list.html": FLAG_LIST,
    "profiles.html": PROFILES, "profile_form.html": PROFILE_FORM,
})


def set_admin(email, value):
    con = sqlite3.connect(DB_PATH)
    cur = con.execute("UPDATE account SET is_admin = ? WHERE lower(email) = ?",
                      (value, email.strip().lower()))
    con.commit()
    con.close()
    return cur.rowcount


def build_combined_app():
    """The customer site at / with the admin app (netflix_app.py) mounted at /admin."""
    from werkzeug.middleware.dispatcher import DispatcherMiddleware
    import netflix_app
    netflix_app.app.config["LOGIN_URL"] = "/"
    return DispatcherMiddleware(app, {"/admin": netflix_app.app})


if __name__ == "__main__":
    import sys
    if not DB_PATH.exists():
        raise SystemExit(
            f"Database not found: {DB_PATH}\nPut team_netflix.db next to this script.")

    # python netflix_user_app.py make-admin you@example.com
    # python netflix_user_app.py remove-admin you@example.com
    if len(sys.argv) == 3 and sys.argv[1] in ("make-admin", "remove-admin"):
        granting = sys.argv[1] == "make-admin"
        if set_admin(sys.argv[2], 1 if granting else 0):
            print(f"{sys.argv[2]} is {'now' if granting else 'no longer'} an admin.")
        else:
            print(f"No account with email {sys.argv[2]}.")
        raise SystemExit

    from werkzeug.serving import run_simple
    run_simple("127.0.0.1", 5001, build_combined_app(),
               use_reloader=True, use_debugger=True)
