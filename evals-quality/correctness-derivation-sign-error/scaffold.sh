#!/usr/bin/env bash
# Fixture: a small ZNE package whose Richardson extrapolation is still a stub, plus a
# derivation note from another agent. Step 2 of the note drops a sign, so its weight
# formula is right for an odd number of scale factors and sign-flipped for an even number.
set -euo pipefail

mkdir -p zne tests notes

cat > zne/__init__.py <<'EOF'
"""Zero-noise extrapolation (ZNE) utilities."""
EOF

cat > zne/folding.py <<'EOF'
"""Global unitary folding for zero-noise extrapolation.

A circuit is a list of gate names applied in order, and "G^-1" is the inverse of
gate "G". Folding with an odd integer scale factor s = 2k + 1 replaces the circuit
C by C (C^-1 C)^k, which multiplies the gate noise of the circuit by about s.
"""

SCALE_FACTOR_PRESETS = {
    "linear": (1, 3),
    "quadratic": (1, 3, 5),
    "cubic": (1, 3, 5, 7),
}
DEFAULT_SCALE_FACTORS = SCALE_FACTOR_PRESETS["quadratic"]


def inverse(circuit):
    """Return the inverse circuit."""
    return [g[:-3] if g.endswith("^-1") else g + "^-1" for g in reversed(circuit)]


def fold_circuit(circuit, scale):
    """Fold `circuit` globally to the odd integer noise scale factor `scale`."""
    if scale < 1 or scale % 2 != 1:
        raise ValueError(f"scale factor must be an odd positive integer, got {scale}")
    k = (scale - 1) // 2
    return list(circuit) + (inverse(circuit) + list(circuit)) * k
EOF

cat > zne/extrapolate.py <<'EOF'
"""Richardson extrapolation of expectation values to zero noise."""


def richardson_weights(scale_factors):
    """Return the weights w_i with E(0) ~= sum_i w_i E(scale_factors[i])."""
    raise NotImplementedError


def extrapolate(scale_factors, values, std_errors=None):
    """Extrapolate expectation values measured at `scale_factors` to zero noise.

    Returns (estimate, std_error); std_error is None when std_errors is None.
    """
    raise NotImplementedError
EOF

cat > zne/pipeline.py <<'EOF'
"""End-to-end ZNE: fold, execute, extrapolate."""

from .extrapolate import extrapolate
from .folding import DEFAULT_SCALE_FACTORS, SCALE_FACTOR_PRESETS, fold_circuit


def run_zne(circuit, executor, scale_factors=DEFAULT_SCALE_FACTORS, shots=4000):
    """Zero-noise estimate of the observable measured by `executor`.

    executor(circuit, shots) returns (mean, standard_error) for one folded circuit.
    scale_factors is a tuple of odd integers or a preset name from SCALE_FACTOR_PRESETS.
    """
    if isinstance(scale_factors, str):
        scale_factors = SCALE_FACTOR_PRESETS[scale_factors]
    means, errors = [], []
    for scale in scale_factors:
        mean, err = executor(fold_circuit(circuit, scale), shots)
        means.append(mean)
        errors.append(err)
    return extrapolate(scale_factors, means, errors)
EOF

touch tests/__init__.py

cat > tests/test_folding.py <<'EOF'
import unittest

from zne.folding import fold_circuit, inverse


class FoldingTest(unittest.TestCase):
    def test_scale_one_is_identity(self):
        self.assertEqual(fold_circuit(["H", "CX"], 1), ["H", "CX"])

    def test_scale_three_triples_length(self):
        self.assertEqual(len(fold_circuit(["H", "CX", "RZ"], 3)), 9)

    def test_inverse_round_trip(self):
        circuit = ["H", "S", "CX"]
        self.assertEqual(inverse(inverse(circuit)), circuit)

    def test_even_scale_rejected(self):
        with self.assertRaises(ValueError):
            fold_circuit(["H"], 2)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_pipeline.py <<'EOF'
import unittest

from zne.pipeline import run_zne


def linear_noise_executor(circuit, shots):
    # Each gate costs 1% of signal, so E(s) = 1 - 0.1 s for a 10-gate circuit.
    return 1.0 - 0.01 * len(circuit), 0.001


class PipelineTest(unittest.TestCase):
    def test_default_recovers_noiseless_value(self):
        estimate, _ = run_zne(["H"] * 10, linear_noise_executor)
        self.assertAlmostEqual(estimate, 1.0, places=9)


if __name__ == "__main__":
    unittest.main()
EOF

cat > notes/richardson-derivation.md <<'EOF'
# Richardson extrapolation weights for ZNE

Prepared by the analysis agent for the `zne` package, to be implemented in
`zne/extrapolate.py`.

## Setup

We measure expectation values E_i = E(λ_i) at distinct noise scale factors
λ_1 < ... < λ_n, where λ_1 = 1 is the unfolded circuit. Near zero noise we model

    E(λ) = E_0 + c_1 λ + ... + c_{n-1} λ^{n-1} + O(λ^n),

and we want E_0 = E(0).

## Step 1: interpolating polynomial

The unique polynomial p of degree at most n - 1 through the points (λ_i, E_i) is

    p(λ) = Σ_i E_i L_i(λ),    L_i(λ) = Π_{j≠i} (λ - λ_j) / (λ_i - λ_j).

## Step 2: evaluate at zero

The estimate is Ê_0 = p(0) = Σ_i w_i E_i with

    w_i = L_i(0) = Π_{j≠i} (0 - λ_j) / (λ_i - λ_j) = Π_{j≠i} λ_j / (λ_i - λ_j).

## Step 3: check on the default scale factors

For λ = (1, 3, 5):

    w_1 = (3 · 5) / ((1 - 3)(1 - 5)) = 15/8
    w_2 = (1 · 5) / ((3 - 1)(3 - 5)) = -5/4
    w_3 = (1 · 3) / ((5 - 1)(5 - 3)) = 3/8

The weights sum to 1, as they must, since the extrapolation reproduces a
constant E(λ) = E_0 exactly.

## Step 4: statistical error

If the E_i are estimated independently with standard errors σ_i, then

    Var(Ê_0) = Σ_i w_i² σ_i²,

so the reported standard error is sqrt(Σ_i w_i² σ_i²). For the default scale
factors and equal σ_i = σ this is about 2.28 σ.
EOF
