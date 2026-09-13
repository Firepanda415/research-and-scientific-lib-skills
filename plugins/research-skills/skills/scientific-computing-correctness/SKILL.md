---
name: scientific-computing-correctness
description: "Implement, debug or independently validate scientific computations while preserving mathematical meaning, numerical accuracy and resource bounds. Use for scientific IV&V and executable research results; exclude manuscript-only review and ordinary application code."
---

# Scientific Computing Correctness

## First principle

Start from the intended scientific contract and realistic use of the relevant public entry, including representative valid inputs and options. Trace the affected quantity through the actual call chain to the results, decisions, reports, and costs its consumers receive. Locate the first divergence and correct its owner before stacking patches around symptoms. Preserve scientific invariants when optimizing or simplifying.

Connect worker-local checks to that user-facing relation. Base completion on integrated behavior supported by independent scientific evidence; revise obsolete or unjustified tests to match the established contract. Use existing evidence, source reasoning, and the smallest discriminating check needed. This perspective does not require rerunning every end-to-end workload or authorize extra runtime diagnostics or unapproved expensive computation.

Discarding information does not by itself justify a stronger claim or greater certainty. Improvements from denoising, estimation, or aggregation need their own mathematical or empirical justification.

## Authority of project records

When a plan, policy, framework, constants registry, review report, or prior
AI-authored summary could change the scientific decision, use the user's
project-level authority classification:

- **Constitutional:** an invariant or decision the user explicitly designates
  as requiring an explicit amendment before it changes.
- **Living:** current engineering guidance that should be revised when better
  first-principles reasoning, executable evidence, or an authorized design
  change makes it stale. Update its enforcement and downstream representations
  together.
- **Descriptive or generated:** a record of code, environment, results, or
  artifacts. Refresh it from the semantic owner; do not use it to overrule the
  state it is meant to describe.

Only the user or a delegated project owner designates constitutional status.
Do not infer it from a filename, location, tone, age, test, or prior agent's
wording. No document establishes mathematical or numerical truth by assertion.
When an undesignated or living record conflicts with current evidence, decide
from the intended quantity and first principles whether the code, the record,
or both must change. Ask the user only when the classification or amendment
authority would materially change the result and has not already been recorded.

## Scientific contract

State only the dimensions relevant to the task, but make them explicit before
implementation:

- the intended quantity and its domain, assumptions, units, frame, sign,
  ordering, and convention.
- whether each statement is mathematical truth, exact computation, numerical
  approximation, heuristic, diagnostic, statistical estimate, resource bound,
  or lifecycle fact.
- execution completion and scientific validation as separate states. A
  user-authorized experimental or hardware-facing mode may preserve raw output
  without error control. Execution success does not imply that scientific
  validation passed, that the computation converged, or that its error is
  controlled. Any estimate or downstream decision not protected by a justified
  bound remains empirically assessed or unvalidated, not certified. An
  experimental estimate may still drive an operational decision.
- the canonical owner, downstream decision, allowed uncertainty, and evidence
  artifact.
- the legal states and relations between fields, including combinations of
  independent options or evidence sources.

Do not promote an observed floating-point pattern, sampled maximum, measured
diagnostic, or passing regression into an exact theorem or certified bound.

## Source-to-code fidelity

For paper-derived implementations or equation/representation changes, read [source-to-code fidelity](references/source-fidelity.md) before accepting the transformation.

## Approximation and decision safety

- An exact path must not silently discard, threshold, round, clip, or substitute
  nonzero information.
- Derive acceptance thresholds from the intended quantity, method, or error
  budget. Do not fit or widen them after observing failures merely to pass a
  gate. Dependence on scale, dimension, or conditioning needs a derivation or
  justified error model; multiplying machine epsilon by a convenient size is
  not a justification. Legitimate calibration and fitted scientific models
  remain valid methods when their role and validation are explicit; they do
  not become certified bounds by fitting the examples used to accept them.
