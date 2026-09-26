#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p vqe_lite tests

cat > README.md <<'EOF'
# vqe_lite

Energy estimates for small variational experiments. A Hamiltonian is a list
of (coefficient, Pauli label) pairs such as [(0.5, "ZI"), (-1.2, "XX")], and a
state is a list of 2^n complex amplitudes with qubit 0 as the most significant
bit. Users paste Hamiltonians from chemistry packages, whose coefficients can
differ by many orders of magnitude and cancel.

Run the tests with `python3 -m unittest`.
EOF

cat > vqe_lite/__init__.py <<'EOF'
EOF

cat > vqe_lite/pauli.py <<'EOF'
"""Matrix-free application of Pauli strings to statevectors."""


def apply_pauli(label, state):
    """Return P|state> for a Pauli label such as "XZ" (qubit 0 first)."""
    n = len(label)
    out = [0j] * len(state)
    for index, amp in enumerate(state):
        target, phase = index, 1 + 0j
        for q, p in enumerate(label):
            bit = (index >> (n - 1 - q)) & 1
            if p in "XY":
                target ^= 1 << (n - 1 - q)
            if p == "Y":
                phase *= 1j if bit == 0 else -1j
            elif p == "Z" and bit:
                phase = -phase
        out[target] += phase * amp
    return out
EOF

cat > tests/__init__.py <<'EOF'
EOF

cat > tests/test_pauli.py <<'EOF'
import unittest

from vqe_lite.pauli import apply_pauli


class PauliTests(unittest.TestCase):
    def test_y_on_zero(self):
        self.assertEqual(apply_pauli("Y", [1, 0]), [0j, 1j])

    def test_zx_on_10(self):
        self.assertEqual(apply_pauli("ZX", [0, 0, 1, 0]), [0j, 0j, 0j, -1 + 0j])


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Pauli-string application"

cat > vqe_lite/estimator.py <<'EOF'
"""Energy estimation for Pauli-sum Hamiltonians."""
import abc
import math
from dataclasses import dataclass

from vqe_lite.pauli import apply_pauli


@dataclass
class EstimatorConfig:
    backend: str = "python"
    shots: int = 1000
    seed: int = 0
    use_gpu: bool = False
    cache_dir: str = ".vqe_cache"


class BaseEstimator(abc.ABC):
    @abc.abstractmethod
    def estimate(self, hamiltonian, state):
        """Return <state|H|state>."""


class PythonEstimator(BaseEstimator):
    def __init__(self, config):
        self.config = config

    def estimate(self, hamiltonian, state):
        _check_hamiltonian(hamiltonian, len(state))
        terms = []
        for coeff, label in hamiltonian:
            p_state = apply_pauli(label, state)
            value = sum(a.conjugate() * b for a, b in zip(state, p_state))
            terms.append(coeff * value.real)
        return math.fsum(terms)


class EstimatorFactory:
    _registry = {"python": PythonEstimator}

    @classmethod
    def create(cls, config):
        return cls._registry[config.backend](config)


def _check_hamiltonian(hamiltonian, dim):
    n = dim.bit_length() - 1
    if dim != 1 << n:
        raise ValueError("state length must be a power of two")
    for coeff, label in hamiltonian:
        if isinstance(coeff, complex):
            raise ValueError("coefficients must be real for a Hermitian Hamiltonian")
        if len(label) != n or set(label) - set("IXYZ"):
            raise ValueError(f"bad Pauli label {label!r} for {n} qubits")


def _mean(values):
    total = 0.0
    count = 0
    for v in values:
        total += v
        count += 1
    return total / count


def energy(hamiltonian, state, config=None):
    config = config or EstimatorConfig()
    return EstimatorFactory.create(config).estimate(hamiltonian, state)


def average_energy(hamiltonian, states):
    """Mean energy over a list of states."""
    return _mean([energy(hamiltonian, s) for s in states])
EOF

cat > tests/test_estimator.py <<'EOF'
import unittest

from vqe_lite.estimator import average_energy, energy


class EstimatorTests(unittest.TestCase):
    def test_zz_on_bell_state(self):
        r = 2 ** -0.5
        self.assertAlmostEqual(energy([(1.0, "ZZ")], [r, 0, 0, r]), 1.0, places=12)

    def test_large_coefficients_cancel(self):
        # Chemistry-style Hamiltonian whose large terms cancel exactly.
        h = [(1e16, "II"), (1.0, "ZI"), (-1e16, "II")]
        self.assertEqual(energy(h, [1, 0, 0, 0]), 1.0)

    def test_rejects_bad_label(self):
        with self.assertRaises(ValueError):
            energy([(1.0, "ZQ")], [1, 0, 0, 0])

    def test_average(self):
        self.assertAlmostEqual(average_energy([(1.0, "Z")], [[1, 0], [0, 1]]), 0.0)


if __name__ == "__main__":
    unittest.main()
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "Add energy estimator"
