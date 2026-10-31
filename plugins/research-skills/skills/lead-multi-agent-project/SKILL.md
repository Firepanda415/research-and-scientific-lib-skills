---
name: lead-multi-agent-project
description: Lead a multi-agent engineering project, such as a scientific-software release, as its principal agent with advisor, worker, review and counselor models. Covers the start-of-run settings, a plan with derived mathematics, briefs, integration checks, review rounds, triage of findings and the release. Use when the user asks this session to run or take over such a project; one brief, one review or monitoring one job uses its own skill.
---

# Lead a multi-agent project

The principal plans, dispatches, integrates and delivers the work. Handle authorized work directly unless another agent supplies missing expertise, necessary independence or a substantial parallel deliverable. Count briefing, source loading, waiting, hand-in and integration as delegation cost. The references illustrate scientific-library releases.

Read a step's reference when you first enter that step, and again after compaction, which can drop its text.

## Roles

Roles describe responsibilities, not a mandatory roster. Scientific software needs code and mathematical competence with the required independence. Combine compatible responsibilities, and use the models the user selects for the roles actually needed.

- **User.** Decides the scope, behavior changes and extra cost on a default path, approves the plan, and gives every instruction to push, merge into the main branch, release and archive.
- **Principal.** Does not derive new mathematics or implement library algorithms beyond integration conflicts. It directly handles source-fact checks, qualified local prose corrections, mechanical integration, validation commands, records and briefs. It alone operates another vendor's desktop app.
- **Code advisor.** Reviews code and engineering, as each job's independent reviewer and in each review round.
- **Mathematics advisor.** Derives and audits the mathematics, designs and runs the studies that choose defaults, settles mathematical and scientific disagreements, and reviews each round's mathematics.
- **Code worker.** Implements library code, tests and documentation, copying the derivations its brief carries.
- **Mathematics worker.** Implements jobs whose correctness rests mainly on derivations, also copying them.
- **Counselor.** Handles material delegated choices, genuine disagreements and substantially new formal-review scope with the principal. It is not an approval step for routine corrections or applying settled decisions. By default its model is from another vendor.

A coherent job goes to the worker of the competency its correctness rests on, with the other required expertise supplied through that competency's derivations and review. Split it only when independent deliverables justify the added coordination.

When deciding whether another session is necessary, or when coordination is delaying delivery, use [delegation scope and examples](references/delegation-scope.md). Do not delegate that decision or create another approval ledger.

## Step 0: settings and capabilities

At the start of every run, ask the user for these settings rather than reuse recorded ones, because models and their relative strengths change often:

- the model and reasoning level of each advisor and worker the principal plans from the project's competencies (the principal is this session);
- which advisors review each round: both by default, or one when the user judges two unnecessary, told what the other would have covered;
- the counselor model;
- for a release, its version and destinations (repository, package index, documentation site, archive);
- the decisions the user keeps, and how to notify the user;
- how each model of another vendor is reached: its desktop app, where the user can follow each agent's progress, or a command-line tool, which the user cannot watch. Without an answer, use the desktop app only.

Then test at once whether this session can start its workers and reviewers as subagents and operate the other vendor's app. Where it cannot start them, ask the user to open them. If it cannot operate the app, tell the user before planning. Before the first request to another vendor's model, read [other-vendor-app.md](references/other-vendor-app.md).

Record the answers, the environment (the checked runner or declared environment, the worktree rules, the memory folder and the working directory) and every standing rule the user states during the run in the durable files later sessions read, not only in the conversation.

## Order of the work

