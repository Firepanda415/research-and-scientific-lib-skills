---
name: write-implementation-job-prompts
description: Draft or review instructions for another implementation agent from a concrete request, plan, or verified findings. Use for implementer handoffs, remediation jobs, corrections, and multi-job plans. Ordinary implementation or review does not require a separate job-prompt workflow.
---

# Write Implementation Job Prompts

Make the requested outcome and acceptance evidence clear enough for another
implementer to act without repeated clarification. Optimize for a correct,
bounded handoff, not contract length or the number of checks.

## Understand the actual job

Read the authorizing request, live contract, owners, callers, and tests. Before
choosing edits or checks, state the affected relation: admitted input meanings
and representations, the consuming operation or lifecycle that decides legality,
and the expected result or forbidden work. A reported reproducer witnesses that
relation; it does not define its whole domain. Trace the actual transformation
to its consumer, including any later conversion or rewrite that can undo the fix.

When the handoff requires choosing an implementation structure, simplification, or code/API retirement, load and apply [Ponytail](../ponytail/SKILL.md) unless it is off. Carry the active level or off state to the implementation agent. Merely transferring a fully settled edit does not need another design pass.

Use the user's existing authority and scope. Drafting a prompt does not itself
authorize dispatch or implementation, but do not request permission again for
actions already authorized. Necessary tests, documentation, and direct callers
can be part of an authorized fix unless the user imposed a closed edit surface.
Only impose per-file whitelists, formal authority maps, or a stop-before-edit rule
when the project or request actually requires them.

Separate production algorithm work from acceptance-only evidence. A requirement
to compare against an independent oracle in a test does not authorize adding
that computation to the runtime loop. Carry explicit human approval for extra
expensive or poorly scaling checks, including their workload, frequency, and any
effect on results, selection, or termination. Coordinators may pass on that
approval, not create it through a correction prompt. A generic request to fix
correctness, or approval of a bounded experiment, does not authorize a recurring
production safeguard. Where approval is missing, finish a concrete proposal and
ask briefly with a bold statement of the extra work and consequences; do not run
the expensive work merely to make the proposal reviewable.

Living project guidance can be updated within authorized scope when evidence
shows it is stale. Do not promote an AI-authored plan or a file name to immutable
authority. Preserve explicit user requirements and identify a real conflict if
one prevents execution.

A handoff the user will send, keep, or reuse is paste-ready text and follows
`research-writing-style`. A brief that an orchestrator passes directly to a
subagent is intermediate material for that agent and is outside the writing
route.

## Write the smallest sufficient handoff

Usually include:

- the concrete problem, desired behavior, and relevant baseline or artifact;
- the existing owner and affected paths, with genuine scope limits;
- the scoped relation, relevant representation/operation distinctions, and material exclusions;
- for new behavior as well as fixes, the property each requested test checks and the independent source of its expected result, such as a specification, derivation, reference implementation, or known-good case;
- separating counterexample (for a fix, a regression check that fails on the pre-change code and passes after the fix), legal-preservation evidence (inputs that must keep working) or forbidden-work evidence, and project-required checks;
- expected deliverables and the actual action boundary.

Specify outcomes before helpers or architecture. Preserve the relation when
choosing a smaller implementation; a named example set is not a closed edit or
support boundary. Include only distinctions that can change the outcome, without
requiring arbitrary coercions, all Cartesian tests, or a new validation framework. Use
[job-prompt-template.md](references/job-prompt-template.md) only as a drafting aid.

For a correction, state what supersedes the old instruction and why, using
[correction-prompt-template.md](references/correction-prompt-template.md) when
helpful. Preserve dispositions of relevant findings without making a new
permanent test for each review comment. Existing evidence may cover several fixes.

Use the current project's supplied guidance to identify required reading and its actual paths. Give the implementer only material relevant to the assigned role and task, following the project's access and storage rules. Carry applicable workspace setup, import binding, integration, and delivery requirements into the handoff. Do not require a project to adopt another project's document layout or workflow. A brief for another implementer belongs to this skill. Resume state for continuing the same work in a later session belongs to `research-watchdog-protocol`.

## Proportional acceptance

