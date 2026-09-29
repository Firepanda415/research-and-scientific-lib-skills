---
name: lead-multi-agent-project
description: Lead a multi-agent engineering project, such as a scientific-software release, as its principal agent with advisor, worker, review and counselor models. Covers the start-of-run settings, a plan with derived mathematics, briefs, integration checks, review rounds, triage of findings and the release. Use when the user asks this session to run or take over such a project; one brief, one review or monitoring one job uses its own skill.
---

# Lead a multi-agent project

The principal is the session the user opens to lead the work. It plans, writes the briefs, dispatches, integrates, keeps the ledger and reports to the user. This skill gives the order of the work and the judgment rules that agents missed in real releases. Examples marked "NWQLib 0.99" or "0.99.1" come from two releases of a scientific library in September 2026 and show what a rule prevents.

Read a step's reference when you first enter that step, and again after compaction, which can drop its text.

## Roles

Roles follow the competencies the project demands. Each competency has an advisor, who derives, reviews and settles questions in it, and a worker, who implements in it. From the project's needs the principal plans the competencies and which of their roles the work uses, and confirms them at step 0. A scientific-computing package demands two competencies, code and mathematics, which give the roles below. Another project may demand others, each assigned to the model the user judges strongest in it.

- **User.** Decides the scope, behavior changes and extra cost on a default path, approves the plan, and gives every instruction to push, merge into the main branch, release and archive.
- **Principal.** Writes no mathematics, and no library code beyond resolving integration conflicts. It is the only session that operates another vendor's desktop app, and it writes the requests of each review round.
- **Code advisor.** Reviews code and engineering, as each job's independent reviewer and in each review round.
- **Mathematics advisor.** Derives and audits the mathematics, designs and runs the studies that choose defaults, settles mathematical and scientific disagreements, and reviews each round's mathematics.
- **Code worker.** Implements library code, tests and documentation, copying the derivations its brief carries.
- **Mathematics worker.** Implements jobs whose correctness rests mainly on derivations, also copying them.
- **Counselor.** Takes delegated user decisions together with the principal while the user is away, and checks the principal's review requests and merged triage before they go out. By default it runs on a model from a different vendor than the principal's, for a different perspective and rigor.

A job goes to the worker of the competency its correctness rests on, and a job that needs two is split by module.

## Step 0: settings and capabilities

At the start of every run, ask the user for these settings rather than reuse recorded ones, because models and their relative strengths change often:

- the model and reasoning level of each advisor and worker the principal plans from the project's competencies (the principal is this session);
- which advisors review each round: both by default, or one of them when the user judges two unnecessary, told what the other would have covered;
- the counselor model;
- the decisions the user keeps, and how to notify the user;
- how each model of another vendor is reached: its desktop app, where the user can follow each agent's progress, or a command-line tool, which the user cannot watch. Without an answer, use the desktop app only.

Then test at once whether this session can start its workers and reviewers as subagents and whether it can operate the other vendor's app. Where it cannot start them, ask the user to open them. If it cannot operate the app, tell the user before planning. Before the first request to another vendor's model, read [other-vendor-app.md](references/other-vendor-app.md). When that model runs through its desktop app, request full-screen control now and keep it to the end.

Record the answers, the environment (the checked runner or declared environment, the worktree rules, the memory folder and the working directory) and every standing rule the user states during the run in the durable files that later sessions read, not only in the conversation.

## Order of the work

