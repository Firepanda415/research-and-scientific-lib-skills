# Plan and dispatch

Read when writing the plan, a job brief or a delegated derivation request, or handling deferred feedback and interruptions.

## The plan

The plan contains:

- the scope and the public API;
- the defaults and their basis. Where a default needs data, the MATH worker runs an authorized pilot study first and the plan records its result. When the user delegates a default to such a study, record the MATH worker's decision with its evidence and limits, subject to the user's override;
- every decision the user must take;
- the jobs, split by module so that parallel jobs own disjoint files, each with its worker session, paired independent reviewer and completion criteria. Count actual workers, within the user's maximum, and name any principal/worker overlap by the selected model;
- the critical path and which independent deliverables justify parallel work after counting coordination and integration time;
- the verification policy and the test policy;
- what each notebook will show. The notebooks themselves are written in the release step.

Make each job a complete owned outcome, with its necessary caller, test, prose and generated-output updates under the stage gates below. Sequence its stages inside the assignment. A checkpoint can unblock another owner without ending this owner's authorized work. Split a stage into another job only when a real dependency, independent review or ownership boundary requires the handoff.

Triage comes first: decide what will be built or fixed before anything is derived. The MATH worker supplies each foreseeable derivation or identifies the qualified result that covers it. A derivation gives each step and premise, covers every case the code can reach, and supplies text and code that can be copied without further derivation. For each item the plan lists every place that states it, such as docstrings, the guide, a constants registry, a mathematics document and notebook text. Missing derivations are not left to the implementer or a later stage.

An independent MATH reviewer checks new or changed derivations, and the CODE reviewer checks the engineering. Reuse a qualified verdict rather than commissioning the review again for the plan. The user approves the plan before dispatch.

When the user has already decided what is fixed, triage still chooses one alternative per finding, assigns it to a job and identifies the mathematics that needs a derivation. A large plan can split substantial independent derivations by area while the principal prepares the briefs' remaining parts. Approval follows the derivations and their complete decision list. Reconsider dispositions when the derivations expose costs, using the user's actual inputs and problem size. Correct the plan when the evidence disproves a promised outcome; present the corrected numbers for approval. Read the derivation and cost envelope rather than relying on its recommendation. A contract widening needs a sweep of unlisted cases and derivation of the contract before approval.

The CODE reviewer's engineering check names each changed representation's consumers and owners, an integration order that keeps the suite green, and ownership of tests, examples, notebook generators, probe registries and documentation constants. A new field type names the record consumers that must accept it, including journal bounds, identity encoders and archive dumps. A changed public execution contract identifies every affected backend and what it already supports.

## Test policy

Unless the project sets its own, use the smallest independent test set that protects current public, scientific, resource and compatibility obligations. Existing coverage may suffice. Kernel checks, public workflows, dependency canaries and regressions need a plausible failure they distinguish. A review request or a past incident alone does not justify another permanent test, and behavior no user can observe, such as private call order or internal structure, gets none of its own. Judge notebook and documentation tests by the executable behavior or independent evidence they protect. Pure wording changes need contextual review and the project's document checks, not tests that only pin text or show that an edit happened.

A job may still add a test that development needs, such as a reproducer or a check of an intermediate result, when the policy does not admit it permanently. The plan names one marker for such tests, a searchable comment or tag saying the test is removed before release. Each temporary test carries it, and the job's report lists it. The release step's test cleanup removes them ([release-and-wrap-up.md](release-and-wrap-up.md)).

## Briefs

The principal works within its assigned roles from the plan's scope, evidence and acceptance criteria. It performs production only for a worker role it also holds. For another session's implementation brief, use `write-implementation-job-prompts`. Supply common rules once and include only the sources and instructions this owner needs:

- the environment and the checked runner, with the interpreter and its version, the base revision and the test command;
- one verification rule, taken from the plan's verification policy;
- the review basis from step 0. The worker handles input within it, adds no guard or test for input outside it, and lists in its report any assigned item that rests on such input;
- the repository's operating, attribution and write restrictions, and the one-session-per-worker rule. The recipient performs its own assignment, with no subagents by default. Any necessary exception follows the role and delegation rules in `SKILL.md`;
- the skills the worker invokes as its first action, such as `scientific-computing-correctness`, and that it runs the completion review before each behavior-changing commit, because naming a skill as guidance has not caused agents to load it;
- the qualified derivations the CODE worker copies verbatim, including when documenting existing code. For a missing relation or unmatched premise, send its consuming path to the principal for MATH work and independent review. If mid-job messaging is unavailable, leave the question in the agreed request file and name it in the report. Continue work that does not depend on the answer;
- the plan's test policy. The witness before and after a fix is its regression evidence, and a permanent test is added only where the policy admits it; a test needed only during development carries the temporary marker. Before deleting or trimming a test, the worker checks against the mutation results that it is not the only detector of some probe;
- that the worker updates every place stating a changed claim. Reused qualified mathematical text needs a placement and context check. New reader-facing prose and its final assembly follow the writing route, without re-deriving unchanged mathematics;
- the paired independent reviewer and the purposes it covers. The same verdict and correction verification serve delivery and acceptance. Assign cross-worker interfaces and integrated workflows to named reviewers on a common revision. Compatible scientific and prose checks may share one reviewer who is competent in both and independent of the original drafting. Carry existing edit authority into the brief when local documentation corrections are allowed. A worker does not launch a duplicate reviewer.

