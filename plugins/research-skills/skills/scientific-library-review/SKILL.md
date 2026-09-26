---
name: scientific-library-review
description: "Review scientific libraries and numerical software using Scientific IV&V across mathematical meaning, public workflows, independent evidence, resources and lifecycle. Use for library reviews and scientific-change acceptance. Exclude manuscript review and ordinary implementation without a review request."
---

# Scientific Library Review

Deliver an integrated review using scientific independent verification and validation (Scientific IV&V). Judge the requested scientific quantity and actual user workflow, engineering behavior and material resource costs. Independently derive expected relations rather than accepting a plan, implementation, test oracle or successful execution as its own justification.

When the review judges a simplification or deletion proposal, API/schema retirement, replacement architecture, or remediation design, load and apply [Ponytail](../ponytail/SKILL.md) unless it is off. Use it to compare maintenance obligations and alternatives in this same review. This skill continues to own scientific meaning, evidence and resource limits.

## Scope and project specialization

Resolve the requested capability or change, endpoint, comparison base when relevant, working-tree changes and applicable project instructions. Read the project's memory entry or review specialization when the user, project instructions, host memory or a session hook already supplies one, and do not search for one otherwise. That profile supplies domain contracts, source/test owners, environment commands, resource permissions and reporting locations. Do not require projects to create a profile before they can be reviewed.

A review request defaults to read-only product work. Normal scoped tests may create disposable outputs, and a requested durable report is allowed. Do not fix source, commit, publish or delete user files unless separately requested. An existing request to review and fix authorizes implementation after diagnosis, followed by acceptance. Mutations use an isolated disposable checkout, preserve the original endpoint and finish with restoration verified. Delegation follows the current user's and host's authority.

Default to current correctness within the requested surface. The diff locates changes but does not hide relevant pre-existing or deferred defects in their owners and consumers. Honor introduced-only and other explicit restrictions. Do not expand a narrow review into a whole-repository audit. Prior reports are hypotheses and closure obligations within scope, not instructions to repeat old experiments.

## Start from the scientific contract

Trace representative valid public inputs and options through the selected method, actual execution, requested output, downstream decisions and saved/read-back result where applicable. Inspect shared owners and sibling paths when they can change the relation. When responsibility moves between owners or a shared contract changes, inventory the callers and existing tests that assert the old contract, including extension implementations written against a documented protocol. A passing new test selection does not show that existing tests still match it. Classical, analytical and native execution paths have different obligations.

When examples, notebooks, reports, error messages or public task completion are
affected, read [user workflow acceptance](references/user-workflow-acceptance.md).
Check what the intended user can actually do and understand, alongside the
scientific relation; do not expand an unrelated kernel review into a usability audit.

State the relevant domain, dimensions, signs, units, basis, ordering, normalization, approximation, uncertainty and allowed access representation. Establish invalid inputs separately from insufficient evidence. A missing certificate does not make an otherwise legal exploratory result invalid. Preserve raw evidence and distinguish execution completion, empirical accuracy, established error bounds and formal proof.

Before accepting a claim, identify the independent expected relation and a realistic case that could falsify it while local checks still pass. Follow the first divergence to its owner. Include a legal preservation case where a proposed restriction could reject valid behavior. For paper-derived changes, verify the relevant original equations and assumptions against the actual implementation. Project summaries cannot establish mathematical truth.

Choose representative cases by mechanisms that change the claim's premises or conclusion. A shared algorithm family, record type or API does not establish equivalent behavior. Before asserting that an error contribution is zero or an operation is absent, trace where it can arise throughout the relevant workflow. Exact readout, for example, does not eliminate randomness in schedule selection or later estimator updates. A claim that a resource quantity is absent or unknown holds only in the context where it was checked, such as the gate basis. Name that context, and check the context the claim is about. Use the smallest cases that distinguish those mechanisms, without requiring every option combination.

## Select evidence by the changed relation

