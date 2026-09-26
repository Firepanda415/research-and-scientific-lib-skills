#!/usr/bin/env bash
set -euo pipefail

mkdir -p qsimlite tests examples profile docs

cat > qsimlite/__init__.py <<'EOF'
"""qsimlite: small reference simulator for Chebyshev-series time evolution."""
from .evolve import evolve

__all__ = ["evolve"]
EOF

cat > qsimlite/block_encoding.py <<'EOF'
"""Block-encoding data for a Pauli-sum Hamiltonian H = sum_j c_j P_j.

A Pauli string has one character per qubit, and character q acts on bit q
of the basis-state index.
"""
import math
from dataclasses import dataclass
from typing import List, Tuple


@dataclass
class BlockEncoding:
    n_qubits: int
    alpha: float                                  # sum_j |c_j|
    terms: List[Tuple[complex, int, List[complex]]]  # (c_j / alpha, flip mask, phase table)


def _compile_pauli(pauli, n):
    """Return (flip, table) with P|b> = table[b] |b ^ flip>."""
    flip = zmask = ycount = 0
    for q, op in enumerate(pauli):
        if op in "XY":
            flip |= 1 << q
        if op in "ZY":
            zmask |= 1 << q
        if op == "Y":
            ycount += 1
    base = 1j ** ycount
    return flip, [base * (-1 if bin(b & zmask).count("1") % 2 else 1) for b in range(1 << n)]


def _check_hermitian(compiled, n):
    """Build the dense normalized matrix and check H = H^dagger.

    Guards against sign errors in the Y handling of _compile_pauli.
    """
    dim = 1 << n
    dense = [[0j] * dim for _ in range(dim)]
    for c, flip, table in compiled:
        for b in range(dim):
            dense[b ^ flip][b] += c * table[b]
    for i in range(dim):
        for j in range(dim):
            if abs(dense[i][j] - dense[j][i].conjugate()) > 1e-12:
                raise ValueError("Hamiltonian is not Hermitian")
    return dense


def _check_norm_bound(dense, iters=60):
    """Power iteration: the block-encoded matrix H/alpha must have spectral norm <= 1."""
    dim = len(dense)
    v = [1.0 / math.sqrt(dim)] * dim
    norm = 0.0
    for _ in range(iters):
        w = [sum(a * x for a, x in zip(row, v)) for row in dense]
        norm = math.sqrt(sum(abs(x) ** 2 for x in w))
        if norm == 0.0:
            return
        v = [x / norm for x in w]
    if norm > 1 + 1e-9:
        raise ValueError("block encoding is not normalized")


def synthesize_block_encoding(hamiltonian_terms):
    """hamiltonian_terms: list of (real coefficient, Pauli string)."""
    n = len(hamiltonian_terms[0][1])
    alpha = sum(abs(c) for c, _ in hamiltonian_terms)
    compiled = []
    for c, pauli in hamiltonian_terms:
        flip, table = _compile_pauli(pauli, n)
        compiled.append((c / alpha, flip, table))
    _check_norm_bound(_check_hermitian(compiled, n))
    return BlockEncoding(n, alpha, compiled)
EOF

cat > qsimlite/evolve.py <<'EOF'
"""Time evolution exp(-iHt)|psi> by the Chebyshev (Jacobi-Anger) series.

exp(-i x y) = J_0(x) + 2 sum_{k>=1} (-i)^k J_k(x) T_k(y), with y = H/alpha, x = alpha t.
"""
import math

from .block_encoding import synthesize_block_encoding


def qsp_phases(x, tol):
    """Series coefficients c_k = (2 - [k == 0]) (-i)^k J_k(x), truncated at |c_k| < tol.

    J_k is computed from its integral representation with the trapezoid rule,
    which converges spectrally for this periodic integrand.
    """
    m = int(abs(x)) + 64
    taus = [math.pi * (j + 0.5) / m for j in range(m)]
    coeffs, k = [], 0
    while True:
        jk = sum(math.cos(k * tau - x * math.sin(tau)) for tau in taus) / m
        coeffs.append((1 if k == 0 else 2) * (-1j) ** k * jk)
        if k > abs(x) and abs(jk) < tol / 2:
            return coeffs
        k += 1


def _apply_h(be, v):
    out = [0j] * len(v)
    for c, flip, table in be.terms:
        for b, vb in enumerate(v):
            if vb:
                out[b ^ flip] += c * table[b] * vb
    return out


def apply_qsvt(be, coeffs, state):
    """Sum_k coeffs[k] T_k(H/alpha)|state> by the three-term recurrence."""
    prev, cur = list(state), _apply_h(be, state)
    result = [coeffs[0] * s for s in prev]
    if len(coeffs) > 1:
        result = [r + coeffs[1] * c for r, c in zip(result, cur)]
    for ck in coeffs[2:]:
        hv = _apply_h(be, cur)
        prev, cur = cur, [2 * h - p for h, p in zip(hv, prev)]
        result = [r + ck * c for r, c in zip(result, cur)]
    return result


