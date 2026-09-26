#!/usr/bin/env bash
set -euo pipefail
mkdir -p results
cat > results/summary.md <<'EOF'
# ODE-Bench v0.3 results (frozen 2026-09-20)

Task: solve du/dt = A u, u(0) = u0, to relative error eps = 1e-4 at final time T.
Suite: 12 instances (heat 1D/2D, advection-diffusion, damped oscillator chains),
N = 2^8 to 2^14 unknowns. Reference solution: dense expm at N <= 2^12, high-order
Radau with rtol = 1e-10 above that.

| Method            | Solved to eps | Median time (s) | Median over |
|-------------------|---------------|-----------------|-------------|
| LCHS (ours)       | 9 / 12        | 0.41            | 9 solved    |
| Krylov expmv      | 12 / 12       | 4.9             | 12          |
| RK45 (SciPy)      | 12 / 12       | 7.3             | 12          |

Notes from the run config (configs/run.yaml):

- LCHS time is the wall time of the statevector simulation of the LCHS circuit
  in our library on one A100. State preparation of u0 is assumed given
  (amplitude encoding not simulated or counted). Readout assumes the full
  normalized output state is available, so no measurement shots are counted.
- LCHS was tuned per instance over 48 (truncation, quadrature) settings and the
  fastest setting that met eps is reported.
- Krylov expmv and RK45 ran with library default settings (Krylov dimension 30,
  RK45 rtol = 1e-6, atol = 1e-9). No tuning.
- LCHS did not reach eps on the 3 advection-dominated instances within the
  2^14-slot limit. Those 3 instances are excluded from the LCHS median.
- Speedup quoted in draft: 4.9 / 0.41 = 12x.
EOF