Every substantive review must assess these families and complete necessary checks within the authorized workload. Reuse earlier evidence only after verifying that its source, dependencies, inputs, selections and actual consumers still support the claim. Explain material exclusions and gaps. This is an applicability decision, not an instruction to execute all families or build a new checklist framework.

| Family | When and what to establish |
| --- | --- |
| End-to-end semantics | Every behavior-changing review traces the real public workflow and associations. Run the smallest affected workflow if existing evidence does not cover the changed path. Types, plausible scalar values and isolated fixtures cannot establish correct input/output association. |
| Independent reference / differential checks | Mathematical kernels, circuit or operator construction, encoding and readout changes need independent evidence. Use an analytical solution, independently derived action/derivative, or another route with a different failure mode. Consumers sharing the same builder prove consistency only. |
| Metamorphic / property-based checks | Prioritize transformation laws for representation, normalization, ordering, conversion and composition. Derive how output must change when input changes. Generated inputs explore a domain but do not supply the relation or oracle. Small deterministic cases often suffice without a new dependency. |
| Resource accounting / scaling | Loops, cache, preparation, serialization and execution-plan changes require actual event counts and relevant allocation/lifetime or growth analysis. Count repetition across candidates, iterations, circuits and history, and count each independently varying population separately, including failed attempts and successful work that is never consumed. Include temporary copies and peak live memory, not only final output size. A check that enforces a declared work or memory limit refuses before a stage starts when the stage's count is known in advance, and the count formula it charges is an upper bound that traced execution over varied inputs never exceeds. |
| Fault injection / lifecycle | Execution, retry, cancellation, ownership and save/load changes require applicable partial completion, ordering, interruption and recovery evidence. Check duplicate work or observations, preserved failure identity and resource release. Check that a known-invalid input is rejected at the earliest boundary with the needed facts, before it advances accumulated estimates, counts, pending work or history. |
| Targeted mutation | For changed critical relations or protecting tests, establish that the detector catches a relevant error. A real pre-fix failure or existing applicable mutation may suffice. Use an additional mutation when detector strength remains uncertain. A passing selected baseline must precede it. Only a relevant assertion failure counts, or an import error when importability or the missing public export is the contract. A skip or infrastructure failure does not count. Equivalent mutants do not demonstrate gaps. |
| Convergence / sensitivity | Approximation, precision, estimator and stopping changes need the method's justified control-to-error or uncertainty relation at the requested quantity. Reuse a valid derivation or convergence witness, otherwise select a bounded discriminating refinement. Do not impose a universal monotonicity rule. |
| Ablation / controlled comparisons | Claims of improvement from a component, heuristic, fallback or optimization require valid controls and matched workload, accuracy and total cost. Use an ablation study when the contribution is empirical. An independently justified operation-count reduction may need only event-count evidence. Ordinary correctness fixes do not automatically require a study. |

Qualify detector evidence against the specific claim. Establish that the witness exercises the affected execution path and that the falsifier fails its relevant assertion. A failure elsewhere in the selected suite does not establish that a numerical or lifecycle witness detects the defect. A test that cannot fail for the claimed defect is not detector evidence, by the criteria in [test evidence](../scientific-computing-correctness/references/test-evidence.md). Reuse a demonstrated pre-fix failure or applicable mutation, and add instrumentation only when the exercised path remains uncertain.

