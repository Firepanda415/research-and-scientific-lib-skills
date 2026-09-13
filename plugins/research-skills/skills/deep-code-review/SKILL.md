---
name: deep-code-review
description: "Review code read-only for domain correctness, engineering, tests and resource costs. Use for substantive code or remediation reviews; include verified current issues unless the user limits scope to introduced defects. Exclude implementation and style-only review."
---

# Deep Code Review

## Review contract

Deliver one integrated review of domain/scientific correctness, engineering quality, and resource cost, grounded in realistic use of the relevant public entries and their downstream consumers. Trace actual affected call chains across file and worker boundaries. Complete relevant verification before the first final report; local passing tests are scoped evidence, and independent evidence must support the claimed user-visible behavior and scientific meaning.

Default to endpoint quality within the requested surface. A base commit supplies
comparison and origin evidence, not an automatic introduced-only filter. Include
every verified actionable current issue in that surface, including pre-existing,
partially remediated, and deferred issues. There is no finding-count cap or quota.
Use the diff as an entry point and trace relevant unchanged owners and siblings.
This does not authorize an unrelated whole-repository audit. Honor an explicit
introduced-only, subsystem-only, security-only, or other narrower request.

Scale inspection, delegation, and checks to the requested scope and unresolved risk. Use existing evidence, source reasoning, and bounded discriminating checks where sufficient. This perspective does not require full end-to-end execution for every small change or authorize extra runtime diagnostics or unapproved expensive computation.

The review is read-only. Do not edit product code, commit, push, post to an
external review service, or delete unknown files. An explicitly requested
durable report is allowed and must use a noncolliding path. Treat every existing
tracked or untracked file as user-owned unless the current task created it.

Read-only does not prohibit normal tests, builds, or analyses that create
documented disposable caches or temporary outputs. Prefer a temporary directory,
inspect the status delta afterward, and never remove a pre-existing user file.

This skill authorizes read-only subagent delegation within the user's review
scope when delegation is available. It does not authorize implementation or any
external action.

## Establish the boundary first

Before delegation:

1. Resolve the exact base, endpoint, merge base when relevant, commit range,
   repository instructions, exclusions, and requested output.
2. Record the current revision, worktree status, changed-file inventory, and
   category-level diff size. Do not let concurrent work silently change the
   endpoint.
3. Verify interpreter, dependency context, and import origin before classifying
   runtime failures.
4. If the range is remediation, read the prior findings and accepted/deferred
   decisions, then create a closure ledger before judging the new diff. Mark
   each in-scope prior item resolved, partial, open, deferred, rejected, or
   unverified using current evidence. A documented deferral is still open work,
   while an obsolete or disproved prescription is not a required fix.
5. For scientific code, also use `scientific-computing-correctness`. When the
   task closes prior scientific findings, read its
   `references/remediation-closure.md` protocol.

## Use coverage-driven parallel review

For a substantive review with useful independent scopes, read [independent review](references/independent-review.md). Keep narrow reviews local; delegation follows current host and user authority.

## Treat candidates as hypotheses

For every candidate:

1. Trace the current owning location through callers, sibling paths, state changes,
   serialization, reports, documentation, and tests far enough to identify the
   semantic owner.
2. Demonstrate the affected scenario with evidence suited to the claim:
   - correctness or API behavior: derive the expected relation from the public
     contract before adopting the reporter's examples. Use an independent oracle
     and separating accepted-representation/consumer-lifecycle cases where they
     can change that relation, including the actual transform and legal preservation;
   - test or harness gaps: a passing baseline plus an injected relevant failure
     or missing-evidence case that the claimed guard fails to catch;
   - resource cost: actual call/lifetime/size counts or a justified operation
     bound at a matched workload, after tracing consumers of the data;
   - maintainability: complete relevant def-use/caller/reachability evidence
     showing dead plumbing or duplicated update ownership. A numerical failure
     is not required, but taste, similar spelling, or a smaller diff is not proof.
