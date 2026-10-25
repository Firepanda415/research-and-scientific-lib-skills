# The counselor

Read before a request to the counselor: a decision on the user's behalf, a round's review requests, or a merged triage.

## Decisions on the user's behalf

- The principal writes its proposed decision with the evidence and the alternatives as a request file and sends it to the counselor with the raw material: the reviews and their witnesses, the pinned worktree and the recorded decisions. It asks for the residual limits of the losing option as well, so that the record shows what was given up. (NWQLib 0.99.1: the counselor agreed with the principal's direction, found in it an omission that three reviews had not seen, and wrote the specification.)
- When they disagree, the advisor of the competency the question concerns reviews it again, such as the mathematics advisor's model for mathematics and scientific judgment, or a fresh reviewer on the code advisor's model for code and engineering. If the positions still differ, that model's judgment is followed.
- Record such a decision as taken by the two models, apart from the user's decisions. Record each disagreement with both positions, the second review and the outcome, and report it at the end, or earlier when the user is present.
- A disagreement that could force large rework stops the work that depends on it. Notify the user by the agreed channel and wait for the decision, continuing with independent work. If the counselor cannot be reached, the decision waits for the user.
- Agreement between the two models settles a decision; it does not verify a result. (NWQLib 0.99: an independent check of the principal's decisions on review findings reversed two of them and changed a third.)

## Review requests and the merged triage

The principal writes the requests of a review round and merges its findings, so the counselor supplies the independence that the implementing side cannot give itself.

- Before the requests go out, the counselor reads them with the raw material and checks that each is self-contained: the operating rules (what to read first, the checked runner with its literal command words, the write and Git restrictions, workload limits, and that recorded outcomes are hypotheses to test), a fixed review ref of its own, the interfaces the review must exercise, one combined workflow, the interruption boundaries, a matched comparison protocol against the previous release, the output file, and a coverage-gaps section in the report. (NWQLib 0.99.1: one such check returned nine corrections, two of which would have invalidated the run: the checked runner resolved the named ref on every call, and the format tags contradicted the user's decision.)
- Before fixes are dispatched, the counselor checks the merged triage against the reports and witnesses, confirms or changes dispositions, and names closure requirements for unresolved gaps. Code-fix verification returns to the assigned reviewers, as [integration-and-review.md](integration-and-review.md) says.
- A second consecutive follow-up job on one feature goes to the counselor before dispatch, as the circuit breaker says, with the accumulated changes and cost. A local correction whose scientific basis cannot be established returns to triage.
- Batch the requests and merged triage for the round. The counselor checks scope, alternatives, coverage and dispositions using the evidence needed to decide them; it does not commission another general technical or prose review. A mechanical update to an already checked request, such as filling its final revision, needs the principal's fact check. Return to the counselor when scope, coverage, authority, cost or the chosen disposition changes, or the circuit breaker applies. Record its duration and available usage in the existing ledger; independence has a cost and does not justify duplicating settled checks.
