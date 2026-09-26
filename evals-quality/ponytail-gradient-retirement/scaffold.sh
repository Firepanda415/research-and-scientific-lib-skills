#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p vqa_lite tests

cat > README.md <<'EOF'
# vqa_lite

A small variational-algorithm toolkit for teaching and prototyping.

- `gates.py`: single-qubit rotations rx, ry and rz, each exp(-i angle P / 2) for a Pauli P.
- `cost.py`: the one-qubit cost <X> after ry(theta[0]) then rz(theta[1]), exactly
  (`energy`) or as a shot-noise estimate like a hardware run (`sampled_energy`).
- `optimize.py`: gradient descent with forward-difference gradients.

Run the tests with `python3 -m unittest`.
EOF

cat > vqa_lite/__init__.py <<'EOF'
EOF

cat > vqa_lite/gates.py <<'EOF'
"""Single-qubit rotation gates exp(-i * angle * P / 2) as 2x2 nested lists."""
import cmath
import math


def rx(angle):
    c, s = math.cos(angle / 2), math.sin(angle / 2)
    return [[c, -1j * s], [-1j * s, c]]


def ry(angle):
    c, s = math.cos(angle / 2), math.sin(angle / 2)
    return [[c, -s], [s, c]]


def rz(angle):
    return [[cmath.exp(-0.5j * angle), 0], [0, cmath.exp(0.5j * angle)]]


def apply(u, state):
    return [u[0][0] * state[0] + u[0][1] * state[1], u[1][0] * state[0] + u[1][1] * state[1]]
EOF

cat > vqa_lite/cost.py <<'EOF'
"""Cost functions of rotation angles for one qubit."""
from .gates import apply, ry, rz


def prepare(theta):
    return apply(rz(theta[1]), apply(ry(theta[0]), [1, 0]))


def energy(theta):
    """Exact <X> of the prepared state; equals sin(theta[0]) * cos(theta[1])."""
    a, b = prepare(theta)
    return 2 * (a.conjugate() * b).real


def sampled_energy(theta, shots, rng):
    """Shot-noise estimate of energy(theta) from `shots` X-basis measurements."""
    p_plus = (1 + energy(theta)) / 2
    plus = sum(1 for _ in range(shots) if rng.random() < p_plus)
    return (2 * plus - shots) / shots
EOF

cat > vqa_lite/grad.py <<'EOF'
"""Gradients of cost functions of rotation angles."""
import math


def finite_difference_grad(f, theta, h=1e-4):
    """Forward-difference gradient of f at theta.

    Truncation error O(h) per component; costs len(theta) + 1 evaluations of f.
    """
    f0 = f(theta)
    grad = []
    for i in range(len(theta)):
        shifted = list(theta)
        shifted[i] += h
        grad.append((f(shifted) - f0) / h)
    return grad


def central_difference_grad(f, theta, h=1e-4):
    """Central-difference gradient of f at theta.

    Truncation error O(h**2) per component; costs 2 * len(theta) evaluations of f.
    """
    grad = []
    for i in range(len(theta)):
        plus, minus = list(theta), list(theta)
        plus[i] += h
        minus[i] -= h
        grad.append((f(plus) - f(minus)) / (2 * h))
    return grad


def parameter_shift_grad(f, theta):
    """Gradient of f at theta by the parameter-shift rule.

    Exact when each angle enters f through one rotation exp(-i * angle * P / 2)
    with a Pauli P, as for rx, ry and rz in gates.py. Costs 2 * len(theta)
    evaluations of f and has no truncation error or step size.
    """
    grad = []
    for i in range(len(theta)):
        plus, minus = list(theta), list(theta)
        plus[i] += math.pi / 2
        minus[i] -= math.pi / 2
        grad.append((f(plus) - f(minus)) / 2)
    return grad


def _fd_step(f, theta, i, h):
    shifted = list(theta)
    shifted[i] += h
    return (f(shifted) - f(theta)) / h
EOF

cat > vqa_lite/optimize.py <<'EOF'
"""Gradient descent on a cost function of rotation angles."""
from .grad import finite_difference_grad


def gradient_descent(f, theta0, lr=0.2, steps=200):
    theta = list(theta0)
    for _ in range(steps):
        g = finite_difference_grad(f, theta)
        theta = [t - lr * gi for t, gi in zip(theta, g)]
    return theta, f(theta)
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_grad.py <<'EOF'
import math
import unittest

from vqa_lite.cost import energy
from vqa_lite.grad import central_difference_grad, finite_difference_grad

THETA = [0.7, -0.4]
EXACT = [math.cos(0.7) * math.cos(-0.4), -math.sin(0.7) * math.sin(-0.4)]


class GradTest(unittest.TestCase):
    def test_forward_difference(self):
        for got, want in zip(finite_difference_grad(energy, THETA), EXACT):
            self.assertAlmostEqual(got, want, delta=1e-3)

    def test_central_difference(self):
        for got, want in zip(central_difference_grad(energy, THETA), EXACT):
            self.assertAlmostEqual(got, want, delta=1e-7)


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_optimize.py <<'EOF'
import unittest

from vqa_lite.cost import energy
from vqa_lite.optimize import gradient_descent


class OptimizeTest(unittest.TestCase):
    def test_reaches_minimum(self):
        _, value = gradient_descent(energy, [0.3, 0.2])
        self.assertAlmostEqual(value, -1.0, delta=1e-3)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "vqa_lite 0.2"
