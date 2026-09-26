#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qlite tests examples review plans

cat > README.md <<'EOF'
# qlite

A small statevector toolkit. Qubit 0 is the least significant bit of the
basis-state index.

## Measurement

```python
>>> from qlite.state import zero_state, apply_1q, X
>>> from qlite.measure import marginal
>>> s = apply_1q(zero_state(nqubits=2), X, 0)
>>> marginal([abs(a) ** 2 for a in s], [0])
{(0,): 1.0, (1,): 0.0}
```

Run the tests with `python3 -m unittest`.
EOF

cat > qlite/__init__.py <<'EOF'
EOF

cat > qlite/state.py <<'EOF'
"""Statevector construction and single-qubit gates."""
import random

X = [[0, 1], [1, 0]]


def zero_state(nqubits):
    state = [0j] * (2 ** nqubits)
    state[0] = 1 + 0j
    return state


def random_state(nqubits, seed):
    rng = random.Random(seed)
    amps = [complex(rng.gauss(0, 1), rng.gauss(0, 1)) for _ in range(2 ** nqubits)]
    norm = sum(abs(a) ** 2 for a in amps) ** 0.5
    return [a / norm for a in amps]


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

cat > qlite/bits.py <<'EOF'
"""Basis-state index helpers."""


def qubit_bit(index, qubit, n_qubits):
    """Value of `qubit` in basis state `index`; qubit 0 is the least significant bit."""
    return (index >> (n_qubits - 1 - qubit)) & 1
EOF

cat > qlite/measure.py <<'EOF'
"""Measurement statistics."""
import math

from .bits import qubit_bit


def marginal(probs, qubits):
    n = int(math.log2(len(probs)))
    out = {}
    for i, p in enumerate(probs):
        key = tuple(qubit_bit(i, q, n) for q in qubits)
        out[key] = out.get(key, 0.0) + p
    return out


def postselect(state, qubit, value):
    n = int(math.log2(len(state)))
    kept = [a if qubit_bit(i, qubit, n) == value else 0j for i, a in enumerate(state)]
    norm = math.sqrt(sum(abs(a) ** 2 for a in kept))
    return [a / norm for a in kept]
EOF

cat > qlite/observables.py <<'EOF'
"""Expectation values."""
import math

from .bits import qubit_bit


def expectation_z(state, qubit):
    n = int(math.log2(len(state)))
    # qubit_bit counts from the other end; mirror the index to compensate
    return sum((1 - 2 * qubit_bit(i, n - 1 - qubit, n)) * abs(a) ** 2 for i, a in enumerate(state))
EOF

cat > qlite/sampling.py <<'EOF'
"""Sampling measurement outcomes."""
import random


def sample_counts(probs, shots, seed=None):
    rng = random.Random(seed) if shots <= 10000 else random
    counts = {}
    for index in rng.choices(range(len(probs)), weights=probs, k=shots):
        counts[index] = counts.get(index, 0) + 1
    return counts
EOF

cat > qlite/circuits.py <<'EOF'
"""Small benchmark circuits."""
import math

from .state import apply_1q, zero_state

H = [[1 / math.sqrt(2), 1 / math.sqrt(2)], [1 / math.sqrt(2), -1 / math.sqrt(2)]]


def plus_state(nqubits):
    state = zero_state(nqubits=nqubits)
    for q in range(nqubits):
        state = apply_1q(state, H, q)
    return state
EOF

cat > qlite/evolve.py <<'EOF'
"""Trotterized time evolution under sums of commuting Pauli groups."""
from .pauli import apply_group


def trotter_step(state, h_a, h_b, dt, order=2):
    if order == 1:
        return apply_group(apply_group(state, h_a, dt), h_b, dt)
    state = apply_group(state, h_a, dt / 2)
    state = apply_group(state, h_b, dt / 2)
    return apply_group(state, h_a, dt / 2)
EOF

