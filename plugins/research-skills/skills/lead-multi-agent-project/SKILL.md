---
name: lead-multi-agent-project
description: Lead a multi-agent engineering project, such as a scientific-software release, as its principal agent with advisor, worker, review and counselor models. Covers the start-of-run settings, a plan with derived mathematics, briefs, integration checks, review rounds, triage of findings and the release. Use when the user asks this session to run or take over such a project; one brief, one review or monitoring one job uses its own skill.
---

# Lead a multi-agent project

The principal is the session the user opens to lead the work. It plans, writes the briefs, dispatches, integrates, keeps the ledger and reports to the user. Use the smallest team that covers the required competencies and independence. Roles and checks do not each require a separate session. The references give examples from scientific-library releases.

Read a step's reference when you first enter that step, and again after compaction, which can drop its text.

## Roles

Roles follow the competencies the project demands. Each competency has an advisor, who derives, reviews and settles questions in it, and a worker, who implements in it. From the project's needs the principal plans the competencies and which of their roles the work uses, and confirms them at step 0. A scientific-computing package demands two competencies, code and mathematics, which give the roles below. Another project may demand others, each assigned to the model the user judges strongest in it.

- **User.** Decides the scope, behavior changes and extra cost on a default path, approves the plan, and gives every instruction to push, merge into the main branch, release and archive.
- **Principal.** Writes no mathematics, and no library code beyond resolving integration conflicts. It is the only session that operates another vendor's desktop app, and it writes the requests of each review round.
- **Code advisor.** Reviews code and engineering, as each job's independent reviewer and in each review round.
- **Mathematics advisor.** Derives and audits the mathematics, designs and runs the studies that choose defaults, settles mathematical and scientific disagreements, and reviews each round's mathematics.
- **Code worker.** Implements library code, tests and documentation, copying the derivations its brief carries.
- **Mathematics worker.** Implements jobs whose correctness rests mainly on derivations, also copying them.
- **Counselor.** Takes delegated user decisions with the principal while the user is away, and checks the principal's review requests and merged triage before they go out. By default it runs on a model from a different vendor than the principal's, for a different perspective and rigor.

A coherent job goes to the worker of the competency its correctness rests on, with the other required expertise supplied through qualified derivations and review. Split it only when independent deliverables justify the added coordination.

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

1. **Plan** ([plan-and-dispatch.md](references/plan-and-dispatch.md)). Triage first, then qualify the necessary mathematics, reusing applicable independent evidence. The plan names its critical path and the independent lines that start together. The user approves the plan before dispatch.
2. **Dispatch** (same reference). Briefs carry derivation packages. Parallel jobs own disjoint files, or disjoint regions in a fix round, and independent lines start at once. Code comes first, an area's documentation once its code review has converged, and notebooks once, at the release.
3. **Implementation.** Workers copy derivations and change every place that states a changed claim. Each job names its independent code and mathematical review owners. Their review serves hand-in and acceptance without duplication. A scientific reviewer may directly correct local documentation claims when authorized in the brief (see Documentation jobs in the dispatch reference).
4. **Integration**, graded by what it can have changed ([integration-and-review.md](references/integration-and-review.md), also for steps 5 to 7).
5. **Before a review round**, reuse valid evidence and run the full suite only where the integration and expensive-check rules require it. The advisor checks the mathematics this round changed.
6. **Review** on the advisor models chosen at step 0. Formal rounds use fresh reviewers, with one owner for each required purpose. A job review may also satisfy acceptance and round review when its scope covers them. End-to-end and previous-release checks belong to the first and final rounds' assigned reviewers. Fix verification stays with the existing reviewers and covers the delta and affected context.
7. **Triage and fix rounds.** The principal triages, the counselor checks the triage, the user decides, and steps 2 to 6 follow.
8. **Release and wrap-up** ([release-and-wrap-up.md](references/release-and-wrap-up.md)).

Once the user approves the plan, carry out the work it authorizes without asking again.

## Mathematics goes to the advisor

A clause states mathematics by its content: a bound, a range, a guarantee, an equivalence, a window, a tolerance, a count of work or bytes, a condition, a cause, a rejection and its remedy direction, or a numerical algorithm with exact arithmetic or scaling.

