#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p hamlite tests

cat > pyproject.toml <<'EOF'
[project]
name = "hamlite"
version = "0.2.0"
requires-python = ">=3.9"
dependencies = []
EOF

cat > README.md <<'EOF'
# hamlite

Expectation values of Pauli-sum Hamiltonians on statevectors of up to 24
qubits. A 24-qubit state has 2^24 (about 16.8 million) amplitudes, so every
kernel works matrix-free and keeps at most one extra state in memory. Qubit 0 is
the most significant bit of a basis index.

Run the tests with `python3 -m unittest`.
EOF

cat > hamlite/__init__.py <<'EOF'
EOF

cat > hamlite/expect.py <<'EOF'
"""Expectation values of diagonal (Z-only) Pauli strings."""


def z_string_expectation(label, state):
    """Return <state|P|state> for a label containing only I and Z."""
    n = len(label)
    mask = 0
    for q, p in enumerate(label):
        if p == "Z":
            mask |= 1 << (n - 1 - q)
    total = 0.0
    for index, amp in enumerate(state):
        sign = -1.0 if bin(index & mask).count("1") % 2 else 1.0
        total += sign * abs(amp) ** 2
    return total
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_expect.py <<'EOF'
import unittest

from hamlite.expect import z_string_expectation


class ZStringTests(unittest.TestCase):
    def test_zz_on_01(self):
        self.assertEqual(z_string_expectation("ZZ", [0, 1, 0, 0]), -1.0)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Z-string expectation values"

cat > hamlite/pauli.py <<'EOF'
"""Matrix-free application of general Pauli strings (I, X, Y, Z)."""
import copy

_CACHE = {}


def _popcount(x):
    count = 0
    while x:
        count += x & 1
        x >>= 1
    return count


def apply_pauli_string(label, state):
    """Return P|state> for a Pauli label such as "XYZ" (qubit 0 first).

    Each basis index i maps to i ^ flip with phase i^(number of Y) times
    (-1)^(parity of the Y and Z bits of i), so the cost is O(2^n) time and one
    output state of memory.
    """
    key = (label, tuple(state))
    if key in _CACHE:
        return _CACHE[key]
    state = copy.deepcopy(state)
    n = len(label)
    flip = phase_mask = 0
    num_y = 0
    for q, p in enumerate(label):
        bit = 1 << (n - 1 - q)
        if p in "XY":
            flip |= bit
        if p in "YZ":
            phase_mask |= bit
        if p == "Y":
            num_y += 1
    global_phase = 1j ** num_y
    out = [0j] * len(state)
    for i, amp in enumerate(state):
        sign = -1 if _popcount(i & phase_mask) % 2 else 1
        out[i ^ flip] = global_phase * sign * amp
    _CACHE[key] = out
    return out


def pauli_expectation(label, state):
    """Return <state|P|state>, which is real for a Pauli string."""
    p_state = apply_pauli_string(label, state)
    return sum(a.conjugate() * b for a, b in zip(state, p_state)).real
EOF

cat > tests/test_pauli.py <<'EOF'
import unittest

from hamlite.pauli import apply_pauli_string, pauli_expectation


class PauliStringTests(unittest.TestCase):
    def test_y_on_zero_and_one(self):
        self.assertEqual(apply_pauli_string("Y", [1, 0]), [0j, 1j])
        self.assertEqual(apply_pauli_string("Y", [0, 1]), [-1j, 0j])

    def test_xz_on_01(self):
        # X on qubit 0, Z on qubit 1: |01> -> -|11>
        self.assertEqual(apply_pauli_string("XZ", [0, 1, 0, 0]), [0j, 0j, 0j, -1 + 0j])

    def test_yy_expectation_on_bell_state(self):
        r = 2 ** -0.5
        self.assertAlmostEqual(pauli_expectation("YY", [r, 0, 0, r]), -1.0, places=12)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Add general Pauli-string application"