def evolve(hamiltonian_terms, t, state, tol=1e-6):
    """Return exp(-i H t) state for H = sum_j c_j P_j given as (c_j, Pauli string) pairs."""
    be = synthesize_block_encoding(hamiltonian_terms)
    coeffs = qsp_phases(be.alpha * t, tol)
    return apply_qsvt(be, coeffs, state)
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_evolve.py <<'EOF'
import cmath
import math
import unittest

from qsimlite import evolve


class EvolveTest(unittest.TestCase):
    def assertStateAlmostEqual(self, got, want, places=6):
        for g, w in zip(got, want):
            self.assertAlmostEqual(abs(g - w), 0.0, places=places)

    def test_single_z(self):
        t = 0.7
        psi = [1 / math.sqrt(2), 1 / math.sqrt(2)]
        want = [cmath.exp(-1j * t) / math.sqrt(2), cmath.exp(1j * t) / math.sqrt(2)]
        self.assertStateAlmostEqual(evolve([(1.0, "Z")], t, psi), want)

    def test_single_x(self):
        t = 1.3
        want = [math.cos(t), -1j * math.sin(t)]
        self.assertStateAlmostEqual(evolve([(1.0, "X")], t, [1.0, 0.0]), want)

    def test_two_qubit_norm(self):
        terms = [(0.5, "XX"), (0.5, "YY"), (1.0, "ZZ"), (0.3, "ZI")]
        out = evolve(terms, 2.0, [0.0, 1.0, 0.0, 0.0])
        self.assertAlmostEqual(sum(abs(a) ** 2 for a in out), 1.0, places=6)


if __name__ == "__main__":
    unittest.main()
EOF

cat > examples/heisenberg_sweep.py <<'EOF'
"""Magnetization <Z_0>(t) of an 8-site open Heisenberg chain at 200 time points."""
from qsimlite import evolve

N = 8
TERMS = []
for i in range(N - 1):
    for p in "XYZ":
        s = ["I"] * N
        s[i] = s[i + 1] = p
        TERMS.append((1.0, "".join(s)))

psi0 = [0j] * (1 << N)
psi0[int("01" * (N // 2), 2)] = 1.0          # Neel state

times = [0.025 * (j + 1) for j in range(200)]  # t in (0, 5]
for t in times:
    psi = evolve(TERMS, t, psi0)
    z0 = sum(abs(a) ** 2 * (1 if b & 1 == 0 else -1) for b, a in enumerate(psi))
    print(f"{t:.3f} {z0:+.6f}")
EOF

cat > docs/API.md <<'EOF'
# Public API

`qsimlite.evolve(hamiltonian_terms, t, state, tol=1e-6)` returns exp(-iHt) applied to `state`.
Its signature and return type have been stable since v1.0. Two downstream packages
(the group's dynamics-study notebooks and the QPE benchmark harness) call it directly,
so a change to this signature needs a deprecation cycle of one minor release.
EOF

cat > NOTES.md <<'EOF'
# qsimlite team notes

## Goal for this quarter
Users of the dynamics-study notebooks sweep 100 to 1000 time points per Hamiltonian.
Target: the 200-point sweep in examples/heisenberg_sweep.py should finish in under 20 s
so that parameter scans become interactive.

## Weekly log
- wk 31: apply_qsvt inner loop, skip zero amplitudes: -4% runtime of apply_qsvt.
- wk 32: apply_qsvt, hoist list allocations out of the recurrence: -5%.
- wk 33: apply_qsvt, precompute c * table[b] products: -3%.
- wk 34: discussed a GPU tensor-network backend plus a small DSL for Hamiltonians. Not started.
EOF

cat > profile/sweep_200_times.txt <<'EOF'
# python3 -m cProfile -s cumulative examples/heisenberg_sweep.py   (2026-09-19, Python 3.9, laptop)
# 200 time points, 8-site Heisenberg chain, 21 terms. Wall time 83.4 s.
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
      200    0.001    0.000   83.140    0.416 qsimlite/evolve.py(evolve)
      200    0.036    0.000   78.311    0.392 qsimlite/block_encoding.py(synthesize_block_encoding)
      200    0.064    0.000   75.232    0.376 qsimlite/block_encoding.py(_check_norm_bound)
      200    2.126    0.011    2.739    0.014 qsimlite/block_encoding.py(_check_hermitian)
     4200    0.007    0.000    0.302    0.000 qsimlite/block_encoding.py(_compile_pauli)
      200    0.090    0.000    4.280    0.021 qsimlite/evolve.py(apply_qsvt)
    14497    3.766    0.000    3.767    0.000 qsimlite/evolve.py(_apply_h)
      200    0.011    0.000    0.548    0.003 qsimlite/evolve.py(qsp_phases)
EOF

git init -q
git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "qsimlite reference simulator"
