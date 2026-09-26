#!/usr/bin/env bash
set -euo pipefail
cat > plan.md <<'EOF'
# QLS-Bench experiment plan (draft 2)

## Question
How do resource requirements of quantum linear-system solvers compare with
classical iterative solvers on sparse systems from PDE and graph problems, and
in which condition-number regimes does each become impractical?

## Methods
- Quantum (resource estimates from our library): QSVT inversion, discrete
  adiabatic, Chebyshev LCU. Cost = T-count and logical qubits of the solver
  circuit, assuming the block-encoding of A and the state preparation of b are
  given as oracles (not counted).
- Classical: CG and GMRES from SciPy. Cost = wall-clock time on a laptop.

## Instances
- Poisson 2D (fixed family), graph Laplacians of 6 fixed road networks, random
  sparse SPD matrices (seeded).

## Grid
5 methods x 8 sizes (2^6 ... 2^20) x 6 target accuracies (1e-1 ... 1e-6)
x 4 condition-number regimes x 10 seeds = 9,600 runs.
All five solvers are deterministic. The seed changes only the random sparse SPD
family. The same 10 seeds are also run for the Poisson and road-network families.

## Validation
For every quantum run, including 2^20, after each QSVT phase block compute the
fidelity of the simulated state with the exact solution using a dense
statevector. This check runs inside the timed region so that timing is
"honest".

## Advisor feedback (to decide)
"Benchmark papers without a new method are hard to publish. Add our own learned
phase-factor predictor (an MLP trained on these same matrices) as the paper's
method, and add a human-expert baseline where two students hand-tune phase
factors."
EOF
