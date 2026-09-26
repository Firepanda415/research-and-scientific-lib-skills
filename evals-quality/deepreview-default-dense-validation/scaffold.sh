#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qsim tests benchmarks

cat > README.md <<'EOF'
# qsim

A pure-Python statevector simulator for small teaching and benchmark circuits.

`run(circuit, n)` simulates circuits of up to 20 qubits on a laptop: the state
has 2^20 amplitudes, about 16 MiB of Python complex numbers, and each gate is
applied in place in O(2^n) time. `benchmarks/ghz_scaling.py` times GHZ
preparation from 2 to 18 qubits.

A circuit is a list of gates: `("u", target, [[a, b], [c, d]])` for a
single-qubit gate and `("cx", control, target)` for CNOT. Qubit 0 is the most
significant bit of a basis index.

Run the tests with `python3 -m unittest`.
EOF

cat > qsim/__init__.py <<'EOF'
EOF

cat > qsim/circuit.py <<'EOF'
"""Statevector simulation of single-qubit gates and CNOT."""


def _apply_1q(state, target, u, n):
    step = 1 << (n - 1 - target)
    for i in range(len(state)):
        if i & step:
            continue
        a0, a1 = state[i], state[i | step]
        state[i] = u[0][0] * a0 + u[0][1] * a1
        state[i | step] = u[1][0] * a0 + u[1][1] * a1


def _apply_cx(state, control, target, n):
    c = 1 << (n - 1 - control)
    t = 1 << (n - 1 - target)
    for i in range(len(state)):
        if i & c and not i & t:
            state[i], state[i | t] = state[i | t], state[i]


def run(circuit, n):
    """Return the statevector after applying circuit to |0...0>."""
    state = [0j] * (1 << n)
    state[0] = 1 + 0j
    for gate in circuit:
        if gate[0] == "u":
            _apply_1q(state, gate[1], gate[2], n)
        elif gate[0] == "cx":
            _apply_cx(state, gate[1], gate[2], n)
        else:
            raise ValueError(f"unknown gate {gate[0]!r}")
    return state
EOF

cat > benchmarks/ghz_scaling.py <<'EOF'
"""Time GHZ-state preparation from 2 to 18 qubits."""
import math
import time

from qsim.circuit import run

H = [[1 / math.sqrt(2), 1 / math.sqrt(2)], [1 / math.sqrt(2), -1 / math.sqrt(2)]]

if __name__ == "__main__":
    for n in range(2, 19):
        circuit = [("u", 0, H)] + [("cx", q, q + 1) for q in range(n - 1)]
        start = time.perf_counter()
        run(circuit, n)
        print(n, f"{time.perf_counter() - start:.3f} s")
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_circuit.py <<'EOF'
import math
import unittest

from qsim.circuit import run

R = 1 / math.sqrt(2)
H = [[R, R], [R, -R]]


class CircuitTests(unittest.TestCase):
    def test_bell_state(self):
        state = run([("u", 0, H), ("cx", 0, 1)], 2)
        for got, want in zip(state, [R, 0, 0, R]):
            self.assertAlmostEqual(abs(got - want), 0.0, places=12)

    def test_x_on_last_qubit(self):
        x = [[0, 1], [1, 0]]
        state = run([("u", 2, x)], 3)
        self.assertAlmostEqual(abs(state[1] - 1), 0.0, places=12)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Statevector simulator with GHZ benchmark"

cat > qsim/circuit.py <<'EOF'
"""Statevector simulation of single-qubit gates and CNOT."""

MAX_QUBITS = 10


def _apply_1q(state, target, u, n):
    step = 1 << (n - 1 - target)
    for i in range(len(state)):
        if i & step:
            continue
        a0, a1 = state[i], state[i | step]
        state[i] = u[0][0] * a0 + u[0][1] * a1
        state[i | step] = u[1][0] * a0 + u[1][1] * a1


def _apply_cx(state, control, target, n):
    c = 1 << (n - 1 - control)
    t = 1 << (n - 1 - target)
    for i in range(len(state)):
        if i & c and not i & t:
            state[i], state[i | t] = state[i | t], state[i]


def _gate_matrix(gate, n):
    """Dense 2^n x 2^n matrix of one gate, built column by column."""
    dim = 1 << n
    columns = []
    for k in range(dim):
        basis = [0j] * dim
        basis[k] = 1 + 0j
        if gate[0] == "u":
            _apply_1q(basis, gate[1], gate[2], n)
        else:
            _apply_cx(basis, gate[1], gate[2], n)
        columns.append(basis)
    return [[columns[j][i] for j in range(dim)] for i in range(dim)]


def _matmul(a, b):
    dim = len(a)
    return [[sum(a[i][k] * b[k][j] for k in range(dim)) for j in range(dim)] for i in range(dim)]


def _check_unitary(circuit, n, tol=1e-9):
    """Build the full circuit unitary U and check that U^dagger U = I."""
    dim = 1 << n
    u = [[1 + 0j if i == j else 0j for j in range(dim)] for i in range(dim)]
    for gate in circuit:
        u = _matmul(_gate_matrix(gate, n), u)
    udag = [[u[j][i].conjugate() for j in range(dim)] for i in range(dim)]
    product = _matmul(udag, u)
    for i in range(dim):
        for j in range(dim):
            if abs(product[i][j] - (1 if i == j else 0)) > tol:
                raise ValueError("circuit is not unitary")


def run(circuit, n, validate=True):
    """Return the statevector after applying circuit to |0...0>.

    With validate=True the circuit unitary is checked before simulation.
    """
    if n > MAX_QUBITS:
        raise ValueError(f"at most {MAX_QUBITS} qubits are supported")
    for gate in circuit:
        if gate[0] not in ("u", "cx"):
            raise ValueError(f"unknown gate {gate[0]!r}")
    if validate:
        _check_unitary(circuit, n)
    state = [0j] * (1 << n)
    state[0] = 1 + 0j
    for gate in circuit:
        if gate[0] == "u":
            _apply_1q(state, gate[1], gate[2], n)
        else:
            _apply_cx(state, gate[1], gate[2], n)
    return state
EOF

cat >> tests/test_circuit.py <<'EOF'


class ValidationTests(unittest.TestCase):
    def test_rejects_non_unitary_gate(self):
        with self.assertRaises(ValueError):
            run([("u", 0, [[1, 1], [0, 1]])], 1)

    def test_rejects_unknown_gate(self):
        with self.assertRaises(ValueError):
            run([("swap", 0, 1)], 2)
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Validate circuits before simulation"
