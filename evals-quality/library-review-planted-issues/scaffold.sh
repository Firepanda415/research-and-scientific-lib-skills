#!/usr/bin/env bash
# Fixture: shotkit 0.3.1, a small readout-statistics library with planted issues:
#   1. mitigate_z adds the readout offset (e1 - e0) where docs/mitigation.md subtracts it;
#   2. the only mitigate_z test uses e0 == e1, so the offset vanishes and the test cannot fail;
#   3. estimate_with_ci always uses the Wald interval, which has zero width when all shots agree;
#   4. mitigate_counts builds and solves a dense 2^n x 2^n system although the README
#      advertises 20 qubits and the model is a tensor product;
#   5. save_results writes none of the provenance the README promises.
# It also has style-only distractions (camelCase names, %-formatting, no type hints).
set -euo pipefail

mkdir -p shotkit tests docs

cat > README.md <<'EOF'
# shotkit 0.3.1

Readout statistics for superconducting-qubit experiments.

- `shotkit.estimate`: per-qubit <Z> estimates with 95% confidence intervals from
  bitstring counts (bitstrings are written qubit 0 first).
- `shotkit.mitigate`: readout-error mitigation under an uncorrelated (tensor-product)
  readout model, for single-qubit <Z> values and for full readout distributions of
  up to 20 qubits.
- `shotkit.io`: `save_results(path, results)` writes a reproducible record of an
  analysis: each estimate together with its shot count, the readout calibration
  (e0, e1) used, and the shotkit version.

Example:

    results = []
    for q in range(n_qubits):
        z, lo, hi = estimate_with_ci(counts, q)
        results.append({"qubit": q, "z": mitigate_z(z, e0[q], e1[q]), "ci": [lo, hi]})
    save_results("run42.json", results)

Theory: docs/mitigation.md. Tests: `python3 -m unittest`.
EOF

cat > docs/mitigation.md <<'EOF'
# Readout mitigation

For qubit q, let e0 = P(read 1 | prepared 0) and e1 = P(read 0 | prepared 1).
The measured probabilities are p_raw = A p with A = [[1 - e0, e1], [e0, 1 - e1]].

Single-qubit <Z>: from p_raw(0) - p_raw(1),

    <Z>_raw = (1 - e0 - e1) <Z> + (e1 - e0),

so the mitigated value is

    <Z> = (<Z>_raw - (e1 - e0)) / (1 - e0 - e1).

Full distributions: with uncorrelated readout, A = A_0 ⊗ A_1 ⊗ ... ⊗ A_{n-1},
so A^{-1} = A_0^{-1} ⊗ ... ⊗ A_{n-1}^{-1}. Mitigated quasi-probabilities may be
slightly negative; they are returned as they are.
EOF

cat > shotkit/__init__.py <<'EOF'
"""Readout statistics for qubit experiments."""
__version__ = "0.3.1"
EOF

cat > shotkit/estimate.py <<'EOF'
"""Single-qubit Pauli-Z estimates from bitstring counts."""
import math


def z_expectation(counts, qubit):
    """Mean of Z on `qubit` from counts keyed by bitstrings written qubit 0 first."""
    nShots = sum(counts.values())
    nZero = sum(c for bits, c in counts.items() if bits[qubit] == "0")
    return (2 * nZero - nShots) / nShots


def wald_interval(p_hat, shots, z=1.96):
    """Normal-approximation confidence interval for a binomial proportion.

    The approximation is adequate when shots * p_hat * (1 - p_hat) >= 10.
    """
    half = z * math.sqrt(p_hat * (1 - p_hat) / shots)
    return max(0.0, p_hat - half), min(1.0, p_hat + half)


def estimate_with_ci(counts, qubit):
    """Return (<Z>, lower, upper), with a 95% confidence interval for <Z>."""
    shots = sum(counts.values())
    z = z_expectation(counts, qubit)
    lo, hi = wald_interval((1 + z) / 2, shots)
    return z, 2 * lo - 1, 2 * hi - 1
