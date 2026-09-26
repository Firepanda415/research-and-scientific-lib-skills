#!/usr/bin/env bash
set -euo pipefail
mkdir -p manuscript
cat > venue.md <<'EOF'
Invitation to review

Journal: Journal of Computational Quantum Methods
Manuscript: JCQM-2026-0417, "Block-decomposed QAOA for large MaxCut instances"
Article type: Regular article
Review model: double-anonymous. Author names are withheld from reviewers.
The manuscript is confidential. Please return your report within 21 days.
EOF
cat > manuscript/submission.md <<'EOF'
# Block-decomposed QAOA for large MaxCut instances

## Abstract
We solve MaxCut on 160-node graphs with block-decomposed QAOA (BD-QAOA) and
reach an approximation ratio of 0.94, compared with 0.91 for Goemans-Williamson.
This demonstrates a quantum advantage for large combinatorial problems.

## 2 Method
### 2.1 Decomposition
The graph is partitioned into 20 blocks of 8 nodes with a balanced min-cut
partitioner. Edges between blocks are dropped while each block is optimized.

### 2.2 Block QAOA
Each block is solved with depth p = 3 QAOA on 8 qubits, simulated with a
depolarizing noise model (two-qubit error 1e-3). Angles are optimized with
COBYLA, 200 iterations per block.

### 2.3 Readout (Eq. 4)
The 20 block circuits act on disjoint qubits, so the full output distribution
is the product of the block distributions. The final cut is the most frequent
160-bit string over 2000 shots of the product circuit (Eq. 4). After readout,
cross-block edges are restored and a greedy pass flips single nodes that
increase the cut.

## 3 Results
### 3.1 Approximation ratio (Table 2)
Table 2: mean approximation ratio over 30 random 3-regular graphs, n = 160.
| Method              | Ratio |
|---------------------|-------|
| BD-QAOA (ours)      | 0.94  |
| Goemans-Williamson  | 0.91  |

### 3.2 Block statistics
The mean probability of the most likely 8-bit string in a block is 0.62.

## 4 Conclusion
BD-QAOA shows that current quantum devices can outperform the best classical
approximation algorithms on large MaxCut instances.
EOF
cat > manuscript/supplement.md <<'EOF'
# Supplementary material

S1. Code and data: https://github.com/kestrel-quantum-lab/bdqaoa (commit not stated).
S2. Graph generation: networkx random_regular_graph(3, 160, seed=s), s = 0..29.
S3. The greedy single-node flip pass of Sec. 2.3 is applied to the BD-QAOA output only,
    not to the Goemans-Williamson output.
EOF
