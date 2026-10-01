# Plan and dispatch

Read when writing the plan, a job brief, or a request to the mathematics advisor.

## The plan

The plan contains:

- the scope and the public API;
- the defaults and their basis. Where a default needs data, the mathematics advisor runs a pilot study first and the plan records its result. When the user delegates a default to such a study, record the advisor's decision with its evidence and limits, subject to the user's override;
- every decision the user must take;
- the jobs, split by module so that parallel jobs own disjoint files, each with its completion criteria;
- the critical path. The principal's own handling between jobs is the serial part of a run, so the plan names the independent lines that start together, such as a code job, its area's documentation package and a study;
- the verification policy and the test policy;
- what each notebook will show. The notebooks themselves are written in the release step.

Triage comes first: decide what will be built or fixed before anything is derived. (NWQLib 0.99: one round derived first and triaged afterwards, and about 380 lines of derivation went unused.) The mathematics advisor then writes the complete derivation of every mathematical item the plan can foresee into the plan itself. A derivation gives each step and every premise, covers every case the code can reach, and supplies text and code that can be copied without further derivation. For each item the plan lists every place that states it, such as docstrings, the guide, a constants registry, a mathematics document and notebook text. No derivation is left to the implementer or to a later stage. (NWQLib 0.99: the plan left some bounds to the implementer or to a later stage, and more than twenty advisor requests after dispatch were derivations for particular jobs.)

A second mathematics advisor thread checks the derivations and the code advisor checks the engineering. The user approves the plan before anything is dispatched.

When the user has already decided what is fixed, the triage still chooses one alternative per finding, assigns each to a job and marks the clauses that state mathematics, which the derivation requests need. A large plan splits its derivation requests by area and runs them in parallel, and the briefs' non-mathematical parts are written while they run. (NWQLib 1.0: four threads derived about 60 items in 27 minutes.) The decision list is complete only after the derivations, so the plan's approval follows them. After the derivations, apply "not fixing is an outcome" again, since they expose real costs, and re-estimate the cost ranking at the user's actual problem size from the user's own inputs, which changed the ranking of several items. An advisor answer that corrects an outcome the review promised corrects the plan, and the approval presents the corrected numbers, never the review's. (NWQLib 1.0: a speedup of 7 times where the review had said 100.) Read a derivation's laws and cost envelope, not its recommendation line; one thread recommended the construction its own envelope showed to be worse. A contract widening, where several findings become one contract change, needs a sweep for the cases the review did not list and a derivation of the contract itself before the plan is approved.

The code advisor's engineering check of the plan names the consumers of every changed representation with their owners; whether each integration keeps the suite green, such as by a reader introduced before a storage change that migrates every consumer; an ownership table that includes tests, examples, notebook generators, the probe registry and the documentation constants, not only source files; for a new field type, which consumers of record values, such as journal bounds, identity encoders and archive dumps, must accept it; and for a change of a public execution contract, every backend that must implement it and what each already supports. (NWQLib 1.0: the check found an integration order that could not keep the suite green, since a representation was read by 14 source sites in 7 jobs and 30 test files, and found unowned files and ownership collisions the principal's split had missed.)

## Test policy

Unless the project sets its own, the plan adopts this one. A test protects a public contract, or a scientific relation checked against an independent reference through a public workflow. It can also be a canary for behavior the library depends on, one test per failure mechanism that recurs, or a detector that a review names. Tests that pin a value or an old behavior, tests that only show that a change happened, and tests of notebooks or documentation are not written.

## Briefs

Write each brief with `write-implementation-job-prompts`. One set of common terms serves every brief:

