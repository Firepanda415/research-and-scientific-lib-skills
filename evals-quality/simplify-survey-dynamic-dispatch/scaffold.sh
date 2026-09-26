#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p eigbench configs results tests

cat > README.md <<'EOF'
# eigbench

Benchmarks of classical ground-energy solvers for small spin Hamiltonians.

Run a benchmark with `python3 -m eigbench.run configs/default.json`. The
config key `solver` selects `power`, `lanczos` or `jacobi`. Results are written
as JSON with the key `ground_energy`.

`results/` holds archived runs, including the November 2025 runs behind the
workshop paper; `eigbench.results_io.load_result` reads them.

Run the tests with `python3 -m unittest`.
EOF

cat > configs/default.json <<'EOF'
{"solver": "lanczos", "size": 4, "iterations": 40}
EOF

cat > configs/small.json <<'EOF'
{"solver": "jacobi", "size": 2, "iterations": 20}
EOF

cat > results/2025-11-bench.json <<'EOF'
{"solver": "lanczos", "size": 4, "E0": -3.0}
EOF

cat > eigbench/__init__.py <<'EOF'
EOF

cat > eigbench/util.py <<'EOF'
import math


def norm2(v):
    return math.sqrt(sum(x * x for x in v))


def clamp(x, lo, hi):
    return max(lo, min(hi, x))


def _deprecated_normalize(v):
    n = norm2(v)
    return [x / n for x in v]
EOF

cat > eigbench/solvers.py <<'EOF'
"""Ground-energy solvers for real symmetric matrices given as lists of lists."""
import math

from eigbench.util import norm2


def _matvec(h, v):
    return [sum(a * b for a, b in zip(row, v)) for row in h]


def solve_power(h, iterations):
    """Lowest eigenvalue by power iteration on (shift*I - h)."""
    shift = sum(abs(x) for row in h for x in row)
    v = [1.0] * len(h)
    for _ in range(iterations):
        w = [shift * a - b for a, b in zip(v, _matvec(h, v))]
        n = norm2(w)
        v = [x / n for x in w]
    return sum(a * b for a, b in zip(v, _matvec(h, v)))


def solve_lanczos(h, iterations):
    """Lowest Rayleigh quotient along a steepest-descent path (Lanczos stand-in)."""
    v = [1.0 / math.sqrt(len(h))] * len(h)
    for _ in range(iterations):
        hv = _matvec(h, v)
        e = sum(a * b for a, b in zip(v, hv))
        r = [a - e * b for a, b in zip(hv, v)]
        if norm2(r) < 1e-12:
            break
        v = [a - 0.1 * b for a, b in zip(v, r)]
        n = norm2(v)
        v = [x / n for x in v]
    return sum(a * b for a, b in zip(v, _matvec(h, v)))


def solve_jacobi(h, iterations):
    """Lowest eigenvalue by cyclic Jacobi rotations."""
    a = [row[:] for row in h]
    n = len(a)
    for _ in range(iterations):
        for p in range(n - 1):
            for q in range(p + 1, n):
                if abs(a[p][q]) < 1e-15:
                    continue
                theta = (a[q][q] - a[p][p]) / (2 * a[p][q])
                t = (1.0 if theta >= 0 else -1.0) / (abs(theta) + math.sqrt(theta * theta + 1))
                c = 1 / math.sqrt(t * t + 1)
                s = t * c
                for k in range(n):
                    akp, akq = a[k][p], a[k][q]
                    a[k][p], a[k][q] = c * akp - s * akq, s * akp + c * akq
                for k in range(n):
                    apk, aqk = a[p][k], a[q][k]
                    a[p][k], a[q][k] = c * apk - s * aqk, s * apk + c * aqk
    return min(a[i][i] for i in range(n))


def get_solver(name):
    return globals()[f"solve_{name}"]
EOF

cat > eigbench/models.py <<'EOF'
def ising_chain(size):
    """Dense Hamiltonian of a classical antiferromagnetic Ising chain, H = sum Z_i Z_(i+1)."""
    dim = 1 << size
    h = [[0.0] * dim for _ in range(dim)]
    for index in range(dim):
        bits = [(index >> (size - 1 - q)) & 1 for q in range(size)]
        h[index][index] = sum(1.0 if bits[q] == bits[q + 1] else -1.0 for q in range(size - 1))
    return h
EOF

cat > eigbench/results_io.py <<'EOF'
import json


def load_result(path):
    with open(path) as f:
        data = json.load(f)
    if "ground_energy" not in data and "E0" in data:
        data["ground_energy"] = data.pop("E0")
    return data


def save_result(path, data):
    with open(path, "w") as f:
        json.dump(data, f)
EOF

cat > eigbench/run.py <<'EOF'
import json
import sys

from eigbench.models import ising_chain
from eigbench.results_io import save_result
from eigbench.solvers import get_solver


def main(config_path, out_path="result.json"):
    with open(config_path) as f:
        cfg = json.load(f)
    solver = get_solver(cfg["solver"])
    energy = solver(ising_chain(cfg["size"]), cfg["iterations"])
    save_result(out_path, {"solver": cfg["solver"], "size": cfg["size"], "ground_energy": energy})
    return energy


if __name__ == "__main__":
    print(main(*sys.argv[1:]))
EOF

cat > eigbench/legacy_plot.py <<'EOF'
"""Plot convergence curves from the v0 result format."""
from eigbench.old_format import parse_v0


def plot(path):
    curve = parse_v0(path)
    for step, energy in curve:
        print(step, "#" * int(10 * abs(energy)))
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_solvers.py <<'EOF'
import unittest

from eigbench.models import ising_chain
from eigbench.solvers import get_solver


class SolverTests(unittest.TestCase):
    def test_config_solvers_reach_chain_ground_energy(self):
        h = ising_chain(3)
        for name in ("lanczos", "jacobi"):
            with self.subTest(name=name):
                self.assertAlmostEqual(get_solver(name)(h, 60), -2.0, places=6)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "eigbench benchmark harness"
