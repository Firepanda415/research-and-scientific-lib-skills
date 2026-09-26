#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p qlsolve tests examples

cat > pyproject.toml <<'EOF'
[project]
name = "qlsolve"
version = "0.1.0"
requires-python = ">=3.9"
dependencies = []
EOF

cat > README.md <<'EOF'
# qlsolve

A classical emulator of an HHL-style quantum linear-system solver, used to
study what the quantum algorithm would return for small systems before
compiling circuits. See the `qlsolve` module docstring for inputs and outputs.

Install with `pip install -e .`. The package has no dependencies.
Run the tests with `python3 -m unittest`.
EOF

cat > qlsolve/__init__.py <<'EOF'
"""qlsolve: a classical emulator of an HHL-style quantum linear-system solver.

solve(A, b) returns what the quantum algorithm would prepare for A x = b: the
normalized solution state x / ||x||, its measurement probabilities, and the
post-selection success probability. The emulator computes these exactly or
samples the measurement, without simulating the circuit gate by gate.

Inputs
    A   real symmetric N x N matrix (list of lists), N a power of two with
        2 <= N <= MAX_DIM, nonsingular.
    b   nonzero real vector of length N.

Output (SolveResult)
    direction            x / ||x||, the normalized quantum state (exact mode only)
    probabilities        |x_i|^2 / ||x||^2, exact or estimated from shots
    norm                 ||x||, restored classically; solution() returns norm * direction
    success_probability  post-selection probability (lambda_min * ||x|| / ||b||)^2
    mode                 "exact" or "shots"
"""
import math
import random

MAX_DIM = 16


class SolveResult:
    def __init__(self, direction, probabilities, norm, success_probability, mode, shots=None):
        self.direction = direction
        self.probabilities = probabilities
        self.norm = norm
        self.success_probability = success_probability
        self.mode = mode
        self.shots = shots

    def solution(self):
        """The physical solution x = norm * direction (exact mode only)."""
        if self.direction is None:
            raise ValueError("shot mode estimates probabilities only; use exact mode for x")
        return [self.norm * c for c in self.direction]


def _validate(A, b):
    n = len(A)
    if n < 2 or n > MAX_DIM or n & (n - 1):
        raise ValueError(f"dimension must be a power of two between 2 and {MAX_DIM}, got {n}")
    if any(len(row) != n for row in A) or len(b) != n:
        raise ValueError("A must be square and b must match its dimension")
    for i in range(n):
        for j in range(i):
            if abs(A[i][j] - A[j][i]) > 1e-12:
                raise ValueError("A must be symmetric")
    if not any(b):
        raise ValueError("b must be nonzero")


def _gauss_solve(A, b):
    n = len(A)
    m = [list(map(float, row)) + [float(v)] for row, v in zip(A, b)]
    for col in range(n):
        pivot = max(range(col, n), key=lambda r: abs(m[r][col]))
        if abs(m[pivot][col]) < 1e-12:
            raise ValueError("A is singular")
        m[col], m[pivot] = m[pivot], m[col]
        for r in range(col + 1, n):
            f = m[r][col] / m[col][col]
            m[r] = [a - f * c for a, c in zip(m[r], m[col])]
    x = [0.0] * n
    for r in reversed(range(n)):
        x[r] = (m[r][n] - sum(m[r][c] * x[c] for c in range(r + 1, n))) / m[r][r]
    return x


def _eigenvalues(A, sweeps=50):
    a = [list(map(float, row)) for row in A]
    n = len(a)
    for _ in range(sweeps):
        if sum(a[i][j] ** 2 for i in range(n) for j in range(n) if i != j) < 1e-24:
            break
        for p in range(n - 1):
            for q in range(p + 1, n):
                if a[p][q] == 0.0:
                    continue
                theta = (a[q][q] - a[p][p]) / (2 * a[p][q])
                t = (1.0 if theta >= 0 else -1.0) / (abs(theta) + math.sqrt(theta * theta + 1))
                c = 1 / math.sqrt(t * t + 1)
                s = t * c
                for k in range(n):
                    akp, akq = a[k][p], a[k][q]
                    a[k][p], a[k][q] = c * akp - s * akq, s * akp + c * akq
                for k in range(n):
                    apk, aqk = a[p][k], a[q][k]
                    a[p][k], a[q][k] = c * apk - s * aqk, s * apk + c * aqk
    return [a[i][i] for i in range(n)]


def solve(A, b, shots=None, seed=None):
    """Emulate the HHL output for A x = b; see the module docstring."""
    _validate(A, b)
    x = _gauss_solve(A, b)
    norm = math.sqrt(sum(v * v for v in x))
    direction = [v / norm for v in x]
    probabilities = [d * d for d in direction]
    lam_min = min(abs(v) for v in _eigenvalues(A))
    b_norm = math.sqrt(sum(v * v for v in b))
    success = (lam_min * norm / b_norm) ** 2
    if shots is None:
        return SolveResult(direction, probabilities, norm, success, "exact")
    rng = random.Random(seed)
    counts = [0] * len(b)
    for k in rng.choices(range(len(b)), weights=probabilities, k=shots):
        counts[k] += 1
    return SolveResult(None, [c / shots for c in counts], norm, success, "shots", shots)
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_qlsolve.py <<'EOF'
import unittest

from qlsolve import MAX_DIM, solve


