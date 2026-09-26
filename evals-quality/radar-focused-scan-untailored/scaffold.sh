#!/usr/bin/env bash
set -euo pipefail

cat > candidates.md <<'EOF'
# Candidates exported 2026-09-26 for: non-unitary dynamics, LCHS, quantum ODE/PDE solvers
# Abstracts, plus excerpts where the full text was opened.

## A. arXiv:2609.10555 (submitted 2026-09-12)
Lower bounds on kernel truncation in linear combination of Hamiltonian simulation
Authors: M. Szabo, R. Okonkwo
Abstract: We prove that for every kernel in the admissible LCHS class, the frequency cutoff needed to
reach error eps is Omega(log(1/eps)). This matches the best known upper bounds up to a
log log(1/eps) factor, so further kernel design within this class cannot improve the cutoff scaling.

## B. arXiv:2608.22019 (submitted 2026-08-28)
Schrodingerization with adaptive auxiliary-variable discretization
Authors: T. Lindahl, P. Moreno
Abstract: We demonstrate an exponential speedup for linear dissipative PDEs by adaptively discretizing
the auxiliary variable in Schrodingerization.
Excerpt, Sec. 4: All results are classical emulations with at most 6 qubits, comparing adaptive and
uniform auxiliary grids. Adaptive grids need 30% to 45% fewer grid points for the same error. No
asymptotic complexity analysis is given.

## C. arXiv:2607.01880 (v1 submitted 2026-07-03, v2 submitted 2026-09-18)
Success-probability bounds for dilation-based linear ODE solvers
Authors: H. Brenner, K. Yamada
Abstract: We bound the success probability of dilation-based quantum linear ODE solvers in terms of
the solution norm history.
v2 comment: Corrected Lemma 4. The success-probability bound in v1 omitted a factor
||u(T)||^2 / ||u(0)||^2. With the correction, the main theorem holds only for solutions whose norm
does not decay; decaying solutions need amplitude amplification with cost growing as ||u(0)|| / ||u(T)||.

## D. arXiv:2605.07721 (submitted 2026-05-11, no later versions)
Block-encoding of Fokker-Planck operators
Authors: S. Rahman, E. Duval
Abstract: We give explicit block-encodings of discretized Fokker-Planck operators with normalization
linear in the drift bound and apply them within LCHS.

## E. arXiv:2609.14777 (submitted 2026-09-15)
QAOA for MaxCut on 127 qubits
Authors: J. Ferreira
Abstract: We run depth-2 QAOA for MaxCut on a 127-qubit device and compare with Goemans-Williamson.

## F. arXiv:2609.19002 (submitted 2026-09-22)
Resource estimates for quantum lattice Boltzmann simulation of Navier-Stokes flow at Re = 10^4
Authors: L. Garnier, A. Kowalczyk
Abstract: We estimate logical qubits and T-count for a Carleman-linearized quantum lattice Boltzmann
solver at Reynolds number 10^4.
Excerpt, Sec. 2: We assume QRAM-style state preparation of the initial velocity field. The cost of
reading out the full velocity field is not included; we report the cost to prepare the final state.

## G. arXiv:2608.03020 (submitted 2026-08-04)
Randomized LCHS by importance sampling of kernel nodes
Authors: Y. Chen-Moreau, D. Abara
Abstract: We sample LCHS kernel nodes by importance sampling and prove a variance bound that is
independent of the number of quadrature nodes. Numerics on a 1D advection-diffusion problem with
up to 10 qubits match the bound.

## H. Press article (tech news site, 2026-09-20)
"Quantum computers can now solve any differential equation exponentially faster"
Reports on arXiv:2608.22019 (item B above).
EOF