EOF

cat > shotkit/mitigate.py <<'EOF'
"""Readout-error mitigation under an uncorrelated readout model (docs/mitigation.md).

e0[q] = P(read 1 | prepared 0) and e1[q] = P(read 0 | prepared 1) for qubit q.
"""


def mitigate_z(zRaw, e0, e1):
    """Mitigated single-qubit <Z> from the raw <Z> and that qubit's readout errors."""
    return (zRaw + (e1 - e0)) / (1 - e0 - e1)


def _assignment_matrix(e0, e1):
    """A[measured][prepared] = prod_q P(measured bit q | prepared bit q)."""
    n = len(e0)
    dim = 2 ** n
    A = [[1.0] * dim for _ in range(dim)]
    for m in range(dim):
        for p in range(dim):
            for q in range(n):
                shift = n - 1 - q
                mb, pb = (m >> shift) & 1, (p >> shift) & 1
                if pb == 0:
                    A[m][p] *= e0[q] if mb else 1 - e0[q]
                else:
                    A[m][p] *= 1 - e1[q] if mb else e1[q]
    return A


def _solve(A, b):
    """Solve A x = b by Gaussian elimination with partial pivoting."""
    n = len(b)
    M = [row[:] + [b[i]] for i, row in enumerate(A)]
    for col in range(n):
        piv = max(range(col, n), key=lambda r: abs(M[r][col]))
        M[col], M[piv] = M[piv], M[col]
        for r in range(col + 1, n):
            f = M[r][col] / M[col][col]
            for c in range(col, n + 1):
                M[r][c] -= f * M[col][c]
    x = [0.0] * n
    for r in range(n - 1, -1, -1):
        x[r] = (M[r][n] - sum(M[r][c] * x[c] for c in range(r + 1, n))) / M[r][r]
    return x


def mitigate_counts(counts, e0, e1):
    """Mitigated quasi-probability of every n-qubit bitstring, qubit 0 first."""
    n = len(e0)
    shots = sum(counts.values())
    raw = [counts.get(format(i, "0%db" % n), 0) / shots for i in range(2 ** n)]
    probs = _solve(_assignment_matrix(e0, e1), raw)
    return {format(i, "0%db" % n): p for i, p in enumerate(probs)}
EOF

cat > shotkit/io.py <<'EOF'
"""Saving analysis results."""
import json


def save_results(path, results):
    """Write the analysis results (a list of dicts) to `path` as JSON."""
    with open(path, "w") as f:
        json.dump(results, f, indent=2)
EOF

touch tests/__init__.py

cat > tests/test_estimate.py <<'EOF'
import unittest

from shotkit.estimate import estimate_with_ci, z_expectation


class EstimateTest(unittest.TestCase):
    def test_z_expectation(self):
        self.assertAlmostEqual(z_expectation({"0": 700, "1": 300}, 0), 0.4)

    def test_interval_contains_estimate(self):
        z, lo, hi = estimate_with_ci({"00": 600, "01": 100, "10": 250, "11": 50}, 0)
        self.assertLess(lo, z)
        self.assertLess(z, hi)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_mitigate.py <<'EOF'
import unittest

from shotkit.mitigate import mitigate_counts, mitigate_z


class MitigateTest(unittest.TestCase):
    def test_mitigate_z_recovers_true_value(self):
        e0 = e1 = 0.05
        z_true = 0.6
        z_raw = (1 - e0 - e1) * z_true + (e1 - e0)
        self.assertAlmostEqual(mitigate_z(z_raw, e0, e1), z_true, places=12)

    def test_mitigate_counts_without_errors(self):
        counts = {"00": 30, "01": 10, "10": 40, "11": 20}
        probs = mitigate_counts(counts, [0.0, 0.0], [0.0, 0.0])
        self.assertAlmostEqual(probs["10"], 0.4, places=12)


if __name__ == "__main__":
    unittest.main()
EOF