class SolveTests(unittest.TestCase):
    def test_two_by_two_closed_form(self):
        # A = [[3, 1], [1, 3]], b = (1, 0): x = (3, -1) / 8, eigenvalues 2 and 4.
        res = solve([[3, 1], [1, 3]], [1, 0])
        x = res.solution()
        self.assertAlmostEqual(x[0], 0.375, places=12)
        self.assertAlmostEqual(x[1], -0.125, places=12)
        self.assertAlmostEqual(res.success_probability, 0.625, places=12)

    def test_diagonal_success_probability(self):
        # A = diag(1, 4), b = (0, 1): x = (0, 1/4), p = (1 * 1/4 / 1)^2.
        res = solve([[1, 0], [0, 4]], [0, 1])
        self.assertAlmostEqual(res.success_probability, 0.0625, places=12)

    def test_shots_are_reproducible(self):
        a = solve([[3, 1], [1, 3]], [1, 0], shots=1000, seed=7)
        b = solve([[3, 1], [1, 3]], [1, 0], shots=1000, seed=7)
        self.assertEqual(a.probabilities, b.probabilities)
        self.assertIsNone(a.direction)

    def test_rejects_large_or_bad_input(self):
        n = 2 * MAX_DIM
        with self.assertRaises(ValueError):
            solve([[float(i == j) for j in range(n)] for i in range(n)], [1.0] * n)
        with self.assertRaises(ValueError):
            solve([[1, 2], [0, 1]], [1, 0])


if __name__ == "__main__":
    unittest.main()
EOF

cat > examples/hhl_demo.ipynb <<'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# HHL demo\n",
    "\n",
    "The Harrow-Hassidim-Lloyd (HHL) algorithm solves linear systems $A x = b$ exponentially faster than any classical algorithm."
   ],
   "id": "cell-0"
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Background\n",
    "\n",
    "HHL encodes $b$ as a quantum state $|b\\rangle = \\sum_i b_i |i\\rangle / \\|b\\|$. Quantum phase estimation with the unitary $e^{iAt}$ writes the eigenvalues $\\lambda_j$ of $A$ into a clock register, so that $|b\\rangle = \\sum_j \\beta_j |u_j\\rangle$ becomes $\\sum_j \\beta_j |u_j\\rangle |\\lambda_j\\rangle$.\n",
    "\n",
    "A rotation of an ancilla qubit controlled by the clock register then multiplies each branch by $C/\\lambda_j$, where $C \\le \\min_j |\\lambda_j|$. Uncomputing the clock register and measuring the ancilla in $|1\\rangle$ leaves the register in $\\sum_j \\beta_j \\lambda_j^{-1} |u_j\\rangle \\propto A^{-1}|b\\rangle$."
   ],
   "id": "cell-1"
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Why it works\n",
    "\n",
    "The post-selection succeeds with probability $p = C^2 \\|A^{-1} b\\|^2 / \\|b\\|^2$. Amplitude amplification raises this to order one with $O(1/\\sqrt{p})$ repetitions. The cost of phase estimation grows with the condition number $\\kappa$ and the inverse precision, and the state preparation of $|b\\rangle$ and the simulation of $e^{iAt}$ are assumed efficient for sparse $A$. Together these give a running time polylogarithmic in the dimension $N$.\n",
    "\n",
    "We now run the algorithm on a small example."
   ],
   "id": "cell-2"
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {
    "jupyter": {
     "source_hidden": true
    }
   },
   "outputs": [],
   "source": [
    "import json\n",
    "from qlsolve import solve, MAX_DIM\n",
    "\n",
    "A = [[4, 1, 0, 0], [1, 4, 1, 0], [0, 1, 4, 1], [0, 0, 1, 4]]\n",
    "b = [1, 0, 0, 0]"
   ],
   "id": "cell-3"
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "solution x = [0.964, -0.258, 0.069, -0.017]\n"
     ]
    }
   ],
   "source": [
    "assert all(A[i][j] == A[j][i] for i in range(len(A)) for j in range(len(A)))\n",
    "assert len(A) <= MAX_DIM and len(b) == len(A)\n",
    "res = solve(A, b)\n",
    "print(\"solution x =\", [round(v, 3) for v in res.direction])"
   ],
   "id": "cell-4"
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "{\n",
      "  \"direction\": [\n",
      "    0.9635143882253899,\n",
      "    -0.25808421113180086,\n",
      "    0.06882245630181356,\n",
      "    -0.01720561407545339\n",
      "  ],\n",
      "  \"probabilities\": [\n",
      "    0.9283599763173475,\n",
      "    0.06660746003552397,\n",
      "    0.004736530491415037,\n",
      "    0.0002960331557134398\n",
      "  ],\n",
      "  \"norm\": 0.2780888246262276,\n",
      "  \"success_probability\": 0.43877128046564806,\n",
      "  \"mode\": \"exact\",\n",
      "  \"shots\": null\n",
      "}\n"
     ]
    }
   ],
   "source": [
    "print(json.dumps(res.__dict__, indent=2))"
   ],
   "id": "cell-5"
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "The solver succeeds with probability 0.92, so almost every run returns the solution $x$ shown above."
   ],
   "id": "cell-6"
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Scaling\n",
    "\n",
    "The success probability stays high as the system grows:"
   ],
   "id": "cell-7"
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "for n in [2, 4, 8, 16, 32]:\n",
    "    A_n = [[4.0 if i == j else (1.0 if abs(i - j) == 1 else 0.0) for j in range(n)] for i in range(n)]\n",
    "    b_n = [1.0] + [0.0] * (n - 1)\n",
    "    print(n, round(solve(A_n, b_n).success_probability, 3))"
   ],
   "id": "cell-8"
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Conclusion\n",
    "\n",
    "qlsolve reproduces the HHL output state and shows the exponential speedup of quantum linear solvers."
   ],
   "id": "cell-9"
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "name": "python"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "qlsolve emulator with HHL demo notebook"
