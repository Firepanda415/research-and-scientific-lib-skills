#!/usr/bin/env bash
set -euo pipefail

export GIT_AUTHOR_DATE="2026-09-20T10:00:00+00:00"
export GIT_COMMITTER_DATE="2026-09-20T10:00:00+00:00"
commit() {
  git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid -c commit.gpgsign=false commit -qm "$1"
}

git init -q
mkdir -p qlite tests review

cat > README.md <<'EOF'
# qlite

Matrix-free Trotterized time evolution of statevectors under sums of Pauli
terms. `evolve` never builds a 2^n x 2^n matrix and is used for systems of up
to 20 qubits.

`evolve(state, h_a, h_b, t, steps, order)` approximates
exp(-i t (H_A + H_B)) |state> with `steps` first-order (order=1) or
symmetric second-order (order=2) Trotter steps. The default order is 1.

See DEVELOPING.md for the test command and contribution rules.
EOF

cat > DEVELOPING.md <<'EOF'
# Developing qlite

- Supported Python: 3.9 or newer, standard library only.
- Run the tests from the repository root with `python3 -m unittest discover -s tests -t .`
- An implementation job starts from a stated commit. Work on a branch named
  `fix/<finding-id>` created from that commit and commit there. Do not push,
  merge or rebase; the maintainer integrates.
- Commit messages describe the change and carry no AI-attribution trailers
  such as Co-Authored-By.
EOF

cat > qlite/__init__.py <<'EOF'
EOF

cat > qlite/evolve.py <<'EOF'
"""Trotterized time evolution of statevectors under sums of Pauli terms.

A Hamiltonian group is a list of (coefficient, label) pairs whose Pauli
strings commute with each other. Character k of a label acts on qubit k, and
qubit 0 is the least significant bit of the basis-state index.
"""
import math


def apply_pauli(state, label):
    """Return P|state> for the Pauli string `label`, such as "XZ"."""
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


def apply_rotation(state, coeff, label, dt):
    """exp(-i * coeff * dt * P) applied to state."""
    c, s = math.cos(coeff * dt), math.sin(coeff * dt)
    p = apply_pauli(state, label)
    return [c * a - 1j * s * b for a, b in zip(state, p)]


def apply_group(state, terms, dt):
    """exp(-i * dt * sum_k c_k P_k) for mutually commuting terms."""
    for coeff, label in terms:
        state = apply_rotation(state, coeff, label, dt)
    return state


def trotter_step(state, h_a, h_b, dt, order=2):
    """One Trotter step of exp(-i * dt * (H_A + H_B))."""
    if order == 1:
        return apply_group(apply_group(state, h_a, dt), h_b, dt)
    if order == 2:
        state = apply_group(state, h_a, dt / 2)
        state = apply_group(state, h_b, dt / 2)
        return apply_group(state, h_a, dt / 2)
    raise ValueError(f"unsupported Trotter order {order!r}")


def evolve(state, h_a, h_b, t, steps, order=2):
    """Approximate exp(-i * t * (H_A + H_B)) |state> with `steps` Trotter steps."""
    dt = t / steps
    for _ in range(steps):
        state = trotter_step(state, h_a, h_b, dt, order)
    return state
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_evolve.py <<'EOF'
import cmath
import math
import unittest

from qlite.evolve import apply_pauli, evolve, trotter_step


def norm(state):
    return math.sqrt(sum(abs(a) ** 2 for a in state))


class PauliTest(unittest.TestCase):
    def test_y_on_zero(self):
        self.assertEqual(apply_pauli([1, 0], "Y"), [0, 1j])


