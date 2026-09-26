---
name: scientific-computing-correctness
description: "Implement, debug, optimize or independently validate scientific computations and executable research results while preserving mathematical meaning, numerical accuracy and resource bounds. Use for scientific IV&V of a specified computation or result. Library reviews, including review-and-fix requests, and scientific-change acceptance use scientific-library-review. Other code reviews use deep-code-review. Exclude manuscript-only review and ordinary application code."
---

# Scientific Computing Correctness

## First principle

Start from the intended scientific contract and realistic use of the relevant public entry, including representative valid inputs and options. Trace the affected quantity through the actual call chain to the results, decisions, reports, and costs its consumers receive. Locate the first divergence and correct its owner before stacking patches around symptoms. Preserve scientific invariants when optimizing or simplifying.

Connect worker-local checks to that user-facing relation, base completion on integrated behavior with independent scientific evidence, and revise obsolete or unjustified tests to match the established contract. Use existing evidence, source reasoning, and the smallest discriminating check needed, without rerunning every end-to-end workload.

Discarding information does not by itself justify a stronger claim or greater certainty. Improvements from denoising, estimation, or aggregation need their own mathematical or empirical justification.

No document establishes mathematical or numerical truth by assertion, and neither does a derivation supplied by another agent or model. Check the steps that later work depends on with a small independent numerical or symbolic calculation. When a plan, policy, framework, constants registry, review report, or earlier AI-authored summary could change the scientific decision, or when the project designates an implementation of record or frozen evidence, read [project records](references/project-records.md).

For implementation, optimization, refactoring, or proposed structural changes, load and apply [Ponytail](../ponytail/SKILL.md) unless it is off. Choose the simplest design that meets the scientific and resource contract established here. Pure verification without code-design decisions does not need it.

