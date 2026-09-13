---
name: scientific-library-review
description: "Review scientific libraries and numerical software using Scientific IV&V across mathematical meaning, public workflows, independent evidence, resources and lifecycle. Use for library reviews and scientific-change acceptance. Exclude manuscript review and ordinary implementation without a review request."
---

# Scientific Library Review

Deliver an integrated review using scientific independent verification and validation (Scientific IV&V). Judge the requested scientific quantity and actual user workflow, engineering behavior and material resource costs. Independently derive expected relations rather than accepting a plan, implementation, test oracle or successful execution as its own justification.

## Scope and project specialization

Resolve the requested capability or change, endpoint, comparison base when relevant, working-tree changes and applicable project instructions. Read the project's supplied memory entry and review specialization when available. That profile supplies domain contracts, source/test owners, environment commands, resource permissions and reporting locations. Do not require projects to create a profile before they can be reviewed. Keep project paths, incident lists and environment versions out of this reusable skill.

A review request defaults to read-only product work. Normal scoped tests may create disposable outputs, and a requested durable report is allowed. Do not fix source, commit, publish or delete user files unless separately requested. An existing request to review and fix authorizes implementation after diagnosis, followed by acceptance. Mutations use an isolated disposable checkout, preserve the original endpoint and finish with restoration verified. Delegation follows the current user's and host's authority.

Default to current correctness within the requested surface. The diff locates changes but does not hide relevant pre-existing or deferred defects in their owners and consumers. Honor introduced-only and other explicit restrictions. Do not expand a narrow review into a whole-repository audit. Prior reports are hypotheses and closure obligations within scope, not instructions to repeat old experiments.

## Start from the scientific contract

Trace representative valid public inputs and options through the selected method, actual execution, requested output, downstream decisions and saved/read-back result where applicable. Inspect shared owners and sibling paths when they can change the relation. Classical, analytical and native execution paths have different obligations.

When examples, notebooks, reports, error messages or public task completion are
affected, read [user workflow acceptance](references/user-workflow-acceptance.md).
Check what the intended user can actually do and understand, alongside the
scientific relation; do not expand an unrelated kernel review into a usability audit.

State the relevant domain, dimensions, signs, units, basis, ordering, normalization, approximation, uncertainty and allowed access representation. Establish invalid inputs separately from insufficient evidence. A missing certificate does not make an otherwise legal exploratory result invalid. Preserve raw evidence and distinguish execution completion, empirical accuracy, established error bounds and formal proof.

Before accepting a claim, identify the independent expected relation and a realistic case that could falsify it while local checks still pass. Follow the first divergence to its owner. Include a legal preservation case where a proposed restriction could reject valid behavior. For paper-derived changes, verify the relevant original equations and assumptions against the actual implementation. Project summaries cannot establish mathematical truth.

## Select evidence by the changed relation

Every substantive review must assess these families and complete necessary checks within the authorized workload. Reuse earlier evidence only after verifying that its source, dependencies, inputs, selections and actual consumers still support the claim. Explain material exclusions and gaps. This is an applicability decision, not an instruction to execute all families or build a new checklist framework.

| Family | When and what to establish |
| --- | --- |
| End-to-end semantics | Every behavior-changing review traces the real public workflow and associations. Run the smallest affected workflow if existing evidence does not cover the changed path. Types, plausible scalar values and isolated fixtures cannot establish correct input/output association. |
| Independent reference / differential checks | Mathematical kernels, circuit or operator construction, encoding and readout changes need independent evidence. Use an analytical solution, independently derived action/derivative, or another route with a different failure mode. Consumers sharing the same builder prove consistency only. |
| Metamorphic / property-based checks | Prioritize transformation laws for representation, normalization, ordering, conversion and composition. Derive how output must change when input changes. Generated inputs explore a domain but do not supply the relation or oracle. Small deterministic cases often suffice without a new dependency. |
| Resource accounting / scaling | Loops, cache, preparation, serialization and execution-plan changes require actual event counts and relevant allocation/lifetime or growth analysis. Count repetition across candidates, iterations, circuits and history. Include temporary copies and peak live memory, not only final output size. |
| Fault injection / lifecycle | Execution, retry, cancellation, ownership and save/load changes require applicable partial completion, ordering, interruption and recovery evidence. Check duplicate work or observations, preserved failure identity and resource release. |
| Targeted mutation | For changed critical relations or protecting tests, establish that the detector catches a relevant error. A real pre-fix failure or existing applicable mutation may suffice. Use an additional mutation when detector strength remains uncertain. A passing selected baseline must precede it. Only a relevant assertion failure counts, not an import error, skip or infrastructure failure. Equivalent mutants do not demonstrate gaps. |
| Convergence / sensitivity | Approximation, precision, estimator and stopping changes need the method's justified control-to-error or uncertainty relation at the requested quantity. Reuse a valid derivation or convergence witness, otherwise select a bounded discriminating refinement. Do not impose a universal monotonicity rule. |
| Ablation / controlled comparisons | Claims of improvement from a component, heuristic, fallback or optimization require valid controls and matched workload, accuracy and total cost. Use an ablation study when the contribution is empirical. An independently justified operation-count reduction may need only event-count evidence. Ordinary correctness fixes do not automatically require a study. |