- the environment and the checked runner, with the interpreter and its version, the base revision and the test command;
- one verification rule, taken from the plan's verification policy;
- the repository's rules (NWQLib 0.99: no AI-facing material in the repository, no AI attribution, no `git stash`);
- the rule for mathematics: the worker copies its derivations verbatim and derives none, also when it documents existing code. A derivation it lacks, or a step it cannot match to its package, goes to the principal as a request file, which the report names, since a worker cannot message the principal mid-job, and the worker continues with the parts that do not depend on the answer. A relation the worker works out itself, such as a count, goes into a request file before the worker relies on it, or is marked in the code as pending the advisor (NWQLib 0.99: the first audit of worker-derived mathematics found 6 of 16 derivations wrong);
- the plan's test policy. The witness before and after a fix is its regression evidence, and a permanent test is added only where the policy admits it. Before deleting or trimming a test, the worker checks against the mutation results that it is not the only detector of some probe;
- that the worker changes every place that states a claim it changes. Mathematical text copied verbatim from a derivation or statement package into documentation stays as it is and needs no writing review; the writing route covers the prose the worker writes itself;
- that before hand-in the worker has its change reviewed in the foreground by the code advisor's model, for code and engineering, since the principal sends the mathematics to the mathematics advisor, and starts no background agent. When the worker cannot reach that model, the principal runs the review at hand-in. When a background agent's completion notice reaches the principal anyway, the principal forwards the result to the worker.

The principal may delegate the drafting of briefs to parallel drafters working from one written instruction file that names the sources and the copy-verbatim rule for mathematics, never the derivation packages or the pre-dispatch check, and reviews every brief before dispatch. A drafter that refuses a mathematical sentence the principal wrote is right; a principal that reconciles two advisor answers is deriving and sends the reconciliation to the advisor. Expect the principal's own time between waves to go to brief decisions, and batch a wave's worker questions into one advisor thread rather than one thread per question. (NWQLib 1.0: nine drafters wrote the wave-1 briefs in parallel, three of them refused principal-written mathematics, and the principal took about 90 decisions in the 1 h 44 min between two waves.)

Each brief adds:

- the task, and for a documentation job its readers;
- the worktree, branch and base revision, the files the job owns, and how to touch shared files (small, local edits);
- its derivation package, copied from the plan, and every place where each of its claims appears;
- the evidence: a witness (a call and its output, or an exact argument, that shows the defect) before and after each fix, and a failure before the fix for each new test that the test policy admits;
- the checks: the test files that cover the modules it changes and the related mutation probes (registered deliberate defects that some test must catch), the probe inventory test when the job moves or renames lines in a module with registered probes, and no full suite. The principal runs the full suite that an entry-point change needs;
- the completion criteria and the report format;
- a stop condition that names a deliverable and a time limit taken from the ledger's measured durations for the job kind, not an open-ended process. The limit is the stop condition, not a planning estimate. (NWQLib 0.99.1: estimates of 2 to 5 hours for jobs that took 20 to 57 minutes misled the user's planning.) Set the limit at about twice the measured median; a limit far above it only delays the discovery of a stuck job. (NWQLib 1.0: 16 jobs took 3.5 to 41 minutes, median 17, under limits of 30 to 120.)

Every report gives each item's disposition and its evidence, the sentences the job changed, and anything left over with a suggested owner. A fix brief also records the principal's decision on each finding, and its report gives one disposition per finding: fixed, fixed differently with a reason, or not a defect with counterevidence.

A brief that holds a large item beside a contract migration names which is delivered first and gives the other its own job at the first partial; a reader interface frozen ahead of a storage change settles the payload lifetime in the same job; for a critical item the brief asks for an early lifecycle sketch and an immediate stop-and-report on a design gap. A follow-up's file list is derived from the original brief's ownership and its carve-outs, item by item, never from the report's leftovers, and its time limit from the remaining work, not copied from the original job. (NWQLib 1.0: a carve-out was lost twice this way, and the same file stopped the same item twice.) When a new finding duplicates an item a running job already holds, an addendum to that job beats a follow-up: one integration, one suite.

Every implemented formula carries its derivation steps, assumptions, error bound and source in the docstring or comment at its definition, copied from the advisor rather than cited, because the reviewers read the code and not the advisor's answers.

Mathematics that appears only while jobs are designed is derived before dispatch and added to the plan, however small it looks. (NWQLib 0.99: a refusal message was dispatched as too simple to be wrong, and the derivation requested afterwards showed that its clause "the count stopped at the limit" can be false after a complete count.) Every request, to a worker or to an advisor, states its audience and scope. (NWQLib 0.99: a request for the library-wide mathematics document did not say "the whole library", and the run was restarted.)

