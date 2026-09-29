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
- Before fixes are dispatched, the counselor reads the merged triage with the reviewers' reports and witnesses, keeps or changes each disposition, and adds the closure requirements and an owner for every gap. The verification of the fixes then goes to the reviewers, as [integration-and-review.md](integration-and-review.md) says.
