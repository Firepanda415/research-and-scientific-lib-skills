# Review Angle Matrix

Use this matrix to avoid missing relevant risks, not to require an agent or
experiment for each row. Select angles justified by the requested surface and briefly
account for material exclusions. The same file may appear in several traces
when they test different invariants.

## Finder angles

| Angle | Primary question | Minimum evidence | Apply when |
| --- | --- | --- | --- |
| Scope and endpoint | Which current behavior is being reviewed, and what comparison, rules, and exclusions govern it? | Base, endpoint, merge base when relevant, status, diff inventory, applicable instructions, endpoint versus explicitly introduced-only scope | Always, parent-owned |
| Prior-finding closure | What current evidence resolves or keeps open each in-scope earlier issue? | Closure ledger, original falsifier or static proof, accepted/deferred decisions, current result, evidence-deletion check | Remediation or follow-up review |
| Domain and semantic correctness | Does the computation preserve the intended quantity, state, ordering, units, and decision meaning? | First-principles or independent oracle plus adversarial and boundary cases | Numerical, scientific, financial, protocol, compiler, or other domain-heavy logic |
| Shared owner and cross-layer contract | Does one fact have one owner across producers, callers, sibling paths, records, serialization, reports, and docs? | Callsite inventory, legal states and relations, nondefault value traced end to end | Shared helpers, schemas, lifecycle fields, common status vocabulary |
| Maintainability and unnecessary structure | Which unused inputs, dead branches, duplicate state, setup helpers, or serialization layers impose a concrete update burden? | Relevant def-use and caller inventory, actual consumers, behavior-preserving deletion/consolidation direction | Substantive review of owned helpers, adapters, records, tests, or abstractions, including unchanged siblings |
| State and event lifecycle | Are planned, constructed, submitted, executed, completed, validated, and reported events distinct and ordered correctly? | Event witness independent of metadata plus zero/nonzero and partial/full cases | Stateful workflows, jobs, accounting, caching, retries, resources |
| API and trust boundaries | Are inputs, removed options, errors, compatibility, schema changes, and serialization validated at the real boundary? | Public caller matrix, invalid and boundary inputs, round-trip or migration checks | Public APIs, parsers, configs, storage, messages, command-line entrypoints |
| Security, concurrency, and data integrity | Can untrusted input, races, partial failure, or retries corrupt, expose, or lose data? | Threat or failure scenario, ownership and atomicity trace, focused reproducer | Relevant trust, parallelism, persistence, or destructive paths |
| Test oracle and harness quality | Can tests or tools report success while the claim is false or evidence is absent? | Passing baseline and a discriminating perturbation or missing-evidence case, explicit numerical tolerances, coverage of the actual runtime branch, outcome classification | Tests or automation relied on for the reviewed behavior, including unchanged oracles |
| Deleted behavior and evidence | What guarantee, negative test, guard, or behavior was removed, and what replaces it? | Deleted-line review, protected invariant, replacement falsifier or explicit retirement | Any deletion or cleanup commit |
| Documentation, examples, and generated artifacts | Do user-visible equations, examples, reports, docs, and generated copies match runtime behavior? | Semantic comparison and regeneration/freshness evidence where applicable | Public behavior or documentation changed |
| Performance and stored state | Does the current path repeat costly kernels, build discarded payloads, serialize unused fields, or accumulate unnecessary state? | Matched workload, call counts, peak live objects/bytes, serialized size, consumer trace, justified scaling law | Hot loops, batches, resource estimation, output/cache growth, preparation and reporting paths |
| CI, dependencies, and platform behavior | Do automation and tests exercise a distinct supported environment and fail actionably? | Workflow-to-policy comparison, base differential, platform-sensitive checks | Workflow, dependency, packaging, precision, or environment changes |
| Integration and gap sweep | What was missed between lanes, commits, or layers? | Coverage record, unreviewed-surface search, cross-angle interaction cases | Final gap check; independent reviewer for exhaustive review or consequential unresolved risk |

## Allocation rules

- Do not assign work as `subsystem A`, `subsystem B`, and `the rest` unless each
  lane also owns a named invariant end to end.
- Combine adjacent angles only when one bounded trace and one evidence set can
  genuinely cover both. Record the combination in the ledger.
- Two agents may inspect the same code intentionally when they use independent
  angles or oracles. Duplicate file access is not duplicate reasoning.
- High-risk overlap should use different failure models. For example, pair a
  mathematical-oracle lane with a public-result or lifecycle lane rather than
  asking two agents to reread the same function.
- Cover remaining angles locally or through sequential waves. Independence means
  a different failure model or evidence source, not a required head count.

## Finder handoff

Give each finder the frozen base and endpoint, applicable repository rules,
explicit exclusions, one angle, and the surfaces that seed its trace. Require a
read-only return with:

```text
reviewed surfaces and call paths
checks or reproducers run
candidates:
  current owning location, whether changed or unchanged
  triggering scenario
  observed and expected behavior
  downstream effect
  likely semantic owner
  introduced, pre-existing, or uncertain origin
  impact category and confidence
  runtime, static, or reused evidence with its exact revision
  closure/deferral state and unresolved evidence
verified-good observations
remaining gaps
```

Do not give a finder the desired findings or ask it to validate another agent's
conclusion. A later verifier may receive a single candidate and its raw evidence
when independent confirmation is needed.

## Parent ledgers

Coverage ledger:

```text
angle | applicability | owner | surfaces | evidence returned | gaps | status
```

Candidate ledger:

```text
candidate | angle | accepted/rejected/merged | impact | origin | priority |
runtime/static/reused evidence | owner | closure state | report location | reason
```

Use these ledgers when the number of findings or handoffs makes them useful;
compact notes suffice for a bounded review. Keep them internal unless requested.
The final report must accurately reflect the boundary, method, accepted
findings, and residual uncertainty.

## Impact summary

Give each accepted finding one primary category, with secondary effects in its
body. Summarize only applicable categories, without forcing a finding into each:

| Category | What the evidence establishes |
| --- | --- |
| Direct domain/scientific correctness | A valid input produces the wrong intended quantity, convention, decision, or claimed guarantee |
| Execution and resource accounting | Requested work, observed events, or published costs disagree or admit invalid values |
| Validation and reproducibility | Oracles, harnesses, reports, or missing provenance cannot support the claimed evidence |
| API and workflow behavior | Supported inputs, options, serialization, or entrypoints fail their contract |
| Computation and memory cost | Unnecessary work or live/output growth with observed counts or a justified bound |
| Maintenance and documentation | Proven dead plumbing, duplicate update ownership, or an inaccurate user/maintainer contract |

Priority is a separate axis. A large resource failure may outrank a narrow
numerical defect. A weak test does not establish a wrong current solver output.
Keep explicit deferred debt visible and resolved defects outside the open count.
Report an unverified area as a coverage limit, not as a verified issue or a clean
bill of health. The same integrated summary belongs in the first final review.