Use lint, type and dependency checks as the applicable engineering baseline. Investigate actionable dead code, duplicated ownership or accidental complexity using actual callers and reachability, not stylistic preference. Formal verification is selective for stable, important and precisely stated properties. None of these replaces the scientific relation.

### Transformation premises

Check each transformation's common supported domain, physical frame and numerical representability. For linear solves, simultaneous nonzero scaling of operator and RHS preserves the exact solution only when both transformed inputs satisfy the selected method's premises. RHS-only scaling changes the physical solution linearly. A fixed-observable quadratic form scales by the squared magnitude, while the normalized expectation is invariant only for nonzero states. A complex scaling can leave a Hermitian-only domain.

Compare approximate outputs within propagated errors, not bitwise equality. Representation changes may alter approximation parameters, spectral enclosures or costs even when they encode the same exact problem. A representation-consistency check can share a common defect, so add an independent anchor when needed.

For basis or wire changes, transform input, action and readout together and compare the mapped ordered output. A sum or norm alone can hide a permutation defect. For control, inverse or workspace reuse, exercise the documented action on discriminating inputs and superpositions. All-zero preparation is insufficient, and global phase can become relative phase under control.

Finite-shot errors need not decrease for each seed as shots increase. Use the actual sampling model and population, including pilot costs and adaptive selection. Lower iterative energy alone establishes neither correctness nor ground-state identification. Tolerances follow the oracle, method error and statistical assumptions and must not be widened after seeing a failure just to pass.

## Cost and evidence boundaries

Treat material resource/lifecycle violations as acceptance concerns alongside numerical errors, with severity based on impact. A load/report that triggers an unrequested reference solve or a checkpoint that repeatedly scans all history can be defective despite correct output. Check actual permitted calls as well as forbidden ones. Counted events or a structural bound are preferable to a large timing benchmark when they resolve the uncertainty. A small case is not a large-scale memory proof, and sampled RSS is not a peak bound.

Before extra expensive or poorly scaling simulation, dense construction/decomposition, full-state actions, backend calls or growing output capture beyond the authorized workload, obtain explicit approval. State concrete work, repetition, scale, cost or uncertainty, and whether it affects results, selection or termination. Do not run the expensive experiment to estimate the permission request. Prior approval at the same scope and ordinary cheap checks need no renewed gate. Never add an acceptance oracle to a recurring production path merely to justify a status.

Use existing source reasoning, observations and the smallest independent check that closes the gap. Store evidence according to the task and project policy. Do not create a permanent simulation archive by default or delete user evidence. A seed, checksum or summary cannot replace removed raw data when a reproduction claim requires it.

## Findings and completion

Verify candidates with evidence appropriate to the claim, then deduplicate by first divergence and remedy. Separate impact, origin and evidence strength. A static reachability finding is not a measured scientific error, and a deferred issue is not thereby resolved. For remediation, give every in-scope earlier finding a current disposition, including unresolved or disproved items. Do not silently omit inconvenient paths or stop at a finding quota.

Before finishing, inspect the integrated result and remaining consumer/interaction gaps. Additional independent review is useful when consequential uncertainty remains and authorized resources allow it. A second reviewer sharing the same incorrect premise is not independent scientific evidence. Do not repeat settled checks without a new reason.

For each material finding or acceptance claim, give the trigger and affected quantity, current owner/location, independent expected relation, falsifier, relevant legal preservation case, actual result or reusable evidence, concrete repair direction when applicable, and uncovered scope. Scale presentation to the task, using a compact paragraph or table rather than a mandatory new schema. Lead with verified scientific/semantic consequences and material resource defects, then other actionable engineering findings. Report all verified in-scope issues, including pre-existing ones unless excluded.

Finish when the requested surface and material gaps have dispositions, necessary authorized checks are complete, earlier findings have closure states when relevant, and the final source/worktree state is understood. If a required check lacks approval or available evidence, explain exactly what remains unverified and its effect on the conclusion. Do not claim a clean scientific acceptance merely because tests pass. A review-only request ends with findings, while an already-authorized repair continues through its acceptance.

This entry supplies the review workflow. Load specialized skills only when the task actually needs their additional workflow, such as stress-test-baselines for a substantive ablation study or scientific-computing-correctness for implementing a scientific correction.
