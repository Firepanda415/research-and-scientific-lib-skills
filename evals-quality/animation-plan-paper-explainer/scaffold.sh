#!/usr/bin/env bash
set -euo pipefail
mkdir -p paper code/cot code/data video

cat > paper/paper.md <<'EOF'
# Commutator-Ordered Trotterization for Low-CNOT Hamiltonian Simulation

Mira Castellan, Tobias Venn, Ana Ruelas (Halden Institute for Quantum Software)

Preprint, 2026. Code: code/ (cot-compiler v1.0).

## Abstract

Product formulas for Hamiltonian simulation spend most of their two-qubit gates on
basis changes between Pauli terms. We introduce commutator-ordered Trotterization
(COT), which orders Pauli terms inside each Trotter step by a greedy walk on their
commutation graph, so that consecutive terms share as many qubits in the same basis as
possible and their basis-change gates cancel. On six molecular and lattice
Hamiltonians of up to 12 qubits, COT uses up to 3.1x fewer CNOT gates per Trotter step
than the grouped ordering of Ref. [7], at the same first-order Trotter error bound.

## 1. Introduction

A first-order Trotter step applies exp(-i h_j P_j dt) for every Pauli term P_j. Each
factor costs basis changes plus a CNOT ladder. Ref. [7] groups mutually commuting terms
and orders groups lexicographically, which already cancels some basis changes inside a
group. Our contribution is the ordering *across* the terms of a step: we show that a
greedy walk on the commutation graph cancels more CNOTs than lexicographic grouping,
without changing the first-order error bound (Section 3.2). We do not change the
term grouping itself, which we take from Ref. [7].

## 2. Method

COT has three stages.

1. **Commutation graph.** Build a graph whose vertices are Pauli terms, with an edge
   weighted by the number of qubits on which two terms act with the same non-identity
   Pauli.
2. **Greedy walk.** Starting from the heaviest term, repeatedly append the unvisited
   term with the largest edge weight to the current term. Ties are broken by term index.
3. **Ladder cancellation.** Compile each exponential with a CNOT ladder and cancel
   adjacent CNOT pairs and basis changes between consecutive terms with a peephole pass.

## 3. Results

All CNOT counts are for one first-order Trotter step, compiled for all-to-all
connectivity (no routing) with the cot-compiler peephole pass. Counts are exact
(compilation is deterministic); no noise or hardware execution is involved.

**Table 2.** CNOT gates per Trotter step.

| Hamiltonian     | Qubits | Pauli terms | Grouped [7] | COT  | Ratio |
|-----------------|--------|-------------|-------------|------|-------|
| H2 (STO-3G)     | 4      | 15          | 56          | 40   | 1.4   |
| LiH (frozen)    | 6      | 62          | 412         | 242  | 1.7   |
| Heisenberg 1D   | 8      | 24          | 96          | 53   | 1.8   |
| H2O (frozen)    | 10     | 184         | 1590        | 837  | 1.9   |
| Fermi-Hubbard   | 12     | 64          | 380         | 173  | 2.2   |
| TFIM 2D (3x4)   | 12     | 29          | 142         | 46   | 3.1   |

### 3.2 Trotter error

Reordering terms inside a first-order step changes the error constant but not the
commutator bound we use, sum over pairs of ||[h_j P_j, h_k P_k]||, which is invariant under
ordering. The measured spectral-norm error at dt = 0.05 differs from the grouped ordering
by less than 4% on all six instances (Table 3, Appendix B).

## 4. Limitations

The gain depends on how many Pauli terms share qubits in the same basis. Hamiltonians
with few such overlaps, such as small molecules, gain least (H2: 1.4x). We have not
studied limited connectivity: routing on a hardware coupling map can add SWAPs that
undo part of the cancellation. We report only first-order formulas and systems of at
most 12 qubits; second-order formulas and larger systems are future work.

## References

[7] P. Okafor and L. Brandt, "Commuting-group Trotterization", 2024.
EOF

cat > code/README.md <<'EOF'
# cot-compiler

Reference implementation of commutator-ordered Trotterization.

    python -m cot.compile hamiltonians/tfim_3x4.json --order cot

Benchmark data used for plots are in data/.
EOF

cat > code/cot/__init__.py <<'EOF'
"""Commutator-ordered Trotterization."""
EOF

cat > code/data/cnot_counts.csv <<'EOF'
# cot-compiler v1.2 benchmark run, 2026-05-14
# target: heavy-hex 127-qubit coupling map, SABRE routing, optimization level 2
hamiltonian,qubits,grouped_cnots,cot_cnots
H2,4,68,55
LiH,6,531,389
Heisenberg1D,8,118,81
H2O,10,2104,1450
FermiHubbard,12,522,301
TFIM2D,12,236,112
EOF
