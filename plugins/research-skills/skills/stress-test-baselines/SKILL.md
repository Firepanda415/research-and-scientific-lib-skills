---
name: stress-test-baselines
description: "Assess, design, or run fair research comparisons and ablation studies when a claimed improvement depends on baseline quality, tuning budgets, component contributions, or robustness. Use for comparison audits and designing or running baseline comparisons or ablations. Ordinary paper writing or reading alone does not trigger a new experiment campaign."
---

# Stress Test Baselines

## Match the requested work

- **Assess:** inspect existing methods, results, budgets, and claim wording. In a
  referee review, decide whether missing comparisons materially affect the
  conclusion; do not require or launch a new study to complete the review.
- **Design:** propose the smallest comparison that can resolve the uncertainty,
  with a compute and storage budget and a stopping condition.
- **Execute:** perform and verify the authorized comparisons. Reuse valid existing
  results; start with a small representative case before expensive work. If no
  budget is stated or inferable, run the small representative case, report its
  measured cost and the planned comparison set, and get approval before scaling.

Use the user's request to select the mode. An execution request should finish
with results rather than another plan. A review or design request does not
authorize an expensive experiment campaign.

## Establish the comparison

Infer the claimed improvement, relevant competitors, metrics, regime, and
available budgets from the supplied paper, code, or artifacts. Ask only for
missing information that changes the decision and cannot be inferred. Distinguish
unavailable evidence from evidence of failure.

Choose a strong feasible baseline for the actual use case. Fairness means making
the comparison's constrained and measured resources explicit, not forcing every
resource to be equal simultaneously. For quantum computing this can include
accuracy, problem size, state preparation, measurement shots, classical work,
runtime, peak memory, and access assumptions. Compare like quantities.

Use fair bounded tuning for every compared method, including the proposed one,
and report the search space, effort, selected settings, and meaningful
sensitivity. When the claim concerns one configuration of the proposed method
across instances, choose a single shared setting by a stated rule. Picking each
instance's best setting by the evaluation metric is then oracle selection, unless
per-instance selection is part of the method and uses only information available
when the method is applied, or the claim is explicitly about per-instance
tuning. A search revised after seeing results is acceptable when the revision is
reported and every instance is rerun. Default settings are acceptable when justified for the
comparison. They are not automatically a strong or weak baseline.

Identify differences that could explain the gain. Select ablations and interaction
checks that distinguish plausible explanations or test the claimed contribution.
Use seeds, regimes, datasets, accuracy targets, tails, or limiting cases where
they materially affect the claim. A ranking at one accuracy target can reverse at
another target a reader would reasonably use. Do not require every axis or
component to be tested, and do not run a full Cartesian sweep without a
decision-relevant reason and budget.

For an ablation study, identify what is removed and which outcome can reveal its
contribution, and check interactions when removing components separately could
miss them. When the ablated item is a test or code component, choose the check
by the kind of component. Test-suite ablation measures which independently
confirmed defects are no longer detected and which legal (valid) controls are
wrongly rejected, plus cost. Production-code simplification instead checks
preservation of scientific meaning, public behavior, and resource requirements.
Keep the relevant oracle independent of the ablated component. Passing all
remaining tests does not by itself establish that removed code or evidence was
unnecessary.

Stop adding comparisons when the requested decision is supported, the authorized
budget is reached, or the remaining uncertainty is better handled by narrowing
the claim. A bounded negative or inconclusive result is a valid outcome.

## Report

State the surviving claim, comparison and budget evidence, plausible alternative
explanations, and any missing check that could change the conclusion. For design,
provide the proposed discriminating experiment; for execution, report actual
results and limitations. Avoid a fixed report schema and never describe a
planned experiment as completed evidence.
