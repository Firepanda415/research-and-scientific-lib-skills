#!/usr/bin/env bash
set -euo pipefail
mkdir -p notebook results/adaptive_L12 configs

cat > notebook/adaptive-trotter.md <<'EOF'
# Adaptive Trotter step size: research notebook

Entries are appended in date order, newest last. IDs: O-nn observation, P-nn
prediction, R-nn resolution. A resolution links the prediction it resolves.

## 2026-09-03 · O-05 · Fixed-step baseline at L=12

Heisenberg chain, L=12, open boundaries, second-order Trotter, t_final = 10. The
fixed-step baseline needs 1,840 steps to reach target error 1e-3 (achieved 9.1e-4).
Source: results/fixed_L12/summary.csv, commit 3f9c2e1.

## 2026-09-10 · P-07 · Prediction for adaptive steps at L=12

Made before any adaptive run at L=12 (commit 3f9c2e1).

Prediction: for the L=12 Heisenberg chain at target error 1e-3, adaptive step-size
control reduces the total number of Trotter steps by at least 30% relative to the
fixed-step baseline in O-05.

Confidence: 70%.

Reasoning: the commutator norm estimate drops by about 3x after t = 2, so later steps
can be longer.

Would count against: a reduction below 15% at the same target error.

## 2026-09-18 · O-06 · Adaptive controller overhead at L=8

At L=8 the step controller's commutator estimate costs about 6% of wall time per
step. Source: results/adaptive_L8/profile.txt, commit 7d2b9e4.
EOF

cat > results/adaptive_L12/summary.csv <<'EOF'
# generated 2026-09-24 by scripts/run_adaptive.py, commit 8a41d07
# config: configs/adaptive_L12.toml
L,boundary,order,method,target_error,achieved_error,trotter_steps,wall_time_s
12,open,2,adaptive,1e-2,8.7e-3,862,1432
EOF

cat > configs/adaptive_L12.toml <<'EOF'
[model]
name = "heisenberg"
L = 12
boundary = "open"

[evolution]
t_final = 10.0
trotter_order = 2
method = "adaptive"
target_error = 1e-2   # TODO: set back to 1e-3 after the smoke test

[controller]
safety = 0.9
max_growth = 1.5
EOF