The principal writes briefs directly from settled decisions and qualified derivations. Delegate drafting only when a substantial set of independent briefs is blocking the critical path and the expected saving exceeds the extra briefing, source loading and verification. State that reason in the existing job ledger. A settled correction or documentation batch does not need a drafter. A delegated drafter receives the named sources and copy-verbatim rule; derivation and the pre-dispatch check remain with their owners. Batch related worker questions into one request to the MATH worker.

For delegated work, also specify:

- the task, and for a documentation job its readers;
- the worktree, branch and base revision, the files the job owns, and how to touch shared files (small, local edits);
- its derivation package, copied from the plan, and every place where each of its claims appears;
- the evidence: a witness (a call and its output, or an exact argument, that shows the defect) before and after each fix, and a failure before the fix for each new test that the test policy admits;
- the checks: the test files that cover the modules it changes and the related mutation probes (registered deliberate defects that some test must catch), the probe inventory test when the job moves or renames lines in a module with registered probes, and no full suite. The principal runs the full suite that an entry-point change needs;
- the completion criteria and the report format;
- a stop condition that names the completed scoped outcome or a real dependency, required independent review, changed premise, unresolved scope/authority or resource limit. Report a blocker when found and continue the authorized work that does not cross that boundary.

Time estimates use measured durations for comparable jobs, including briefing, review, integration and correction work. Record measured duration and available usage in their existing home. At job boundaries inspect accumulated coordination and available usage, especially when the user raises cost. Use existing records. Distinguish elapsed time, cumulative model usage and concurrent capacity. Report the measurement window and classification basis, label mixed-role sessions as mixed, and separate cached input from new input. Token counts do not establish subscription usage, price or savings from a workflow change.

Every report gives dispositions, evidence paths and unresolved obligations with their owners. Cite the diff for changed text and quote a sentence only when its wording matters to a finding. A fix brief records the principal's decision on each finding, and its report gives one disposition per finding: fixed, fixed differently with a reason, or not a defect with counterevidence. Reuse common rules and current evidence owners rather than copying the project's history into each brief or report.

For a continuation by the same owner, update the existing request or job entry with the changed instruction, endpoint, checks and open obligation, and tell the owner. Reuse still-current guidance and evidence. A routine local correction needs no new standalone brief and full hand-in. Reassess actual returns, waiting, repeated reading and integration even when the work keeps the same job name. Consolidate the remaining authorized work before creating another return cycle.

A brief that holds a large item beside a contract migration names their order and the checkpoint needed by other owners. Keep later work with this owner unless an independent deliverable justifies another job. A reader interface frozen ahead of a storage change settles the payload lifetime in the same job. For a critical item, ask for an early lifecycle sketch. On a design gap, stop the dependent work and report it at once. A follow-up's file list comes from the original ownership and carve-outs, not only the report's leftovers. When a finding duplicates an item a running job owns, send it as an addendum: one integration, one suite.

Every implemented formula carries its derivation steps, assumptions, error bound and source in the docstring or comment at its definition, copied from the qualified derivation so the reviewer can check the implemented relation in place.

New mathematics found while designing jobs is qualified before dispatch and added to the plan, however small it looks. Every request to another session states its audience, scope and stopping point.

## Scheduling and assignment

