#!/usr/bin/env bash
set -euo pipefail

mkdir -p feed

cat > feed/arxiv-listing-2026-09-26.md <<'EOF'
# arXiv export, pulled 2026-09-26 08:10 (quant-ph new + cross-lists). Abstracts only.

## quant-ph

### arXiv:2609.21044 (submitted 2026-09-25)
Tighter truncation bounds for linear combination of Hamiltonian simulation with smooth kernels
Authors: I. Petrov, L. Moreau
Abstract: For the linear combination of Hamiltonian simulation (LCHS) representation of non-unitary
dynamics, we prove that for a family of analytic kernels the frequency cutoff needed for error eps
scales as O(log^{1+delta}(1/eps)), improving the previous O(log^2(1/eps)) bound for this family.
The bound yields a smaller number of LCU terms; numerical tests on a 1D heat equation agree with
the predicted scaling.

### arXiv:2609.20517 (submitted 2026-09-24)
Oscillator-pointer phase estimation on a transmon-cavity module
Authors: K. Albrecht, S. Iyer, M. Fontaine
Abstract: We demonstrate phase estimation in which a microwave cavity mode serves as the pointer
register for a two-qubit Hamiltonian encoded in transmons. A conditional-displacement interaction
couples the Hamiltonian to the cavity and one homodyne measurement per shot reads the phase. We
report energy estimates with 2% relative error, limited by cavity loss and finite squeezing, and
give a resource model for extending the scheme to larger registers.

### arXiv:2609.21810 (submitted 2026-09-25)
Graph neural network decoding of bivariate bicycle codes under drifting circuit noise
Authors: N. Castell, Y. Ouyang, P. Baptiste
Abstract: We train a graph neural network decoder for the [[144,12,12]] bivariate bicycle code
under circuit-level noise at p = 0.1% and test it on noise it was not trained on: biased noise,
and a drift model fitted to 30 days of device calibration data. Against BP+OSD-10 and BP-LSD, the
decoder lowers the logical error rate by 1.6x to 2.4x in-distribution and 1.3x to 1.9x under shift.
An ablation removes the attention module. Estimated FPGA latency is 0.8 us per round. Code and
trained models are released. Training data size and training cost are reported; tests at larger
code distance are left for future work.

### arXiv:2609.19933 (submitted 2026-09-23)
QAOA-GPT: large language models write quantum optimization code
Authors: R. Delgado, T. Wu
Abstract: We prompt a large language model to write Qiskit programs implementing QAOA for MaxCut
on graphs with 3 to 8 nodes. A second instance of the same model grades each program for
correctness; 91% of programs are graded correct. Programs are not executed.

### arXiv:2609.20260 (submitted 2026-09-24)
SAT-based minimum-weight decoding certificates for small quantum LDPC codes
Authors: H. Lindgren, A. Obi
Abstract: We encode minimum-weight decoding of quantum LDPC codes as SAT instances and use an
off-the-shelf SAT solver to obtain provably minimum-weight corrections for codes with distance up to
6. The certificates let us measure the optimality gap of BP+OSD exactly on these codes; BP+OSD is
optimal on 97.2% of sampled syndromes.

### arXiv:2609.21333 (submitted 2026-09-25)
Quantum kernel classifier achieves 98% accuracy on the Iris dataset
Authors: G. Moretti
Abstract: A 4-qubit quantum kernel classifier reaches 98% test accuracy on Iris, compared with 96%
for a linear SVM.

### arXiv:2609.20001 (submitted 2026-09-24)
Exponential quantum advantage for portfolio optimization
Authors: B. Kaur, D. Lemaire
Abstract: Assuming QRAM access to the covariance matrix, we give a quantum algorithm for mean-variance
portfolio optimization with exponential speedup in the number of assets. End-to-end costs of loading
data and reading out the portfolio are not analyzed.

### arXiv:2609.18420v2 (v1 submitted 2026-09-15, v2 submitted 2026-09-25)
Time-to-solution of early-fault-tolerant phase estimation on 48 logical qubits: a resource model
Authors: E. Novak, J. Haruna
Abstract: We model time-to-solution for ground-state energy estimation with robust phase estimation
on a 48-logical-qubit early-FTQC architecture, including magic-state factories and decoding latency.
v2 comment: corrected Table 3, where v1 underestimated the T-count by a factor of 4. The estimated
crossover time against classical DMRG for the target molecule changes from 2.1 days (v1) to 6.3 days.

### arXiv:2506.01234 (submitted 2025-06-03, no later versions)
A survey of variational quantum algorithms
Authors: C. Huber
Abstract: We survey variational quantum algorithms. (Listed today in the "trending" box.)

## math.NA cross-list

### arXiv:2609.21044 (submitted 2026-09-25)
Tighter truncation bounds for linear combination of Hamiltonian simulation with smooth kernels
Authors: I. Petrov, L. Moreau
(Same abstract as in quant-ph above.)

## cs.LO cross-list, older item pulled from the 60-day window

### arXiv:2608.14102 (submitted 2026-08-19)
A verified compiler pass for Clifford+T rotation merging in Lean 4
Authors: O. Varga, F. Nakashima
Abstract: We formalize the phase-folding rotation-merging optimization for Clifford+T circuits in
Lean 4 and prove that the pass preserves circuit semantics up to global phase. Running the verified
pass against an unverified implementation in a widely used open-source compiler on 1,200 benchmark
circuits exposed two semantic bugs, both since confirmed and fixed upstream. The proof covers the
pass itself, not the parser or the gate-synthesis stage.
EOF

cat > feed/press.md <<'EOF'
# Press items seen 2026-09-25 to 2026-09-26

1. University news release, 2026-09-25: "New AI decoder makes quantum computers error-free."
   Describes the graph neural network decoder of arXiv:2609.21810.

2. Vendor news release, 2026-09-26: "Vendor Q announces a 1,000-qubit roadmap for 2028."
   No technical paper or data accompanies the announcement.
EOF
