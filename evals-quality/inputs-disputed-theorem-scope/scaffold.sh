#!/usr/bin/env bash
set -euo pipefail

mkdir -p refs

cat > refs/P1-nakamura-adeyemi.md <<'EOF'
# P1. R. Nakamura and F. Adeyemi, "Single-contour eigenphase estimation with Heisenberg-limited scaling"
arXiv:2511.08812. v1 posted 2025-11-20, v2 posted 2026-02-14 (v2: typo fixes in Sec. 5). Full text available; excerpts below.

Abstract. We introduce single-contour eigenphase estimation (SCEPE) and prove that it achieves
Heisenberg-limited scaling, T_max = O(1/eps), for ground-state energy estimation, requiring only a
nonzero overlap between the initial state and the ground state.

Appendix B, Theorem 2 (p. 14). Let p0 = |<psi_0|E_0>|^2 be the ground-state overlap of the initial
state and assume p0 > 0.71. Then with probability at least 1 - eta, SCEPE returns E with
|E - E_0| <= eps using maximal evolution time T_max = O(1/eps) and total evolution time
O(eps^-1 log(1/eta)).

Remark 3 (p. 15). For p0 <= 0.71 the single-contour fit can lock onto an excited-state
contribution. We conjecture that a multi-modal variant removes the restriction; Sec. 5 gives
numerical evidence for p0 >= 0.5.

Sec. 5, Fig. 4. Numerical experiments on an 8-qubit transverse-field Ising model with
p0 in {0.5, 0.6, 0.8}. In all three cases the error decreases as 1/T_max down to 1e-3.
EOF

cat > refs/P2-adeyemi-nakamura-chu.md <<'EOF'
# P2. F. Adeyemi, R. Nakamura and J. Chu, "SCEPE on chemistry benchmarks"
arXiv:2604.02210, posted 2026-04-09. Abstract and one table available.

Abstract. We confirm the Heisenberg-limited behavior of SCEPE on molecular Hamiltonians.

Table 1. H2O, N2 and LiH active spaces (10 to 12 qubits), initial states with p0 in {0.6, 0.7, 0.9}.
Error follows 1/T_max down to 1e-3 in every case.
EOF

cat > refs/P3-varela-imhof.md <<'EOF'
# P3. A. Varela and S. Imhof, "Failure modes of single-contour phase estimation at low overlap"
arXiv:2607.11456, posted 2026-07-22. Full text available; excerpt below.

Sec. 3, Table 1. 2x4 Fermi-Hubbard model (16 qubits), initial states with p0 = 0.3 and p0 = 0.4.
SCEPE's energy error plateaus at 3e-2 and does not decrease with T_max. RWPE with the same T_max
reaches 1e-3 for both overlaps.
EOF

cat > refs/P4-blog.md <<'EOF'
# P4. Blog post "Phase estimation is solved" (2026-03-02)

SCEPE is Heisenberg-limited for any initial state with nonzero overlap, as proven by Nakamura and
Adeyemi. Older robust methods such as RWPE are now obsolete.
EOF

cat > refs/our-benchmark-overlaps.md <<'EOF'
# Our benchmark: initial-state overlaps p0 from our state preparation

| Hamiltonian | p0   |
| H1          | 0.85 |
| H2          | 0.78 |
| H3          | 0.74 |
| H4          | 0.66 |
| H5          | 0.52 |
| H6          | 0.45 |
| H7          | 0.38 |
| H8          | 0.31 |
| H9          | 0.25 |
EOF
