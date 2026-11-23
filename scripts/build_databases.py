"""Create separate, fresh SQLite databases for SalesDB and University ERD B."""
from pathlib import Path
import sqlite3
BASE = Path(__file__).resolve().parents[1]
out = BASE / 'databases'
out.mkdir(exist_ok=True)
for name, sql_file in [('sales', '00_setup.sql'), ('university', '08_university_schema.sql')]:
    db = out / f'{name}.db'
    if db.exists():
        db.unlink()
    conn = sqlite3.connect(db)
    conn.executescript((BASE / 'sql' / sql_file).read_text(encoding='utf-8'))
    assert not conn.execute('PRAGMA foreign_key_check').fetchall()
    conn.commit()
    conn.close()
    print('Created:', db)
