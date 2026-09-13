# Benchmark experiments and interpretation

Design the smallest study that can establish the intended comparison or
measurement. Select methods and regimes for the claim, not a universal model,
category, repetition, or ablation count.

## Fair comparison

Use the strongest relevant alternatives under comparable assumptions and budgets.
Record actual versions, inputs, accuracy targets, tuning effort, and resource
conditions. An older baseline can remain relevant; a newer one is not
automatically appropriate. Document consequential unavailable comparisons.

Use `stress-test-baselines` when designing or auditing the comparison itself;
it owns detailed fairness, tuning-budget, and ablation criteria. These reminders
keep the paper's experiment description aligned with that evidence.

For quantum-computing studies, distinguish algorithmic/query cost, realizable
circuit or hardware cost, and classical simulation cost. Include preparation,
compilation, repeated execution, measurement, and postprocessing when they affect
the claim. Match the cost model to the access assumptions.

For stochastic results, choose repetitions from variability and the decision's
needed precision. Report appropriate uncertainty. Deterministic execution does
not remove approximation or discretization error. Separate those errors from
sampling uncertainty and hardware noise.

## Informative analyses

Useful analyses may include total performance, scaling, accuracy-cost tradeoffs,
representative failure cases, convergence, or an ablation that isolates the claimed
mechanism. Run one because it resolves a question, not because it occupies a
standard checklist row. A full parameter Cartesian product is rarely justified
without a coverage requirement.

Use small trusted or analytical instances to catch implementation mistakes before
large runs when applicable. Check result-sensitive parameter conventions and
source-to-code correspondence. Keep validation costs out of the timed workload
unless the measured contract includes them; disclose the timing boundary.

## Conditional ML or human evaluation

Prompt variants, model-size comparisons, learned judges, contamination checks,
and human baselines apply only to settings that use them. Validate an automated
judge against an appropriate trusted reference. A human baseline is an observed
comparison, not automatically an upper bound. Temperature zero does not by
itself establish reproducibility.

When a companion learned method is present, separate training/tuning from held-out
evaluation, check relevant leakage, and obtain evidence for the claimed
generalization. Do not demand unrelated downstream studies or every ablation.

## Evidence and reporting

Report the actual finding and its tested scope, including informative negative
results. Do not force surprise, a monotonic trend, or a mechanism explanation from
aggregate scores. Keep enough configuration, provenance, and raw evidence for
reproduction and important failure diagnosis, with bounded retention. Avoid
duplicate large outputs or repeated computation solely to populate reports.
