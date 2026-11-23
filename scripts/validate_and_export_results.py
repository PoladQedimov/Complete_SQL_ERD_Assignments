"""Run all 68 assignment tasks against SQLite and export actual result tables.

Usage: python scripts/validate_and_export_results.py
No external packages required.
"""
from pathlib import Path
import re
import sqlite3
import csv

BASE = Path(__file__).resolve().parents[1]
SQL = BASE / 'sql'
RESULTS = BASE / 'results'
TASK_PATTERN = re.compile(r'--\s*\[(B\d{2}|[1-6]\.\d{1,2})\]')
ORDER = ([f'B{i:02d}' for i in range(1, 11)] +
         [f'{scenario}.{task}' for scenario, n in
          [(1, 7), (2, 9), (3, 12), (4, 10), (5, 10), (6, 10)]
          for task in range(1, n+1)])


def statements(sql):
    """Yield complete SQL statements, retaining preceding comments for task labels."""
    buffer = ''
    for line in sql.splitlines(keepends=True):
        buffer += line
        if sqlite3.complete_statement(buffer):
            yield buffer
            buffer = ''
    if buffer.strip() and not buffer.strip().startswith('--'):
        raise ValueError('Unfinished SQL: ' + buffer[:100])


def table_markdown(columns, rows):
    if not rows:
        return '*Nəticə: 0 sətir (sorğuya uyğun qeyd yoxdur).*\n'
    def escape(value):
        if value is None:
            return '`NULL`'
        return str(value).replace('|', '\\|').replace('\n', ' ')
    widths = list(columns)
    out = ['| ' + ' | '.join(widths) + ' |',
           '| ' + ' | '.join('---' for _ in widths) + ' |']
    out.extend('| ' + ' | '.join(escape(v) for v in row) + ' |' for row in rows)
    return '\n'.join(out) + '\n'


def main():
    conn = sqlite3.connect(':memory:')
    conn.execute('PRAGMA foreign_keys = ON')
    conn.executescript((SQL / '00_setup.sql').read_text(encoding='utf-8'))
    task_results = {}
    queries_run = 0
    for path in sorted(SQL.glob('0[1-7]*.sql')):
        current_task = None
        for statement in statements(path.read_text(encoding='utf-8')):
            task_match = TASK_PATTERN.search(statement)
            if task_match:
                current_task = task_match.group(1)
                task_results.setdefault(current_task, [])
            # sqlite3 accepts leading comments. Run each statement and capture SELECT results.
            try:
                cursor = conn.execute(statement)
            except sqlite3.Error as exc:
                raise RuntimeError(f'{path.name} / {current_task}: {exc}\n{statement}') from exc
            if cursor.description is not None and current_task is not None:
                names = [x[0] for x in cursor.description]
                rows = [tuple(x) for x in cursor.fetchall()]
                task_results[current_task].append((names, rows))
                queries_run += 1

    assert set(task_results) == set(ORDER), f'Task mismatch: missing={set(ORDER)-set(task_results)} extra={set(task_results)-set(ORDER)}'
    assert all(task_results[t] for t in ORDER), 'Each numbered task must have a verification result set'
    for name, expected in [('Customers', 9), ('Products', 8), ('Employees', 5), ('Orders', 24)]:
        actual = conn.execute(f'SELECT COUNT(*) FROM {name}').fetchone()[0]
        assert actual == expected, f'{name}: expected {expected}, got {actual}'
    assert [r[1] for r in conn.execute('PRAGMA table_info(Products)')] == ['ProductID', 'Product', 'Category', 'Price']
    assert conn.execute('PRAGMA foreign_key_check').fetchall() == []

    # Independent spot-checks for the most error-prone requirements.
    check = lambda t: task_results[t][-1][1]
    assert [r[0] for r in check('1.4')] == [9]
    assert [r[0] for r in check('2.3')] == [202]
    assert [r[0] for r in check('3.5')] == [108]
    assert [r[0] for r in check('5.5')] == [221, 222]
    assert 15 in [r[0] for r in check('5.7')]
    assert 15 in [r[0] for r in check('6.6')]
    assert [r[0] for r in check('6.7')] == [1, 2, 3]
    assert [r[0] for r in check('6.9')] == [7]

    lines = [
        '# Real SQL query results / Faktiki SQL nəticələri',
        '',
        '> **DBMS:** SQLite 3. Nəticələr 24 sifarişlik orijinal verilənlər üzərində hesablanıb.',
        '> **İstisna:** 2.5–2.9 müvəqqəti test qeydləri ilə icra edilir, sonra geri qaytarılır.',
        '> 3.8–3.10 test məhsulu və `StockQuantity` sütunu da sonunda geri qaytarılır.',
        '> `NULL` — boş mətn deyil, SQL NULL dəyəridir.',
        '',
    ]
    scenario_titles = {
        'B': 'Basic SQL / Əsas SQL',
        '1': 'Scenario 1 — Customer loyalty',
        '2': 'Scenario 2 — Orders and delivery',
        '3': 'Scenario 3 — Products and employees',
        '4': 'Scenario 4 — Targeted campaigns',
        '5': 'Scenario 5 — Fulfilment exceptions',
        '6': 'Scenario 6 — Sales team and retention',
    }
    previous = None
    for task in ORDER:
        grp = 'B' if task.startswith('B') else task.split('.')[0]
        if grp != previous:
            lines += ['## ' + scenario_titles[grp], '']
            previous = grp
        results = task_results[task]
        lines += [f'### Task {task}', '']
        if len(results) > 1:
            lines += ['*Bu tapşırıqda bir neçə yoxlama sorğusu var; hamısının nəticəsi göstərilir.*', '']
        for ix, (cols, rows) in enumerate(results, 1):
            if len(results) > 1:
                lines += [f'**Yoxlama sorğusu {ix}:**', '']
            lines += [table_markdown(cols, rows), '']
    (RESULTS / 'TASK_RESULTS.md').write_text('\n'.join(lines), encoding='utf-8')
    print(f'OK: {len(ORDER)} tasks, {queries_run} result-producing statements.')
    print(f'Wrote {RESULTS / "TASK_RESULTS.md"}')
    print('Key checks: no orders customer 9; late order 202; unsold product 108; anomalies 221/222; returning IDs 1/2/3.')


if __name__ == '__main__':
    main()
