#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p twolevel tests

cat > twolevel/__init__.py <<'EOF'
EOF

cat > twolevel/energy.py <<'EOF'
"""Spectrum of real symmetric two-level Hamiltonians H = [[a, c], [c, d]]."""
import math


def _eigvals(h):
    a, c, d = h[0][0], h[0][1], h[1][1]
    mean = (a + d) / 2
    radius = math.hypot((a - d) / 2, c)
    return mean - radius, mean + radius


def ground_energy(h):
    """Lowest eigenvalue of H."""
    if h[1][0] != h[0][1]:
        raise ValueError("H must be symmetric")
    if h[0][1] == 0.0:
        return min(h[0][0], h[1][1])
    return _eigvals(h)[0]


def spectral_gap(h):
    """Difference between the two eigenvalues of H."""
    if h[1][0] != h[0][1]:
        raise ValueError("H must be symmetric")
    low, high = _eigvals(h)
    return high - low
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_energy.py <<'EOF'
import unittest

from twolevel.energy import _eigvals, ground_energy, spectral_gap

PAULI_X = [[0.0, 1.0], [1.0, 0.0]]
PAULI_Z = [[1.0, 0.0], [0.0, -1.0]]
MIXED = [[0.3, 0.4], [0.4, -0.3]]  # 0.3 Z + 0.4 X, eigenvalues -0.5 and 0.5


class GroundEnergyTests(unittest.TestCase):
    def test_pauli_x_ground(self):
        self.assertAlmostEqual(ground_energy(PAULI_X), -1.0, places=12)

    def test_sigma_x_lowest_level(self):
        sigma_x = [[0.0, 1.0], [1.0, 0.0]]
        lowest = ground_energy(sigma_x)
        self.assertAlmostEqual(lowest, -1.0, places=12)

    def test_pauli_z_ground(self):
        self.assertAlmostEqual(ground_energy(PAULI_Z), -1.0, places=12)

    def test_mixed_closed_form(self):
        self.assertAlmostEqual(ground_energy(MIXED), -0.5, places=12)

    def test_matches_eigvals_helper(self):
        h = [[2.0, 1.0], [1.0, 3.0]]
        self.assertEqual(ground_energy(h), _eigvals(h)[0])

    def test_rejects_nonsymmetric(self):
        with self.assertRaises(ValueError):
            ground_energy([[0.0, 1.0], [2.0, 0.0]])


class GapTests(unittest.TestCase):
    def test_mixed_gap_closed_form(self):
        self.assertAlmostEqual(spectral_gap(MIXED), 1.0, places=12)

    def test_gap_matches_helper(self):
        h = [[2.0, 1.0], [1.0, 3.0]]
        low, high = _eigvals(h)
        self.assertEqual(spectral_gap(h), high - low)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Two-level spectrum helpers with tests"
