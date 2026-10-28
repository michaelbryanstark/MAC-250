"""
Team Netflix - a Flask web app that reads your SQLite database and builds a
page (list + add form + delete) for every table automatically.

Setup:
    pip install flask
    python netflix_app.py
Then open http://127.0.0.1:5000
"""
import sqlite3
from pathlib import Path

from flask import (Flask, abort, flash, g, redirect, render_template_string,
                   request, url_for)
from werkzeug.security import generate_password_hash

# Change this to your database filename (kept next to this script)
DB_PATH = Path(__file__).parent / "netflix.db"

app = Flask(__name__)
app.secret_key = "change-me"


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


def get_tables(db):
    rows = db.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    ).fetchall()
    return [r["name"] for r in rows]


def label_expr(db, table):
    """SQL expression used to show a friendly name for rows of `table`."""
    cols = db.execute(f'PRAGMA table_info("{table}")').fetchall()
    names = [c["name"] for c in cols]
    if "first_name" in names and "last_name" in names:
        return "first_name || ' ' || last_name"
    for c in cols:
        if not c["pk"] and any(t in (c["type"] or "").upper() for t in ("CHAR", "TEXT")):
            return f'"{c["name"]}"'
    return None


def fk_options(db, table, to_col):
    """[(value, label)] for a foreign key, or None if the target is unusable."""
    if to_col is None:
        pk = [c["name"]
              for c in db.execute(f'PRAGMA table_info("{table}")') if c["pk"]]
        to_col = pk[0] if pk else None
    if to_col is None:
        return None
    label = label_expr(db, table)
    try:
        if label:
            sql = f'SELECT "{to_col}" AS v, {label} AS l FROM "{table}" ORDER BY l'
        else:
            sql = f'SELECT "{to_col}" AS v, "{to_col}" AS l FROM "{table}" ORDER BY v'
        return [(r["v"], f'{r["l"]} (#{r["v"]})') for r in db.execute(sql)]
    except sqlite3.Error:
        return None  # e.g. the foreign key points at a column that doesn't exist


def describe(db, table):
    """Build the form fields for a table from the database's own schema."""
    cols = db.execute(f'PRAGMA table_info("{table}")').fetchall()
    fks = {r["from"]: r for r in db.execute(
        f'PRAGMA foreign_key_list("{table}")')}
    pk_cols = [c for c in cols if c["pk"]]
    auto_pk = None
    if len(pk_cols) == 1 and "INT" in (pk_cols[0]["type"] or "").upper():
        auto_pk = pk_cols[0]["name"]

    fields = []
    for c in cols:
        name, typ = c["name"], (c["type"] or "").upper()
        f = {
            "name": name,
            "label": name.replace("_", " ").title(),
            "required": bool(c["notnull"]) and name != auto_pk and c["dflt_value"] is None,
            "hint": "Leave blank to auto-assign" if name == auto_pk else "",
            "input": "text",
            "options": None,
        }
        opts = None
        if name in fks:
            opts = fk_options(db, fks[name]["table"], fks[name]["to"])
        if opts is not None:
            f["options"] = opts
        elif "BOOL" in typ:
            f["options"] = [(1, "Yes"), (0, "No")]
        elif name == "password":
            f["input"] = "password"
        elif "email" in name.lower():
            f["input"] = "email"
        elif "DATETIME" in typ or "TIMESTAMP" in typ:
            f["input"] = "datetime-local"
        elif "DATE" in typ:
            f["input"] = "date"
        elif any(t in typ for t in ("DEC", "REAL", "FLOA", "DOUB", "NUM")):
            f["input"] = "number"
            f["step"] = "any"
        elif "INT" in typ:
            f["input"] = "number"
        fields.append(f)
    return {"table": table, "auto_pk": auto_pk, "fields": fields}


