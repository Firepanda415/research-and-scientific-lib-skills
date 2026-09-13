# Turn a plan into executable jobs

Use for a requested implementer job series. Preserve the plan's required outcomes
and split work where there is a real dependency or an independently reviewable
change. Do not create a series merely because a task has several steps.

## Dependencies and scope

Identify what each job produces and what another job consumes. Independent jobs
may run in parallel; file overlap is an integration concern, not automatically a
causal dependency. Keep inseparable changes together when an intermediate state
would be invalid or untestable. Priority, owner, rollback, and evidence needs
inform the split without a numeric scoring rule.

A short job table may capture outcome, dependencies, owner/scope, and acceptance.
Use a clause ledger or immutable contract revisions only for a plan whose size or
governance needs that traceability. Do not silently drop an authorized outcome.
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
changes, and remaining temporary obligations. Mutation probes, scan controls,
byte-identical goldens, and full closure batteries apply only when the project
or a real evidence gap requires them. Do not turn closure into unrelated cleanup.
