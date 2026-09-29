# Integration and review rounds

Read when integrating a job, preparing or requesting a review round, or planning a fix round.

## Graded integration checks

A full suite runs before each review, and at an integration only in the third and last cases below. The release step says when it runs at the release.

- A fast-forward to the tree the worker tested: check the diff scope only.
- A rebase that brings in only files the job does not own: run the job's tests, the repository-wide consistency tests (tests of the whole repository's registries and documentation references), the linter and the project's policy lints (its own lints of the source and the rendered documentation).
- A rebase that touches the job's code files, or that needed conflict resolution: run the full suite.
- A documentation-only change: compare the syntax trees without docstrings, and run the strict documentation build and the policy lints.
- A job that changes an entry point every extension passes through: the principal runs the full suite before integrating it.

Before a rebase, make a backup branch at the worker's final revision, and resolve conflicts from the intent of both sides. After integrating, log the revision and the check results in the ledger, and tell the jobs still running their new base. On one machine, full suites run one at a time, because concurrent runs slow each other; different platforms run in parallel. Every leftover gets an owner in the ledger at once. (NWQLib 0.99: at least 198 full suites ran on one machine, 12.2 hours, where one run per integration that changed library code would have been about 38. None of the principal's 50 runs failed, and five concurrent runs took up to 313 seconds for tests that took 178 alone.)

## Before each review

