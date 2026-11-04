#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../_trigger-fixture/polyevo.sh" before
sed -i.bak 's/"""Plan a polynomial approximation of exp(-i tau x) and its phase factors."""/"""Plan a polynomial aproximation of exp(-i tau x) and its phase factors."""/' polyevo/plan.py
sed -i.bak 's/"""A plan that cannot be built under the given controls."""/"""A plan that canot be built under the given controls."""/' polyevo/plan.py
rm -f polyevo/plan.py.bak
git add -A
git commit -qm "Import the planning module"