- The principal and the workers derive none of it. A worker that lacks a derivation sends the principal the relation, consuming path and missing premise, and continues independent work. The principal batches related questions for the advisor.
- New claims, changed premises or unsupported mathematical reasoning go to the advisor before dispatch. Reuse qualification only when the conclusion, premises and actual consuming paths still match. Restoring documentation to an already qualified result needs a source check and contextual reread, not a new derivation. Missing evidence, changed scientific meaning or a changed user contract follows its scientific or implementation route, regardless of the edit's length.

## Triage of findings

Triage material findings before planning implementation fixes, treating the review's severity and remedy as inputs. Authorized local documentation corrections close within their review, as the dispatch reference describes. Read [triage-calibration.md](references/triage-calibration.md) before each triage.

- **Three questions.** Does the finding produce a wrong result, block a user who follows the documentation, or lead a user to a wrong decision?
- **An impact sentence** names a supported user path and what goes wrong. Establish reachability from the public contract and actual consumers, not only internal callers. An uncommon valid input can still expose a defect. Unsupported hypothetical use alone does not establish one.
- **Wrong or only imprecise.** A loose valid bound, nominal charge or arithmetic precision limit is not a defect merely for being inexact. Check the promised semantics and downstream use. Incorrect result associations, provenance or resource classification are code defects when consumers rely on them, even if the headline numerical answer is unchanged.
- **The cheapest correct change** removes the demonstrated harm. Text alone suffices only when behavior and consumed data already meet the contract. A larger change needs a concrete benefit relative to its engineering cost and instability, using derivations and implementation already available where applicable.
- **Not fixing is an outcome.** Give material findings a disposition and reason. Keep real deferrals visible, but optional wording preferences create neither jobs nor active backlog items.
- **Circuit breaker.** At every partial, judge the accumulated changes and coordination cost. A chain that changes the design or correctness basis returns to triage. A second substantive follow-up job on one feature goes to the counselor before dispatch, including documentation rewrites. A local correction closed by the existing reviewer is not another job.
- **Direct documentation closure.** Within authorized edits, the responsible reviewer corrects local defects whose basis is established, then rereads the changed text and its context. Keep the original review snapshot and the correction diff. New mathematics, code changes and contract changes use their existing routes. Read-only reviews stay read-only.
- **Present triage** as change code, change text, and defer or not fix, with impact and disposition for each material finding. The user decides new scope and rounds, or the principal and counselor within delegated authority. Complete already-authorized corrections without renewed approval. Report local documentation corrections with their evidence.

## Decisions with the counselor

The principal and counselor take only decisions delegated by the user. The counselor also checks formal review requests and substantive merged triage with the necessary source evidence. Reuse that decision for mechanical updates and authorized local corrections. Read [counselor.md](references/counselor.md) before a request. Agreement settles a decision within the delegation, not the correctness of a result.

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

- **Plan, before approval:** triage came first, necessary mathematics has applicable qualification, and the plan names its critical path and independent lines.
- **Brief, before dispatch, inherited briefs included:**
  - mathematical statements have applicable advisor qualification; changed meaning is qualified before dispatch;
  - every place that states each changed claim is listed;
  - a fix of a public contract, or one a review names, requires a detector that fails before the fix;
  - the checks are the covering test files and probes, with no full suite;
  - its stop condition names a deliverable;
  - each additional agent has a distinct deliverable or independence requirement worth its briefing, context and review cost; delivery and acceptance share the assigned reviewer;
  - it updates the places that state its changed claims but carries no documentation job for its area, which starts only after the area's code review has converged, and notebooks wait for the release.
- **Advisor request:** it covers the claim and its supported public uses, identifies missing or changed premises, and requests the derivation those gaps require.
- **Review request:** it is neutral (revision, scope, decisions, environment, output) without working files, names a fixed ref of its own, and the counselor has checked it.
- **Integration:** checks match the change and required delivery scope, including notebook cells or other formats the project's gates cover. Every failed test line was read. A scoped check is not reported as a repository-wide pass.
- **Triage, before presenting:** every item, including those not fixed, has an impact sentence, each item not fixed or deferred has a reason, and the counselor has checked the triage.
- **Fix list:** every deferred item names its owner, scope and who decided it.
- **Expensive checks:** ran on the final code, or the record says why not.
- **Rules:** a rule is recorded only at the user's request or as a stated standing rule, in its smallest form; a changed rule is in the file the other session rereads; standing rules the user stated this run are in the durable files.
- **Start of the run:** the step 0 settings were asked this run.
