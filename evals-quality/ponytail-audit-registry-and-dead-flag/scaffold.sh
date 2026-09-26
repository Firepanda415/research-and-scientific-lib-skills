#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qopt/algorithms tests

cat > README.md <<'EOF'
# qopt

Classical baselines for MaxCut benchmark studies.

    python3 -m qopt.cli --algorithm anneal --edges 0-1,1-2,2-0

`--algorithm` accepts any name registered in `qopt.registry`, currently
`brute` and `anneal`.

Run the tests with `python3 -m unittest`.
EOF

cat > requirements.txt <<'EOF'
six>=1.16
EOF

cat > qopt/__init__.py <<'EOF'
EOF

cat > qopt/registry.py <<'EOF'
ALGORITHMS = {}


def register(name):
    def wrap(fn):
        ALGORITHMS[name] = fn
        return fn
    return wrap
EOF

cat > qopt/cache.py <<'EOF'
from collections import OrderedDict


class Memo:
    """Least-recently-used memo for a function of hashable arguments."""

    def __init__(self, fn, maxsize=4096):
        self.fn = fn
        self.maxsize = maxsize
        self.data = OrderedDict()

    def __call__(self, *args):
        if args in self.data:
            self.data.move_to_end(args)
            return self.data[args]
        value = self.fn(*args)
        self.data[args] = value
        if len(self.data) > self.maxsize:
            self.data.popitem(last=False)
        return value
EOF

cat > qopt/maxcut.py <<'EOF'
from qopt.cache import Memo


def _cut_value(edges, bits):
    return sum(1 for i, j in edges if bits[i] != bits[j])


cut_value = Memo(_cut_value)
EOF

cat > qopt/algorithms/__init__.py <<'EOF'
from qopt.algorithms import anneal, brute  # noqa: F401  (registers the algorithms)
EOF

cat > qopt/algorithms/brute.py <<'EOF'
from itertools import product

from qopt.maxcut import cut_value
from qopt.registry import register


@register("brute")
def run_brute(edges, n, seed=0):
    best = max(product((0, 1), repeat=n), key=lambda bits: cut_value(edges, bits))
    return best, cut_value(edges, best)
EOF

cat > qopt/algorithms/anneal.py <<'EOF'
import math
import random

from qopt.maxcut import cut_value
from qopt.registry import register


@register("anneal")
def run_anneal(edges, n, seed=0, steps=2000):
    rng = random.Random(seed)
    bits = tuple(rng.randint(0, 1) for _ in range(n))
    best = bits
    for step in range(steps):
        temperature = max(1e-3, 2.0 * (1 - step / steps))
        k = rng.randrange(n)
        trial = bits[:k] + (1 - bits[k],) + bits[k + 1:]
        delta = cut_value(edges, trial) - cut_value(edges, bits)
        if delta >= 0 or rng.random() < math.exp(delta / temperature):
            bits = trial
            if cut_value(edges, bits) > cut_value(edges, best):
                best = bits
    return best, cut_value(edges, best)
EOF

cat > qopt/cli.py <<'EOF'
import argparse

import qopt.algorithms  # noqa: F401  (registers the algorithms)
from qopt.registry import ALGORITHMS


def parse_edges(text):
    edges = tuple(tuple(int(v) for v in pair.split("-")) for pair in text.split(","))
    n = 1 + max(max(e) for e in edges)
    return edges, n


def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--algorithm", choices=sorted(ALGORITHMS), default="brute")
    parser.add_argument("--edges", required=True)
    parser.add_argument("--seed", type=int, default=0)
    parser.add_argument("--legacy-mode", action="store_true", help="use the pre-0.3 output format")
    args = parser.parse_args(argv)
    edges, n = parse_edges(args.edges)
    bits, value = ALGORITHMS[args.algorithm](edges, n, seed=args.seed)
    print("".join(map(str, bits)), value)
    return value


if __name__ == "__main__":
    main()
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_cli.py <<'EOF'
import contextlib
import io
import unittest

from qopt.cli import main


class CliTests(unittest.TestCase):
    def test_triangle_max_cut_is_two(self):
        for algorithm in ("brute", "anneal"):
            with self.subTest(algorithm=algorithm), contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(main(["--algorithm", algorithm, "--edges", "0-1,1-2,2-0"]), 2)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "qopt MaxCut baselines"
