---
name: research-watchdog-protocol
description: Monitor requested long-running jobs or recurring checks, and support requested research continuity or unattended operation using native task and scheduler state. Use for HPC monitoring, stall recovery, and multi-session handoffs. An ordinary long experiment does not by itself require a new orchestration workflow.
---

# Research Watchdog Protocol

Check whether the monitored work is running as expected and whether intervention
is justified. Prefer scheduler/job state, native task status, exit codes, and
existing logs before adding a custom heartbeat.

For requested coordination across sessions, use
[research-continuity.md](references/research-continuity.md). For requested
unattended work, use [unattended-operation.md](references/unattended-operation.md).
These optional modes support task operations; they do not impose a research
method, log, or monitoring layer on ordinary work.

## Monitoring scope

Identify the actual task or job, expected output cadence, normal runtime or
progress signals, and the user's notification and retry preferences. Reuse
existing authorization; ask only when a necessary action falls outside it.
Use an available persistent scheduler for recurring monitoring and do not claim
background execution without one.

For custom state or existing file-based records, read
[approval-and-state-contract.md](references/approval-and-state-contract.md).
Use native task/scheduler state for new monitoring when it supplies the needed
evidence; existing records do not require migration.

## Checks

- Inspect cheap, relevant health signals: scheduler status, recent bounded log
  tails, heartbeat age where one exists, expected artifact metadata, and exit
  status. Parse result contents only when that check is needed to diagnose a
  failure; do not reread large datasets on every poll.
- Distinguish active work, expected delay, a stalled worker, failure, completion,
  and an intentional pause. A process ID alone does not prove progress, and no
  new output during a long kernel does not prove a stall.
- Derive stale and retry thresholds from expected work, cadence, and cost. Do not
  classify a run from a universal number of unchanged checks.
- A completed process may still require scientific validation. Report that
  distinction without calling normal deferred validation an operational failure.

## Actions

Report or notify on meaningful changes, completion, failure, or required user
action. Stay quiet when healthy or non-actionable state is unchanged unless the
user requested periodic reports. Keep only the monitoring history needed for
recovery and diagnosis; native state or a compact snapshot is often sufficient.

A monitor can send an authorized bounded nudge or recommend a repair. The worker
or orchestrator executes repairs and compute actions within the approved scope
and remaining budget. Do not restart a paused task, duplicate an uncertain job,
or infer new spending authority from the absence of the user.

Operational monitoring never modifies scientific conclusions, invents missing
data, or certifies correctness. Escalate the precise unresolved blocker when
needed; do not wrap every status update in a mandatory safety checklist.