1. **Plan** ([plan-and-dispatch.md](references/plan-and-dispatch.md)). Triage first, then the mathematics advisor derives every foreseeable mathematical item in the plan. The plan names its critical path and the independent lines that start together. The user approves the plan before any dispatch.
2. **Dispatch** (same reference). Briefs carry derivation packages. Parallel jobs own disjoint files, and independent lines start at once. Code comes first, an area's documentation once its code review has converged, and notebooks once, at the release.
3. **Implementation.** Workers copy derivations and change every place that states a changed claim. Each job gets a code advisor review, and its mathematics goes back to the mathematics advisor.
4. **Integration**, graded by what it can have changed ([integration-and-review.md](references/integration-and-review.md), also for steps 5 to 7).
5. **Before each review**, a full suite per changed platform and the advisor's check of the mathematics this round changed.
6. **Review** by fresh reviewers on the advisor models chosen at step 0, requested by the principal: the code advisor's model for code, engineering and the user's side, the mathematics advisor's model for the mathematics and the check against the previous release. A round checks only what changed. The end-to-end check runs in the first round and before the release, the check against the previous release in the first round and after the fix rounds converge. A round with one job merges its job review and the round review, keeping these two checks.
7. **Triage and fix rounds.** The principal triages, the counselor checks the triage, the user decides, and steps 2 to 6 follow.
8. **Release and wrap-up** ([release-and-wrap-up.md](references/release-and-wrap-up.md)).

Once the user approves the plan, carry out the work it authorizes without asking again.

## Mathematics goes to the advisor

A clause states mathematics by its content: a bound, a range, a guarantee, an equivalence, a window, a tolerance, a count of work or bytes, a condition, a cause, a rejection and its remedy direction, or a numerical algorithm with exact arithmetic or scaling.

- The principal and the workers derive none of it. A worker that needs a derivation its brief lacks writes a request file for the principal, which opens a new advisor thread, and the worker continues with the parts that do not depend on the answer.
- Every clause that states mathematics goes to the advisor before dispatch, however small it looks. That includes fixes disposed of as text or as fixed differently, review suggestions, which stay hypotheses until derived, and the principal's own decisions and rule proposals, such as an argument that one check covers another path or a cost convention. Only text that states no mathematics skips the advisor. A derivation requested after dispatch repairs a missed step and is not a second route.
- A request covers the whole claim in every case the code reaches, not only the part in question. For each problem found it asks for the complete derivation of the correct statement: each step, every premise, and the resulting bound, condition or direction, in text and code that can be copied without further derivation.
- An implementation that follows a derivation goes back to the advisor with its code, which checks that every branch meets the premises and that every text agrees.

## Triage of findings

Before any fix is planned, triage every finding and present the triage to the user. Models of both vendors judged importance poorly when asked for first-principles judgment, so the judgment is built into these steps, and the review's severity and proposed change are inputs. Read [triage-calibration.md](references/triage-calibration.md) before each triage.

- **Three questions.** Does the finding produce a wrong result, block a user who follows the documentation, or lead a user to a wrong decision?
- **An impact sentence** names who meets the finding in ordinary use and what goes wrong for them. A finding without one is at most a text item.
- **Wrong or only imprecise.** A bound that holds but is loose, a charge that is a nominal proxy, a precision limit of the arithmetic, an edge no caller reaches and a rounding difference far below any tolerance are not defects of a result. Correct the claim that overstates them. Change code to meet a claim only when users rely on the claim as a contract.
- **The cheapest correct change** removes the harm, often with one sentence. A larger change needs its own reason. When a complete derivation and code for a fix already exist, the fix costs only its extra engineering and instability, so it goes ahead when it needs little extra code and changes little else, even beyond the cheapest change.
- **Not fixing is an outcome.** List the items not fixed and the items deferred, each with its reason, next to the items fixed.
- **Circuit breaker.** At every partial, judge the accumulated chain of smallest changes, and when it has grown into a new design, stop and triage from first principles before another fix.
- **Changes that cannot be wrong** get no detector (a test that fails when its fix is undone), no full suite and no separate review, the code advisor's included. The code or text they describe shows directly that they are correct, as for notebook prose, a stale figure, a run time, or "at least" added to a refusal whose count stops at the limit. Judge each clause: one that states mathematics still goes to the advisor. The principal checks the diff scope, runs the checks of the touched files, and collects such items into one job.
- **The user sees the triage** in three groups (change code, change text, defer or not fix), each item, including those not fixed, with its impact sentence and recommendation, and decides which items are fixed and whether another round runs. While the user is away and has not kept this decision, the principal and the counselor take it. Small text problems, such as a stale run time or a wording slip, are fixed without waiting, also beside a job's items, and the report names them. Only new work, changes to the user's rules and extra cost wait for the user.

