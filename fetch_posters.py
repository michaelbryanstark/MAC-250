"""

1. Make a free account at https://www.themoviedb.org and create an API key
   (Settings > API, the "API Key (v3 auth)" value).
2. Run:   TMDB_API_KEY=your_key python fetch_posters.py
          (Windows PowerShell:  $env:TMDB_API_KEY="your_key"; python fetch_posters.py)
"""
import json
import os
import sqlite3
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

DB_PATH = Path(__file__).parent / "team_netflix.db"
KEY = os.environ.get("TMDB_API_KEY")
if not KEY:
    sys.exit(
        "Set the TMDB_API_KEY environment variable first (see the top of this file).")


def search(kind, title):
    url = (f"https://api.themoviedb.org/3/search/{kind}?"
           + urllib.parse.urlencode({"api_key": KEY, "query": title}))
    with urllib.request.urlopen(url, timeout=15) as resp:
        data = json.load(resp)
    for hit in data.get("results", []):
        if hit.get("poster_path"):
            return "https://image.tmdb.org/t/p/w342" + hit["poster_path"]
    return None


db = sqlite3.connect(DB_PATH)
for table, kind in (("film", "movie"), ("tv_show", "tv")):
    rows = db.execute(
        f'SELECT id, title FROM "{table}" WHERE poster IS NULL OR poster = ""').fetchall()
    print(f"{table}: {len(rows)} titles to look up")
    for tid, title in rows:
        try:
            url = search(kind, title)
        except Exception as e:  # network hiccup: skip this one, keep going
            print(f"  ! {title}: {e}")
            continue
        if url:
            db.execute(
                f'UPDATE "{table}" SET poster = ? WHERE id = ?', (url, tid))
            db.commit()
            print(f"  ok {title}")
        else:
            print(f"  -- no poster found for {title}")
        time.sleep(0.15)
print("Done.")