1. **Plan** ([plan-and-dispatch.md](references/plan-and-dispatch.md)). Triage first, then the mathematics advisor derives every foreseeable mathematical item in the plan, reusing qualified derivations (defined below). The plan names its critical path and the independent lines that start together. The user approves the plan before dispatch.
2. **Dispatch** (same reference). Briefs carry derivation packages. Parallel jobs own disjoint files, or disjoint regions in a fix round, and independent lines start at once. Code comes first, an area's documentation once its code review has converged, and notebooks once, at the release.
3. **Implementation.** Workers copy derivations and change every place that states a changed claim. Each job names its independent code and mathematical review owners. Their review serves hand-in and acceptance without duplication.
4. **Integration**, graded by what it can have changed ([integration-and-review.md](references/integration-and-review.md), also for steps 5 to 7).
5. **Before a review round**, reuse valid evidence and run the full suite only where the integration and expensive-check rules require it. The advisor checks the mathematics this round changed.
6. **Review** on the advisor models chosen at step 0. Formal rounds, the review rounds of this step, use fresh reviewers, with one owner for each required purpose. A job review may also satisfy acceptance and round review when its scope covers them. End-to-end and previous-release checks belong to the first and final rounds' assigned reviewers. Fix verification stays with the existing reviewers and covers the delta and affected context.
7. **Triage and fix rounds.** The principal closes routine items directly. Material unresolved choices go to the counselor or user, then affected work follows steps 2 to 6.
8. **Release and wrap-up** ([release-and-wrap-up.md](references/release-and-wrap-up.md)).

Once the user approves the plan, carry out the work it authorizes without asking again.

## Mathematics goes to the advisor

A clause states mathematics by its content: a bound, a range, a guarantee, an equivalence, a window, a tolerance, a count of work or bytes, a condition, a cause, a rejection and its remedy direction, or a numerical algorithm with exact arithmetic or scaling.

- The principal and the workers derive none of it. A worker that lacks a derivation sends the principal the relation, consuming path and missing premise, and continues independent work. The principal batches related questions for the advisor.
- New claims, changed premises and unsupported mathematical reasoning go to the advisor before dispatch. That includes the principal's own arguments, such as that one check covers another path, a cost convention or a reconciliation of two advisor answers.
- A derivation or verdict is qualified when the mathematics advisor or an independent mathematics reviewer produced or checked it and its conclusion, premises and actual consuming paths still match. A qualified result is reused, and restoring documentation to one needs a source check and contextual reread, not a new derivation. Missing evidence, changed scientific meaning or a changed user contract follows its scientific or implementation route, regardless of the edit's length.

## Triage of findings

Triage every finding before planning fixes, treating the review's severity and remedy as inputs. Read [triage-calibration.md](references/triage-calibration.md) before each triage.

- **Three questions.** Does the finding produce a wrong result, block a user who follows the documentation, or lead a user to a wrong decision?
- **An impact sentence** names a supported user path and what goes wrong. Establish reachability from the public contract and actual consumers, not only internal callers. An uncommon valid input can still expose a defect. Unsupported hypothetical use alone does not establish one.
- **Wrong or only imprecise.** A loose valid bound, nominal charge or arithmetic precision limit is not a defect merely for being inexact. Check the promised semantics and downstream use. Incorrect result associations, provenance or resource classification are code defects when consumers rely on them, even if the headline numerical answer is unchanged.
- **The cheapest correct change** removes the demonstrated harm. Text alone suffices only when behavior and consumed data already meet the contract. A larger change needs a concrete benefit relative to its engineering cost and instability, using derivations and implementation that already exist.
- **Not fixing is an outcome.** Give every finding a disposition and its reason, and keep deferrals visible. An optional wording preference is marked not fixed and creates no job or backlog item.
- **Circuit breaker.** At every partial, judge the accumulated changes and coordination cost. A chain that changes the design or correctness basis returns to triage. A second consecutive follow-up job on one feature, delivered or not and documentation rewrites included, goes to the counselor before dispatch. A qualified local correction closed by the principal or current owner is not a follow-up job.
- **Direct documentation closure.** The principal or current owner corrects authorized local text from qualified science and actual consumers, rereads it in context and closes it. That reread supplies the passage's writing review. No new writer, verifier, counselor or acceptance round follows. Restating established behavior is not a new derivation. New mathematics, runtime changes or a material capability decision use their substantive routes.
- **Present triage** in three groups (change code, change text, defer or not fix), with the impact sentence and disposition of each finding. The user decides new scope and rounds, or the principal and counselor within delegated authority. Report local documentation corrections with their evidence.

## Decisions with the counselor

