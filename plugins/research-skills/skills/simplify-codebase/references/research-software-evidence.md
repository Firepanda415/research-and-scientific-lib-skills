# Scientific Software Evidence Conservation

Purpose: simplify research software without preserving a conclusion while
deleting the independent evidence that made the conclusion auditable.

Use this reference when a cleanup can change numerical claims, validation or
certificate semantics, resource estimates, experiment records, tests, mutation
probes, reports, examples, notebooks, documentation promises, CI gates, or the
dependency environment in which results are interpreted. Respect explicit
scope exclusions and do not reopen areas the user excluded.

## Separate three questions

Review these independently:

1. **Behavior conservation:** does the implementation still return the intended
   value or state?
2. **Evidence conservation:** can an independent witness still detect a wrong
   value, wrong path, or overstated claim?
3. **Interface truthfulness:** do structured records, rendered reports,
   examples, notebooks, and documentation describe the same quantity and
   execution that actually occurred?

A green remaining suite answers only the tests it still contains. It does not
show that deleted detectors were redundant, that generated artifacts execute,
or that human-readable output exposes the evidence present in an internal
record.

## Build a claim-to-evidence map

For every affected scientific claim, trace all applicable surfaces:

| Surface | Evidence question |
| --- | --- |
| Numerical implementation | Is there a closed-form, dense, hand-derived, published, or otherwise independent oracle? |
| Validation and certificates | What was evaluated, under which scope and tolerance, and what remains unresolved? |
| Resource accounting | What physical or logical quantity is counted, over which input (for example, circuit) population and lifecycle event? |
| Structured records | Are value, provenance, units, scope, and `not evaluated` states retained? |
| Rendered reports | Can a reader see the same caveats and quantities without inspecting `to_dict()`? |
| Serialization and replay | Can persisted evidence be reconstructed without silently strengthening its status? |
| Examples and notebooks | Does the real user entry path execute, and is its scientific narrative true for its actual options? |
| Documentation | Are current promises backed by code or a live detector rather than a deleted mechanism? |
| Tests and mutation probes | Which distinct defect class does each independent witness detect? |
| CI, scheduled checks, and dependency drift | Which future changes remain observable after a gate is removed? |

Do not treat one surface as a proxy for another. A JSON field does not prove
the report prints it. Byte-fresh notebook generation does not prove a Jupyter
kernel can execute it. A documented gate does not exist merely because its
name remains in a runbook.

## Audit the deleted evidence, not only the surviving code

For every removed test, assertion, fixture, probe, gate, scheduled workflow, or
report line:

1. Name the defect class it could detect.
2. Locate a surviving independent owner for that same defect class. When the
   project keeps mutation probes and the relevant mutant runs are cheap or
   approved, run those mutants on the current tree with and without the
   removal. Each mutant that a removed test killed must
   still be killed by a surviving test. Otherwise show that the relation it
   protected has no user-visible consequence, and retire the probes whose only
   killing test is removed.
3. Classify the deletion as `relocated equivalent`, `stronger replacement`,
   `true duplicate`, `obsolete contract`, `lost evidence`, or `unresolved`.
4. When cheap and safe, replay the deleted witness against an isolated copy of
   the current tree. A witness that still passes was not removed because the
   behavior disappeared; this is evidence to investigate its owner, not an
   automatic instruction to restore it.
5. For a removed mutation probe, distinguish a surviving test that detects the
   defect from a maintained measurement of mutation coverage. Preserve the
   measurement only when a current claim or project requirement needs it; a
   probe is not automatically permanent merely because it once supplied evidence.
6. For a removed gate, run or inspect the old check when practical and reconcile
   every documentation statement that claims the gate still exists. Retire the
   policy and its prose together, or keep a real owner.

Do not commit permanent migration-negative tests whose only claim is that an
old API, option, helper, filename, or field remains absent. Such checks are
one-time residue audits. Preserve a permanent test only when absence itself is
a current product, security, or compatibility contract.

## Reject self-certifying replacements

A replacement test is not independent merely because it uses a different
field name.

Reject or downgrade checks where:

- the same branch both decides whether work ran and writes
  `executed_count = 0`;
- two compared fields are copies of the same expression or list;
- an expected value is reconstructed through the production helper under test;
- a provenance label is asserted without checking the value or operation it
  labels;
- a broad status such as `WARNING` is asserted without scope or reason, so an
  unrelated warning would pass;
- a fixture is algebraically degenerate, causing the expected relation to hold
  even for a plausible wrong implementation;
- a loose default tolerance silently supplies the real acceptance window.

Prefer a separating fixture and one independent witness. Keep targeted
instrumentation when it is the only practical way to prove that simulation,
transpilation, dense materialization, network submission, or another forbidden
operation did not occur. A self-reported lifecycle counter is not equivalent
to observing the boundary.

## Audit numerical and statistical meaning

For a changed comparison, threshold, certificate, or resource law, use
`scientific-computing-correctness` as the owner of numerical, statistical,
source-to-code, and resource semantics. Its scientific contract, approximation,
verification, and retention rules apply to the affected computation.

This simplification audit adds the deletion-specific question: which surviving
independent witness still distinguishes the correct scientific meaning from a
plausible wrong one? Check that witness and the real consumer surfaces; a shorter
implementation or smaller remaining suite does not answer it.

## Exercise the real consumer environment

Use the project's pinned interpreter and confirm the imported source resolves
inside the checkout or worktree being reviewed. A green suite against an
editable install from another checkout proves nothing.

Run the boundary that users actually consume when it is affected:

- execute generated notebooks in a real kernel when notebook usability is a
  claim;
- run examples with their actual default and optional command-line paths;
- inspect both structured output and rendered text;
- verify version-relative links from the reviewed revision rather than a moving
  default branch;
- inspect scheduled and optional-dependency paths separately from ordinary CI;
- report skipped optional or large-instance reproductions as unverified rather
  than treating the suite total as coverage.

## Keep the review proportional

For a low-hanging-fruit request, remove only evidence-free fossils whose current
owner and consequence are obvious and whose focused verification is cheap.
Defer candidates that require rebuilding numerical oracles, replaying large
experiments, or adjudicating scientific scope.

For a broad scientific simplification, report the code reduction and material
evidence changes. Use relevant fields below when they clarify the result:

```text
Claim: quantity or scientific statement affected
Before evidence: independent witnesses and user-facing surfaces
After evidence: surviving independent owners
Lost detector: exact defect class no longer observable, or none
Interface parity: record, report, example, notebook, and docs status
Environment: interpreter/import origin and skipped boundaries
Disposition: preserve, replace, restore, retire with contract, or unresolved
```

The simplification is scientifically complete only when every affected claim
has a surviving independent owner or the claim itself is explicitly retired.