- Identify approximations that can materially affect the requested result. For
  an error-controlled claim, propagate defensible error or uncertainty through
  the affected consumers; recording unused removed mass is not propagation.
- A certified ranking, stopping rule, selection, or pass/fail decision requires
  its advertised guarantee. For a deterministic bound this may require every
  admissible value to give the same decision; for a statistical guarantee use
  the stated model, confidence level, and any adaptive-selection correction.
- Exploratory computations may use empirical convergence checks or heuristics
  without a formal bound. State their basis and limitations; distinguish
  operational termination from established convergence. Do not add certificate
  machinery or reject usable experimental output merely because no proof exists.
- Coefficient size alone does not determine relevance to a state, observable,
  cancellation, or later decision. Use the bound in the consumer's frame.
- Combining exact and sampled contributions needs a valid uncertainty model
  for any certified result. Preserve the raw estimate and provenance when a
  variance-like estimate is negative; clipping it to zero does not establish
  zero uncertainty or certified success.
- If evidence cannot support the advertised guarantee, leave that guarantee
  unresolved or narrow the claim. Reject inputs when the method's required
  premises fail, not merely because the result is experimental. Never convert unknown,
  `not_run`, `not_evaluated`, `not_applicable`, or suppressed evidence into zero,
  false, or passed.

## Ownership and cross-layer consistency

- Give each scientific fact, status vocabulary, and lifecycle transition one
  semantic owner. Trace every producer, transform, caller, sibling path, and
  consumer before changing a shared owner.
- When a public record is affected, define the field's meaning and the units,
  population, event, or cross-field relations needed to interpret it. Do not
  introduce a new status schema or bookkeeping layer for an unchanged contract.
- Validate semantic relations, not only type conversion. Defaults must not
  overwrite observed facts. If the contract defines nested circuit populations,
  check relations such as `0 <= executed <= realized <= represented` together.
  Derive the relation from the actual populations; retries or different counting
  units may require a different relation.
- Identify interactions that can violate the changed invariant. Use separating
  cases or equivalence classes; enumerate a full Cartesian product only when
  the contract and cost justify it. Independent one-axis checks can miss coupling.
- Treat code, equations, documentation, structured results, human reports, and
  generated artifacts as representations of the same scoped claim. A contract
  change migrates all of them together.
- Metadata and error records must describe the same construction or execution
  that produced the shipped artifact, not a second nominally equivalent build.

## Dependency failures and recovery

For dependency exceptions, numerical failures or proposed recovery, read [dependency recovery](references/dependency-recovery.md). Recover only by an applicable scientific method; otherwise preserve and propagate the cause.

## Resource proportionality and retention

When a change affects resource use, treat material cost growth, memory exhaustion,
worsening scaling, and inaccurate resource claims as acceptance concerns. Use the
user's priorities and measured impact to rank them alongside scientific defects;
do not automatically defer them as cleanup. A justified accuracy or capability
gain may require more resources; state that tradeoff explicitly.

Extra expensive or poorly scaling computation beyond the authorized algorithm
or workload to validate, diagnose, or correct results requires explicit human
approval before execution or inclusion in the default runtime path. This covers
extra simulation, full-state operator applications, dense reference solves, and
growing evidence capture. Count target scale and repetition, including classical
work alongside quantum execution. Disclose unknown cost without first launching
an expensive measurement. Approval for one bounded check does not authorize a
recurring production check or new selection/termination behavior. Existing
explicit approval at the same scope and ordinary cheap checks need no new gate.
Make the request brief, with a bold statement of the concrete added work, its
cost and frequency, its effect on results, and a recommendation. A coordinator
cannot provide missing human approval.

- Define the affected resource envelope: circuit counts, depth and two-qubit
  gates, per-circuit and total shots, backend calls, expensive-kernel calls,
  peak live memory, retained and serialized bytes, or cache/output growth.
  Select relevant quantities, their populations, and their growth with problem
  size and iterations. Compare the same workload, accuracy target, execution
  mode, and environment; distinguish measured values from projections.
