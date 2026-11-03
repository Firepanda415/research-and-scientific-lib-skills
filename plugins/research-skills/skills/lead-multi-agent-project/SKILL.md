---
name: lead-multi-agent-project
description: Lead a multi-agent engineering project, such as a scientific-software release, as the principal. Assign production by model, keep independent reviewers, and coordinate planning, implementation, integration, triage and release. Use when the user asks this session to run or take over such a project; one brief, one review or monitoring one job uses its own skill.
---

# Lead a multi-agent project

The principal plans, dispatches, integrates and delivers the work. Handle authorized work directly unless another agent supplies missing expertise, necessary independence or a substantial parallel deliverable. Count briefing, source loading, waiting, hand-in and integration as delegation cost. The references illustrate scientific-library releases.

Read each reference when its step applies. After compaction, reload guidance lost from the current context.

## Roles

The user selects the models for this run. For scientific software, assign CODE and MATH production and review separately.

- **User.** Approves the plan, scope and behavior changes, extra default-path costs, and each push, main-branch merge, release and archive.
- **Principal.** Owns planning, integration, checks, shared records and delivery. When its model matches the selected CODE or MATH worker model, it takes that worker's job in its own session. It alone operates another vendor's desktop app.
- **CODE worker.** Implements code, tests and associated documentation from qualified derivations.
- **MATH worker.** Derives new results, states premises and cases, and designs and runs authorized studies of defaults.
- **CODE and MATH reviewers.** Independently check engineering and public workflows, or derivations and their use in the implementation. Assign each required review to a session independent of the producer, including when the principal produced the work.
- **Counselor.** Uses a model from a different vendor than the principal. Joins when a delegated choice remains material, a disagreement needs resolution, formal-review scope is substantially new or the circuit breaker applies.

With distinct CODE and MATH worker models and both reviews required, a match gives five core sessions: principal and matching worker together, counselor, matching reviewer, other worker and other reviewer. If neither model matches, each worker has its own session, giving six. Compare the model itself, not just its vendor. Start each session when its work is needed.

Any role may delegate within user and host authority for missing expertise, necessary independence or a substantial independent deliverable worth its setup. The delegating owner collects and checks the result. Use [delegation scope](references/delegation-scope.md) when the benefit is unclear or coordination is delaying delivery.

## Step 0: settings and opening brief

At the start of each run, use the settings the user gave for this run and ask for any missing choices before planning:

- the model and reasoning level for each worker, reviewer and the cross-vendor counselor (the current session is the principal);
- which reviewers cover formal rounds: both by default, or one if the user chooses and assigns it the required coverage;
- the decisions the user keeps, how to notify them and, for a release, its version and destinations;
- the channel for another vendor's model: its visible desktop app by default, or a command-line tool if the user chooses it.

Once selected, give the user a short opening brief in bullets, one per actual role session. Put combined roles on one bullet. Each bullet names the role, model, reasoning level, work it owns and when it joins. A last bullet gives the review basis from project memory: whom the project serves, its basic logic and what is a defect for them. Ask only if project memory has none. Include this in the plan's opening, without a separate approval step.

Verify access to the selected sessions and cross-vendor channel before planning. Use host capability information where available. If a necessary session must be opened by the user, ask when it is needed. Report access limits early. Read [other-vendor-app.md](references/other-vendor-app.md) before the first cross-vendor request.

Record these choices, the review basis, the checked runner or declared environment, worktree rules, memory and working directories, and the user's standing instructions in the project's existing records.

## Order of the work

