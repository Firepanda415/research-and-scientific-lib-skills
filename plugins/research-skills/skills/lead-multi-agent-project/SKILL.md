---
name: lead-multi-agent-project
description: Lead a multi-agent engineering project, such as a scientific-software release, as the principal. Assign production by model, keep independent reviewers, and coordinate planning, implementation, integration, triage and release. Use when the user asks this session to run or take over such a project; one brief, one review or monitoring one job uses its own skill.
---

# Lead a multi-agent project

The principal carries out the plan through planning, dispatch, coordination, integration, acceptance and delivery. "Implement the plan" assigns this leadership responsibility. Production follows the selected worker roles. Count briefing, source loading, waiting, hand-in and integration as delegation cost.

Read each reference when its step applies, and reload lost guidance after compaction.

## Roles

Before starting, map the user's roles to models and sessions. Specific assignments govern who produces the work. For scientific software, assign CODE and MATH production and review separately.

- **User.** Approves the plan, scope and behavior changes, extra default-path costs, and each push, main-branch merge, release and archive.
- **Principal.** Owns planning, integration, checks, records and delivery. By default it also takes the worker role with the same model, not merely vendor, unless the user assigns a separate session. Verify and record the overlap before production. Other production and substantive fixes, including integration fixes, go to their workers. It alone operates another vendor's desktop app.
- **CODE worker.** Implements code, tests and associated documentation from qualified derivations.
- **MATH worker.** Derives new results, states premises and cases, and designs and runs authorized studies of defaults.
- **CODE and MATH reviewers.** Check engineering and public workflows, or derivations and their implementation. Default to one independent reviewer in a separate session per actual worker, including a principal with a worker role. Keep the pairing through fixes and acceptance. User allocations override the count, with coverage assigned for every worker.
- **Counselor.** Uses a model from a different vendor than the principal. Joins when a delegated choice remains material, a disagreement needs resolution, formal-review scope is substantially new or the circuit breaker applies.

Count actual workers, not the allowed maximum. Start sessions as needed. Distinguish concurrent activity from total sessions. Pin reviewed revisions and pause the corresponding workers' changes in that scope. Assign interfaces and integrated workflows to existing reviewers on a common revision.

One worker or reviewer is one session doing its own work, without subagents by default, even if a specialist skill suggests them. Before adding one, state the necessary expertise, independence or substantial parallel deliverable the assigned sessions cannot provide effectively, within user and host authority. Its owner checks the result. Use [delegation scope](references/delegation-scope.md) when the benefit is unclear.

## Step 0: settings and opening brief

Use the user's settings and existing role assignments. Ask only for choices still missing:

- the model and reasoning level for each worker, reviewer and the cross-vendor counselor (the current session is the principal);
- the actual worker sessions, their paired reviewers and formal-round coverage, within the user's concurrency limits;
- the decisions the user keeps, how to notify them and, for a release, its version and destinations;
- the channel for another vendor's model: its visible desktop app by default, or a command-line tool if the user chooses it.

Open the plan with one bullet per actual session: role, model, reasoning level, work, worker/reviewer pairing and start trigger. Combine overlapping roles. End with the review basis from project memory: whom the project serves, its basic logic and what is a defect for them. Ask only if memory has none. No separate approval is needed.

Verify selected-model access before dispatch. Report limits without substituting models. Ask for user setup when needed. Read [other-vendor-app.md](references/other-vendor-app.md) before the first cross-vendor request.

Record the settings, review basis, runner or environment, worktree rules, memory and working directories, and standing instructions in existing project records.

## Order of the work

