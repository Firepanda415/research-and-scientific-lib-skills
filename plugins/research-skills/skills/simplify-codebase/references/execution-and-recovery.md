# Execution and Recovery

Purpose: retire each proved obligation completely, validate affected behavior,
and leave a recovery path proportional to the side effects.

## Choose a reviewable cut

Prefer one high-confidence ownership boundary over a mixed cleanup batch. The selected change should retire a complete obligation and have a decisive check. If investigation reveals a larger product choice or broader migration than the user authorized, present the ranked plan and obtain one scope confirmation before applying it.

Pause application when dynamic or external consumers remain unknown, stored data lacks a migration story, baseline failures erase the intended signal, the cut crosses unrelated ownership boundaries, or rollback would be impractical. Convert the result into an evidence report with the exact missing decision or fact.

## Remove the obligation vertically

Follow the contract from outside inward and back out. Account for:

- public declaration, schema, route, command, option, or manifest;
- registration, dispatch, parsing, and compatibility paths;
- implementations, adapters, state, caches, events, and cleanup;
- imports, exports, packages, build and generated inventories;
- migrations, fixtures, examples, documentation, and operational configuration;
- tests dedicated to the retired behavior and tests protecting the surviving contract;
- dependencies and scripts that become unnecessary.

Delete compatibility glue when no compatibility obligation exists. When one does exist, preserve it or provide an explicit migration with an end condition. Do not replace two representations with a new synchronization layer.

Keep unrelated working-tree changes intact. Commit, push, publish, deploy, or
alter protected environments only when the user's existing authorization covers
the action; do not request the same permission again.

The cut is structurally complete when every affected declaration, consumer, artifact, owner, and compatibility obligation is either changed, deliberately retained with a reason, or explicitly excluded as outside scope.

## Choose proportional verification

Start with the decisive check and the diff. Add checks below only when the cut
affects the corresponding contract, a repository rule requires them, or unresolved
risk justifies them. A focused private-code deletion need not run every layer.

1. **Residue check**: search removed names, strings, paths, formats, flags, and docs. Delete or update each hit that exists only because of the retired obligation, including a note, comment, or test added only to record the removal. Hits in a compatibility path or migration kept under the compatibility rule in the previous section stay, as do hits in changelogs, migration notes, attributions, and dated logs. The search is a one-time check and does not become a permanent test.
2. **Decisive check**: run the smallest test or probe that would fail if the cut were incorrect.
3. **Lead check**: re-run any analyzer or query that produced the original candidate.
4. **Local gates**: run required package gates and checks for the affected behavior.
5. **Repository gates**: run the broader relevant suite when cost and scope justify it.
6. **Boundary comparison**: compare public output, persisted representation, wire behavior, operational lifecycle, and user-visible behavior.
7. **Diff audit**: inspect every changed file, whitespace integrity, generated artifacts, and dependency lock changes.

When the simplification claims a latency, throughput, memory, startup, or other performance effect, add a controlled before-and-after measurement whose workload and environment make that claim meaningful.

Summarize routine checks. Distinguish material untested boundaries when they
limit the claim; passing a unit test does not establish deployment or acceptance.

If a post-change check fails, compare it with the baseline and decide whether the failure was pre-existing, the implementation is incomplete, or the candidate was load-bearing. Repair the current batch or undo it using the recorded recovery path. Preserve the meaningful check and revise the proof instead of weakening the gate to make the deletion pass.

## Report the result

For a focused change, report the cut, decisive validation, and any material
remaining risk. For broad changes, migrations, or consequential side effects,
use the relevant parts of this receipt when they help review or recovery:

```text
Scope: ownership boundary changed
Baseline: commands and pre-existing failures
Retired obligation: contract, state, layer, or dependency removed
Artifacts: files and generated outputs changed
Realized net effect: concepts, artifacts, lines, and dependencies removed minus replacement or migration machinery added, where measurable
Behavior: preserved and intentionally changed observations
Verification: exact commands, probes, and results
Residual risk: untested boundaries or external uncertainty
Retained candidates: high-value items kept and why
Undo: files or commit range to reverse and any data/config restoration required
```

The undo path must match the side effects. Source-only changes may be reversible
from the diff; migrations, published packages, deployments, and durable data
need an appropriate restoration plan and authorization covering those effects.

The batch is complete when the intended cut is implemented, the affected
contract has suitable verification, and the diff and recovery path are understood.
State unavailable evidence and its limitation without expanding a small change
into unrelated validation or documentation work.
