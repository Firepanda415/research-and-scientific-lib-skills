# Monitoring authority and optional state format

The user's instructions and host action rules determine authority. Unattended
operation does not expand it; an existing bounded authorization remains valid
without repeated confirmation. No monitoring file can create or revoke that
authority by itself.

## Operational boundary

Monitoring reads health signals, reports meaningful changes, and can send bounded
nudges already authorized by the workflow. A worker or orchestrator performs
repairs or restarts within the approved task, retry conditions, and remaining
compute budget. Resolve uncertain job state before resubmission to avoid
duplicate work. Never auto-restart an intentionally paused task.

Ask only when the next necessary action exceeds existing scope or budget, lacks
needed authorization, or depends on a user decision. A minor local diagnostic
already within scope does not need a new action-specific record. External
messaging, publication, and destructive changes follow their actual permissions.

The watchdog reports operational health, not scientific validity. An authorized
worker may interpret evidence and revise a scientific claim; the monitor does
not perform that analysis or substitute a health label for it.

## Native state first

Use scheduler IDs, task status, exits, bounded logs, and artifact metadata where
available. Record only information that native state does not supply. Choose
monitor cadence, stale thresholds, retry limits, and retention from expected
runtime, normal artifact cadence, costs, and notification preferences.

For custom records, distinguish task lifecycle from monitoring health. A useful
snapshot contains the checked task, observation time, actual health evidence,
and any necessary next action. Missing optional validation records do not turn a
successful process into an operational failure.

## Existing file-based records

These notes interpret records written by earlier file-based deployments of this
watchdog workflow (format version 1.0). A new monitor need not create them. Prefer
[native state](#native-state-first) and preserve historical data without migration.

- `watchdog_config.json` records task paths, the heartbeat path, expected
  artifacts, freshness/progress thresholds, nudge limits, and documented actions
  or preapprovals. These records do not create authority or require renewed
  approval; use the user's actual scope and budget.
- Each JSONL line is an object with an ISO 8601 `ts`. `heartbeat.jsonl` contains
  `source`, `event`, and `detail`; `seen` indicates liveness, while other deployed
  event labels describe workflow changes. They are not invalid merely because
  they differ from `seen`.
- `health_snapshot.jsonl` records `task`, `last_seen`, `missing_artifacts`,
  `stale_reason`, `recommended_action`, and monitoring `health_status` (or the
  older `status` field). This health label is separate from task lifecycle.
- `nudges.jsonl` records bounded nudges; legacy records mark
  `does_not_change_science=true`. `escalations.jsonl` records the task, reason,
  evidence, recommended options, and `requires_human_decision=true`.

Read only the records needed for the current check; do not scan growing logs on
every poll or restart completed work because an old format differs.
