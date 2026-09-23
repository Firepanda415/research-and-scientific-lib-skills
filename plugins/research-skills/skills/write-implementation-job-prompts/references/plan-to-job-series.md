# Turn a plan into executable jobs

Use for a requested implementer job series. Preserve the plan's required outcomes
and split work where there is a real dependency or an independently reviewable
change. Do not create a series merely because a task has several steps.

## Principal responsibility and consultation

The principal owns the integrated design and acceptance. User goals and explicit
constraints govern the work; provisional plans, APIs and worker READY judgments
remain revisable when evidence shows they fail the intended relation. Carry a
correction to affected jobs rather than leaving conflicting instructions active.

Distinguish consultation on a consequential, sufficiently developed plan before
implementation, diagnosis of a persistent unresolved problem, and independent
acceptance of the actual implementation at a fixed revision. They answer different
questions. For consultation, provide the concrete uncertainty, relevant evidence,
attempted remedies when applicable, and the decision another perspective could
change. The principal adjudicates the answer and proceeds; do not seek repeated
agreement or READY tokens, or consult on every ordinary prompt revision.

Choose expertise by the task and unresolved failure modes, not permanent model
brand roles. Model agreement is not independent scientific evidence. Consultation
and delegation still require current authorization and available capabilities;
writing a job series does not authorize external messages, extra agents or compute.

## Dependencies and scope

Identify what each job produces and what another job consumes. Independent jobs
may run in parallel; file overlap is an integration concern, not automatically a
causal dependency. Keep inseparable changes together when an intermediate state
would be invalid or untestable. Priority, owner, rollback, and evidence needs
inform the split without a numeric scoring rule.

A short job table may capture outcome, dependencies, owner/scope, and acceptance.
Use a clause ledger or immutable contract revisions only for a plan whose size or
governance needs that traceability. Do not silently drop an authorized outcome.
When jobs address reported findings, map each finding to a job or a recorded
disposition before dispatch. Leaving one out of scope or deferred requires a
decision by the user, a maintainer, or an authoritative project contract, and the
user's request may already set that scope. Finishing the job set or passing the
suite does not close an unmapped finding.
Record a deferred obligation where it will actually be revisited rather than in
several overlapping ledgers.

## Refresh before dispatch

Verify the relevant live baseline and prerequisites when a job becomes ready.
Do not freeze later commands or file lists before earlier work changes the tree.
Reuse already-delivered work and avoid duplicate owners. A coherent replacement
prompt should identify what it supersedes if requirements change.

Once a job's authority, outcome, owner, starting state, and sufficient checks are
clear, dispatch when authorized. Prefer implementation evidence over further
prompt revisions. Empirical uncertainty calls for a discriminating check.

## Migration and final acceptance

Track temporary coexistence, compatibility promises, and deferred validation only
when they actually exist. Name who or which job retires the temporary state and
what evidence establishes completion. A focused test run is not automatically a
debt to run a full suite; use the project's requirements and affected behavior.

When cumulative outputs matter, distinguish the program baseline from a job's
local baseline. Final acceptance checks required outcomes, intended artifact
changes, and remaining temporary obligations. Additional mutation probes, scan
controls, byte-identical goldens, and full closure batteries apply only when the
project or a real evidence gap requires them. Do not turn closure into unrelated
cleanup.
