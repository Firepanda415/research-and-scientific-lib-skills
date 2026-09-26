#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p hamevo tests

cat > README.md <<'EOF'
# hamevo

Time evolution exp(-iHt)|psi> for sparse spin Hamiltonians by a truncated
Taylor series. Hamiltonians are stored in compressed sparse row (CSR) form, so
18-qubit chains (262,144 amplitudes, about 5 million nonzeros for a
transverse-field Ising chain) fit in a few hundred MiB of Python objects; a dense
18-qubit matrix would need 2^36 entries.

Run the tests with `python3 -m unittest`.
EOF

cat > hamevo/__init__.py <<'EOF'
EOF

cat > hamevo/sparse.py <<'EOF'
"""Compressed sparse row matrices built from Pauli X and Z strings."""


class CSR:
    def __init__(self, dim, indptr, indices, data):
        self.dim, self.indptr, self.indices, self.data = dim, indptr, indices, data

    def matvec(self, v):
        out = [0j] * self.dim
        for row in range(self.dim):
            acc = 0j
            for k in range(self.indptr[row], self.indptr[row + 1]):
                acc += self.data[k] * v[self.indices[k]]
            out[row] = acc
        return out


def tfim_chain(n, j=1.0, h=1.0):
    """CSR matrix of H = -j sum Z_q Z_(q+1) - h sum X_q on an open chain."""
    dim = 1 << n
    indptr, indices, data = [0], [], []
    for row in range(dim):
        bits = [(row >> (n - 1 - q)) & 1 for q in range(n)]
        diag = -j * sum(1 if bits[q] == bits[q + 1] else -1 for q in range(n - 1))
        entries = {row: diag}
        for q in range(n):
            col = row ^ (1 << (n - 1 - q))
            entries[col] = entries.get(col, 0.0) - h
        for col in sorted(entries):
            indices.append(col)
            data.append(entries[col])
        indptr.append(len(indices))
    return CSR(dim, indptr, indices, data)
EOF

cat > hamevo/numeric.py <<'EOF'
def isclose(a, b, rel=1e-9, abs_=0.0):
    """True when a and b agree to a relative or absolute tolerance."""
    return abs(a - b) <= max(rel * max(abs(a), abs(b)), abs_)
EOF

cat > hamevo/options.py <<'EOF'
from dataclasses import dataclass


@dataclass
class Options:
    order: int = 12
    steps: int = 20
    precision: str = "double"
    verbose: bool = False
EOF

cat > hamevo/evolve.py <<'EOF'
"""Truncated-Taylor time evolution with a sparse Hamiltonian."""
import math

from hamevo.options import Options

# old_expm() was removed in v0.4; use evolve() instead.


def evolve(h_csr, state, t, options=None):
    """Return exp(-i H t) state using options.steps Taylor steps of options.order terms."""
    options = options or Options()
    dt = t / options.steps
    psi = list(state)
    for _ in range(options.steps):
        term = psi
        total = list(psi)
        for k in range(1, options.order + 1):
            term = [(-1j * dt / k) * x for x in h_csr.matvec(term)]
            total = [a + b for a, b in zip(total, term)]
        psi = total
    return psi


def norm(state):
    return math.sqrt(sum(abs(x) ** 2 for x in state))
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_evolve.py <<'EOF'
import cmath
import unittest

from hamevo.evolve import evolve, norm
from hamevo.numeric import isclose
from hamevo.sparse import tfim_chain


class EvolveTests(unittest.TestCase):
    def test_single_spin_precession(self):
        # H = -X on one qubit: exp(iXt)|0> = cos t |0> + i sin t |1>.
        h = tfim_chain(1, j=0.0, h=1.0)
        psi = evolve(h, [1, 0], 0.7)
        self.assertTrue(isclose(psi[0].real, cmath.cos(0.7).real, rel=1e-10))
        self.assertTrue(isclose(psi[1].imag, cmath.sin(0.7).real, rel=1e-10))

    def test_norm_preserved_on_chain(self):
        h = tfim_chain(4)
        psi = evolve(h, [1] + [0] * 15, 0.5)
        self.assertTrue(isclose(norm(psi), 1.0, rel=1e-9))
EOF

cat > tests/test_removed_api.py <<'EOF'
import unittest

import hamevo
import hamevo.evolve


class RemovedApiTests(unittest.TestCase):
    def test_old_expm_stays_removed(self):
        self.assertFalse(hasattr(hamevo.evolve, "old_expm"))

    def test_dense_expm_stays_removed(self):
        self.assertFalse(hasattr(hamevo, "dense_expm"))
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "hamevo 0.4: sparse Taylor evolution"
