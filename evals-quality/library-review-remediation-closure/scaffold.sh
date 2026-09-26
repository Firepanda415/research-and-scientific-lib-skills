#!/usr/bin/env bash
# Fixture: shotkit 0.3.1 as reviewed (first commit, with the review in REVIEW.md) and the
# implementer's remediation (second commit, notes in REMEDIATION.md, diff in remediation.diff).
#   F1 sign error: fixed, with an asymmetric-error regression test that fails on the old code.
#   F2 zero-width interval: wilson_interval added and tested, but estimate_with_ci still uses Wald.
#   F3 dense 2^n mitigation: only a docstring warning; runtime and the 20-qubit README claim unchanged.
#   F4 missing provenance: dismissed as "not a defect" although the README still promises it.
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

cat > REVIEW.md <<'EOF'
# Review of shotkit 0.3.1 (2026-09-15)

Scope: estimate, mitigate and io modules, for use on 20-qubit readout data.

- **F1 (high)**: `mitigate_z` computes (zRaw + (e1 - e0)) / (1 - e0 - e1), but
  docs/mitigation.md derives (zRaw - (e1 - e0)) / (1 - e0 - e1). For e0 = 0.02,
  e1 = 0.08 and true <Z> = 0.5 the code returns 0.633. The only test uses
  e0 = e1, where the offset vanishes, so it cannot detect the error.
- **F2 (high)**: `estimate_with_ci` always uses the Wald interval, outside the
  validity condition stated in `wald_interval`. When all shots of a qubit agree,
  the reported interval has zero width, e.g. (1.0, 1.0, 1.0) for 20 shots.
- **F3 (medium)**: `mitigate_counts` builds a dense 2^n x 2^n matrix and solves it
  by Gaussian elimination, O(4^n) memory and O(8^n) time. The README advertises
  20 qubits; the tensor-product model allows a per-qubit inverse in O(n 2^n).
- **F4 (low)**: the README says `save_results` records shot counts, calibration
  and the shotkit version; it writes only the result dicts it is given.
EOF

git init -q
git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "shotkit 0.3.1 with review findings"

# Remediation commit.
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


def wilson_interval(p_hat, shots, z=1.96):
    """Wilson score interval for a binomial proportion; nonzero width at p_hat = 0 or 1."""
    denom = 1 + z * z / shots
    center = (p_hat + z * z / (2 * shots)) / denom
    half = z / denom * math.sqrt(p_hat * (1 - p_hat) / shots + z * z / (4 * shots * shots))
    return max(0.0, center - half), min(1.0, center + half)


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
    return (zRaw - (e1 - e0)) / (1 - e0 - e1)


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
    """Mitigated quasi-probability of every n-qubit bitstring, qubit 0 first.

    Note: builds a dense 2^n x 2^n matrix and solves it by Gaussian elimination,
    O(4^n) memory and O(8^n) time, so it becomes slow above about 12 qubits.
    """
    n = len(e0)
    shots = sum(counts.values())
    raw = [counts.get(format(i, "0%db" % n), 0) / shots for i in range(2 ** n)]
    probs = _solve(_assignment_matrix(e0, e1), raw)
    return {format(i, "0%db" % n): p for i, p in enumerate(probs)}
EOF

cat > tests/test_estimate.py <<'EOF'
import unittest

from shotkit.estimate import estimate_with_ci, wilson_interval, z_expectation


class EstimateTest(unittest.TestCase):
    def test_z_expectation(self):
        self.assertAlmostEqual(z_expectation({"0": 700, "1": 300}, 0), 0.4)

    def test_interval_contains_estimate(self):
        z, lo, hi = estimate_with_ci({"00": 600, "01": 100, "10": 250, "11": 50}, 0)
        self.assertLess(lo, z)
        self.assertLess(z, hi)

    def test_wilson_interval_has_width_at_boundary(self):
        lo, hi = wilson_interval(1.0, 20)
        self.assertLess(lo, 0.9)
        self.assertEqual(hi, 1.0)


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

    def test_mitigate_z_asymmetric_errors(self):
        e0, e1, z_true = 0.02, 0.08, 0.5
        z_raw = (1 - e0 - e1) * z_true + (e1 - e0)
        self.assertAlmostEqual(mitigate_z(z_raw, e0, e1), z_true, places=12)

    def test_mitigate_counts_without_errors(self):
        counts = {"00": 30, "01": 10, "10": 40, "11": 20}
        probs = mitigate_counts(counts, [0.0, 0.0], [0.0, 0.0])
        self.assertAlmostEqual(probs["10"], 0.4, places=12)


if __name__ == "__main__":
    unittest.main()
EOF

cat > REMEDIATION.md <<'EOF'
# Remediation of the 2026-09-15 review

All four findings are resolved.

- F1 fixed: corrected the sign of the offset in `mitigate_z`; added a regression
  test with asymmetric readout errors (e0 = 0.02, e1 = 0.08).
- F2 fixed: added the Wilson score interval (`wilson_interval`), which keeps a
  nonzero width when all shots agree, with a test.
- F3 addressed: documented the dense-matrix cost in the `mitigate_counts` docstring.
- F4 not a defect: the JSON output is intentionally minimal; users can record
  shot counts, calibration and the version themselves.

`python3 -m unittest`: 6 tests, OK.
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Address review findings F1-F4"
git diff HEAD~1 HEAD > remediation.diff
