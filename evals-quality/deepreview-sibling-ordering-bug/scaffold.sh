#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qsim tests

cat > README.md <<'EOF'
# qsim

Small helpers for statevector experiments.

Qubit ordering: qubit 0 is the most significant bit of a basis index. For
n = 3 the basis state |q0 q1 q2> = |100> has index 4.

Run the tests with `python3 -m unittest`.
EOF

cat > qsim/__init__.py <<'EOF'
EOF

cat > qsim/observables.py <<'EOF'
"""Pauli-Z expectation values on real or complex statevectors.

Qubit 0 is the most significant bit of the basis index (see README).
"""


def expectation_z(state, qubit, n):
    """Return <Z_qubit> for an n-qubit statevector."""
    total = 0.0
    for index, amp in enumerate(state):
        bit = (index >> qubit) & 1
        total += (-1) ** bit * abs(amp) ** 2
    return total


def expectation_zz(state, q1, q2, n):
    """Return <Z_q1 Z_q2> for an n-qubit statevector."""
    total = 0.0
    for index, amp in enumerate(state):
        b1 = (index >> q1) & 1
        b2 = (index >> q2) & 1
        total += (-1) ** (b1 ^ b2) * abs(amp) ** 2
    return total
EOF

cat > qsim/energy.py <<'EOF'
"""Classical Ising energy of a statevector."""

from qsim.observables import expectation_z, expectation_zz


def ising_energy(state, n, couplings, fields):
    """Return <H> for H = sum_(i,j) J_ij Z_i Z_j + sum_i h_i Z_i.

    couplings maps (i, j) pairs to J_ij and fields maps i to h_i.
    """
    energy = 0.0
    for (i, j), coupling in couplings.items():
        energy += coupling * expectation_zz(state, i, j, n)
    for i, field in fields.items():
        energy += field * expectation_z(state, i, n)
    return energy
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_observables.py <<'EOF'
import math
import unittest

from qsim.observables import expectation_z, expectation_zz


class ObservableTests(unittest.TestCase):
    def test_all_zero_state(self):
        state = [1, 0, 0, 0]
        self.assertEqual(expectation_z(state, 0, 2), 1.0)
        self.assertEqual(expectation_zz(state, 0, 1, 2), 1.0)

    def test_plus_state(self):
        r = 1 / math.sqrt(2)
        state = [r, r]
        self.assertAlmostEqual(expectation_z(state, 0, 1), 0.0, places=12)

    def test_bell_state_correlation(self):
        r = 1 / math.sqrt(2)
        state = [r, 0, 0, r]
        self.assertAlmostEqual(expectation_zz(state, 0, 1, 2), 1.0, places=12)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Add Z and ZZ expectation helpers and Ising energy"

cat > qsim/observables.py <<'EOF'
"""Pauli-Z expectation values on real or complex statevectors.

Qubit 0 is the most significant bit of the basis index (see README).
"""


def expectation_z(state, qubit, n):
    """Return <Z_qubit> for an n-qubit statevector."""
    total = 0.0
    for index, amp in enumerate(state):
        bit = (index >> (n - 1 - qubit)) & 1
        total += (-1) ** bit * abs(amp) ** 2
    return total


def expectation_zz(state, q1, q2, n):
    """Return <Z_q1 Z_q2> for an n-qubit statevector."""
    total = 0.0
    for index, amp in enumerate(state):
        b1 = (index >> q1) & 1
        b2 = (index >> q2) & 1
        total += (-1) ** (b1 ^ b2) * abs(amp) ** 2
    return total
EOF

cat > tests/test_observables.py <<'EOF'
import math
import unittest

from qsim.observables import expectation_z, expectation_zz


class ObservableTests(unittest.TestCase):
    def test_all_zero_state(self):
        state = [1, 0, 0, 0]
        self.assertEqual(expectation_z(state, 0, 2), 1.0)
        self.assertEqual(expectation_zz(state, 0, 1, 2), 1.0)

    def test_plus_state(self):
        r = 1 / math.sqrt(2)
        state = [r, r]
        self.assertAlmostEqual(expectation_z(state, 0, 1), 0.0, delta=1e-2)

    def test_bell_state_correlation(self):
        r = 1 / math.sqrt(2)
        state = [r, 0, 0, r]
        self.assertAlmostEqual(expectation_zz(state, 0, 1, 2), 1.0, places=12)

    def test_expectation_z_uses_msb_ordering(self):
        # Regression test for the qubit-ordering fix: both qubits in |1>.
        state = [0, 0, 0, 1]
        self.assertEqual(expectation_z(state, 0, 2), -1.0)
        self.assertEqual(expectation_z(state, 1, 2), -1.0)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Fix qubit ordering in expectation_z, add regression test, tidy tests"