- Schedule by inputs, not by job order. Start an independent deliverable when its code and derivations exist. Split a blocked job only when the remaining work justifies another agent's setup, review and integration; otherwise the owner continues its unblocked work. Batch small corrections by owner and shared context.
- Assign a coherent job to the worker of the competency its correctness rests on, with qualified derivations and independent review. Split work across competencies only when the deliverables and ownership justify it. Use the host mechanism agreed at step 0 and carry its review assignments across hosts, rather than adding review sessions because the worker ran elsewhere.
- At each dispatch, verify the selected role model and reasoning level. If access is unavailable, report it and continue independent work within the existing assignments. Do not silently substitute the principal or another model.
- Development jobs run in parallel only when their files are disjoint. A feature whose blocks share files is one job, ordered inside its brief. In a fix round, substantial independent jobs may own named disjoint regions of a file, with the principal resolving conflicts. Batch small text changes by owner instead of making each correction a parallel job.
- Start the parallel work selected in the plan when its inputs are ready. A maximum worker count is a ceiling, not a target. When the principal holds a matching worker role, leave it time for a coherent batch and incoming blockers. During review, pause the corresponding workers' changes to the submitted scope, keeping the reviewed revision fixed. Unrelated authorized work may continue. Report active concurrency separately from the total role sessions.
- A low-cost read-only investigation may start while the MATH worker confirms its reference definitions. Label provisional results until the definitions are settled.
- During development, code and documentation of the same area never run in parallel, because code goes through several review rounds that each find many problems, and documentation written alongside only waits for rework. Different areas can run in parallel.
- Notebooks are written once, in the release step, on the final integrated behavior.
- A worktree is created at dispatch from the integration branch's head, never in advance; a worktree prepared earlier is only a base to re-check against the files changed since.
- Correct a shared helper before dispatching its dependent jobs. Every affected branch needs a qualified derivation, reusing the existing one where its premises hold.
- A change that moves an execution-time admission earlier, to planning, has a dispatch precondition: run the planning-only fixtures at the user's scale first, such as the largest plans and the resource notebook, and have the MATH worker cover the estimate-only case explicitly. (NWQLib 1.0: the user declined a whole delivered job for this.) A change that removes a cap or changes a default has the same precondition toward the documented or reported target scale, within approved cost, because the cap may be hiding the cost.
- "Dispatched" is written only after the launch result arrives; the running set is read from launch results, not from memory, and a message to an agent uses the id from its launch result. An agent definition written during the run becomes launchable only on a later turn, so write it before the capability test.
- Group related questions with the assigned owner. A separate specialist session is useful when independent work justifies its setup. Reuse qualified results, and return fix verification to the responsible reviewer within the session rules.

## Feedback and interruptions

- **Feedback and interruptions.** While producing a batch, limit concurrent work that needs the principal's attention. Handle immediate feedback directly. For a delayed item, leave one line in its job entry with next action, when due and report location. Prioritize a blocked dependency or invalidated premise. Before switching, note where to resume and the next step. At batch boundaries, integration and handoff, reconcile outstanding jobs with their expected reports. Clear temporary entries once resolved or resumed and keep the disposition with the job. AI agents read internal job records, handoffs and these temporary notes directly. Use brief facts, actions and paths. Load `research-writing-style` for these records only at the user’s explicit request.

## Documentation jobs

After the area's code review converges, assemble its documentation from qualified statements and the implemented behavior, involving the MATH worker only for missing claims, changed premises or unresolved mismatches. The documentation package identifies the current source for each claim rather than repeating the derivation campaign. Assign reader-facing prose by the strengths of the models.

Name one writer, a scientific review owner and one independent prose-review owner for a substantial documentation batch. Compatible roles may share a reviewer; the prose reviewer must be independent of the original drafting and able to apply the writing workflow. This does not require a separate session for each role. The writer applies its local checks, the scientific reviewer settles the claims, and prose review handles remaining comprehension problems while preserving those claims.

Within authorized documentation work, the principal or current owner closes a local defect whose meaning is established by qualified science and the consuming code. This includes a condition, domain, unit, bound, stale source reference or comprehension defect. Runtime-message edits stay with the assigned CODE owner, including a principal only when it holds that role. Trace actual consumers for computation, control flow, contract, saved-identity and format effects. A qualified message correction with none of these effects stays in the current job. Identity or format changes belong in the CODE owner's delta for its paired reviewer. A literal that controls computation or changes a contract follows the substantive route. Comparing syntax with text masked can isolate other changes, but cannot establish that the text has no effects. Apply the message checks in [graded integration](integration-and-review.md#graded-integration-checks). Preserve the reviewed snapshot, record the delta, apply the writing route and reread the changed passages in context. Code defects, missing mathematical evidence, new derivations and material capability changes use their substantive routes. Explicitly read-only reviews remain read-only.

The session executing an integrated artifact closes qualified output-dependent prose on that revision within its edit authority. If another owner must edit it, send the values through the existing job dependency and tell that owner, without creating a separate job for each number.

Batch findings that need another owner. The responsible reviewer's local correction and contextual reread close the item without another writer, verifier, counselor pass or acceptance round. A substantial new argument follows the required independent scientific and prose review, using the existing reviewers where possible. At final assembly, review cross-section consistency and the public workflow, reusing local evidence that still holds. Keep settled scientific claims intact. Stop when the defects that call for a change and the required checks are resolved.

## Delegating a derivation

- A worker's request file gives the relation, where it is used, what is known and what the worker suspects.
- The principal's request gives the context, the exact relation in the code, what is measured, what is needed, the limits on computation and on the repository, and the answer file to write. It covers the whole claim in every case the code reaches, not only the part in question, and for each problem found asks for the complete derivation of the correct statement. Give the MATH worker a pinned snapshot worktree on its own branch with the checked runner so that the revision stays fixed.

## Hand-in

When a job contains mathematics, its assigned independent scientific review checks the affected branches and statements against the derivation's premises and actual consumers. A completed qualified verdict serves hand-in and acceptance. Send missing coverage to that owner rather than repeating the whole review.
