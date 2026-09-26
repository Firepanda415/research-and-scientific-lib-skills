#!/usr/bin/env bash
set -euo pipefail
mkdir -p round1 round2
cat > round1/policy_note.md <<'EOF'
Policy record, round 1 (made by me, the referee)
Journal: Physical Review-style journal, single-anonymous review.
Reviewer guidelines checked 2026-06-02: AI tools may assist if no manuscript
material is uploaded to external services. No disclosure field in the form.
Manuscript is not public (no preprint found by the editor).
EOF
cat > round1/my_report.md <<'EOF'
Referee report, round 1, manuscript "Hardware-efficient VQE for the 1D Fermi-Hubbard model"

M1. The paper claims that the VQE outperforms classical methods for the 8-site
Hubbard chain, but DMRG is essentially exact for 1D chains of this size. Please
compare with DMRG and revise the claim accordingly.

M2. The VQE uses 1e4 shots per energy evaluation. Please state the total
sampling budget and compare it with the classical VMC baseline's budget.

M3. The extrapolation in Sec. 5 to 20 sites is not supported by any data beyond
8 sites. Please remove it or provide evidence.
EOF
cat > round2/rebuttal.md <<'EOF'
Response to the referee

M1. We added a DMRG comparison (new Table 3). We note that VQE is
hardware-native, which is its main advantage.

M2. Both methods now use matched budgets: 1e4 shots for VQE and 1e4 samples
for VMC.

M3. We removed the extrapolation to 20 sites.
EOF
cat > round2/revised_manuscript.md <<'EOF'
# Hardware-efficient VQE for the 1D Fermi-Hubbard model (revised)

## Abstract
For the 8-site Fermi-Hubbard chain at U/t = 4, our hardware-efficient VQE
outperforms classical methods and reaches an energy ratio of 0.998.

## 2 Methods
The Hamiltonian is measured in 45 commuting Pauli groups with 1e4 shots per
group per energy evaluation. The optimizer runs 300 iterations. The VMC
baseline draws 1e4 Monte Carlo samples in total.
To make all energies positive, we add a constant offset c = 40 to H and report
the energy ratio r = (E_exact + c) / (E_VQE + c).

## 4 Results
Table 3 (new): ground-state energy error |E - E_exact| for 8 sites, E_exact = -9.80.
| Method | Energy error |
|--------|--------------|
| VQE    | 6e-2         |
| VMC    | 3e-2         |
| DMRG   | 1e-8         |

The VQE energy is E_VQE = -9.74, giving r = 30.20 / 30.26 = 0.998.

## 5 Conclusion
The VQE approach reaches near-exact energies and scales favorably to 20 sites,
making it a promising route to quantum advantage for correlated fermions.
EOF