## Scheduling and assignment

- Schedule by inputs, not by job order. A sub-task starts as soon as its code and derivations exist, even while its parent job waits on another part, from the branch that already holds what it needs. Split a job that is half blocked.
- Each job goes to the worker of the competency its correctness rests on, with the derivation package of its mathematics; a job that needs two competencies is split by module. A worker on the principal's host runs as a subagent. A worker in another vendor's app works in a new thread that the principal opens; the job's mathematics then goes to a separate mathematics advisor thread, and the principal runs its code advisor review.
- At each dispatch, set the role's model and reasoning level explicitly. Where a subagent inherits the parent's level unless its agent definition sets one, dispatch through definitions that set it.
- Development jobs run in parallel only when their files are disjoint. A feature whose blocks share files is one job, ordered inside its brief, and is not split to look parallel. In a fix round, small jobs may edit different regions of one file in parallel, each brief naming its regions, with the principal resolving the conflicts, and text batches are split by file ownership and dispatched beside the code jobs. (NWQLib 1.0: a one-writer-per-file rule made a fix round a four-stage serial chain until the user asked why nothing ran in parallel; small fix jobs took 4 to 25 minutes, so serialization cost more than conflicts.)
- Dispatch independent lines at once, and prepare the next request while a job runs. (NWQLib 0.99.1: the day's wall clock went to one fix chain and to the principal's steps between jobs, until three lines were parallelized in the evening.)
- A low-cost read-only investigation may start while the advisor confirms its reference definitions, with its results labeled candidates until the advisor answers.
- During development, code and documentation of the same area never run in parallel, because code goes through several review rounds that each find many problems, and documentation written alongside only waits for rework. Different areas can run in parallel.
- Notebooks are written once, in the release step, because they show the output of every module and any earlier change ripples into them. (NWQLib 0.99: 38 commits changed the notebooks during development and the first two fix rounds.)
- A worktree is created at dispatch from the integration branch's head, never in advance; a worktree prepared earlier is only a base to re-check against the files changed since.
- A correction to a helper that several parallel jobs consume is its own job, integrated before those jobs are dispatched, with its derivation re-requested for every branch the helper reaches. (NWQLib 1.0: a carve-out in "the earliest dispatched of the three" would have let the other two run against the uncorrected helper.)
- A change that moves an execution-time admission earlier, to planning, has a dispatch precondition: run the planning-only fixtures at the user's scale first, such as the largest plans and the resource notebook, and ask the advisor explicitly for the estimate-only case. (NWQLib 1.0: the user declined a whole delivered job for this.)
- "Dispatched" is written only after the launch result arrives; the running set is read from launch results, not from memory, and a message to an agent uses the id from its launch result. An agent definition written during the run becomes launchable only on a later turn, so write it before the capability test.
- Independent continuations to an advisor go to separate new threads, each with the context it needs, rather than queuing on one thread. (NWQLib 1.0: one thread answered five continuations at 28 to 33 minutes each; new threads answered in 12 to 15.)

## Documentation jobs

Before an area's documentation is written, the mathematics advisor writes one package of every mathematical statement that documentation needs, reconciled with the implemented code, and the writers copy from it. (NWQLib 0.99: several earlier derivation texts had been superseded by later corrections or described more than was implemented.) Assign reader-facing prose by the strengths of the models. (NWQLib 0.99: documentation written on the mathematics advisor's model was accurate but read like a specification, so the user moved the rewrite to the code worker's model, which copied every mathematical statement from the advisor.)

## Requests to the mathematics advisor

- A worker's request file gives the relation, where it is used, what is known and what the worker suspects.
- The principal's request gives the context, the exact relation in the code, what is measured, what is needed, the limits on computation and on the repository, and the answer file to write. It covers the whole claim in every case the code reaches, not only the part in question, and for each problem found asks for the complete derivation of the correct statement. It points the advisor at a pinned snapshot worktree on its own branch with the checked runner, because a branch in use moves under the advisor and invalidates the runner's revision.

## Hand-in

When a code worker's job contains mathematics, the principal sends its diff and mathematical items to the mathematics advisor, which checks every branch against the derivation's premises and every text against the derivation.
