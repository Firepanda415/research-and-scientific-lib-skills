## Use coverage-driven parallel review

For broad or exhaustive reviews, or reviews with material cross-owner risk,
read [references/review-angle-matrix.md](review-angle-matrix.md) and
mark every angle `applicable`, `not applicable`, or `covered elsewhere` with a
reason. For a narrow review, compact notes on relevant coverage, semantic owners,
independent evidence, and material exclusions suffice; the full matrix is not
required.

- Assign bounded work by invariant, event, or failure mode. One reviewer may
  cover related angles when a shared trace supplies their evidence. Use
  independent reviewers where a distinct perspective or oracle adds confidence;
  there is no required agent or lane count.
- Give every lane an invariant and evidence target that it owns end to end.
  Split a lane that cannot name them, such as a catch-all lane for the
  remaining surfaces.
- Add independent overlap for consequential decisions when the first evidence
  source could share a failure mode. More agents repeating one assumption do
  not strengthen the result.
- Start independent lanes in parallel up to the available concurrency limit.
  Cover remaining angles locally or in additional waves when needed; preserve
  coverage without turning the matrix into a staffing quota.
- Finder agents are leaf reviewers. They remain read-only and return candidates,
  reviewed surfaces, checks run, and residual uncertainty. They do not edit,
  plan fixes, or approve their own findings.
- For executable checks, pass finders the verified absolute interpreter or
  required runner, working directory, and exact relevant commands. Their
  handoff returns the commands actually run and the applicable revision/import
  context so the parent can reproduce a finding without guessing the environment.
- The parent owns boundary resolution, candidate integration, reproduction,
  deduplication, severity, and the final verdict. Continue useful local review
  while agents run.

Source-mutating probes run only in an isolated disposable checkout (a temporary
worktree or copy). Confirm that the tests import from that copy rather than an
editable install of the original, and leave the user's checkout untouched. Do
not let finders, tests, and mutation tools share mutable source state.

Before classifying a mutation as killed, deduplicate its selected tests and
require them to pass with zero skips on the unmodified tree. Count a kill only
when the mutation introduces the failure; in a full probe run, a skipped probe
is incomplete rather than successful. A probe that changes multiple occurrences
establishes only group-level coverage unless each occurrence is independently
mutated and killed. Do not impose a universal one-occurrence rule when grouped
coverage is the explicit contract.
