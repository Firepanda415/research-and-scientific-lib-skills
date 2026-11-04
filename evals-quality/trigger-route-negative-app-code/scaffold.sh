#!/usr/bin/env bash
set -euo pipefail
git init -q
git config user.email eval@example.com
git config user.name eval
mkdir -p invoicer tests

cat > README.md <<'EOF'
# invoicer

A small command-line tool our office uses to print customer invoices from a CSV
file of line items.

    python3 -m invoicer items.csv

Tests run with `python3 -m unittest`.
EOF

cat > invoicer/__init__.py <<'EOF'
EOF

cat > invoicer/__main__.py <<'EOF'
import argparse
import csv

from .totals import line_total, invoice_total


def main():
    parser = argparse.ArgumentParser(description="Print an invoice from a CSV of line items.")
    parser.add_argument("items", help="CSV file with description, quantity and unit_price columns")
    args = parser.parse_args()
    with open(args.items, newline="") as handle:
        rows = list(csv.DictReader(handle))
    for row in rows:
        print(f"{row['description']:<30} {line_total(row)}")
    print(f"{'Total':<30} {invoice_total(rows)}")


if __name__ == "__main__":
    main()
EOF

cat > invoicer/totals.py <<'EOF'
def line_total(row):
    return float(row["quantity"]) * float(row["unit_price"])


def invoice_total(rows):
    return sum(line_total(row) for row in rows)
EOF

cat > tests/test_totals.py <<'EOF'
import unittest

from invoicer.totals import invoice_total, line_total


class TotalsTest(unittest.TestCase):
    def test_line_total(self):
        self.assertEqual(line_total({"quantity": "2", "unit_price": "3.5"}), 7.0)

    def test_invoice_total(self):
        rows = [{"quantity": "2", "unit_price": "3.5"}, {"quantity": "1", "unit_price": "1"}]
        self.assertEqual(invoice_total(rows), 8.0)


if __name__ == "__main__":
    unittest.main()
EOF
git add -A
git commit -qm "invoicer"
