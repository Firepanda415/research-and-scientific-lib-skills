#!/usr/bin/env bash
set -euo pipefail
bash "$(dirname "$0")/../_trigger-fixture/polyevo.sh" after

cat > FINDINGS.md <<'EOF'
# Findings from the reviewer of polyevo 1.3

We reproduced the number in each finding, on this commit, with the same inputs.

## F1. Long evolutions with decay are refused

`plan_evolution` with decay rate `gamma = 0.5`, so that `alpha` includes it and
`tau = alpha * t`, at `t = 300` fails with a phase residual of 1.53e-12 above the
fixed tolerance of 1e-12. The requested output is the norm of the evolved state,
`norm_squared = exp(-2 * gamma * t)`. Proposed: accept as Blocking.

## F2. Outlying Ritz errors come from the overlap matrix

In three outlying seeds the lowest Ritz value of the measured pencil is off by up
to 0.72. We kept the recorded `h` and replaced the measured `s` by the exact
overlap, which brought the error down to 0.036. The recorded `h` is the first
element returned by `polyevo.pencil.assemble_pencil`. Proposed fix: pool the
overlap measurements of all groups.

## F3. Commutator tables can exhaust memory during planning

`commutator_terms` builds its rows during planning with no memory check, and the
table reached 4.7 GiB for a 16-qubit system. Proposed fix: at the start of planning
raise `MemoryError` when
`len(hamiltonian_labels) * len(candidate_labels) * 8 * (qubits + 1) > max_bytes`.
EOF
git add -A
git commit -qm "Add the reviewer's findings"
