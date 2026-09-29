#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p gridsolve tests

cat > README.md <<'GS_EOF'
# gridsolve

Closed-form solutions of 2x2 linear systems, JSON persistence of solutions, and a small step runner.

Run the tests with `python3 -m unittest`. CI on main has one failing test since 0.3.0: tests/test_pipeline.py::test_all_steps_run.
GS_EOF

cat > gridsolve/__init__.py <<'GS_EOF'
GS_EOF

cat > gridsolve/solver.py <<'GS_EOF'
"""Closed-form solutions of 2x2 linear systems a @ x = b."""
import math

_CALL_LOG = []


def _reset_call_log():
    """Clear the call log."""
    _CALL_LOG.clear()


def _check_shape(a, b):
    if len(a) != 2 or any(len(row) != 2 for row in a) or len(b) != 2:
        raise ValueError("matrix must be 2x2")
    values = [v for row in a for v in row] + list(b)
    if any(not math.isfinite(v) for v in values):
        raise ValueError("non-finite input")


def _det(a):
    return a[0][0] * a[1][1] - a[0][1] * a[1][0]


def solve(a, b):
    """Return x with a @ x = b for a 2x2 matrix a and a length-2 vector b."""
    _check_shape(a, b)
    det = _det(a)
    if det == 0:
        raise ValueError("singular matrix")
    _CALL_LOG.append((a, b))
    x0 = (b[0] * a[1][1] - b[1] * a[0][1]) / det
    x1 = (a[0][0] * b[1] - a[1][0] * b[0]) / det
    return [x0, x1]


def residual(a, x, b):
    """Return a @ x - b."""
    return [a[i][0] * x[0] + a[i][1] * x[1] - b[i] for i in range(2)]
GS_EOF

cat > gridsolve/io.py <<'GS_EOF'
"""Save and load solutions as JSON with a versioned format key."""
import json

FORMAT = "gridsolve/1"


def save_solution(path, x):
    with open(path, "w", encoding="utf-8") as f:
        json.dump({"format": FORMAT, "x": list(x)}, f)


def load_solution(path):
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    if data.get("format") != FORMAT:
        raise ValueError("unknown solution format")
    return data["x"]
GS_EOF

cat > gridsolve/pipeline.py <<'GS_EOF'
"""Run named steps in order, reporting each to a callback before it runs."""


def run_pipeline(steps, on_step):
    """Run each (name, fn) pair in order, calling on_step(name) before fn()."""
    results = []
    for i in range(len(steps) - 1):
        name, fn = steps[i]
        on_step(name)
        results.append(fn())
    return results
GS_EOF

cat > gridsolve/cli.py <<'GS_EOF'
"""Command line: gridsolve solve a00 a01 a10 a11 b0 b1"""
import sys

from .solver import solve


def parse_system(args):
    values = [float(v) for v in args]
    if len(values) != 6:
        raise SystemExit("expected six numbers")
    return [[values[0], values[1]], [values[2], values[3]]], [values[4], values[5]]


def main(argv=None):
    argv = sys.argv[1:] if argv is None else argv
    if not argv or argv[0] != "solve":
        raise SystemExit("usage: gridsolve solve a00 a01 a10 a11 b0 b1")
    a, b = parse_system(argv[1:])
    x = solve(a, b)
    print(" ".join(repr(v) for v in x))
    return x
GS_EOF

cat > tests/__init__.py <<'GS_EOF'
GS_EOF

cat > tests/test_solver.py <<'GS_EOF'
import unittest

from gridsolve import solver
from gridsolve.solver import _CALL_LOG, _det, _reset_call_log, residual, solve

IDENTITY = [[1.0, 0.0], [0.0, 1.0]]
SYSTEM = [[2.0, 1.0], [1.0, 3.0]]  # with b = [1, 2] the solution is [0.2, 0.6]