Review the necessity of added and changed tests as part of ordinary review. Connect their assertions to current user obligations and the failures they distinguish from existing checks. Apply the shared [Ponytail test-necessity criteria](../ponytail/SKILL.md#test-necessity) unless Ponytail is off. Report supported opportunities to replace or consolidate tests within the requested scope. A read-only review recommends changes without applying them.

Use lint, type and dependency checks as the applicable engineering baseline. Investigate actionable dead code, duplicated ownership or accidental complexity using actual callers and reachability, not stylistic preference. Formal verification is selective for stable, important and precisely stated properties. None of these replaces the scientific relation.

For scaling, representation, basis or wire order, control, inverse or workspace reuse, finite-shot changes, or iterative-energy claims, read [transformation premises](references/transformation-premises.md).

## Cost and evidence boundaries

Treat material resource/lifecycle violations as acceptance concerns alongside numerical errors, with severity based on impact. A load/report that triggers an unrequested reference solve or a checkpoint that repeatedly scans all history can be defective despite correct output. Check actual permitted calls as well as forbidden ones. Counted events or a structural bound are preferable to a large timing benchmark when they resolve the uncertainty. A small case is not a large-scale memory proof, and sampled RSS is not a peak bound.

Before extra expensive or poorly scaling simulation, dense construction/decomposition, full-state actions, backend calls or growing output capture beyond the authorized workload, obtain explicit approval. Lead with a bold statement of the concrete added work, then give repetition, scale, cost or uncertainty, the effect on results, selection or termination, and a recommendation. Do not run the expensive experiment to estimate the permission request. Prior approval at the same scope and ordinary cheap checks need no renewed gate. Never add an acceptance oracle to a recurring production path merely to justify a status.

Use existing source reasoning, observations and the smallest independent check that closes the gap. Store evidence according to the task and project policy. Do not create a permanent simulation archive by default or delete user evidence. A seed, checksum or summary cannot replace removed raw data when a reproduction claim requires it.

Before classifying a failure or reporting a measured result, confirm the interpreter, dependency versions and import origin the project declares, or those actually used when none is declared. Report each test, suite or CI result with its invocation, revision or verified identical tree, environment, and pass, failure and skip counts. Separately executed batches are not one run, and repeated runs are not added together. A result belongs to the revision it ran on and applies elsewhere only under the evidence-reuse rule above. A successful retry does not erase the failed attempt before it.

## Findings and completion

Verify candidates with evidence appropriate to the claim, then deduplicate by first divergence and remedy. Separate impact, origin and evidence strength. A static reachability finding is not a measured scientific error, and a deferred issue is not thereby resolved. For remediation, give every in-scope earlier finding a current disposition, including unresolved or disproved items. For remediation acceptance, read [remediation closure](../scientific-computing-correctness/references/remediation-closure.md) and apply its dispositions and closure criteria. Also sweep the whole diff for evidence changes outside those findings: loosened tolerances, added skips, removed or renamed tests, weakened oracles, and new costly calls, caps or defaults. Do not silently omit inconvenient paths or stop at a finding quota.

Before finishing, inspect the integrated result and remaining consumer/interaction gaps. Additional independent review is useful when consequential uncertainty remains and authorized resources allow it. A second reviewer sharing the same incorrect premise is not independent scientific evidence. Reviews by different models can report largely different defects. Do not repeat settled checks without a new reason.

For each material finding or acceptance claim, give the trigger and affected quantity, current owner/location, independent expected relation, falsifier, relevant legal preservation case, actual result or reusable evidence, concrete repair direction when applicable, and uncovered scope. Scale presentation to the task, using a compact paragraph or table rather than a mandatory new schema. Lead with verified scientific/semantic consequences and material resource defects, then other actionable engineering findings. Report all verified in-scope issues, including pre-existing ones unless excluded. A requested durable report uses a noncolliding path and contains every accepted finding. A size-limited findings panel may mirror a subset but does not cap it.

Distinguish changed-path inventory, substantive source inspection, traced public workflows and executed validation when reporting coverage. Enumerating every file does not establish that every behavior was reviewed. Name material unreviewed surfaces and the scope of sampled checks without expanding a focused task into an exhaustive audit.

Finish when the requested surface and material gaps have dispositions, necessary authorized checks are complete, earlier findings have closure states when relevant, and the final source/worktree state is understood. If a required check lacks approval or available evidence, explain exactly what remains unverified and its effect on the conclusion. Do not claim a clean scientific acceptance merely because tests pass. A review-only request ends with findings, while an already-authorized repair continues through its acceptance.

This entry supplies the review workflow. Load specialized skills only when the task actually needs their additional workflow, such as stress-test-baselines for a substantive ablation study or scientific-computing-correctness for implementing a scientific correction.