End implementation or validation work with the [review before completion](#review-before-completion).

## Scientific contract

State the dimensions relevant to the task explicitly before implementation:

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

For paper-derived implementations, replications, proof-assistant formalizations, or equation/representation changes, read [source-to-code fidelity](references/source-fidelity.md) before accepting the transformation.

## Approximation and decision safety

- An exact path must not silently discard, threshold, round, clip, or substitute
  nonzero information, including inside a dependency call such as a synthesis
  routine with an internal fidelity target. Before documenting such a
  construction as exact, measure the error of what it actually builds on small
  instances.
- Derive acceptance thresholds from the intended quantity, method, or error
  budget. Do not fit or widen them after observing failures merely to pass a
  gate. Dependence on scale, dimension, or conditioning needs a derivation or
  justified error model, and multiplying machine epsilon by a convenient size
  is not a justification. Legitimate calibration and fitted scientific models
  remain valid methods when their role and validation are explicit. They do
  not become certified bounds by fitting the examples used to accept them.
- Identify approximations that can materially affect the requested result. For
  an error-controlled claim, propagate defensible error or uncertainty through
  the affected consumers. Recording unused removed mass is not propagation.
- A certified ranking, stopping rule, selection, or pass/fail decision requires
  its advertised guarantee. For a deterministic bound this may require every
  admissible value to give the same decision. For a statistical guarantee use
  the stated model, confidence level, and any adaptive-selection correction.
- Exploratory computations may use empirical convergence checks or heuristics
  without a formal bound, stating their basis and limitations and
  distinguishing operational termination from established convergence. Do not add certificate
  machinery or reject usable experimental output merely because no proof exists.
- Coefficient size alone does not determine relevance to a state, observable,
  cancellation, or later decision. Use the bound in the consumer's frame.
- Keep an internal numerical guard, such as a condition-number gate, only while
  it matches a failure mechanism of the current formulation. A documented
  rejection that users rely on is a public contract and changes only as one.
  After a reformulation, reproduce the mechanism a guard targets before keeping,
  tuning or trusting it, and locate the actual source of any remaining error, because a
  gate kept from an earlier formulation can reject valid inputs while missing
  the real error.
- Combining exact and sampled contributions needs a valid uncertainty model
  for any certified result. Preserve the raw estimate and provenance when a
  variance-like estimate is negative. Clipping it to zero does not establish
  zero uncertainty or certified success.
- If evidence cannot support the advertised guarantee, leave that guarantee
  unresolved or narrow the claim. Reject an input or value at the first owner
  that knows the violated method premise or quantity definition. A value
  outside the quantity's defined domain is invalid, not unknown or
  inconclusive. A signed estimator's raw value can legitimately fall outside
  that domain. Assess evidence sufficiency only for admissible values. A roundoff-to-zero
  adjustment covers roundoff only, not sampling or model inconsistency, needs a
  stated scale-aware tolerance, and keeps the raw value. Never convert unknown, `not_run`, `not_evaluated`,
  `not_applicable`, or suppressed evidence into zero, false, or passed.

## Ownership and cross-layer consistency

- Give each scientific fact, status vocabulary, and lifecycle transition one
  semantic owner. Trace every producer, transform, caller, sibling path, and
  consumer before changing a shared owner, including extension implementations
  written against a documented protocol. Targeted tests can miss those
  implementations, so a change to an entry point that they all pass through
  runs the project's standard full test suite before integration.
- Document each formula or numerical rule that the work adds or changes at its
  definition, in the docstring or a comment above the line, with the derivation
  steps a reader needs, its assumptions, its error bound when it has one, and
  its source with a stable identifier. Copy a derivation made elsewhere, such
  as in a report or another agent's answer, into the code or existing algorithm
  documentation, because such records may not last. Owners sharing a
  derivation name each other, and a test asserting a derived bound names the
  owner that derives it. When documenting existing code, derive each step,
  and report one that contradicts the derivation as a finding rather than
  inventing a reason for it.
- Treat code, equations, documentation, structured results, human reports, and
  generated artifacts as representations of the same scoped claim. A contract
  change migrates all of them together.

When a change touches a public record or its fields, a relation between counts
or populations, interacting options, a reuse key, cache or dependency
qualification, or metadata that describes a build, read
[cross-layer consistency](references/cross-layer-consistency.md).

For dependency exceptions, numerical failures or proposed recovery, read [dependency recovery](references/dependency-recovery.md). Recover only by an applicable scientific method, and otherwise preserve and propagate the cause.

## Resource proportionality

When a change affects resource use, material cost growth, memory exhaustion,
worsening scaling, and inaccurate resource claims are acceptance concerns,
ranked by the user's priorities and measured impact alongside scientific
defects rather than deferred as cleanup. A justified
accuracy or capability gain may require more resources, and the report states
that tradeoff. Keep expensive checks, dense reference constructions, repeated
scans, copies, and diagnostic serialization out of hot loops unless the
algorithm requires them. Reducing cost must preserve the scientific quantity,
error control, and required evidence. Small coefficients or large raw outputs
alone do not justify deletion.

Extra expensive or poorly scaling computation beyond the authorized algorithm
or workload to validate, diagnose, or correct results requires explicit human
approval before execution or inclusion in the default runtime path. This covers
extra simulation, full-state operator applications, dense reference solves, and
growing evidence capture. Existing explicit approval at the same scope and
ordinary cheap checks need no new gate, and a coordinator cannot provide
missing human approval. [Resource accounting](references/resource-accounting.md)
covers the resource envelope, stored evidence, declared limits and resource
claims, and how to count extra work and phrase the request.

## Verification

- For a scientific IV&V request about a specified computation or result,
  independently assess its mathematical premises and expected behavior, not
  just agreement with the implementation or its tests. Trace representative
  public workflows through actual execution, raw evidence and material resource
  behavior.
- Before implementing a behavior or accepting an existing implementation, state
  the property a test must check and the independent source of the expected
  result. At the same time, define the falsifier by asking what ordinary,
  adversarial, boundary, mixed-interaction, or cross-layer case could make
  every local check pass while the scientific conclusion is wrong.
- Use an independent oracle with a different failure mode, such as a
  specification, a first-principles derivation, a reference implementation, or
  a known-good case. Two consumers of the same builder prove consistency,
  not correctness. When a change alters an assertion or expected value, name
  the independent relation that justifies the new expectation.
- Keep acceptance oracles in development verification unless their production
  role is explicitly justified and authorized. An agreement test does not
  authorize full reference recomputation or exact-decision equality in a hot
  loop. Fix the numerical owner and reuse existing results before proposing
  additional work. Do not satisfy an accuracy failure merely by installing a
  veto and changing the test to expect termination.
- Leave the smallest test set that protects a current scientific, resource,
  provenance, lifecycle, public-input, or serialization obligation. Temporary
  migration and implementation-shape checks do not become permanent tests. Each
  added or changed test observes the promised property and can fail for a
  plausible defect in it, and a fix's regression test fails on the pre-change
  code. When adding or changing tests or numeric assertions, or when a result
  varies across platforms, read [test evidence](references/test-evidence.md).
- Before classifying a failure or reporting a measured result, confirm the
  interpreter, dependency versions and import origin the project declares (or
  those actually used when none is declared), and state them with the result.
  Report separately executed test runs separately, with the revision each ran
  on, rather than as one combined total.
- A green build, regenerated notebook, mutation kill, or full test suite proves
  only the invariants that its checks can falsify. Use an additional independent
  pass when unresolved scientific risk warrants it, and do not rerun settled
  checks or large experiments without a new evidential need.

When work is intended to close earlier scientific-review findings, read and
apply [remediation closure](references/remediation-closure.md) before editing.
Ordinary scientific-computing tasks do not need it.

## Review before completion

Before reporting implementation or validation work, check the final diff and
draft report against these items, and against the review of any other applied
skill such as Ponytail, in one pass separate from writing them. The pass
repeats no verification the work already did and adds no runs beyond the
checks the task requires. Fix what fails within scope and recheck only what
changed.

- Each claim in the report or documentation, such as fixed, verified, exact,
  unchanged, absent or unknown, rests on evidence that applies to the final
  revision, new or reused, and was checked in the context the claim names.
  Otherwise the claim is removed or marked unverified.
- Each new or changed formula or numerical rule is documented at its
  definition, with its derivation, assumptions and source, and its error bound
  when it has one.
- Each new or changed test names its independent expected relation, and a
  fix's regression check failed on the pre-change code.
- No tolerance, threshold or cap was widened after a failure without a
  derivation, and no unknown, not-run or suppressed evidence became zero,
  false or passed.
- An entry point that extension implementations pass through was checked
  against them, and the full test suite ran before integration or is named as
  outstanding for whoever integrates.
- The default runtime path gained no extra expensive computation without
  approval, and resource comparisons use matched workloads.
- Each measured value or test result names the environment and revision that
  produced it, and each status label comes with the quantities that decide it.

## Completion

Report the invariant preserved, the first divergence fixed, the independent
evidence used, and anything still approximate, unvalidated, unresolved, or out
of scope, without claiming formal proof, universal scalability, or end-to-end
error control that was not established. Show a status label such as PASS,
FAIL, or INCONCLUSIVE next to the quantities, diagnostics, and bounds that
decide it, each with its scope, and mark which values the implementation under
test produced and which came from independent checks.

For unexpected results or slow experiment cycles, read
[scientific diagnostics](references/scientific-diagnostics.md). Use
`stress-test-baselines` for comparison design or assessment, and the relevant
writing or review skill for manuscript-only work.