class SolveTests(unittest.TestCase):
    def test_solve_runs(self):
        solve(SYSTEM, [1.0, 2.0])

    def test_solve_identity(self):
        self.assertEqual(solve(IDENTITY, [3.0, -4.0]), [3.0, -4.0])

    def test_solve_known_system(self):
        x = solve(SYSTEM, [1.0, 2.0])
        self.assertAlmostEqual(x[0], 0.2, places=12)
        self.assertAlmostEqual(x[1], 0.6, places=12)
        for r in residual(SYSTEM, x, [1.0, 2.0]):
            self.assertAlmostEqual(r, 0.0, places=12)

    def test_solve_matches_det_formula(self):
        a, b = SYSTEM, [1.0, 2.0]
        det = _det(a)
        expected = [(b[0] * a[1][1] - b[1] * a[0][1]) / det,
                    (a[0][0] * b[1] - a[1][0] * b[0]) / det]
        self.assertEqual(solve(a, b), expected)

    def test_rejects_singular(self):
        with self.assertRaises(ValueError):
            solve([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]], [1.0, 2.0])

    def test_solve_calls_logged(self):
        _reset_call_log()
        solve(IDENTITY, [1.0, 1.0])
        self.assertEqual(len(_CALL_LOG), 1)

    def test_no_legacy_solve2(self):
        self.assertFalse(hasattr(solver, "solve2"))
GS_EOF

cat > tests/test_regression.py <<'GS_EOF'
import math
import unittest

from gridsolve.solver import solve


class RegressionTests(unittest.TestCase):
    def test_issue_12_rejects_non_finite(self):
        # Issue 12: a NaN right-hand side used to return NaN silently.
        with self.assertRaises(ValueError):
            solve([[1.0, 0.0], [0.0, 1.0]], [math.nan, 1.0])
GS_EOF

cat > tests/test_cli.py <<'GS_EOF'
import unittest

from gridsolve.cli import main


class CliTests(unittest.TestCase):
    def test_cli_parses_six_numbers(self):
        self.assertEqual(main(["solve", "1", "0", "0", "1", "3", "-4"]), [3.0, -4.0])
        with self.assertRaises(SystemExit):
            main(["solve", "1", "0", "0", "1", "3"])

    def test_cli_nan_issue_12(self):
        with self.assertRaises(ValueError):
            main(["solve", "1", "0", "0", "1", "nan", "1"])
GS_EOF

cat > tests/test_io.py <<'GS_EOF'
import json
import os
import tempfile
import unittest
from unittest import mock

from gridsolve.io import load_solution, save_solution


class IoTests(unittest.TestCase):
    def setUp(self):
        self.dir = tempfile.TemporaryDirectory()
        self.path = os.path.join(self.dir.name, "x.json")

    def tearDown(self):
        self.dir.cleanup()

    def test_roundtrip(self):
        save_solution(self.path, [0.2, 0.6])
        self.assertEqual(load_solution(self.path), [0.2, 0.6])

    def test_saved_file_has_format_key(self):
        save_solution(self.path, [1.0, 2.0])
        with open(self.path, encoding="utf-8") as f:
            self.assertEqual(json.load(f)["format"], "gridsolve/1")

    def test_save_uses_json_dump(self):
        with mock.patch("gridsolve.io.json.dump") as dump:
            save_solution(self.path, [1.0, 2.0])
        dump.assert_called_once()
GS_EOF

cat > tests/test_pipeline.py <<'GS_EOF'
import unittest

from gridsolve.pipeline import run_pipeline


def _steps(events):
    return [
        ("load", lambda: events.append("ran load") or 1),
        ("solve", lambda: events.append("ran solve") or 2),
        ("save", lambda: events.append("ran save") or 3),
    ]


class PipelineTests(unittest.TestCase):
    def test_callback_precedes_step(self):
        events = []
        run_pipeline(_steps(events), lambda name: events.append("before " + name))
        self.assertEqual(events[:4], ["before load", "ran load", "before solve", "ran solve"])

    def test_all_steps_run(self):
        events = []
        results = run_pipeline(_steps(events), lambda name: events.append("before " + name))
        self.assertEqual([e for e in events if e.startswith("before ")], ["before load", "before solve", "before save"])
        self.assertEqual(results, [1, 2, 3])
GS_EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "gridsolve 0.3.0 with its test suite"