cat > qlite/pauli.py <<'EOF'
"""Pauli rotations applied to statevectors (qubit 0 is the least significant bit)."""
import math


def apply_pauli(state, label):
    out = [0j] * len(state)
    for i, a in enumerate(state):
        j, phase = i, 1
        for q, p in enumerate(label):
            bit = (i >> q) & 1
            if p in "XY":
                j ^= 1 << q
            if p == "Y":
                phase *= -1j if bit else 1j
            if p == "Z" and bit:
                phase = -phase
        out[j] += phase * a
    return out


def apply_group(state, terms, dt):
    for coeff, label in terms:
        c, s = math.cos(coeff * dt), math.sin(coeff * dt)
        p = apply_pauli(state, label)
        state = [c * a - 1j * s * b for a, b in zip(state, p)]
    return state
EOF

cat > examples/demo.py <<'EOF'
from qlite.circuits import plus_state
from qlite.measure import marginal
from qlite.state import random_state

state = random_state(nqubits=3, seed=1)
print(marginal([abs(a) ** 2 for a in state], [0]))
print(marginal([abs(a) ** 2 for a in plus_state(3)], [0, 1]))
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_state.py <<'EOF'
import unittest

from qlite.state import X, apply_1q, random_state, zero_state


class StateTest(unittest.TestCase):
    def test_x_on_qubit_0(self):
        self.assertEqual([abs(a) for a in apply_1q(zero_state(nqubits=2), X, 0)], [0, 1, 0, 0])

    def test_random_state_is_normalized(self):
        state = random_state(nqubits=3, seed=5)
        self.assertAlmostEqual(sum(abs(a) ** 2 for a in state), 1.0)


if __name__ == "__main__":
    unittest.main()
EOF

cat > review/findings.md <<'EOF'
# Review findings for qlite 0.5

R1 (bug). `sample_counts(probs, shots, seed)` in qlite/sampling.py uses the
seeded `random.Random(seed)` only when shots <= 10000. Above that it draws
from the module-level `random`, so seeded runs with more than 10000 shots are
not reproducible.

R2 (bug). `qubit_bit` in qlite/bits.py counts qubits from the most
significant bit, while the library convention (README, `apply_1q`) makes
qubit 0 the least significant bit. `marginal` and `postselect` in
qlite/measure.py inherit the error. `expectation_z` in qlite/observables.py
compensates by mirroring the qubit index, so it must drop that mirror when
`qubit_bit` is fixed.

R3 (API consistency). `zero_state(nqubits)` and `random_state(nqubits, seed)`
in qlite/state.py are the only public functions that spell the qubit count
`nqubits`; everything else uses `n_qubits`. Callers pass it by keyword:
qlite/circuits.py, examples/demo.py, tests/test_state.py and the README
example.

R4 (docs). The README's Measurement example shows output pasted from the
buggy `marginal` (R2). It must show the corrected output.

R5 (tests). No test checks that `postselect` renormalizes a state with
unequal amplitudes.

R6 (bug). `trotter_step(..., order=2)` in qlite/evolve.py applies H_B for
dt/2 instead of dt, so second-order evolution does not converge.
EOF

cat > plans/remediation-plan.md <<'EOF'
# Remediation plan for review/findings.md

Drafted by the planning agent on 2026-09-22.

The jobs run strictly in order. Each starts after the previous one is merged.

1. Job 1, R1: make `sample_counts` use the seeded generator for every shot
   count. File: qlite/sampling.py.
2. Job 2, R2: fix the bit order of `qubit_bit`. File: qlite/bits.py.
3. Job 3, R3 part 1: rename the `nqubits` parameter to `n_qubits` in
   qlite/state.py.
4. Job 4, R3 part 2: update the callers that pass `nqubits=`
   (qlite/circuits.py, examples/demo.py, tests/test_state.py, README).
5. Job 5, R4: regenerate the README example output.
6. Job 6, R5: add a test for `postselect` renormalization.
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "qlite 0.5 with review findings and remediation plan"
