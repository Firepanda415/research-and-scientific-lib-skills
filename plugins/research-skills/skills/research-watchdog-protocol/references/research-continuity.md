# Research continuity across sessions

Use when the user wants coordination or a reliable handoff across sessions,
branches, or linked deliverables. Reuse native task state, scheduler IDs,
repository state, and existing research records. Add a compact note only when
they do not preserve information needed to continue.

This guide owns the minimal resume state for continuing a specific monitored,
theory, or manuscript task. Record durable project decisions and reusable
lessons with `maintain-project-memory`, and observations or predictions with
`write-research-log`.

Retain the objective and scope, current result or unresolved uncertainty,
evidence/configuration locations, next action, actual blocker, and remaining
limits where relevant. Keep each fact in one place.

Keep prospective predictions distinct from exploratory findings when that
distinction matters. An ordinary reading or experiment does not require
preregistration. Preserve observations and material failed attempts; a current
summary can be updated without rewriting the underlying scientific record.

Judge progress from the task: normal runtime and scheduler state for an HPC job,
a proof obstacle for theory, or resolved claims for manuscript work. Apply the
stall rules in the skill's [Checks](../SKILL.md#checks) before treating quiet work
as a dead end. Change direction when evidence or actual stalled work
justifies it, not merely to make successive iterations different.

On resumption, verify the target task/revision, relevant action limits, and the
evidence needed by the next action. Read only state needed to continue, rather
than reparsing complete research logs or large outputs. Report missing evidence;
do not repair scientific content by guessing.

When parallel workers must pause, for example while the owner is offline, each
worker commits its finished part on its task branch when the job allows
commits, leaves unfinished edits in its worktree, and stops. A worker whose
commits and worktree do not show the next step first writes a compact resume
note in a location that survives a restart. On resumption, a message tells
each worker to read its note, if any, and continue. That message needs a host
that can resume a stopped agent with its context. Where the host cannot, each
worker writes the resume note before stopping, because a fresh agent started
for the task sees only the commits, the worktree, and the note. Committed work
also survives an unplanned restart.

Existing deployments may already have progress, hypothesis, finding, evidence,
decision, and verification files. Preserve their consumers and actual schemas
while maintaining those tasks. This optional guide does not require migration,
deletion, or creation of any such files. Task completion and monitoring health
remain distinct from scientific validity.