The principal and counselor take only delegated decisions. Request the counselor for materially new review scope, unresolved consequential choices or the circuit breaker, with the evidence needed to decide. Source/ref updates, settled dispositions and qualified local text stay with the principal. Read [counselor.md](references/counselor.md) before a necessary request. Agreement settles a decision, not scientific correctness.

## Standing rules

- **Scope.** Apply instructions at their stated scope. Pass the user's words when delegating decisions and distinguish the principal's proposals from those decisions. Record only requested or standing rules, briefly, in their current owner. Ask when unresolved ambiguity changes authority or results. A topic the user closed stays closed.
- **No timers.** Start no timers, scheduled wake-ups or polling for dispatched work; completion notices report it. Check a background launch's log once within its first five minutes, to catch a run that never started; that single check is the only timed step. When the user asks about progress, look at what each job has produced, take any finished deliverable and stop only that job. Monitoring the user asks for follows `research-watchdog-protocol`.
- **Text for agents.** Check the facts of briefs, requests, fix lists and handoffs against their sources before sending them.
- **Short-lived sessions.** Keep context bounded: a reviewer serves one round and its fix verification; an advisor thread takes only its job's continuations, until six compactions, and new work opens a new thread. The principal hands off where the user decides, preferably at a job boundary; a principal already compacted by earlier work hands off at the first job boundary.
- **Handoff.** Name this skill, the current revision and rules, active jobs, next actions, open decisions and evidence links. The successor verifies them against live state and reads history only to resolve a current uncertainty. Keep later-step obligations in that step's checklist.
- **Rules another session rereads.** When a rule changes, change the file that session rereads and tell it.
- **Clock.** The command that writes a record reads the clock itself, and a decision is recorded when it is taken; a time the model types runs ahead of the clock.
- **Environment.** Run every interpreter, test, lint and documentation command through the project's checked runner (a wrapper that pins the interpreter and revision) or in its declared environment, and carry that command into every brief.
- **Records.** Each fact has one home in the project's existing records. Keep a compact current entry for rules, revision, jobs, decisions and evidence owners, with dated history linked separately. Preserve decision provenance and unresolved obligations when archiving history. Use measured duration and available usage without copying the full chronology into briefs or handoffs. Read actual content size rather than trusting line count. Edit records with file tools and keep them under version control at boundaries.

## Checks

Check each artifact before it leaves the principal.

- **Plan, before approval:** triage came first, every foreseeable mathematical item is derived in the plan or reuses a qualified derivation, and the plan names its critical path and independent lines.
- **Brief, before dispatch, inherited briefs included:**
  - every mathematical statement is qualified, and one whose meaning changed was qualified before dispatch;
  - every place that states each changed claim is listed;
  - a fix of a public contract, or one a review names, shows a detector that fails before the fix, kept in the suite only where the test policy admits it;
  - the checks are the covering test files and probes, with no full suite;
  - its stop condition names a deliverable;
  - each additional agent has a distinct deliverable or independence requirement worth its briefing, context and review cost; delivery and acceptance share the assigned reviewer;
  - it updates the places that state its changed claims but carries no documentation job for its area, which starts only after the area's code review has converged, and notebooks wait for the release.
- **Advisor request:** it covers the whole claim in every case the code reaches and in its supported public uses, names missing or changed premises, and asks for complete derivations.
- **Review request:** it is neutral, source-bound and independent of producer discussion. Substantially new formal-review scope has its required counselor check, not another check for a mechanical update.
- **Integration:** checks match the change and required delivery scope, including notebook cells or other formats the project's gates cover. Every failed test line was read. A scoped check is not reported as a repository-wide pass.
- **Triage:** every item has a consequence and disposition. The counselor checks material unresolved choices, not each local text correction or settled no-change item.
- **Fix list:** every deferred item names its owner, scope and who decided it.
- **Expensive checks:** ran on the final code, or the record says why not.
- **Rules:** a rule is recorded only at the user's request or as a stated standing rule, in its smallest form; a changed rule is in the file the other session rereads; standing rules the user stated this run are in the durable files.
- **Start of the run:** the step 0 settings were asked this run.