- Run one full suite on each supported platform whose code path changed (see the expensive checks below), all platforms in parallel, unless one already ran on the same tree, dependencies and platform.
- The mathematics advisor checks only the mathematics the round changed, with its code: the changed items, the principal's decisions and the changed texts. It does not widen into mathematics the round did not touch.
- Before a review of fixes, the fix list gives each item with its disposition and commits, what each commit changes (code, tests or documentation), the owner and scope of each deferred item and who decided it (the user, or the principal and the counselor under the step 0 delegation), and the open questions. The reviewers check each entry against its commits. (NWQLib 0.99: a deferral recorded only in the principal's ledger, which the reviewers do not read, reached the review as an item without an owner.)

## The expensive checks

A full suite on a platform and the mutation campaign are the expensive checks. Wherever this skill calls for one, at an integration, before a review, at the release or for any change after the release checks, whether a fix of a late finding or work the user adds, the principal judges from the diff since the check's last run whether the change can alter its result, and a change that cannot leaves the last run standing. The integration grades and the before-review rule apply this at their steps. The principal takes the judgment itself, reports it, and records the commit each check ran on and what changed after it, in the validation record and the pull-request text. (NWQLib 0.99.1: two changes after the release checks, a documentation policy and a one-module fix of archive reopening, needed one full suite on one platform, and the principal judged this only when the user asked.)

- A full suite on a platform reruns for library code that platform's run exercises. A platform's code path is what its run exercises and the other platforms' runs do not, such as a native simulator or a platform-specific dependency; a change to platform-independent code needs the suite on one platform, and a change to an entry point every extension passes through gets it, as at integration.
- The mutation campaign reruns for a change that can lower what the tests detect: a test deleted, trimmed or weakened, a probe added or moved, or a change at a probe site or on the path from its killing test to it. A change that only admits more inputs, or changes text, leaves the campaign's result standing.
- Documentation, notebooks and the version number need only the checks of their own files.

## The review round

- The principal requests each round from fresh reviewers on the advisor models chosen at step 0: the code advisor's model for code, engineering and the user's side, the mathematics advisor's model for the mathematics and the independent check against the previous release. A reviewer on the principal's host runs as a subagent; one on another vendor's model runs in a new thread. A round with one job merges the job review and the round review into one review that keeps the user-side and previous-release checks. (NWQLib 0.99.1: the round review's value was the interaction and comparison coverage: its one P2 finding sat where a 0.99 mechanism met the new contract, which no job review could see, and both reviewers found it independently.)
- Each request is a file the reviewer rereads, self-contained: the operating rules (what to read first, the checked runner with its literal command words, the write and Git restrictions, workload limits, that it does not operate the other vendor's app, and that recorded outcomes are hypotheses to test), a fixed review ref of its own, the interfaces to exercise, one combined workflow, the interruption boundaries, the comparison protocol, the output file, and a coverage-gaps section for the report. The request is neutral: revision, scope, recorded decisions, environment and output, without the implementation working files, the worker reports or the advisor's answers. The counselor checks the requests before they go out ([counselor.md](counselor.md)). When a rule changes, the principal changes the request file as well as telling the reviewer. (NWQLib 0.99, when each review ran in a session of its own: the file that session reread still gave it control of the vendor app after the rule had changed, because the change had reached it only as a message, and the user had to shut the session down.)
- The review has a ref that nothing moves. A checked runner that resolves a named ref on every call would let a concurrent integration change the code under review.
- The reviewers use the project's review workflow, such as `scientific-library-review` with the project's review profile, under the scope restrictions below, including that closed items are not reported, in place of a disposition for each finding.
- Shared context stays minimal. A reviewer reads the plan and the recorded decisions, the project's review profile and environment records, the code, its documentation and notebooks, primary sources and its own runs. The plan's derivations are claims it checks, not settled facts. Turn off cross-session memory features of its models, which could carry implementation context into the review.
- The principal merges the findings, reruns the witness of every P1 finding (a wrong result or crash on a supported path) and P2 finding (wrong under a documented edge, or misleading), triages them, and sends the merged triage to the counselor before any fix is dispatched. The verification of the fixes goes back to the round's reviewers as a continuation, or to fresh reviewers with the same request material when a thread is spent; the principal does not judge its own fixes.
- A finding gives its severity, file and line, a witness, the smallest change and an impact sentence: who meets it in ordinary use and what goes wrong for them. Every mathematical finding comes with a complete derivation from the mathematics reviewer.
- A review of fixes checks only what the fixes changed and the other places that state the same claims, and does not widen into new areas.
- The reviewers do not report what the principal would not change anything for, such as a fix that passes perfectly. An item they do not report needs no further change. A round with nothing to change ends with one line saying so.
- A reviewer writes its report to the file its request names. Where the host refuses a subagent that write, the reviewer returns the report as its final message and the principal saves it unchanged.

## From the user's side and against the previous release

- An end-to-end review from the user's side runs in a fresh session, in the first review round and again before the release. It starts from the guide and the notebooks as a new user would, uses only the public API, and completes the whole workflow, such as planning, solving or estimating, reading the results, saving and loading. It also runs one set of ordinary workloads on the current revision, the revision of the first review and the previous release, and compares which inputs are newly refused and how results, time and memory changed. (NWQLib 0.99: a sweep of ordinary inputs showed that a mathematically sound range policy refused 7 of 36 ordinary problems.)
- The user-side review also reports the cost of the user's stated end-to-end problems at this revision, in time, memory and refusals, because a review of the contract alone accepts workloads no user would run. (NWQLib 0.99.1: three rounds accepted a scan over 4^14 sign patterns, which the principal's own end-to-end example then exposed.)
- An independent check of the whole change against the previous release runs in a new mathematics advisor thread, in the first review round and again after the fix rounds converge. (NWQLib 0.99: this check, run once at the end, found a defect that four review rounds had missed.)

## Fix rounds

- After each review the principal presents the findings item by item with its triage, checked by the counselor, and the user decides.
- A limitation a reviewer or verifier finds is a triage item, pre-existing or found late included. When its fix is small, the user decides whether it is fixed now or deferred, or the principal and the counselor together when the user is away; the principal does not defer it alone.
- A mathematical finding is derived by the mathematics advisor as an addendum to the plan before any job is dispatched.
- Engineering findings go to code workers by module, and each fix changes every place that states its claim.
- A detector is added only for a public contract or where the review names one. It must fail when the fix is undone, on the path where the defect lives. Before a test is deleted or trimmed, check against the mutation results that it is not the only detector of some probe.
- When a fix replaces a validation with a cheaper one, the verification request asks the reviewer to enumerate, in its first pass, the input classes the old validation covered, rather than rerun only the finding's witness. (NWQLib 0.99.1: two verification rounds each found the next input class the replacement mishandled.)
- A reviewer's smallest change is smallest for one finding. Judge the accumulated chain at every partial, as the circuit breaker says; when the chain has become a design change, the mathematics advisor derives the alternatives and the counselor takes the decision with the principal.
- Steps 2 to 6 follow.
