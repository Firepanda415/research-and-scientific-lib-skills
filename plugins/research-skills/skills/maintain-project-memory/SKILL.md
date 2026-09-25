---
name: maintain-project-memory
description: Maintain project memory by reconciling current decisions, evidence, unresolved work and reusable lessons. Use when asked to organize project memory, retain lessons, update long-term decisions or establish a durable project entry. Reading memory to perform an ordinary task does not itself authorize updates.
---

# Maintain Project Memory

Leave enough accurate context for a later session to make the next decision
without reconstructing the whole conversation. Preserve knowledge that changes
future work, rather than a transcript of activity.

## Find the current owners

An owner is the authoritative record for a fact or decision. Read the user's
request, the existing project entry and the records relevant to the requested
update. Verify important current claims against live source, configuration,
decisions or evidence. Follow replacement links when old paths have moved; a
remembered filename is not a reason to recreate a retired file. When a record
routes work through a skill or other host-installed workflow, refer to it by
catalog name, such as `plugin:skill`, and let the host resolve it. When
reconciling such a record, replace an install or cache path with that name.
Project source paths are outside this rule. Report a missing owner or evidence
source without inventing its contents.

Distinguish user requirements, current design decisions, observed results,
proposals and historical reports. Plans and successful runs cannot establish
scientific truth or override current user intent. A historical action permission
does not by itself authorize a new run, external message or behavior change.

Use the project's existing locations and access rules. Public contracts belong
in public documentation; private coordination and project history belong in
project memory; temporary reports retain the evidence needed for their claims.
These are responsibilities, not a required directory structure. Keep private
paths and agent instructions out of public user documentation. Read only the
history needed to resolve the update, not all logs or large research outputs.
Where a project has always-loaded instruction files, keep them compact and
limited to rules that must steer every session. Put longer lessons, rationale
and evidence in linked records, and keep one authoritative copy when several
hosts read the same project.

## Select knowledge worth keeping

Retain confirmed, nontrivial facts that could change a future decision:

- A failure mechanism, the condition that exposed it, the prevention rule at
  its actual owner, and the domain where the lesson applies.
- A decision's rationale, relevant rejected alternative, consequence and the
  condition under which reconsideration would make sense.
- An accepted result's source/revision, workload or assumptions, evidence
  location and limits. Record a later unresolved finding alongside earlier
  acceptance when their scopes differ; neither erases the other.
- Unresolved work and user-approved deferrals, with the remaining question and
  the next action only when it is actually known and authorized.

Prefer a short causal note and evidence link. Do not record routine typos,
repeated principles, transient progress or an unverified hypothesis as a lesson.
Keep hypotheses and proposals visibly provisional when they are useful to retain.
A concrete incident may illustrate a general mechanism; it does not justify a
universal restriction, permanent test, new runtime check or recurring experiment.

Write entries as current guidance. Before adding or rewriting a rule, identify
the mistake a later session would make without it, and leave out a rule that
prevents none. A removed or rejected option belongs in memory only inside the
decision that excluded it, with the reason and any condition for reconsidering
it, or when the user explicitly asks to keep it out. An item removed only
because it is no longer needed leaves nothing to record. Record a temporary
arrangement, such as a workaround awaiting an upstream fix, as current status
that names the condition ending it, rather than as a project convention.

## Reconcile rather than append

Choose whether each relevant record needs an addition, correction, replacement
link or removal. Decisions and evidence may be marked historical. Remove
superseded operating guidance in active entries (routes, commands, environment
names, conventions, branch or revision status, job states, retired gates)
rather than relabeling or inverting it, and do not reimport it. When a removed
item or an ended arrangement leaves no current requirement, delete in the same
update every rule, index line and reference that existed because of it, and
add nothing in their place. For example, when a folder prepared for one meeting
is deleted, delete the rule that kept it in sync instead of rewriting it as
“ignore that folder.” Keep one current owner for
each decision and link to it from readers that need it. Preserve unique
rationale and evidence before consolidating records; respect immutable history
and user-owned files.
Do not delete raw research evidence merely because a summary now exists.
If the user authorizes pruning evidence, keep the remaining originals unmodified
and record their sources, with hashes when later readers must check integrity.
Mark claims resting only on a summary as no longer re-checkable.

Separate current status from durable lessons. Keep a historical command,
environment version or test total only as scoped evidence for a current claim,
and direct future execution to the live environment owner. Historical plans and
unresolved possibilities do not become a dispatch queue merely by appearing in
memory.

Reuse the existing entry and naming conventions. Create a new record only when
the topic and its reader justify it. Keep rationale meant for the coordinating
agent or user separate from task instructions handed to implementing agents,
where the project makes that distinction.

Project memory loads only in its own project. Flag records you read during the
update whose scope exceeds the project, such as a user-wide preference, a model
or tool default, or host behavior, and propose moving them to global
instructions. After an authorized move, replace the project copy with a pointer.
A record explicitly limited to this project stays in project memory.

Write only within the user's requested memory scope and the host's persistence
rules. If the host requires proposed update notes instead of direct memory
edits, use that mechanism and distinguish proposed updates from applied ones. In
a host whose memory keeps every note, each correction names the earlier notes or
claims it supersedes. This workflow does not authorize source changes, new
research runs, issue publication, global memory updates or periodic maintenance
outside that scope.

## Verify the handoff

Check that the updated entry reaches the current owners, referenced evidence and
protected artifacts exist where claimed, superseded instructions no longer steer
new work, and unresolved obligations remain visible. Before recording an
artifact as protected or reusable, confirm that its location survives restarts
and routine cleanup. For a temporary location, record how to rebuild the
artifact or that it cannot be rebuilt. Do not mark a finding resolved from a
worker receipt or green suite alone. Resume state for continuing an in-progress
task, such as a running job or an unfinished proof, belongs to
`research-watchdog-protocol`.

For a substantial reorganization, consider a bounded cold-start handoff check:
give a fresh session the entry and a realistic next task, then inspect whether
it finds the right owners, evidence limits and action boundaries. Use delegation
only when available and authorized; otherwise inspect the same path locally. A
delegate should load the project instructions a new session would (in Claude
Code, not the built-in Explore or Plan agents, which skip the project
instruction file), receive only the entry and the task, and report which
instruction sources it had. A subagent only approximates a new session. Do not
launch the underlying experiment just to test the memory.

Report the actual records changed, important corrections, retained uncertainties
and the handoff checks performed. Distinguish link/source checks from demonstrated
successful use by a fresh session.
