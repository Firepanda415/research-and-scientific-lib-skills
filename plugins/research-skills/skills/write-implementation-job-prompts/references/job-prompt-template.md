# Optional implementation handoff template

Use the fields that make the actual job executable; delete irrelevant sections.
For a small fix, the same information can fit in a few bullets. This is a
drafting aid, not a required contract schema.
Copy the text inside the block, fill every retained field, and remove
the surrounding instructions and fence from the delivered prompt.

```text
Problem and desired result:
{{CONCRETE_TRIGGER_CURRENT_BEHAVIOR_AND_DESIRED_RESULT}}

Current evidence:
{{LIVE_REVISION_OR_ARTIFACT_DEFINING_OWNER_AND_REPRODUCER_OR_FALSIFIER}}

Scope and constraints:
{{AUTHORIZED_WORK_EXCLUSIONS_AND_AFFECTED_INVARIANTS}}

Implementation:
{{EXISTING_OWNER_AND_NECESSARY_SOLUTION_BOUNDARY}}

Acceptance:
{{BEHAVIOR_OR_NUMERIC_RELATION_CHECKED_COMMANDS_ENVIRONMENT_AND_REQUIRED_GATES}}

Delivery:
{{REQUESTED_ARTIFACTS_VALIDATION_EVIDENCE_DEVIATIONS_AND_ACTION_BOUNDARY}}
```

Add exact starting SHA, closed file surface, owner counts, forbidden-work checks,
mutation/restoration gates, cumulative baseline, or plan-clause coverage when the
project or failure mechanism needs them. Do not require these fields for an
ordinary handoff. In NWQLib, carry the live external baseline/environment and
checked-command requirements into the prompt.

An unfinished placeholder draft is not dispatchable. A short complete prompt
does not need to pass the optional contract-style linter's larger format.
