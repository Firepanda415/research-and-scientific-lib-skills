# Resource accounting

Read this reference when a change affects resource use, stored output, a
declared work or memory limit, or a resource claim, or when extra computation
needs the approval that the parent skill requires.

When asking for that approval, count target scale and repetition, including
classical work alongside quantum execution. Disclose unknown cost without first
launching an expensive measurement. Approval for one bounded check does not
authorize a recurring production check or new selection or termination
behavior. Make the request brief, with a bold statement of the concrete added
work, its cost and frequency, its effect on results, and a recommendation.

- Define the affected resource envelope: circuit counts, depth and two-qubit
  gates, per-circuit and total shots, backend calls, expensive-kernel calls,
  peak live memory, stored and serialized bytes, or cache/output growth.
  Select relevant quantities, their populations, and their growth with problem
  size and iterations. Compare the same workload, accuracy target, execution
  mode, and environment, and distinguish measured values from projections.
- Trace each stored payload to its consumers and reproduction, statistical,
  or provenance obligations. Preserve sufficient auditable evidence with an
  explicit retention policy. Prefer bounded aggregation, deduplication, or
  streaming when they preserve those obligations, and keep required raw
  evidence with a stated storage budget. Make optional detailed capture
  explicit. A seed alone does not reproduce stochastic or hardware
  observations.
- Check peak live memory as well as final output size, including temporary
  copies, accumulated per-iteration records, and repeated report serialization.
  Resource records must not trigger unnecessary construction or execution merely
  to describe it. Include affected tests and examples in this cost check. A
  statement that a resource quantity is absent or unknown holds only in the
  context where it was checked, such as the gate basis. Name that context.
- Validate fixed assumptions at input or representation boundaries. Use the
  established optimized numerical stack and a scalable representation. Fewer
  lines or a standard-library loop do not imply less computation.
- When software enforces a declared work or memory limit and a stage's count is
  known before it starts, such as a circuit count given by a closed-form law,
  check the stage against the limit before its first unit of work. Charge
  what each stage actually adds rather than a whole-run upper bound, which
  would refuse runs that stop early. A refusal names the limit's field, the
  limit, the amount already counted, the amount requested, and the minimum
  needed, all taken from the current state, and every remedy, such as the
  constructor argument or the method that extends an open run.
- Before an admission check relies on a work or memory law, derive the law as
  an upper bound and compare it with traced execution over varied inputs.
  Report the range of the law's ratio to the measurement. A ratio below one on
  any traced input refutes the bound. Say where the law overestimates most and
  why, for example a memory bound that cannot anticipate how much truncation
  will remove.
- Revisit a deferred item when new measurements or an expanded workload
  invalidate its rationale. Record the cost, owner, and revisit condition.
  Increasing the affected footprint requires remeasurement or a justified bound
  before acceptance.
