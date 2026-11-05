---
name: scientific-computing-correctness
description: "Implement, debug, optimize or independently validate scientific computations and executable research results while preserving mathematical meaning, numerical accuracy and resource bounds. Use for scientific IV&V (independent verification and validation) of a specified computation or result. Library reviews, including review-and-fix requests, and scientific-change acceptance use scientific-library-review. Other code reviews use deep-code-review. Exclude manuscript-only review and ordinary application code."
---

# Scientific Computing Correctness

## First principle

Start from the intended scientific contract and the problems its users pose through the relevant public entry, including representative valid inputs and options. Trace the affected quantity through the actual call chain to the results, decisions, reports, and costs its consumers receive. Locate the first divergence and correct its owner before stacking patches around symptoms. Preserve scientific invariants when optimizing or simplifying.

Base completion on integrated behavior with independent scientific evidence, and revise obsolete or unjustified tests to match the established contract. Use existing evidence and the smallest discriminating check, without rerunning every end-to-end workload.

Discarding information does not justify a stronger claim. Improvements from denoising, estimation or aggregation need their own mathematical or empirical justification.

No document establishes mathematical or numerical truth by assertion, nor does a derivation supplied by another agent or model. Check the steps that later work depends on with a small independent numerical or symbolic calculation. When a plan, policy, framework, constants registry, review report, or earlier AI-authored summary could change the scientific decision, or when the project designates an implementation of record or frozen evidence, read [project records](references/project-records.md).

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
  without error control. Execution success does not show validation, convergence
  or controlled error. An estimate or decision without a justified bound remains
  empirically assessed or unvalidated, not certified, and may still drive an
  operational decision.
- the canonical owner, downstream decision, allowed uncertainty, and evidence
  artifact.
- the legal states and relations between fields, including combinations of
  independent options or evidence sources.

Do not promote an observed floating-point pattern, sampled maximum, measured
diagnostic, or passing regression into an exact theorem or certified bound.

When full assessment is impractical, compute reliable, decision-relevant components, combine cheap qualified relations, and expose dependencies and gaps. Partial evidence is not a total guarantee. Added assessment needs a decision benefit within authorized cost. A sufficient condition alone cannot widen the accuracy contract or add a new default veto.

For paper-derived implementations, replications, proof-assistant formalizations, or equation/representation changes, read [source-to-code fidelity](references/source-fidelity.md) before accepting the transformation.

## Approximation and decision safety

- An exact path must not silently discard, threshold, round, clip, or substitute
  nonzero information, including inside a dependency call such as a synthesis
  routine with an internal fidelity target. Before documenting such a
  construction as exact, measure the error of what it actually builds on small
  instances.
- Derive acceptance thresholds from the quantity, method or error budget,
  with a justified model for scale, dimension and conditioning. A forecast and
  the stage it predicts share one error allocation. Explicitly validated
  calibration and fitted models remain legitimate, but fitting acceptance examples does not
  certify a bound. For floating-point boundaries, inverse/forward checks, or
  choices among reformulation, scaling and enclosing arithmetic, read
  [floating-point decisions](references/floating-point-decisions.md).
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
- Carry a fact proved about the input through transforms that preserve it, rather
  than re-detecting it by exact comparison of computed values.
