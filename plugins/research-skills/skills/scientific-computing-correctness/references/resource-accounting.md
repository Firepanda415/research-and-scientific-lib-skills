# Resource accounting

Read this reference when a change affects resource use, stored output, a
declared work or memory limit, or a resource claim, or when extra computation
needs the approval that the parent skill requires.

When asking for that approval, count target scale and repetition, including
every stage of a hybrid workflow, such as classical work alongside quantum
execution. Disclose unknown cost without first
launching an expensive measurement. Approval for one bounded check does not
authorize a recurring production check or new selection or termination
behavior. Make the request brief, with a bold statement of the concrete added
work, its cost and frequency, its effect on results, and a recommendation.

- Define the affected resource envelope: expensive-kernel, solver or backend
  calls, iterations, communication, peak live memory, stored and serialized
  bytes, or cache/output growth, and for quantum workloads circuit counts,
  depth and two-qubit gates, and per-circuit and total shots.
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
- Before an admission check relies on a work or memory law, compare it, within
  approved cost, with traced execution over varied inputs and at two or more sizes
  where the dominant allocation dominates, measuring memory in a fresh process.
  Report the range of the law's ratio to the measurement and judge it by both
  failures: admitting work that exhausts the resource, and refusing work that
  would run. A ratio below one refutes a law stated as an upper bound. A coarse
  estimate is judged against the factor the project accepts, so a small difference
  near a limit is no defect, and one low by an order of magnitude is a defect
  however it is labeled. Say where the law overestimates most and why, for example
  a memory bound that cannot anticipate how much truncation will remove. A bound
  far above what posed inputs reach can size a stage or warn, but does not refuse,
  because it rejects runnable inputs. A limit the user declares as hard, such as a
  paid budget, may refuse on a stated upper bound.
- Label each reported quantity by what produced it. `exact` needs a comparison
  with the emitted artifact on a case that separates it from the alternatives,
  such as a serial sum against a depth on disjoint gates, or an upper bound
  against the count after classification. A declared size is an estimate until
  it is observed. State the population a count covers.
- Removing a cap or changing a default extends what users can reach, including
  the cost the cap hid. Before that change lands, walk the route along its
  users' growth axes toward the documented or reported target scale, without full
  execution where possible, such as its users' size, time, precision and
  conditioning. Planning can itself be expensive, so a step beyond approved cost
  stays unrun, with its forecast in the report. A check at one size just
  above the old cap shows only that the cap is gone. Move a known-size check ahead
  of the work it guards, and record the scale reached and what stopped it.
- Revisit a deferred item when new measurements or an expanded workload
  invalidate its rationale. Record the cost, owner, and revisit condition.
  Increasing the affected footprint requires remeasurement or a justified bound
  before acceptance.
