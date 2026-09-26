#!/usr/bin/env bash
set -euo pipefail
mkdir -p log
cat > log/experiments.md <<'EOF'
# Layerwise warm start (LWS) for VQE: research log

Method: grow a hardware-efficient ansatz one layer at a time. LWS initializes each
new layer to the identity and copies the optimized parameters of the previous
layers. Baseline: full-depth ansatz with random initial parameters.
Metric: optimizer iterations to reach 1.6 mHa of the exact ground energy.
All runs: statevector simulation, Adam, seeds 0-4. No hardware runs, no
wall-clock comparison.

2026-03-02  H2, LiH: LWS needs 40% fewer iterations than baseline.
2026-03-05  Found sign bug in our parameter-shift gradient. Fixed, reran H2, LiH:
            LWS needs 35% fewer iterations. The 40% numbers are invalid.
2026-03-09  Learning-rate sweep 1e-3 to 1e-1 on LiH. Picked 0.02 for all runs.
2026-03-12  BeH2: LWS needs 30% fewer iterations.
2026-03-15  Control: same layer-by-layer growth, but each new layer gets random
            parameters instead of the identity/copy warm start. Result: 28% fewer
            iterations than baseline on H2, LiH, BeH2 (vs 35%, 35%, 30% for LWS).
            So most of the saving comes from growing layer by layer, not from the
            warm-start values.
2026-03-18  Final energies: LWS, control and baseline agree within 1e-6 Ha on
            H2, LiH, BeH2.
2026-03-20  Proof: when the appended layer is initialized to the identity, the
            initial energy of the L-layer circuit equals the optimized energy of
            the (L-1)-layer circuit. Exact, by construction.
2026-03-25  N2 (12 qubits): LWS failed to converge in 2 of 5 seeds, baseline in
            1 of 5 seeds. Gradients vanish after layer 6 in the failing seeds.
EOF