- When keeping or changing an internal numerical guard, read [repair the mechanism](references/floating-point-decisions.md#repair-the-mechanism) and establish its basis in the current formulation.
- Combining exact and sampled contributions needs a valid uncertainty model
  for a certified result. Keep a negative variance-like estimate and its
  provenance, because clipping it to zero establishes neither zero uncertainty
  nor success.
- If evidence cannot support the advertised guarantee, leave that guarantee
  unresolved or narrow the claim. Reject an input or value at the first owner
  that knows the violated method premise or quantity definition. A value
  outside the quantity's defined domain is invalid, not unknown or
  inconclusive. A signed estimator's raw value can legitimately fall outside
  that domain. Assess evidence sufficiency only for admissible values. A roundoff-to-zero
  adjustment covers roundoff only, not sampling or model inconsistency, needs a
  stated scale-aware tolerance, and keeps the raw value.

## Ownership and cross-layer consistency

- Give each scientific fact, status vocabulary, and lifecycle transition one
  semantic owner. Trace every producer, transform, caller, sibling path, and
  consumer before changing a shared owner, including extension implementations
  written against a documented protocol, which targeted tests can miss.
- Before adding, changing or documenting a formula, read [formula documentation](references/project-records.md#documenting-formulas). Keep its derivation, assumptions, error bound and stable source at the definition or linked algorithm documentation.
- Code, equations, documentation, structured results, reports and generated
  artifacts represent the same claim, so a contract change migrates them together.

When a change touches a public record or its fields, a relation between counts
or populations, interacting options, a reuse key, cache or dependency
qualification, or metadata describing a build, read
[cross-layer consistency](references/cross-layer-consistency.md).

For dependency exceptions, numerical failures or proposed recovery, read [dependency recovery](references/dependency-recovery.md). Recover only by an applicable scientific method, and otherwise preserve and propagate the cause.

## Resource proportionality

When a change affects resource use, material cost growth, memory exhaustion,
worsening scaling, and inaccurate resource claims are acceptance concerns,
ranked by measured impact alongside scientific defects. A justified
accuracy or capability gain may require more resources, and the report states
that tradeoff. Keep expensive checks, dense reference constructions, repeated
scans, copies, and diagnostic serialization out of hot loops unless the
algorithm requires them. Reducing cost must preserve the scientific quantity,
error control, and required evidence. Small coefficients or large raw outputs
alone do not justify deletion.

Before changing resource controls, distinguish capacity-only limits from explicit resource-aware policies. Capacity-only failures must not become inapplicability or silently alter scientific choices. Establish scientific equivalence for identical inputs under varied sufficient capacities.

Extra expensive or poorly scaling computation beyond the authorized algorithm
or workload to validate, diagnose, or correct results requires explicit human
approval before execution or inclusion in the default runtime path. This covers
extra simulation, full-state applications, dense conditioning/reference solves, and
growing evidence capture. Approval at the same scope and ordinary cheap checks
need no new gate, and a coordinator cannot provide missing human approval. Read
[resource accounting](references/resource-accounting.md) before setting a
declared limit, an admission law or a resource claim, or asking for approval.
Removing a cap or changing a default extends what users reach, so walk the route
toward the documented or reported target scale as it describes.

## Verification

- For scientific IV&V of a specified computation or result, independently assess its mathematical
  premises and expected behavior, not just agreement with the implementation
  or its tests.
- Before implementing a behavior or accepting an existing implementation, state
  the property a test must check and the independent source of the expected
  result. At the same time, define the falsifier by asking what ordinary,
  adversarial, boundary, mixed-interaction, or cross-layer case among the
  problems users pose could make every local check pass while the scientific conclusion is wrong.
- Use an independent oracle with a different failure mode, such as a
  specification, a first-principles derivation, a reference implementation, or
  a known-good case. Two consumers of the same builder prove consistency,
  not correctness.
- Keep acceptance oracles in development verification unless their production
  role is explicitly justified and authorized. An agreement test does not
  authorize full reference recomputation or exact-decision equality in a hot
  loop. Fix the numerical owner and reuse existing results before proposing
  more work. Do not satisfy an accuracy failure merely by installing a
  veto and changing the test to expect termination.
- Leave the smallest test set that protects a current scientific, resource,
  provenance, lifecycle, public-input, or serialization obligation.
  When adding or changing tests or numeric assertions, or when a result varies
  across platforms, read [test evidence](references/test-evidence.md).
- Before classifying a failure or reporting a measured result, confirm the
  interpreter, dependency versions and import origin the project declares (or
  those actually used when none is declared).
- A green build, regenerated notebook, mutation kill, or full test suite proves
  only the invariants its checks can falsify. Add an independent pass when
  scientific risk warrants it, and rerun settled checks only for new evidence.

When work aims to close earlier scientific-review findings, read and
apply [remediation closure](references/remediation-closure.md) before editing.

## Review before completion

Before committing a behavior change or reporting implementation or validation
work, check the diff and draft report against these items, and against the review
of any other applied skill such as Ponytail, in one pass separate from writing
them. The pass repeats no verification the work already did and adds no runs
beyond the checks the task requires. Fix what fails within scope and recheck
only what changed.

- Each claim in the report or documentation, such as fixed, verified, exact,
  unchanged, absent or unknown, rests on evidence that applies to the final
  revision, new or reused, and was checked in the context the claim names.
  Otherwise the claim is removed or marked unverified.
- Each new or changed formula or numerical rule is documented as the ownership
  section requires.
- Each new or changed test or expected value names its independent relation, and
  a fix's regression check failed on the pre-change code.
- No tolerance, threshold or cap was widened after a failure without a
  derivation, and no unknown, not-run, not-evaluated, not-applicable or suppressed
  evidence became zero, false or passed.
- Each refusal, tolerance or cap added or newly reached has one of these causes:
  a premise the input really violates, a declared or physical limit, the requested
  accuracy or error allocation, the precision the result needs, or a documented
  contract. Following its stated remedy leads past it, shown by derivation when
  running is costly.
- The report of a removed cap or changed default gives the largest size reached
  along its users' growth axes and what stopped it.
- A known-size check runs before the work it guards. A count charged against a
  hard limit is an upper bound. Another admission estimate stays within the factor
  the project accepts, and a bound far above what posed inputs reach does not refuse
  unless the user declared the limit hard. A label such as exact or upper bound
  matches the emitted artifact.
- A removed or changed option, default, constant, formula or count was searched
  by its old name, old value and the words describing it through docstrings, guides,
  examples, generated sources, project registries, test names and release notes.
- An entry point that extension implementations pass through was checked
  against them, and the full test suite ran before integration or is named as
  outstanding for whoever integrates.
- The default runtime path gained no extra expensive computation without
  approval, and resource comparisons use matched workloads.
  Capacity-only limits preserve scientific choices. Partial evidence keeps its scope.
- Each measured value or test result names the command, interpreter, dependency
  versions, import origin where it matters, and revision that produced it.
  Separately executed runs are reported separately rather than as one total.

## Completion

Report the invariant preserved, the first divergence fixed, the independent
evidence used, and anything still approximate, unvalidated, unresolved, or out
of scope, without claiming formal proof, universal scalability, or end-to-end
error control that was not established. Show a status label such as PASS,
FAIL, or INCONCLUSIVE next to the quantities, diagnostics, and bounds that
decide it, each with its scope, and mark which values the implementation under
test produced and which came from independent checks.

For unexpected results, long computations or slow experiment cycles, read
[scientific diagnostics](references/scientific-diagnostics.md). Use
`stress-test-baselines` for comparison design or assessment.
