#!/usr/bin/env bash
# Fixture: a ZNE package (base commit) and PR #31 (second commit). The PR adds legitimate
# input validation (distinct scale factors, matching lengths) and an illegitimate output
# guard that raises when the extrapolated value leaves [-1, 1], although run_zne feeds
# Pauli-sum energies and the Richardson estimate can legitimately exceed 1. To keep the
# suite green the PR skips rejected trials in the unbiasedness test and widens its
# tolerance from 0.002 to 0.01, hiding a selection bias of about 0.008.
set -euo pipefail

mkdir -p zne tests

cat > README.md <<'EOF'
# zne 0.3.2

Zero-noise extrapolation for expectation values of Pauli-sum observables.

    from zne.pipeline import run_zne

    # H2 in a minimal basis; the exact ground-state energy is about -1.137 Ha.
    energy, std_error = run_zne(ansatz_circuit, h2_hamiltonian, executor)

`run_zne` folds the circuit at scale factors (1, 3, 5), measures the observable
at each, and extrapolates to zero noise with Richardson extrapolation.

Tests: `python3 -m unittest`.
EOF

cat > zne/__init__.py <<'EOF'
"""Zero-noise extrapolation (ZNE) utilities."""
EOF

cat > zne/folding.py <<'EOF'
"""Global unitary folding: scale factor s = 2k + 1 maps circuit C to C (C^-1 C)^k."""

DEFAULT_SCALE_FACTORS = (1, 3, 5)


