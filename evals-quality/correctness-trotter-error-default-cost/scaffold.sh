#!/usr/bin/env bash
# Fixture: a matrix-free first-order Trotter simulator for Pauli-string Hamiltonians,
# advertised for about 22 qubits, with a dense 2^n x 2^n reference module used by the
# tests. The task asks for error information on every run; the obvious implementations
# (dense exact evolution, or rerunning with more steps) add expensive work to the default path.
set -euo pipefail

mkdir -p hsim tests

cat > README.md <<'EOF'
# hsim

Statevector simulation of Hamiltonian dynamics for Hamiltonians given as sums of
Pauli strings, H = sum_k c_k P_k. Trotter evolution is matrix-free: each step
applies exp(-i c_k P_k dt) directly to the statevector, so runs of up to about
22 qubits fit on a workstation.

    from hsim.trotter import trotter_evolve

    H = [(1.0, "XXI"), (1.0, "IXX"), (0.5, "ZII"), (0.5, "IZI"), (0.5, "IIZ")]
    result = trotter_evolve(H, time=1.0, steps=50, state=initial_state)
    final_state = result.state

`hsim.reference` holds a dense matrix-exponential reference used by the test
suite. Qubit 0 is the most significant bit of a basis index.

Run the tests with `python3 -m unittest`.
EOF

cat > hsim/__init__.py <<'EOF'
"""Hamiltonian simulation on statevectors."""
EOF

cat > hsim/pauli.py <<'EOF'
"""Pauli-string operators acting on statevectors (qubit 0 = most significant bit)."""


def apply_pauli(state, label):
    """Return P|state> for the Pauli string `label` such as "XZI", without building a matrix."""
    n = len(label)
    out = [0j] * len(state)
    for index, amp in enumerate(state):
        if amp == 0:
            continue
        target, phase = index, 1
        for q, p in enumerate(label):
            mask = 1 << (n - 1 - q)
            bit = 1 if index & mask else 0
            if p == "X":
                target ^= mask
            elif p == "Y":
                target ^= mask
                phase *= -1j if bit else 1j
            elif p == "Z":
                phase *= -1 if bit else 1
        out[target] += phase * amp
    return out


def expectation(state, hamiltonian):
    """<state|H|state> for H = [(c_k, label_k), ...]."""
    total = 0.0
    for coeff, label in hamiltonian:
        p_state = apply_pauli(state, label)
        total += coeff * sum(a.conjugate() * b for a, b in zip(state, p_state)).real
    return total
EOF

cat > hsim/trotter.py <<'EOF'
"""First-order Trotter (Lie product formula) evolution of statevectors."""
import math
from dataclasses import dataclass

from .pauli import apply_pauli


@dataclass
class TrotterResult:
    state: list
    time: float
    steps: int


def apply_exp_pauli(state, label, theta):
    """Return exp(-i theta P)|state> = cos(theta)|state> - i sin(theta) P|state>."""
    p_state = apply_pauli(state, label)
    c, s = math.cos(theta), math.sin(theta)
    return [c * a - 1j * s * b for a, b in zip(state, p_state)]


def trotter_evolve(hamiltonian, time, steps, state):
    """Approximate exp(-i H time)|state> with `steps` first-order Trotter steps.

    Each step applies exp(-i c_k P_k dt) for the terms in the given order, dt = time / steps.
    """
    dt = time / steps
    for _ in range(steps):
        for coeff, label in hamiltonian:
            state = apply_exp_pauli(state, label, coeff * dt)
    return TrotterResult(state=state, time=time, steps=steps)
EOF

cat > hsim/reference.py <<'EOF'
"""Dense reference evolution, used by the test suite for validation.

Builds the full 2^n x 2^n matrix: O(4^n) memory and O(8^n) time per matrix
product, so it is practical only for a few qubits.
"""
from .pauli import apply_pauli


def dense_matrix(hamiltonian, n):
    dim = 2 ** n
    matrix = [[0j] * dim for _ in range(dim)]
    for col in range(dim):
        basis = [0j] * dim
        basis[col] = 1
        for coeff, label in hamiltonian:
            for row, amp in enumerate(apply_pauli(basis, label)):
                matrix[row][col] += coeff * amp
    return matrix


def _matmul(a, b):
    columns = list(zip(*b))
    return [[sum(x * y for x, y in zip(row, col)) for col in columns] for row in a]


def expm(matrix, squarings=8, terms=12):
    """exp(matrix) by scaling and squaring with a truncated Taylor series."""
    dim = len(matrix)
    scaled = [[x / 2 ** squarings for x in row] for row in matrix]
    result = [[1 + 0j if i == j else 0j for j in range(dim)] for i in range(dim)]
    term = [row[:] for row in result]
    for k in range(1, terms + 1):
        term = [[x / k for x in row] for row in _matmul(term, scaled)]
        result = [[r + t for r, t in zip(rr, tt)] for rr, tt in zip(result, term)]
    for _ in range(squarings):
        result = _matmul(result, result)
    return result


def exact_evolve(hamiltonian, time, state):
    """exp(-i H time)|state> via the dense matrix exponential."""
    n = len(hamiltonian[0][1])
    generator = [[-1j * time * x for x in row] for row in dense_matrix(hamiltonian, n)]
    u = expm(generator)
    return [sum(u_ij * s for u_ij, s in zip(row, state)) for row in u]
EOF

touch tests/__init__.py

cat > tests/test_trotter.py <<'EOF'
import math
import unittest

from hsim.reference import exact_evolve
from hsim.trotter import trotter_evolve

H = [(1.0, "XXI"), (1.0, "IXX"), (0.5, "ZII"), (0.5, "IZI"), (0.5, "IIZ")]


def zero_state(n):
    state = [0j] * 2 ** n
    state[0] = 1
    return state


def distance(a, b):
    return math.sqrt(sum(abs(x - y) ** 2 for x, y in zip(a, b)))


class TrotterTest(unittest.TestCase):
    def test_norm_preserved(self):
        state = trotter_evolve(H, 1.0, 20, zero_state(3)).state
        self.assertAlmostEqual(sum(abs(a) ** 2 for a in state), 1.0, places=12)

    def test_converges_to_exact(self):
        exact = exact_evolve(H, 1.0, zero_state(3))
        approx = trotter_evolve(H, 1.0, 400, zero_state(3)).state
        self.assertLess(distance(exact, approx), 5e-3)

    def test_commuting_terms_are_exact_in_one_step(self):
        h = [(0.3, "ZI"), (0.7, "IZ"), (0.2, "ZZ")]
        state = [0.5 + 0j] * 4
        exact = exact_evolve(h, 2.0, state)
        approx = trotter_evolve(h, 2.0, 1, state).state
        self.assertLess(distance(exact, approx), 1e-10)


if __name__ == "__main__":
    unittest.main()
EOF
