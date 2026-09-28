# Integration and review rounds

Read when integrating a job, preparing or opening a review round, or planning a fix round.

## Graded integration checks

A full suite runs before each review, and at an integration only in the third and last cases below. The release step says when it runs at the release.

- A fast-forward to the tree the worker tested: check the diff scope only.
- A rebase that brings in only files the job does not own: run the job's tests, the repository-wide consistency tests (tests of the whole repository's registries and documentation references), the linter and the project's policy lints (its own lints of the source and the rendered documentation).
- A rebase that touches the job's code files, or that needed conflict resolution: run the full suite.
- A documentation-only change: compare the syntax trees without docstrings, and run the strict documentation build and the policy lints.
- A job that changes an entry point every extension passes through: the principal runs the full suite before integrating it.

Before a rebase, make a backup branch at the worker's final revision, and resolve conflicts from the intent of both sides. After integrating, log the revision and the check results in the ledger, and tell the jobs still running their new base. On one machine, full suites run one at a time, because concurrent runs slow each other; different platforms run in parallel. Every leftover gets an owner in the ledger at once. (NWQLib 0.99: at least 198 full suites ran on one machine, 12.2 hours, where one run per integration that changed library code would have been about 38. None of the principal's 50 runs failed, and five concurrent runs took up to 313 seconds for tests that took 178 alone.)

## Before each review

- Run one full suite on each supported platform whose code path changed, all platforms in parallel.
- The mathematics advisor checks only the mathematics the round changed, with its code: the changed items, the principal's decisions and the changed texts. It does not widen into mathematics the round did not touch.
- Before a review of fixes, the fix list gives each item with its disposition and commits, what each commit changes (code, tests or documentation), the owner and scope of each deferred item and who decided it (the user, or the principal and the counselor under the step 0 delegation), and the open questions. The review principal checks each entry against its commits. (NWQLib 0.99: a deferral recorded only in the principal's ledger, which the review side does not read, reached the review as an item without an owner.)

## The review round

- Each round runs in a new review session. Its handoff file, which it rereads, states every rule it works under, including that it does not operate the other vendor's app. When a rule changes, the principal changes that file as well as telling the session.
- The review side uses the project's review workflow, such as `scientific-library-review` with the project's review profile, and the handoff states the scope restrictions below, including that closed items are not reported, in place of a disposition for each finding.
- Shared context stays minimal. The review side reads the plan and the recorded decisions, the project's review profile and environment records, the code, its documentation and notebooks, primary sources and its own runs. It does not read the implementation working files, the worker reports or the advisor's answers. Turn off cross-session memory features of its models, which could carry implementation context into the review.
- The review principal writes the requests to its verifiers, runs them, and merges and verifies the findings. It reruns the witness of every P1 finding (a wrong result or crash on a supported path) and P2 finding (wrong under a documented edge, or misleading). It changes no code.
- A finding gives its severity, file and line, a witness, the smallest change and an impact sentence: who meets it in ordinary use and what goes wrong for them. Every mathematical finding comes with a complete derivation from the review side's mathematics verifier.
- A review of fixes checks only what the fixes changed and the other places that state the same claims, and does not widen into new areas.
- The review side does not report what the principal would not change anything for, such as a fix that passes perfectly. An item it does not report needs no further change. A round with nothing to change ends with one line saying so.
- The review principal sends the path of its report to the principal.
- Requests from the review side to the other vendor's model go through the principal, as [other-vendor-app.md](other-vendor-app.md) describes.

## From the user's side and against the previous release

- An end-to-end review from the user's side runs in a fresh session, in the first review round and again before the release. It starts from the guide and the notebooks as a new user would, uses only the public API, and completes the whole workflow, such as planning, solving or estimating, reading the results, saving and loading. It also runs one set of ordinary workloads on the current revision, the revision of the first review and the previous release, and compares which inputs are newly refused and how results, time and memory changed. (NWQLib 0.99: a sweep of ordinary inputs showed that a mathematically sound range policy refused 7 of 36 ordinary problems.)
- An independent check of the whole change against the previous release runs in a new mathematics advisor thread, in the first review round and again after the fix rounds converge. (NWQLib 0.99: this check, run once at the end, found a defect that four review rounds had missed.)

## Fix rounds

- After each review the principal presents the findings item by item with its triage, and the user decides.
- A mathematical finding is derived by the mathematics advisor as an addendum to the plan before any job is dispatched.
- Engineering findings go to code workers by module, and each fix changes every place that states its claim.
- A detector is added only for a public contract or where the review names one. It must fail when the fix is undone, on the path where the defect lives. Before a test is deleted or trimmed, check against the mutation results that it is not the only detector of some probe.
- Steps 2 to 6 follow.