Choose checks that could detect the plausible defect. A fix's regression test
must fail on the pre-change code and pass after the fix. An earlier reproduction
of that failure can be reused while it still applies to the current code. For
other checks, request a new deliberate small breakage only when a plausible
defect could still pass the checks unnoticed and the cost is justified. The
number of changed tests does not decide this. Evidence still valid for the
current code and behavior can be reused, and one breakage can support several
tests when the report names the property it covers. A rename or reorganization
that leaves what every assertion checks unchanged needs no new failure
demonstration. An import or missing-symbol failure on the pre-change code is
valid evidence when importability or that public export is the contract.
Otherwise a failure caused only by the feature's absence, or by deleting text
that is not itself the contract, does not show that a behavior check works. A
labeled characterization test written before a refactor may record its expected
values from the pre-change code. When a test is expensive, demonstrate its
failure on a small instance, and extra expensive computation still needs the
approval described above. Use the concrete public path, input, relation, and
tolerance when those determine correctness. A separate independent oracle
computation, owner-call count (how many times the owning routine runs),
forbidden-work sentinel (a check that detects disallowed extra computation, such
as an extra solver call), or additional mutation probe is useful when output
equality could conceal a wrong algorithm or hidden cost. It is not a field
required on every acceptance row.

For scientific changes, state which assumptions, numeric conventions, error
criteria, and output semantics must hold. Test small analytical or trusted
instances first when useful. Do not add simulation, transpilation, dense
operators, full output retention, or full-suite runs merely to test metadata or
resource reporting. Include performance checks when the changed path can alter
asymptotic work, allocations, communication, or measured runtime.

Distinguish byte-stable artifacts, intentional semantic changes, and numeric
tolerance checks. Specify new values only after obtaining them from the intended
reference. Do not regenerate unrelated expensive artifacts for appearance.

Use the project's supported toolchain and ensure checks import the target checkout when shadowed installations are possible. When project instructions require a checked runner or revision checks, carry the actual checkout, revision, and invocation into the handoff. Resolve required guidance and executable paths from current project instructions before dispatch, rather than copying historical commands or inventing missing environment rules.

Do not game a scan by hiding its matches. Reuse the project's existing gates and
show their actual results. Run deliberate breakages and any required mutation
checks apart from the acceptance run, and establish restoration before later
evidence is accepted.

## Multi-job work and dispatch

Read [plan-to-job-series.md](references/plan-to-job-series.md) when the user wants
a job series. Split on real dependencies and independently reviewable changes;
do not serialize jobs merely because they belong to one plan. Preserve required
outcomes, temporary migration obligations, and the final acceptance responsibility
without a new ledger for every relationship.

## Pre-dispatch check

Apply these checks to the clauses that the job actually contains:

- Back claimed current values, counts, and artifact differences with live
  measurements or an independent reference. Distinguish target outcomes from
  observed results; do not guess empirical expectations.
- Call a gate verified only when actual run evidence supports that claim on the
  relevant baseline and within the authorized workload. New gates for behavior
  not yet implemented stay proposed: explain what defect they can distinguish.
  Job readiness does not require demonstrating that future behavior first.
  Run a bounded demonstration only when an existing mechanism's result is
  needed to decide the design; retain unavailable or unapproved checks as proposed.
- Verify where the relation is first decided and where it is consumed; one
  centralized helper is not evidence of a complete domain. Derive any closed
  edit surface from that trace and keep unchecked scope explicit.
- Give late amendments the same evidence check as the original job. Reconcile
  the affected title, authority, edit surface, outcomes, gates including counts,
  and permitted artifact differences; remove superseded clauses.
- Validate the final command text and selectors in the intended environment.
  For broad selections mixing cheap and expensive tests, inspect the targets
  and fixtures first; use collection-only when needed to check the actual nodes.
  Collection imports modules, so it does not replace source and cost inspection.
  Do not execute an unknown selection merely to validate its coverage.
  Reuse still-valid run evidence for unchanged expensive checks; use a bounded
  check for new uncertainty and mark any remaining run unverified. Do not repeat
  production work merely to fill a prompt or call an unrun command validated.
- Carry the user's standing rules that the implementer may not inherit and the job could violate, such as authorship or commit, integration, or push authority. An implementer on another host, in a fresh session, or in a subagent may not load the user's global instructions. Carry the current project's required reading, workspace/import, action, and delivery rules as well. Resolve a material conflict before treating the job as ready.

For a review-only request, apply these checks to the existing prompt and report
each failing clause, quoted, with the specific fix. Do not rewrite or dispatch
the prompt unless asked.

Once authority, starting state, owner, outcome, and sufficient acceptance evidence
are clear, dispatch if authorized. Revise again only for new evidence, baseline
drift, or a real scope change. A worker's completion token or READY claim is not
acceptance. Inspect the live change and relevant evidence.

Return the prompt in chat unless a durable file is requested or needed by the
established workflow. The bundled `scripts/lint_job_prompt.py` targets detailed
contract-style handoffs; use it only when that format is selected. Its formatting
rules do not define scientific validity or require adding absent machinery to an
otherwise sufficient short handoff.

When the detailed handoff format calls for the bundled linter, read [linter execution](references/linter-execution.md). Apply the current project's environment and runner requirements to that command.