1. **Plan** ([plan-and-dispatch.md](references/plan-and-dispatch.md)). Triage first. Reuse qualified results and have the MATH worker derive foreseeable new claims for independent review. Identify the critical path and worthwhile parallel work. The user approves the plan before implementation.
2. **Assign work** (same reference). Assign complete outcomes under the approved roles and stage gates, including routine caller, test, text and output updates. Parallel jobs own disjoint files or, in fix rounds, named disjoint regions. Develop code first, assemble documentation after code review converges, and write notebooks at release.
3. **Implement.** The CODE worker applies qualified derivations and updates every place stating a changed claim. Assign independent review to the batch, with the same verdict serving hand-in and acceptance within its coverage.
4. **Integrate** with checks graded by what the change can affect ([integration-and-review.md](references/integration-and-review.md), also for steps 5 to 7).
5. **Before review**, reuse valid evidence and run the full suite where the integration and expensive-check rules require it. The MATH reviewer checks changed mathematics with its consuming code.
6. **Review.** Keep the assigned independent reviewers for related rounds and fix verification. Use a fresh reviewer when independence from an earlier verdict is needed, the incumbent helped produce the work under review, or user, project or host rules require it. One review can cover hand-in, acceptance and the formal round within its actual scope. The first and final formal rounds include end-to-end and previous-release checks.
7. **Triage and fix.** Close routine items directly. Send material open choices to the counselor or user and return affected work to its owner.
8. **Release and wrap up** ([release-and-wrap-up.md](references/release-and-wrap-up.md)).

Once the user approves the plan, carry out the work it authorizes.

Checkpoints report progress. When a dependency, review, changed premise, scope/authority or resource limit blocks work, report it and continue unaffected authorized work. Before a continuation, identify what existing authority could not finish.

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
- **Circuit breaker.** At each partial, assess accumulated changes, returns and coordination cost, even in one job. Consolidate local returns with the current owner before redispatch. Re-triage a chain that changes design or correctness basis. Before a second consecutive follow-up job on one feature, consult the counselor, counting completed jobs and documentation rewrites. Qualified local closure creates no job.
- **Direct documentation closure.** The principal or current owner closes authorized local text from qualified science and actual consumers, then rereads it for writing review. Runtime messages stay with the CODE owner. Identity or format effects need its paired review. New mathematics and material capability choices go to their owners.
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
- **Clock.** Read the clock in the command recording a decision.
- **Environment.** Run every interpreter, test, lint and documentation command through the project's checked runner or in its declared environment, and carry that command into every brief.
- **Records.** The principal keeps current rules, revision, active jobs, decisions and evidence owners in the shared project record. Link dated history separately and preserve outstanding obligations at handoff. Check the actual size of context sent to agents. Edit records with file tools and keep them under version control at boundaries.
- **Feedback and interruptions.** Before switching, record the resume point and next action. Keep delayed feedback with its job and reconcile open jobs at batch, integration and handoff boundaries. On deferral or interruption read [continuity rules](references/plan-and-dispatch.md#feedback-and-interruptions).

## Checks

Check each artifact before it leaves the principal.

- **Plan, before approval:** triage came first, each foreseeable mathematical claim has an independently checked or still-applicable qualified derivation, and the plan names its critical path and independent lines.
- **Brief, before dispatch, inherited briefs included:**
  - it names the skills the recipient invokes first;
  - the mathematical claims the recipient relies on are qualified, including claims with changed premises;
  - every place that states each changed claim is listed;
  - a fix of a public contract, or one a review names, shows a detector that fails before the fix, kept in the suite only where the test policy admits it;
  - the checks are the covering test files and probes, with no full suite;
  - its stop condition names a complete scoped deliverable or a justified dependency, review, authority or resource boundary;
  - the session does its own work, any subagent has a justified need within authority, and delivery and acceptance share its reviewer;
  - it updates the places that state its changed claims but carries no documentation job for its area, which starts only after the area's code review has converged, and notebooks wait for the release.
- **Derivation request:** covers the claim in every reachable case and supported public use, names missing or changed premises and asks for a complete derivation.
- **Review request:** the reviewer is independent of the producer and has the original requirements, review basis, relevant source and evidence. Exclusions follow what users pose, not input magnitude. Substantially new formal-review scope has its counselor check.
- **Integration:** checks match the change and required delivery scope, including notebook cells or other formats the project's gates cover. Every failed test line was read. A scoped check is not reported as a repository-wide pass.
- **Triage:** every item has a consequence and disposition. The counselor checks material unresolved choices, not each local text correction or settled no-change item.
- **Fix list:** every deferred item names its owner, scope and who decided it.
- **Expensive checks:** ran on the final code, or the record says why not.
- **Rules:** a rule is recorded only at the user's request or as a stated standing rule, in its smallest form; a changed rule is in the file the other session rereads; standing rules the user stated this run are in the durable files.
- **Opening brief:** sessions have models, reasoning levels, responsibilities, reviewer pairings and triggers. Role overlaps match the user's selections. Total sessions and concurrent activity are distinct.