- Trace each retained payload to its consumers and reproduction, statistical,
  or provenance obligations. Preserve sufficient auditable evidence with an
  explicit retention policy. Prefer bounded aggregation, deduplication, or
  streaming when they preserve those obligations; retain required raw evidence
  with a stated storage budget. Make optional detailed capture explicit. A seed
  alone does not reproduce stochastic or hardware observations.
- Check peak live memory as well as final output size, including temporary
  copies, accumulated per-iteration records, and repeated report serialization.
  Resource records must not trigger unnecessary construction or execution merely
  to describe it. Include affected tests and examples in this cost check.
- Validate fixed assumptions at input or representation boundaries. Keep
  expensive checks, dense reference constructions, repeated scans, copies, and
  diagnostic serialization out of hot loops unless the algorithm requires them.
  Use the established optimized numerical stack and a scalable representation;
  fewer lines or a standard-library loop do not imply less computation.
- Revisit a deferred item when new measurements or an expanded workload invalidate
  its rationale. Record the cost, owner, and revisit condition; increasing the
  affected footprint requires remeasurement or a justified bound before acceptance.

Reducing cost must preserve the scientific quantity, error control, and required
evidence. Small coefficients or large raw outputs alone do not justify deletion.

## Verification

- For a "scientific IV&V" request, apply this skill as independent verification
  and validation of the specified computation and claims. Independently assess
  the mathematical premises and expected behavior, not just agreement with the
  implementation or its tests. Trace representative ordinary public workflows
  through actual execution and raw evidence; include material resource behavior.
- Define the falsifier before accepting the implementation: ask what
  ordinary, adversarial, boundary, mixed-interaction, or cross-layer case could make every
  local check pass while the scientific conclusion is wrong.
- Use an independent oracle or equivalent first-principles derivation with a
  different failure mode. Two consumers of the same builder prove consistency,
  not correctness.
- Keep acceptance oracles in development verification unless their production
  role is explicitly justified and authorized. An agreement test does not
  authorize full reference recomputation or exact-decision equality in a hot
  loop. Fix the numerical owner and reuse existing results before proposing
  additional work. Do not satisfy an accuracy failure merely by installing a
  veto and changing the test to expect termination; lack of a certificate does
  not by itself require stopping a usable experimental computation.
- Leave the smallest test set that protects a current scientific, resource,
  provenance, lifecycle, public-input, or serialization obligation. Temporary
  migration and implementation-shape checks do not become permanent tests.
- Classify numeric assertions before writing them. Compare floating-point values
  numerically with a tolerance derived from the method and with explicit margin
  from decision boundaries. For APIs that combine absolute and relative
  tolerances, set both explicitly; an omitted library default must not define or
  dominate the effective acceptance window. Require exact text only when
  byte-level serialization or formatting is itself the contract.
- A green build, regenerated notebook, mutation kill, or full test suite proves
  only the invariants that its checks can falsify. Use an additional independent
  pass when unresolved scientific risk warrants it; do not rerun settled checks
  or large experiments without a new evidential need.

## Remediation closure

When work is intended to close earlier scientific-review findings, read
[references/remediation-closure.md](references/remediation-closure.md) before
editing. Its closure-ledger, original-falsifier, shared-record, integration,
evidence-deletion, and environment rules are mandatory for that remediation
mode. Ordinary scientific-computing tasks do not load this reference.

## Completion

Report the invariant preserved, the first divergence fixed, the independent
evidence used, and anything still approximate, unvalidated, unresolved, or out
of scope. Do not claim formal proof, universal scalability, or end-to-end error
control unless those are actually established.

When Ponytail or other minimal-change guidance also applies, this skill defines
the correctness constraints first. Minimize only within them. For unexpected
results or slow experiment cycles, read
[scientific-diagnostics.md](references/scientific-diagnostics.md) when needed.
Use `stress-test-baselines` for comparison design or assessment, and the relevant
writing or review skill for manuscript-only work.