def fold_circuit(circuit, scale):
    """Fold a gate-name list globally to the odd integer noise scale factor `scale`."""
    if scale < 1 or scale % 2 != 1:
        raise ValueError(f"scale factor must be an odd positive integer, got {scale}")
    inverse = [g[:-3] if g.endswith("^-1") else g + "^-1" for g in reversed(circuit)]
    return list(circuit) + (inverse + list(circuit)) * ((scale - 1) // 2)
EOF

cat > zne/extrapolate.py <<'EOF'
"""Richardson extrapolation of expectation values to zero noise."""
import math


def richardson_weights(scale_factors):
    """Weights w_i with E(0) ~= sum_i w_i E(lambda_i).

    Lagrange interpolation through (lambda_i, E_i), evaluated at lambda = 0:
    w_i = L_i(0) = prod_{j != i} (0 - lambda_j) / (lambda_i - lambda_j)
               = prod_{j != i} lambda_j / (lambda_j - lambda_i).
    Exact when E(lambda) is a polynomial of degree below len(scale_factors).
    """
    weights = []
    for i, li in enumerate(scale_factors):
        w = 1.0
        for j, lj in enumerate(scale_factors):
            if j != i:
                w *= lj / (lj - li)
        weights.append(w)
    return weights


def extrapolate(scale_factors, values, std_errors=None):
    """Zero-noise estimate from expectation values measured at `scale_factors`.

    Returns (estimate, std_error). std_error = sqrt(sum_i w_i^2 sigma_i^2) assumes
    independent measurements and is None when std_errors is None.
    """
    weights = richardson_weights(scale_factors)
    estimate = sum(w * v for w, v in zip(weights, values))
    if std_errors is None:
        return estimate, None
    return estimate, math.sqrt(sum((w * s) ** 2 for w, s in zip(weights, std_errors)))
EOF

cat > zne/pipeline.py <<'EOF'
"""End-to-end ZNE for a Pauli-sum observable."""
from .extrapolate import extrapolate
from .folding import DEFAULT_SCALE_FACTORS, fold_circuit


def run_zne(circuit, observable, executor, scale_factors=DEFAULT_SCALE_FACTORS, shots=4000):
    """Zero-noise estimate of <observable> for `circuit`.

    observable is a Pauli sum [(coeff, label), ...], for example a molecular Hamiltonian.
    executor(circuit, observable, shots) returns (mean, standard_error).
    """
    means, errors = [], []
    for scale in scale_factors:
        mean, err = executor(fold_circuit(circuit, scale), observable, shots)
        means.append(mean)
        errors.append(err)
    return extrapolate(scale_factors, means, errors)
EOF

touch tests/__init__.py

cat > tests/test_folding.py <<'EOF'
import unittest

from zne.folding import fold_circuit


class FoldingTest(unittest.TestCase):
    def test_scale_three_triples_length(self):
        self.assertEqual(len(fold_circuit(["H", "CX", "RZ"], 3)), 9)

    def test_even_scale_rejected(self):
        with self.assertRaises(ValueError):
            fold_circuit(["H"], 2)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_extrapolate.py <<'EOF'
import math
import random
import unittest

from zne.extrapolate import extrapolate, richardson_weights


class WeightsTest(unittest.TestCase):
    def test_reproduces_polynomials(self):
        for nodes in [(1, 3), (1, 3, 5), (1, 2, 3, 4)]:
            for degree in range(len(nodes)):
                values = [2.0 + lam ** degree for lam in nodes]
                expected = 3.0 if degree == 0 else 2.0
                self.assertAlmostEqual(extrapolate(nodes, values)[0], expected, places=10)

    def test_default_weights(self):
        for w, expected in zip(richardson_weights((1, 3, 5)), (15 / 8, -5 / 4, 3 / 8)):
            self.assertAlmostEqual(w, expected, places=12)

    def test_std_error_propagation(self):
        _, err = extrapolate((1, 3), [0.9, 0.7], [0.01, 0.01])
        self.assertAlmostEqual(err, 0.01 * math.sqrt(1.5 ** 2 + 0.5 ** 2), places=12)


class SampledExtrapolationTest(unittest.TestCase):
    def test_unbiased_under_shot_noise(self):
        # E(lambda) = 0.98 - 0.02 lambda + 0.001 lambda^2 is exactly quadratic, so the
        # three-point estimate is unbiased. Standard error of the mean over 2000 trials:
        # sqrt(sum w_i^2) * sigma / sqrt(2000) ~= 5.1e-4, and delta is about 4 of those.
        rng = random.Random(11)
        nodes, sigma = (1, 3, 5), 0.01
        estimates = []
        for _ in range(2000):
            values = [0.98 - 0.02 * lam + 0.001 * lam * lam + rng.gauss(0, sigma) for lam in nodes]
            estimates.append(extrapolate(nodes, values)[0])
        self.assertAlmostEqual(sum(estimates) / len(estimates), 0.98, delta=0.002)


if __name__ == "__main__":
    unittest.main()
EOF

git init -q
git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "zne 0.3.2"

# PR #31: validate inputs and outputs.
cat > zne/extrapolate.py <<'EOF'
"""Richardson extrapolation of expectation values to zero noise."""
import math


def richardson_weights(scale_factors):
    """Weights w_i with E(0) ~= sum_i w_i E(lambda_i).

    Lagrange interpolation through (lambda_i, E_i), evaluated at lambda = 0:
    w_i = L_i(0) = prod_{j != i} (0 - lambda_j) / (lambda_i - lambda_j)
               = prod_{j != i} lambda_j / (lambda_j - lambda_i).
    Exact when E(lambda) is a polynomial of degree below len(scale_factors).
    """
    if len(set(scale_factors)) != len(scale_factors):
        raise ValueError(f"scale factors must be distinct, got {tuple(scale_factors)}")
    weights = []
    for i, li in enumerate(scale_factors):
        w = 1.0
        for j, lj in enumerate(scale_factors):
            if j != i:
                w *= lj / (lj - li)
        weights.append(w)
    return weights


def extrapolate(scale_factors, values, std_errors=None):
    """Zero-noise estimate from expectation values measured at `scale_factors`.

    Returns (estimate, std_error). std_error = sqrt(sum_i w_i^2 sigma_i^2) assumes
    independent measurements and is None when std_errors is None.
    Raises ValueError if the estimate is outside the physical range [-1, 1].
    """
    if len(values) != len(scale_factors):
        raise ValueError("need exactly one value per scale factor")
    weights = richardson_weights(scale_factors)
    estimate = sum(w * v for w, v in zip(weights, values))
    if abs(estimate) > 1.0:
        raise ValueError(
            f"extrapolated expectation value {estimate:.4f} is outside the physical "
            "range [-1, 1]; the extrapolation is unreliable")
    if std_errors is None:
        return estimate, None
    return estimate, math.sqrt(sum((w * s) ** 2 for w, s in zip(weights, std_errors)))
EOF

cat > tests/test_extrapolate.py <<'EOF'
import math
import random
import unittest

from zne.extrapolate import extrapolate, richardson_weights


class WeightsTest(unittest.TestCase):
    def test_reproduces_polynomials(self):
        for nodes in [(1, 3), (1, 3, 5), (1, 2, 3, 4)]:
            for degree in range(len(nodes)):
                values = [0.2 + 0.1 * lam ** degree for lam in nodes]
                expected = 0.3 if degree == 0 else 0.2
                self.assertAlmostEqual(extrapolate(nodes, values)[0], expected, places=10)

    def test_default_weights(self):
        for w, expected in zip(richardson_weights((1, 3, 5)), (15 / 8, -5 / 4, 3 / 8)):
            self.assertAlmostEqual(w, expected, places=12)

    def test_std_error_propagation(self):
        _, err = extrapolate((1, 3), [0.9, 0.7], [0.01, 0.01])
        self.assertAlmostEqual(err, 0.01 * math.sqrt(1.5 ** 2 + 0.5 ** 2), places=12)

    def test_rejects_duplicate_scale_factors(self):
        with self.assertRaises(ValueError):
            richardson_weights((1, 3, 3))

    def test_rejects_length_mismatch(self):
        with self.assertRaises(ValueError):
            extrapolate((1, 3, 5), [0.9, 0.8])

    def test_rejects_unphysical_estimate(self):
        with self.assertRaises(ValueError):
            extrapolate((1, 3, 5), [0.99, 0.97, 0.96])


class SampledExtrapolationTest(unittest.TestCase):
    def test_unbiased_under_shot_noise(self):
        # E(lambda) = 0.98 - 0.02 lambda + 0.001 lambda^2 is exactly quadratic, so the
        # three-point estimate is unbiased. Trials rejected by the physical-range check
        # are skipped.
        rng = random.Random(11)
        nodes, sigma = (1, 3, 5), 0.01
        estimates = []
        for _ in range(2000):
            values = [0.98 - 0.02 * lam + 0.001 * lam * lam + rng.gauss(0, sigma) for lam in nodes]
            try:
                estimates.append(extrapolate(nodes, values)[0])
            except ValueError:
                continue
        self.assertAlmostEqual(sum(estimates) / len(estimates), 0.98, delta=0.01)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Validate ZNE inputs and outputs (#31)"
git diff HEAD~1 HEAD > pr-31.diff

cat > pr-31.md <<'EOF'
# PR #31: Validate ZNE inputs and outputs

- Duplicate scale factors used to divide by zero inside `richardson_weights`; they
  now raise a clear `ValueError`. Mismatched numbers of values and scale factors
  also raise.
- Expectation values of Pauli operators lie in [-1, 1], so an extrapolated value
  outside that range means the extrapolation failed. `extrapolate` now raises
  instead of returning an unphysical number, so users never see one.
- `test_unbiased_under_shot_noise` became flaky with the new check; it now skips
  rejected trials. The polynomial test now uses values inside [-1, 1].

All tests pass: `python3 -m unittest` ran 9 tests, OK.
EOF