# ---------- template ----------
TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ page }} - Team Netflix</title>
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
  .bar { max-width:1100px; margin:0 auto; }
  .brand { display:block; padding:.9rem 0 0; color:var(--accent); font-weight:800;
           letter-spacing:.08em; }
  nav { display:flex; flex-wrap:wrap; gap:.1rem; }
  nav a { padding:.7rem .75rem; color:var(--muted); text-decoration:none; font-size:.9rem;
          border-bottom:2px solid transparent; }
  nav a.active { color:var(--accent); border-bottom-color:var(--accent); font-weight:600; }
  main { max-width:1100px; margin:1.5rem auto; padding:0 1.5rem; }
  .card { background:var(--card); border:1px solid var(--line); border-radius:10px;
          padding:1.25rem; margin-bottom:1.5rem; }
  h2 { margin:0 0 1rem; font-size:1.1rem; }
  form.add { display:grid; grid-template-columns:repeat(auto-fit,minmax(210px,1fr)); gap:1rem; }
  label { display:block; font-size:.85rem; color:var(--muted); margin-bottom:.3rem; }
  input, select { width:100%; padding:.55rem .65rem; border:1px solid var(--line);
                  border-radius:6px; background:var(--bg); color:var(--text); font:inherit; }
  button { padding:.55rem 1rem; border:0; border-radius:6px; background:var(--accent);
           color:#fff; font:inherit; cursor:pointer; align-self:end; }
  button.link { background:none; color:var(--danger); padding:0; }
  .table-wrap { overflow-x:auto; }
  table { width:100%; border-collapse:collapse; }
  th, td { text-align:left; padding:.6rem .5rem; border-bottom:1px solid var(--line); white-space:nowrap; }
  th { font-size:.8rem; text-transform:uppercase; letter-spacing:.04em; color:var(--muted); }
  .empty { color:var(--muted); }
  .flash { background:var(--flash); border:1px solid var(--danger); color:var(--danger);
           padding:.7rem 1rem; border-radius:8px; margin-bottom:1rem; }
  .flash.ok { border-color:var(--accent); color:var(--accent); background:transparent; }
</style>
</head>
<body>
<header>
  <div class="bar">
    <span class="brand">TEAM NETFLIX</span>
    <nav>
      {% for t in tables %}
        <a href="{{ url_for('index', page=t) }}" class="{{ 'active' if t == page else '' }}">{{ t }}</a>
      {% endfor %}
    </nav>
  </div>
</header>
<main>
  {% for category, msg in get_flashed_messages(with_categories=true) %}
    <div class="flash {{ 'ok' if category == 'ok' else '' }}">{{ msg }}</div>
  {% endfor %}

  <div class="card">
    <h2>Add to {{ page }}</h2>
    <form class="add" method="post">
      {% for f in fields %}
        <div>
          <label for="{{ f.name }}">{{ f.label }}{% if f.required %} *{% endif %}</label>
          {% if f.options is not none %}
            <select id="{{ f.name }}" name="{{ f.name }}" {{ 'required' if f.required }}>
              <option value="">-- choose --</option>
              {% for value, text in f.options %}
                <option value="{{ value }}">{{ text }}</option>
              {% endfor %}
            </select>
          {% else %}
            <input id="{{ f.name }}" name="{{ f.name }}" type="{{ f.input }}"
                   {% if f.step %}step="{{ f.step }}"{% endif %}
                   {% if f.hint %}placeholder="{{ f.hint }}"{% endif %}
                   {{ 'required' if f.required }}>
          {% endif %}
        </div>
      {% endfor %}
      <button type="submit">Add</button>
    </form>
  </div>

  <div class="card">
    <h2>{{ page }} ({{ rows|length }})</h2>
    {% if rows %}
      <div class="table-wrap">
        <table>
          <thead>
            <tr>{% for f in fields %}<th>{{ f.label }}</th>{% endfor %}<th></th></tr>
          </thead>
          <tbody>
            {% for row in rows %}
              <tr>
                {% for cell in row.cells %}<td>{{ cell }}</td>{% endfor %}
                <td>
                  <form method="post" action="{{ url_for('delete', page=page, rowid=row.rowid) }}"
                        onsubmit="return confirm('Delete this row?')">
                    <button class="link" type="submit">Delete</button>
                  </form>
                </td>
              </tr>
            {% endfor %}
          </tbody>
        </table>
      </div>
    {% else %}
      <p class="empty">No rows yet.</p>
    {% endif %}
  </div>
</main>
</body>
</html>
"""


# ---------- routes ----------
@app.route("/", defaults={"page": None}, methods=["GET", "POST"])
@app.route("/<page>", methods=["GET", "POST"])
def index(page):
    db = get_db()
    tables = get_tables(db)
    if not tables:
        return "No tables found in the database. Check DB_PATH at the top of the script.", 500
    if page is None:
        return redirect(url_for("index", page=tables[0]))
    if page not in tables:  # whitelist: table names never come straight from the user
        abort(404)

    info = describe(db, page)
    fields = info["fields"]

    if request.method == "POST":
        values = {}
        for f in fields:
            raw = request.form.get(f["name"], "").strip()
            if raw:
                if f["name"] == "password":
                    raw = generate_password_hash(raw)
                values[f["name"]] = raw.replace(
                    "T", " ") if f["input"] == "datetime-local" else raw

        pk = info["auto_pk"]
        if pk and pk not in values:
            values[pk] = db.execute(
                f'SELECT COALESCE(MAX("{pk}"), 0) + 1 FROM "{page}"'
            ).fetchone()[0]

        if not values:
            flash("Nothing to add.")
            return redirect(url_for("index", page=page))

        cols = list(values)
        sql = (f'INSERT INTO "{page}" ({", ".join(chr(34) + c + chr(34) for c in cols)}) '
               f'VALUES ({", ".join("?" for _ in cols)})')
        try:
            db.execute(sql, [values[c] for c in cols])
            db.commit()
            flash("Row added.", "ok")
        except sqlite3.Error as e:
            db.rollback()
            flash(f"Could not add row: {e}")
        return redirect(url_for("index", page=page))

    # Map stored values to friendly text for dropdown columns (FKs, booleans)
    lookups = {f["name"]: {str(v): t for v, t in f["options"]}
               for f in fields if f["options"] is not None}

    rows = []
    for r in db.execute(f'SELECT rowid AS _rowid_, * FROM "{page}" ORDER BY rowid'):
        cells = []
        for f in fields:
            val = r[f["name"]]
            if val is None:
                cells.append("")
            elif f["name"] == "password":
                cells.append("••••••••")
            elif f["name"] in lookups:
                cells.append(lookups[f["name"]].get(str(val), val))
            else:
                cells.append(val)
        rows.append({"rowid": r["_rowid_"], "cells": cells})

    return render_template_string(TEMPLATE, tables=tables, page=page, fields=fields, rows=rows)


@app.route("/<page>/delete/<int:rowid>", methods=["POST"])
def delete(page, rowid):
    db = get_db()
    if page not in get_tables(db):
        abort(404)
    try:
        db.execute(f'DELETE FROM "{page}" WHERE rowid = ?', (rowid,))
        db.commit()
        flash("Row deleted.", "ok")
    except sqlite3.Error as e:
        db.rollback()
        flash(f"Could not delete row: {e}")
    return redirect(url_for("index", page=page))


if __name__ == "__main__":
    if not DB_PATH.exists():
        raise SystemExit(
            f"Database not found: {DB_PATH}\nEdit DB_PATH at the top of the script.")
    app.run(debug=True)