class EvolveTest(unittest.TestCase):
    def test_norm_preserved(self):
        state = [0.6, 0.8j, 0, 0]
        for order in (1, 2):
            out = evolve(state, [(0.7, "XI"), (0.3, "IX")], [(1.1, "ZZ")], 2.0, 50, order)
            self.assertAlmostEqual(norm(out), 1.0, delta=1e-12)

    def test_first_order_exact_for_commuting_groups(self):
        # H_A = Z on qubit 0 and H_B = 0.5 Z on qubit 1 commute, so first-order Trotter is exact.
        state = [0.5, 0.5, 0.5, 0.5]
        t = 0.9
        out = evolve(state, [(1.0, "ZI")], [(0.5, "IZ")], t, 3, order=1)
        for i, a in enumerate(out):
            z0 = 1 - 2 * (i & 1)
            z1 = 1 - 2 * ((i >> 1) & 1)
            self.assertAlmostEqual(a, 0.5 * cmath.exp(-1j * t * (z0 + 0.5 * z1)), delta=1e-12)

    def test_rejects_unknown_order(self):
        with self.assertRaises(ValueError):
            trotter_step([1, 0], [], [], 0.1, order=3)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
commit "qlite 0.4: Trotter evolution"
reviewed=$(git rev-parse --short=12 HEAD)

cat > review/repro_f2.py <<'EOF'
"""Reproducer for F2: error of evolve() against the closed form for H = X + Z on one qubit."""
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from qlite.evolve import evolve  # noqa: E402


def exact(t):
    w = math.sqrt(2)
    c, s = math.cos(w * t), math.sin(w * t) / w
    # exp(-i t (X + Z)) |0> = cos(sqrt(2) t) |0> - i sin(sqrt(2) t) / sqrt(2) (|0> + |1>)
    return [c - 1j * s, -1j * s]


for order in (1, 2):
    for steps in (16, 32, 64):
        got = evolve([1 + 0j, 0j], [(1.0, "X")], [(1.0, "Z")], 1.0, steps, order)
        err = math.sqrt(sum(abs(a - b) ** 2 for a, b in zip(got, exact(1.0))))
        print(f"order={order} steps={steps} error={err:.3e}")
EOF

cat > review/findings.md <<'EOF'
# Review findings for qlite

Reviewed commit: REVIEWED_COMMIT. Each finding was reproduced with `python3`
(3.9) from the repository root.

## F1 (minor, verified): apply_pauli accepts unknown characters

`apply_pauli(state, "XQ")` treats "Q" as the identity instead of raising.
Labels come from user input.

## F2 (major, verified): the second-order Trotter step evolves H_B for half the step

`trotter_step(..., order=2)` in `qlite/evolve.py` applies
exp(-i H_A dt/2) exp(-i H_B dt/2) exp(-i H_A dt/2). The symmetric (Strang)
step is exp(-i H_A dt/2) exp(-i H_B dt) exp(-i H_A dt/2), so the code evolves
H_B for only half of each step, and the error does not decrease as the number
of steps grows.

Reproducer: `python3 review/repro_f2.py` evolves |0> under H = X + Z
(H_A = X, H_B = Z) to t = 1 and prints the error norm against the closed form
exp(-i t (X + Z)) = cos(sqrt(2) t) I - i sin(sqrt(2) t) (X + Z) / sqrt(2).

| order | steps | error |
|---|---|---|
| 1 | 16 | 4.368e-02 |
| 1 | 32 | 2.183e-02 |
| 1 | 64 | 1.091e-02 |
| 2 | 16 | 4.220e-01 |
| 2 | 32 | 4.222e-01 |
| 2 | 64 | 4.222e-01 |

The first-order path converges as O(dt); the second-order path plateaus. The
existing tests miss this: `test_norm_preserved` passes for any unitary step,
and the exactness test uses order=1 only.

Suggested remedy: apply H_B for the full dt in the order=2 branch. So that
this cannot regress, also make `evolve()` build the exact propagator
exp(-i H t) with a dense matrix exponential at the end of every call and raise
if the returned state differs from it by more than 1e-6.

## F3 (minor, verified): the README states the wrong default order

The README says the default order is 1; `evolve()` defaults to order=2.
EOF
sed -i.bak "s/REVIEWED_COMMIT/${reviewed}/" review/findings.md
rm review/findings.md.bak

git add -A
commit "Add review findings for qlite 0.4"
