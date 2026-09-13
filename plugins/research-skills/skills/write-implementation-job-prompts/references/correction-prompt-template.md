# Optional correction handoff

Replace conflicting instructions with one coherent current instruction. Identify
the previous prompt or artifact and the affected requirement; do not force a new
full contract when a short correction is sufficient.
Copy the text inside the block, fill every retained field, and remove
the surrounding instructions and fence from the delivered prompt.

```text
Supersedes:
{{IDENTIFIED_PRIOR_INSTRUCTION_AND_REPLACEMENT_SCOPE}}

Reason and current evidence:
{{VERIFIED_FAILURE_CHANGED_REQUIREMENT_OR_BASELINE_DRIFT}}

Required result:
{{CORRECTED_BEHAVIOR_AND_AFFECTED_INVARIANTS}}

Scope:
{{EXISTING_AUTHORITY_CURRENT_EDITS_TO_RETAIN_OR_REWORK_AND_BOUNDARIES}}

Acceptance and delivery:
{{DISCRIMINATING_CHECK_REQUIRED_GATES_DELIVERABLES_AND_DEVIATIONS}}
```

Reuse an existing regression witness when it covers the defect. A new review
comment does not automatically require a new test, owner counter, mutation, or
ledger. Rerun evidence the correction can invalidate; retain valid unaffected
evidence. If the project explicitly uses a closed contract, update its actual
scope and clauses and preserve the required baseline and runner.
