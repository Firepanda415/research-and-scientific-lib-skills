# Plan and dispatch

Read when writing the plan, a job brief, or a request to the mathematics advisor.

## The plan

The plan contains:

- the scope and the public API;
- the defaults and their basis. Where a default needs data, the mathematics advisor runs a pilot study first and the plan records its result. When the user delegates a default to such a study, record the advisor's decision with its evidence and limits, subject to the user's override;
- every decision the user must take;
- the jobs, split by module so that parallel jobs own disjoint files, each with its completion criteria;
- the verification policy and the test policy;
- what each notebook will show. The notebooks themselves are written in the release step.

Triage comes first: decide what will be built or fixed before anything is derived. (NWQLib 0.99: one round derived first and triaged afterwards, and about 380 lines of derivation went unused.) The mathematics advisor then writes the complete derivation of every mathematical item the plan can foresee into the plan itself. A derivation gives each step and every premise, covers every case the code can reach, and supplies text and code that can be copied without further derivation. For each item the plan lists every place that states it, such as docstrings, the guide, a constants registry, a mathematics document and notebook text. No derivation is left to the implementer or to a later stage. (NWQLib 0.99: the plan left some bounds to the implementer or to a later stage, and more than twenty advisor requests after dispatch were derivations for particular jobs.)

A second mathematics advisor thread checks the derivations and the code advisor checks the engineering. The user approves the plan before anything is dispatched.

## Test policy

Unless the project sets its own, the plan adopts this one. A test protects a public contract, or a scientific relation checked against an independent reference through a public workflow. It can also be a canary for behavior the library depends on, one test per failure mechanism that recurs, or a detector that a review names. Tests that pin a value or an old behavior, tests that only show that a change happened, and tests of notebooks or documentation are not written.

## Briefs

Write each brief with `write-implementation-job-prompts`. One set of common terms serves every brief:

- the environment and the checked runner, with the interpreter and its version, the base revision and the test command;
- one verification rule, taken from the plan's verification policy;
- the repository's rules (NWQLib 0.99: no AI-facing material in the repository, no AI attribution, no `git stash`);
- the rule for mathematics: the worker copies its derivations verbatim and derives none, also when it documents existing code. A derivation it lacks, or a step it cannot match to its package, goes to the principal as a request file, and the worker continues with the parts that do not depend on the answer;
- the plan's test policy. The witness before and after a fix is its regression evidence, and a permanent test is added only where the policy admits it. Before deleting or trimming a test, the worker checks against the mutation results that it is not the only detector of some probe;
- that the worker changes every place that states a claim it changes. Mathematical text copied verbatim from a derivation or statement package into documentation stays as it is and needs no writing review; the writing route covers the prose the worker writes itself;
- that before hand-in the worker has its change reviewed in the foreground by the code advisor's model, for code and engineering, since the principal sends the mathematics to the mathematics advisor, and starts no background agent. When the worker cannot reach that model, the principal runs the review at hand-in. When a background agent's completion notice reaches the principal anyway, the principal forwards the result to the worker.

Each brief adds:

- the task, and for a documentation job its readers;
- the worktree, branch and base revision, the files the job owns, and how to touch shared files (small, local edits);
- its derivation package, copied from the plan, and every place where each of its claims appears;
- the evidence: a witness (a call and its output, or an exact argument, that shows the defect) before and after each fix, and a failure before the fix for each new test that the test policy admits;
- the checks: the test files that cover the modules it changes and the related mutation probes (registered deliberate defects that some test must catch), and no full suite. The principal runs the full suite that an entry-point change needs;
- the expected duration, the completion criteria and the report format;
- a stop condition that names a deliverable, not an open-ended process.

Every report gives each item's disposition and its evidence, the sentences the job changed, and anything left over with a suggested owner. A fix brief also records the principal's decision on each finding, and its report gives one disposition per finding: fixed, fixed differently with a reason, or not a defect with counterevidence.

Every implemented formula carries its derivation steps, assumptions, error bound and source in the docstring or comment at its definition, copied from the advisor rather than cited, because the review side reads the code and not the advisor's answers.

Mathematics that appears only while jobs are designed is derived before dispatch and added to the plan. Every request, to a worker or to an advisor, states its audience and scope. (NWQLib 0.99: a request for the library-wide mathematics document did not say "the whole library", and the run was restarted.)

## Scheduling and assignment

- Schedule by inputs, not by job order. A sub-task starts as soon as its code and derivations exist, even while its parent job waits on another part, from the branch that already holds what it needs. Split a job that is half blocked.
- Each job goes to the worker of the competency its correctness rests on, with the derivation package of its mathematics; a job that needs two competencies is split by module. A worker on the principal's host runs as a subagent. A worker in another vendor's app works in a new thread that the principal opens; the job's mathematics then goes to a separate mathematics advisor thread, and the principal runs its code advisor review.
- At each dispatch, set the role's model and reasoning level explicitly. Where a subagent inherits the parent's level unless its agent definition sets one, dispatch through definitions that set it.
- Jobs run in parallel only when their files are disjoint.
- Code and documentation of the same area never run in parallel, because code goes through several review rounds that each find many problems, and documentation written alongside only waits for rework. Different areas can run in parallel.
- Notebooks are written once, in the release step, because they show the output of every module and any earlier change ripples into them. (NWQLib 0.99: 38 commits changed the notebooks during development and the first two fix rounds.)

## Documentation jobs

Before an area's documentation is written, the mathematics advisor writes one package of every mathematical statement that documentation needs, reconciled with the implemented code, and the writers copy from it. (NWQLib 0.99: several earlier derivation texts had been superseded by later corrections or described more than was implemented.) Assign reader-facing prose by the strengths of the models. (NWQLib 0.99: documentation written on the mathematics advisor's model was accurate but read like a specification, so the user moved the rewrite to the code worker's model, which copied every mathematical statement from the advisor.)

## Requests to the mathematics advisor

- A worker's request file gives the relation, where it is used, what is known and what the worker suspects.
- The principal's request gives the context, the exact relation in the code, what is measured, what is needed, the limits on computation and on the repository, and the answer file to write. It points the advisor at a pinned snapshot worktree on its own branch with the checked runner, because a branch in use moves under the advisor and invalidates the runner's revision.

## Hand-in

When a code worker's job contains mathematics, the principal sends its diff and mathematical items to the mathematics advisor, which checks every branch against the derivation's premises and every text against the derivation.