1. **Plan** ([plan-and-dispatch.md](references/plan-and-dispatch.md)). Triage first. Reuse qualified results and have the MATH worker derive foreseeable new claims for independent review. Identify the critical path and worthwhile parallel work. The user approves the plan before implementation.
2. **Assign work** (same reference). The principal does its own batch from the approved plan and acceptance criteria. Write briefs for work being handed to another session. Parallel jobs own disjoint files or, in a fix round, named disjoint regions. Develop code first, assemble its documentation once its code review converges, and write notebooks at release.
3. **Implement.** The CODE worker applies qualified derivations and updates every place stating a changed claim. Assign independent review to the batch, with the same verdict serving hand-in and acceptance within its coverage.
4. **Integrate** with checks graded by what the change can affect ([integration-and-review.md](references/integration-and-review.md), also for steps 5 to 7).
5. **Before review**, reuse valid evidence and run the full suite where the integration and expensive-check rules require it. The MATH reviewer checks changed mathematics with its consuming code.
6. **Review.** Keep the assigned independent reviewers for related rounds and fix verification. Use a fresh reviewer when independence from an earlier verdict is needed, the incumbent helped produce the work under review, or user, project or host rules require it. One review can cover hand-in, acceptance and the formal round within its actual scope. The first and final formal rounds include end-to-end and previous-release checks.
7. **Triage and fix.** Close routine items directly. Send material open choices to the counselor or user and return affected work to its owner.
8. **Release and wrap up** ([release-and-wrap-up.md](references/release-and-wrap-up.md)).

Once the user approves the plan, carry out the work it authorizes.

## Producing and qualifying mathematics

Check the basis of bounds, ranges, guarantees, equivalences, windows, tolerances, work and byte counts, conditions, causal claims, rejections and remedies, and numerical algorithms with exact arithmetic or scaling.

- The MATH worker (including a matching principal) owns new claims, changed premises and unsupported reasoning. This includes cost conventions, coverage arguments and reconciliation of conflicting results. Other producers identify the missing relation, premise and consuming path, batch related questions for that owner and continue independent work.
- The MATH reviewer independently checks new or revised derivations before approval of the plan that relies on them or before dependent implementation if discovered later. Give the reviewer the original problem, constraints, derivation and primary evidence so it can challenge the premise and conclusion. Check actual consuming branches when the code exists.
- Reuse an independently checked result while its conclusion, premises and consuming paths still match the reviewed scope. Restoring prose to that result needs a source check and contextual reread. A changed scientific claim or public contract follows its substantive route.

## Triage of findings

Triage every finding before planning fixes, treating the review's severity and remedy as inputs. Read [triage-calibration.md](references/triage-calibration.md) before each triage.

- **Three questions.** Does the finding produce a wrong result, block a user who follows the documentation, or lead a user to a wrong decision?
- **An impact sentence** names a supported user path and what goes wrong. Establish reachability from the public contract and actual consumers, not only internal callers. An uncommon input within the review basis can still expose a defect. Unsupported hypothetical use alone does not establish one.
- **Wrong or only imprecise.** A loose valid bound, nominal charge or arithmetic precision limit is not a defect merely for being inexact. Check the promised semantics and downstream use. Incorrect result associations, provenance or resource classification are code defects when consumers rely on them, even if the headline numerical answer is unchanged.
- **The cheapest correct change** removes the demonstrated harm. Text alone suffices only when behavior and consumed data already meet the contract. A larger change needs a concrete benefit relative to its engineering cost and instability, using derivations and implementation that already exist.
- **Not fixing is an outcome.** Give every finding a disposition and its reason, and keep deferrals visible. An optional wording preference is marked not fixed and creates no job or backlog item.
- **Circuit breaker.** At each partial, assess accumulated changes and coordination cost. Re-triage a chain that changes the design or correctness basis. Before a second consecutive follow-up job on one feature, consult the counselor. Count completed jobs and documentation rewrites. Qualified local corrections closed by the principal or current owner create no job.
- **Direct documentation closure.** The principal or current owner corrects authorized local text from qualified science and actual consumers, then rereads it in context. This completes the passage’s writing review. Route new mathematics, runtime changes and material capability choices to their respective owners.
- **Present triage** as code changes, text changes and deferred or closed items. Include each impact and disposition, with evidence for local corrections. The user decides new scope and rounds, or the principal and counselor within delegated authority.

## Decisions with the counselor

The principal and counselor take only delegated decisions. Request the counselor for materially new review scope, unresolved consequential choices or the circuit breaker, with the evidence needed to decide. Source/ref updates, settled dispositions and qualified local text stay with the principal. Read [counselor.md](references/counselor.md) before a necessary request. Agreement settles a decision, not scientific correctness.

