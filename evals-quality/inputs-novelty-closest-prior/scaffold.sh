#!/usr/bin/env bash
set -euo pipefail

mkdir -p sources

cat > sources/S0-our-idea.md <<'EOF'
# Shadow-ADAPT (internal draft note, 2026-09-21)

Idea: in ADAPT-VQE, each iteration must estimate the energy gradient g_k = <psi|[H, A_k]|psi>
for every operator A_k in the pool. Today we measure each commutator separately.
Shadow-ADAPT instead collects one set of classical shadows (random single-qubit Pauli-basis
snapshots) of the current ansatz state |psi> and estimates all g_k from the same snapshots
with median-of-means. We expect a large cut in measurement cost per ADAPT iteration.

Novelty: to our knowledge this is the first use of classical shadows for ADAPT operator selection.
Search log (arXiv full-text search, 2026-09-20): "classical shadow ADAPT-VQE",
"shadow gradient operator pool", "classical shadows operator selection" -> 0 relevant hits.
EOF

cat > sources/S1-okafor-lindqvist-2025.md <<'EOF'
# S1. P. Okafor and E. Lindqvist, "Randomized-measurement recycling for gradient screening in adaptive variational ansatze"
arXiv:2503.04417, v1 posted 2025-03-11. Full text available; excerpts below.

Abstract. Adaptive ansatz construction requires, at every step, the gradient of the energy with
respect to each candidate generator. We show that a single batch of randomized measurements of the
current state can be recycled to screen the entire pool.

Sec. 2 (Method). At each adaptive step we prepare the current ansatz state and measure it N times,
each time in a basis drawn uniformly from the single-qubit Pauli bases X, Y, Z on every qubit. From
these N snapshots we form unbiased estimators of <[H, A_k]> for all pool operators A_k simultaneously,
combined with median-of-means. The same snapshots are reused for every A_k.

Sec. 4, Table 2. Measurement reduction versus measuring each commutator separately, at equal
gradient-estimation error, for the qubit-excitation-based pool:
| Molecule | Qubits | Reduction |
| H4 chain | 8      | 12x       |
| LiH      | 12     | 21x       |
| BeH2     | 14     | 35x       |

Sec. 5 (Limitations). The estimator variance grows as 3^w for a commutator of Pauli weight w. We
therefore restrict to pools whose commutators with H have weight w <= 4. Fermionic pools with
long Jordan-Wigner strings exceed this and are not treated.
EOF

cat > sources/S2-brandt-2024.md <<'EOF'
# S2. L. Brandt, K. Sato and R. Mensah, "Classical shadows for fermionic observables"
arXiv:2407.11873, posted 2024-07-16. Abstract only (full text not retrieved).

Abstract. We introduce randomized measurements built from fermionic Gaussian unitaries whose
estimator variance for k-body fermionic observables does not depend on the Jordan-Wigner string
length. We apply the scheme to k-RDM estimation and report reduced measurement cost relative to
Pauli-basis shadows for molecular systems.
EOF

cat > sources/S3-haddad-okafor-lindqvist-2026.md <<'EOF'
# S3. M. Haddad, P. Okafor and E. Lindqvist, "Scaling randomized-measurement gradient screening to 30 qubits"
arXiv:2606.01192, posted 2026-06-03. Abstract only (full text not retrieved).

Abstract. We extend randomized-measurement recycling for adaptive ansatz construction to systems of
up to 30 qubits and report an 80x reduction in measurement cost relative to per-operator
measurement, confirming the favorable scaling observed in our earlier work.
EOF

cat > sources/S4-ruiz-tanaka-2025.md <<'EOF'
# S4. D. Ruiz and H. Tanaka, "Operator-pool gradients via commutator grouping"
arXiv:2509.20114, posted 2025-09-24. Full text available; excerpt below.

Sec. 3. We group the commutators [H, A_k] into sets of mutually qubit-wise commuting Pauli strings
and measure each set jointly, a deterministic scheme with no randomized bases.
Sec. 5, Fig. 3. On H4, LiH and BeH2 (8 to 14 qubits) grouping reduces the number of measurement
settings by 5x to 8x relative to measuring each commutator separately.
EOF

cat > sources/S5-blog-2026.md <<'EOF'
# S5. Blog post "Shadows solve ADAPT's measurement problem" (quantum-notes blog, 2026-08-02)

Classical shadows make ADAPT-VQE gradient measurement essentially free: expect 100x savings at any
system size. Several groups are already doing this.
EOF