## Decisions with the counselor

When a decision belongs to the user, the user did not keep it at step 0, and the user may be away, the principal and the counselor take it together, because decisions the principal took alone were often not thought through. The counselor also checks each round's review requests before they go out and the merged triage before fixes are dispatched, with the raw material in hand. Read [counselor.md](references/counselor.md) before a request to the counselor. Agreement between the two models settles a decision; it does not verify a result.

## Standing rules

- **Scope.** Act on an instruction at the scope the user gave. Do not turn a remark into rules across several files or extend a decision to later stages. Ask when the scope is unclear or an instruction could mean two different actions. Record a rule only when the user asks for one or states a standing rule, and then in the smallest form. Pass the user's own words to other sessions, not another model's reading of them. (NWQLib 0.99: a request to lighten one round's verification became a general rule on review depth, which the user then kept only as a record of that round.)
- **No timers.** Start no timers, scheduled wake-ups or polling for dispatched work; completion notices report it. Check a background launch's log once within its first five minutes, to catch a run that never started; that single check is the only timed step. When the user asks about progress, look at what each job has produced, take any finished deliverable and stop only that job. Monitoring the user asks for follows `research-watchdog-protocol`.
- **Text for agents.** Check the facts of briefs, requests, fix lists and handoffs against their sources before sending them.
- **Short-lived sessions.** Repeated compaction lowers a model's ability, so sessions and agents other than the principal are not used for long or for many tasks. A reviewer serves one round and the verification of its fixes. An advisor thread takes only continuations of its job, until it has been compacted six times; new work opens a new thread. The principal hands off where the user decides, preferably at a boundary of the job split.
- **Handoff.** The handoff file names this skill in its first section and gives the state, the next steps and the open questions. The new principal loads the skill, reads the durable records from the start, checks the handoff's facts against the live checkout and the rule files, and records there any rule that lived only in the handoff, because a handoff written from a compacted context can be wrong.
- **Rules another session rereads.** When a rule changes, change the file that session rereads as well as telling it.
- **Clock.** Take every recorded time from the system clock, and record a decision when it is taken; estimated times ran ahead of the clock.
- **Environment.** Run every interpreter, test, lint and documentation command through the project's checked runner (a wrapper that pins the interpreter and revision) or in its declared environment, and carry that command into every brief.
- **Records.** Keep a ledger of jobs, advisor threads, integrations, leftovers and the measured duration of each job kind, with each of the principal's decisions and its reason; a decision record that separates the user's decisions from those of the two models; a disagreement record; the project's rule file; and its lessons. Each fact has one home file, named in the project's guidance, and other records point to it.

## Checks

Check each artifact before it leaves the principal.

- **Plan, before approval:** triage came first, every foreseeable mathematical item is derived in the plan, and the plan names its critical path and the lines that start together.
- **Brief, before dispatch, inherited briefs included:**
  - every clause that states mathematics came from the mathematics advisor;
  - every place that states each changed claim is listed;
  - a fix of a public contract, or one a review names, requires a detector that fails before the fix;
  - the checks are the covering test files and probes, with no full suite;
  - its stop condition names a deliverable and a time limit taken from measured job times;
  - it updates the places that state its changed claims but carries no documentation job for its area, which starts only after the area's code review has converged, and notebooks wait for the release.
- **Advisor request:** it covers the whole claim in every case the code reaches and asks for complete derivations.
- **Review request:** it is neutral (revision, scope, decisions, environment, output) without working files, names a fixed ref of its own, and the counselor has checked it.
- **Integration:** the checks match its grade.
- **Triage, before presenting:** every item, including those not fixed, has an impact sentence, each item not fixed or deferred has a reason, and the counselor has checked the triage.
- **Fix list:** every deferred item names its owner and scope.
- **Expensive checks:** ran on the final code, or the record says why not.
- **Rules:** a rule is recorded only at the user's request or as a stated standing rule, in its smallest form; a changed rule is in the file the other session rereads; standing rules the user stated in this run are in the durable files.
- **Start of the run:** the step 0 settings were asked this run.
