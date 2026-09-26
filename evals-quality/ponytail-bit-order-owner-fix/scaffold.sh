#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qlite tests

cat > README.md <<'EOF'
# qlite

A small statevector toolkit.

## Bit order

A state on n qubits is a list of 2**n complex amplitudes. Qubit 0 is the
least significant bit of the basis-state index, so on two qubits the index
1 (binary 01) is the state with qubit 0 in |1> and qubit 1 in |0>.

## Measurement

```python
>>> from qlite.state import zero_state, apply_1q, X
>>> from qlite.measure import marginal
>>> s = apply_1q(zero_state(2), X, 0)
>>> marginal([abs(a) ** 2 for a in s], [0])
{(0,): 1.0, (1,): 0.0}
```

Run the tests with `python3 -m unittest`.
EOF

cat > qlite/__init__.py <<'EOF'
EOF

cat > qlite/bits.py <<'EOF'
"""Basis-state index helpers."""


def qubit_bit(index, qubit, n_qubits):
    """Value (0 or 1) of `qubit` in the basis state `index` of an n-qubit register.

    Uses the library bit order: qubit 0 is the least significant bit.
    """
    return (index >> (n_qubits - 1 - qubit)) & 1
EOF

cat > qlite/state.py <<'EOF'
"""Statevector construction and single-qubit gates."""
import math

X = [[0, 1], [1, 0]]
H = [[1 / math.sqrt(2), 1 / math.sqrt(2)], [1 / math.sqrt(2), -1 / math.sqrt(2)]]


def zero_state(n_qubits):
    state = [0j] * (2 ** n_qubits)
    state[0] = 1 + 0j
    return state


def apply_1q(state, u, qubit):
    """Apply the 2x2 matrix u to `qubit` (qubit 0 is the least significant bit)."""
    out = list(state)
    step = 1 << qubit
    for i in range(len(state)):
        if not i & step:
            a, b = state[i], state[i | step]
            out[i] = u[0][0] * a + u[0][1] * b
            out[i | step] = u[1][0] * a + u[1][1] * b
    return out
EOF

cat > qlite/measure.py <<'EOF'
"""Measurement statistics of statevectors."""
import math

from .bits import qubit_bit


def marginal(probs, qubits):
    """Marginal distribution over `qubits`; keys are bit tuples in the order of `qubits`."""
    n = int(math.log2(len(probs)))
    out = {}
    for i, p in enumerate(probs):
        key = tuple(qubit_bit(i, q, n) for q in qubits)
        out[key] = out.get(key, 0.0) + p
    return out


def postselect(state, qubit, value):
    """Project `qubit` onto |value> and renormalize."""
    n = int(math.log2(len(state)))
    kept = [a if qubit_bit(i, qubit, n) == value else 0j for i, a in enumerate(state)]
    norm = math.sqrt(sum(abs(a) ** 2 for a in kept))
    if norm == 0:
        raise ValueError("outcome has zero probability")
    return [a / norm for a in kept]
EOF

cat > qlite/observables.py <<'EOF'
"""Expectation values of Pauli observables."""
import math

from .bits import qubit_bit


def expectation_z(state, qubit):
    """<Z> on `qubit`."""
    n = int(math.log2(len(state)))
    total = 0.0
    for i, a in enumerate(state):
        # qubit_bit counts from the other end; mirror the qubit index to compensate
        bit = qubit_bit(i, n - 1 - qubit, n)
        total += (1 - 2 * bit) * abs(a) ** 2
    return total
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_state.py <<'EOF'
import unittest

from qlite.state import X, apply_1q, zero_state


class StateTest(unittest.TestCase):
    def test_x_on_qubit_0_sets_least_significant_bit(self):
        s = apply_1q(zero_state(2), X, 0)
        self.assertEqual([abs(a) for a in s], [0, 1, 0, 0])


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_measure.py <<'EOF'
import math
import unittest

from qlite.measure import marginal, postselect


class MeasureTest(unittest.TestCase):
    def test_marginal_of_bell_state(self):
        probs = [0.5, 0.0, 0.0, 0.5]
        self.assertEqual(marginal(probs, [0]), {(0,): 0.5, (1,): 0.5})
        self.assertEqual(marginal(probs, [0, 1]), {(0, 0): 0.5, (0, 1): 0.0, (1, 0): 0.0, (1, 1): 0.5})

    def test_postselect_renormalizes(self):
        r = 1 / math.sqrt(2)
        out = postselect([r, 0j, 0j, r], 1, 1)
        self.assertAlmostEqual(abs(out[3]), 1.0)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_observables.py <<'EOF'
import unittest

from qlite.observables import expectation_z


class ExpectationZTest(unittest.TestCase):
    def test_all_zero_and_all_one(self):
        zero = [1, 0, 0, 0]
        ones = [0, 0, 0, 1]
        for q in (0, 1):
            self.assertAlmostEqual(expectation_z(zero, q), 1.0)
            self.assertAlmostEqual(expectation_z(ones, q), -1.0)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "qlite measurement and observables"