3. Compare base and endpoint when origin is uncertain. Distinguish an introduced
   regression, a pre-existing current issue, a remediation failure, and a
   cleanup opportunity.
4. Use an independent oracle or observable event where correctness matters.
   Multiple agents repeating the same producer are not independent evidence.
5. Merge candidates that share one first divergence and remedy. Preserve
   distinct downstream failures only when they require different action or
   materially different verification.
6. Reject speculative or non-actionable candidates and record why. An intentional
   behavior needs a contract-level defect before it is a finding. An unreachable
   failure scenario is not a runtime bug, but proven dead code/plumbing can be
   actionable maintenance work. A previous deferral changes scheduling, not
   whether a demonstrated current issue belongs in the review.

Classify impact, origin, evidence strength, and closure state separately. An old
issue need not be a blocker to qualify. Static maintenance findings must not be
described as measured numerical errors, and small allocation counts must not be
promoted to whole-run speedups or memory failures. For an explicitly strict
diff-only review, keep pre-existing observations outside the introduced findings
and include them as residual context only when useful.

## Final gap sweep

For an exhaustive review or consequential unresolved cross-angle risk, run an
independent gap sweep after initial verification. Otherwise inspect remaining
gaps locally. Give an independent reviewer the frozen boundary and coverage
record, without asking it merely to confirm accepted findings. Look for:

- changed files, callers, consumers, or interaction cells no lane actually
  covered;
- deleted tests, guards, negative guarantees, and cleanup commits that removed
  evidence;
- one fact represented differently across code, schema, report, documentation,
  example, generated artifact, or CI;
- unchecked semantic equivalents or lifecycle distinctions hidden by defaults,
  fixed fixture spelling, copied expectations, or a shared test-selection assumption;
- engineering areas not represented by the numerical findings, or mathematical
  meaning not assessed by a detailed engineering review;
- current candidates dropped only because they predate the base, were deferred,
  have static evidence, or exceed an informal finding quota;
- cross-angle defects that appear only when two individually covered dimensions
  interact.

Verify new gap candidates by the same standard as the first wave.

## Stop condition

Do not stop because findings already look substantial. Stop only when:

- every applicable angle, changed surface, and relevant unchanged owner has an
  explicit disposition, including material exclusions;
- every high-risk candidate has independent verification;
- prior findings have closure states when remediation is in scope;
- the appropriate final gap check is complete;
- every accepted finding meets its claim-specific evidence standard, with
  incomplete checks stated rather than deferred into an implied second review;
- accepted findings are deduplicated and classified by impact as well as priority;
- all agents and source-mutating checks are finished; and
- the final worktree state is understood and user-owned files remain intact.

## Deliver the review

Lead with the most consequential verified findings. When findings span multiple
categories, include a compact impact table using the matrix categories. Highlight
direct scientific/semantic errors before the total count, distinguishing them
from validation gaps, API failures, resource costs, and maintenance debt. State
when no direct mathematical error was verified. Origin counts and P1/P2/P3 labels
alone do not convey scientific severity.

For each issue give the smallest current location, trigger, effect, origin,
verification evidence, and concrete repair direction. Keep open, resolved,
deferred, and unverified items distinct. For scientific issues, state the affected
quantity, demonstrated error, and preserved paths. Resource severity follows the
measured or bounded impact, not an automatic low-priority cleanup label.

Deliver all accepted findings in one review. A requested durable report contains
the full findings, relevant prior-issue closure, coverage, checks, and material
limits at a noncolliding path. The chat summary highlights consequences and
links to that report. Without a requested file, return the integrated review in
chat. A size-limited inline UI may mirror a subset but cannot cap the report.
Follow the requested Markdown/comment format and cite applicable repository rules
only when they materially support the finding.

A review-only request does not authorize fixes. If the user has already asked
for review and implementation, carry that authorized work through validation
without asking for the same permission again.