## Standing rules

- **Scope.** Carry the user's actual instructions into delegated work. Distinguish proposals from decisions, record standing rules with their owner and clarify ambiguity that changes authority or results. Respect closed decisions.
- **Completion notices.** Use host completion events for dispatched work. Do not schedule wake-ups or poll. Check a background launch once in its first five minutes for startup failure. On a user progress request, inspect actual outputs and collect completed work. User-requested monitoring follows `research-watchdog-protocol`.
- **Text for agents.** Check the facts of briefs, requests, fix lists and handoffs against their sources before sending them.
- **Session continuity.** Keep each active owner for related batches, questions and corrections. When an owner has ended or reached a user, project or host limit, hand off its current task. For separate derivation and review sessions, and for chats in the other vendor's app, hand off after six compactions by default. The user sets the principal's handoff point, preferably a job boundary. A principal already compacted by earlier work hands off at the first boundary.
- **Handoff.** Name this skill, the current revision and rules, active jobs, next actions, open decisions and evidence links. The successor verifies them against live state and reads history only to resolve a current uncertainty. Keep later-step obligations in that step's checklist.
- **Rule changes.** Update the file the affected session rereads and tell its owner.
- **Clock.** Read the clock in the command that records a decision, at the time it is taken.
- **Environment.** Run every interpreter, test, lint and documentation command through the project's checked runner (a wrapper that pins the interpreter and revision) or in its declared environment, and carry that command into every brief.
- **Records.** The principal keeps current rules, revision, active jobs, decisions and evidence owners in the shared project record. Link dated history separately and preserve outstanding obligations at handoff. Check the actual size of context sent to agents. Edit records with file tools and keep them under version control at boundaries.
- **Feedback and interruptions.** While producing a batch, limit concurrent work that needs the principal's attention. Handle immediate feedback directly. For a delayed item, leave one line in its job entry with next action, when due and report location. Prioritize a blocked dependency or invalidated premise. Before switching, note where to resume and the next step. At batch boundaries, integration and handoff, reconcile outstanding jobs with their expected reports. Clear temporary entries once resolved or resumed and keep the disposition with the job. AI agents read internal job records, handoffs and these temporary notes directly. Use brief facts, actions and paths. Load `research-writing-style` for these records only at the user’s explicit request.

## Checks

Check each artifact before it leaves the principal.

- **Plan, before approval:** triage came first, each foreseeable mathematical claim has an independently checked or still-applicable qualified derivation, and the plan names its critical path and independent lines.
- **Brief, before dispatch, inherited briefs included:**
  - the mathematical claims the recipient relies on are qualified, including claims with changed premises;
  - every place that states each changed claim is listed;
  - a fix of a public contract, or one a review names, shows a detector that fails before the fix, kept in the suite only where the test policy admits it;
  - the checks are the covering test files and probes, with no full suite;
  - its stop condition names a deliverable;
  - each additional agent has a distinct deliverable or independence requirement worth its briefing, context and review cost; delivery and acceptance share the assigned reviewer;
  - it updates the places that state its changed claims but carries no documentation job for its area, which starts only after the area's code review has converged, and notebooks wait for the release.
- **Derivation request:** covers the claim in every reachable case and supported public use, names missing or changed premises and asks for a complete derivation.
- **Review request:** the reviewer is independent of the producer and has the original requirements, review basis, relevant source and evidence. Substantially new formal-review scope has its counselor check.
- **Integration:** checks match the change and required delivery scope, including notebook cells or other formats the project's gates cover. Every failed test line was read. A scoped check is not reported as a repository-wide pass.
- **Triage:** every item has a consequence and disposition. The counselor checks material unresolved choices, not each local text correction or settled no-change item.
- **Fix list:** every deferred item names its owner, scope and who decided it.
- **Expensive checks:** ran on the final code, or the record says why not.
- **Rules:** a rule is recorded only at the user's request or as a stated standing rule, in its smallest form; a changed rule is in the file the other session rereads; standing rules the user stated this run are in the durable files.
- **Opening brief:** one bullet per actual role session gives its model, reasoning level, responsibility and trigger.
