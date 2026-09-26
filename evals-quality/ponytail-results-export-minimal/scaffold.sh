#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qbench tests

cat > README.md <<'EOF'
# qbench

Timing and fidelity benchmarks for small quantum-circuit simulators.
`qbench.bench.run_suite` runs a list of cases and returns `BenchResult`
records. The cluster scripts write results as JSON files that
`qbench.io.load_results` reads.

Run the tests with `python3 -m unittest`.
EOF

cat > qbench/__init__.py <<'EOF'
EOF

cat > qbench/bench.py <<'EOF'
"""Run benchmark cases and collect timing and fidelity results."""
from dataclasses import dataclass
import time


@dataclass
class BenchResult:
    name: str
    n_qubits: int
    depth: int
    shots: int
    seconds: float
    fidelity: float


def run_case(name, n_qubits, depth, shots, simulate):
    """Time one call of `simulate(n_qubits, depth, shots)`, which returns a fidelity."""
    start = time.perf_counter()
    fidelity = simulate(n_qubits, depth, shots)
    return BenchResult(name, n_qubits, depth, shots, time.perf_counter() - start, fidelity)


def run_suite(cases, simulate):
    """Run each (name, n_qubits, depth, shots) case with `simulate`."""
    return [run_case(*case, simulate=simulate) for case in cases]
EOF

cat > qbench/io.py <<'EOF'
"""Reading benchmark results written by the cluster scripts."""
import json

from .bench import BenchResult

SCHEMA_VERSION = 1


def load_results(path):
    """Read results from a JSON file of the form {"schema": 1, "results": [{...}, ...]}."""
    with open(path) as f:
        data = json.load(f)
    if data.get("schema") != SCHEMA_VERSION:
        raise ValueError(f"unsupported results schema {data.get('schema')!r}")
    return [BenchResult(**row) for row in data["results"]]
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_io.py <<'EOF'
import json
import os
import tempfile
import unittest

from qbench.bench import BenchResult
from qbench.io import load_results


class LoadResultsTest(unittest.TestCase):
    def write(self, directory, payload):
        path = os.path.join(directory, "results.json")
        with open(path, "w") as f:
            json.dump(payload, f)
        return path

    def test_reads_schema_1(self):
        row = {"name": "ghz", "n_qubits": 4, "depth": 4, "shots": 1000, "seconds": 0.5, "fidelity": 0.99}
        with tempfile.TemporaryDirectory() as d:
            path = self.write(d, {"schema": 1, "results": [row]})
            self.assertEqual(load_results(path), [BenchResult("ghz", 4, 4, 1000, 0.5, 0.99)])

    def test_rejects_unknown_schema(self):
        with tempfile.TemporaryDirectory() as d:
            path = self.write(d, {"schema": 2, "results": []})
            with self.assertRaises(ValueError):
                load_results(path)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_bench.py <<'EOF'
import unittest

from qbench.bench import run_suite


class RunSuiteTest(unittest.TestCase):
    def test_collects_one_result_per_case(self):
        results = run_suite([("ghz", 3, 3, 100), ("qft", 4, 10, 200)], simulate=lambda n, d, s: 1.0 - 0.01 * n)
        self.assertEqual([r.name for r in results], ["ghz", "qft"])
        self.assertAlmostEqual(results[1].fidelity, 0.96)
        self.assertGreaterEqual(results[0].seconds, 0.0)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Add benchmark runner and result loader"
