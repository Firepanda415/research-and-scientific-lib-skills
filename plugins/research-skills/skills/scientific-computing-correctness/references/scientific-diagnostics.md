# Scientific diagnostics

Use this reference for unexplained results or slow experiment cycles. Start from
available code, configurations, logs, and outputs; identify the uncertainty
before choosing another run.

## Unexpected results

- Separate the aggregate observation from its proposed explanation. Aggregate
  evidence can support an aggregate claim without establishing its mechanism.
- Inspect cases that distinguish competing causes: representative and failing
  regimes, boundaries, tails, or counterexamples. Use stratified sampling when
  imbalance could hide a failure; do not impose a sample quota.
- Check relevant inputs and conventions before attributing the result to the
  method. Group failures only when the observations support a useful category.
- State the observed pattern, competing explanation, and smallest distinguishing
  check. After an intervention, inspect the affected cases and metrics again.
- For large states or trajectories, use selected observables, residuals, or
  streamed summaries. State what the inspected sample cannot establish.

## Slow experiment cycles

- Locate time spent reaching an informative result, including launch, execution,
  interpretation, and repeated manual work. Use existing timings first.
- Choose the smallest workload that preserves the mechanism being tested;
  shrinking away the relevant regime or parallel behavior is not a valid check.
- Reuse launch and comparison routines. Add automation only for a demonstrated
  repeated bottleneck, and keep the code, input, configuration, environment
  identifiers, and observations needed to reproduce the claim.
- Expand the workload only when doing so resolves a remaining uncertainty.
  Complete an authorized fix and its verification rather than stopping at a plan.
