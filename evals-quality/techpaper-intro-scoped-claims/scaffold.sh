#!/usr/bin/env bash
set -euo pipefail
mkdir -p notes
cat > notes/claims.md <<'EOF'
# Symmetry-projected Trotter paper: claims and evidence (for the Introduction)

Working headline: "exponential reduction in Trotter steps for symmetric Hamiltonians"

## Setting
H = A + B on n qubits. First-order Trotter with r steps has the standard bound
||U(t) - (e^{-iAt/r} e^{-iBt/r})^r|| <= t^2 ||[A,B]|| / (2r)   [CommutatorBounds]
Prior symmetry work used symmetries to protect against or mitigate errors
[SymProtect, SymVerify] but did not use them to reduce the step count.

## Results
1. Theorem 1 (proved, Appendix A). If H commutes with a symmetry group G and the
   initial state lies exactly in one irreducible sector with projector P, the
   first-order error is bounded by t^2 ||P [A,B] P|| / (2r).
   Condition: exact sector initialization. No statement for mixed-sector states.
2. Numerical observation. XXZ chains, open boundaries, n = 8, 10, 12, 14, 16,
   classical statevector simulation: the projected bound is 3.1x to 4.7x
   smaller than the unprojected bound, so r is 3.1x to 4.7x smaller at the same
   error. n > 16 not tested.
3. Interpretation (not shown). We suspect the ratio keeps growing with n because
   the sector dimension shrinks relative to 2^n. The ratio from n = 8 to 16 grows
   slowly (3.1, 3.6, 4.0, 4.4, 4.7). No proof, no data beyond n = 16.
4. Control. Transverse-field Ising model with a random product initial state
   (not in a single sector): ratio 1.0x to 1.1x, no useful reduction.

## Our draft contribution list
C1. Theorem 1.
C2. XXZ numerics.
C3. A new ProjectedTrotter class in our library.
C4. A caching layer for commutator norms.
C5. A --sector command-line flag.
C6. A GPU backend for norm estimation.

## Citation keys available
CommutatorBounds, SymProtect, SymVerify, XXZReview, TrotterSurvey
EOF
