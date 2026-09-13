---
name: simplify-codebase
description: "Audit or perform authorized codebase simplification to remove accidental complexity, dead code, duplication and obsolete layers while preserving contracts. Use for 代码简化, 代码瘦身 or 熵回收; exclude general review and performance tuning."
---

# Simplify Codebase

Reduce the number of concepts and obligations a codebase must keep coherent. Line-count reduction is supporting evidence, not the objective. A successful run may conclude that the inspected surface is already justified.

## Select mode and scope

First choose the authority mode:

- **Survey** for simplification audit, investigation, or candidate-finding requests. Remain read-only and return ranked evidence.
- **Change** for explicit simplify, remove, consolidate, refactor, or repository-documentation edit requests. Prove each cut, implement it within the authorized scope, and validate the surviving contract.

Then choose the coverage scope:

- **Focused** when the user names a subsystem, symbol, state machine, dependency, or suspected duplication. Cover that boundary thoroughly before expanding outward.
- **Broad** when the request spans the repository or asks for multiple candidates. Partition the system and account for every in-scope domain.

Deleting a reachable capability, supported interface, stored representation, or compatibility path is a product decision. Describe the consequence and obtain direction unless the user has already chosen it.

## Establish the contract

1. Read the repository's instructions and the architecture, decision records, manifests, test guidance, or generated-file conventions relevant to the proposed cut.
2. Inspect version-control state and preserve unrelated work. Identify vendored, generated, migration, fixture, and public-package surfaces before classifying them.
3. Trace the runtime path from entrypoints through configuration, registration, dispatch, persistence, processes, and wire boundaries. Record public, dynamic, persisted, generated, and compatibility-sensitive contracts.
4. In Change mode, discover the repository's real verification commands and capture a proportional baseline when feasible. A failing baseline narrows what the final checks can prove.

Preserve authorization, trust-boundary validation, security isolation, accessibility essentials, data-loss prevention, stored-format compatibility, and cleanup that establishes quiescence. Treat changes to these protections as their own explicitly authorized objective, not an incidental simplification.

The contract map is complete when all in-scope entrypoints and authority boundaries are enumerated, each is traced far enough to name its owner and observable contract, and every uninspected or externally unknowable surface is recorded as a blind spot.

## Cover the relevant surface

For every Broad engagement, and for Focused work involving dynamic architecture or dependency substitution, read [investigation.md](references/investigation.md). Build a coverage map before ranking findings; the first plausible deletion must not end the survey.

For concurrency, cancellation, readiness, cleanup, defensive copies, validation, authorization, security isolation, accessibility, data-loss prevention, or cross-process data, also read [boundaries-and-lifecycle.md](references/boundaries-and-lifecycle.md).

For scientific or research software, numerical libraries, benchmark repositories, or any simplification that removes tests, probes, reports, examples, documentation, or gates used to support scientific claims, read [research-software-evidence.md](references/research-software-evidence.md). Audit conservation of independent evidence separately from conservation of behavior.

For scientific dependency guards, error wrappers, or recovery candidates, also use the [dependency-failure policy](../scientific-computing-correctness/references/dependency-recovery.md#dependency-failures-and-recovery) to distinguish useful numerical recovery, informative errors, and cheap rejection of silently wrong inputs.

Use repository-native search, compiler and linter output, dependency metadata, and history as discovery instruments. Treat their findings as leads until runtime consumers and contracts have been examined.

## Build a proof record

For each candidate, establish its burden, real consumers, consequence, and the
smallest check that would reveal a wrong cut. A focused change needs only these
facts in compact notes. For a broad survey or consequential contract retirement,
the following record can help compare candidates; omit irrelevant fields:

```text
Candidate: the exact contract, representation, or layer to remove or merge
Burden: the concepts, synchronization, publication, or testing cost it creates
Reachability: production, non-production, dynamic, external, and persisted consumers
Rationale: why it exists and whether that reason remains current
Cut: declarations, implementations, branches, artifacts, docs, and dependencies affected
Consequence: observable capability or compatibility behavior surrendered
Confidence / risk: evidence strength, uncertainty, blast radius, and reversibility
Proof: the smallest check that would expose an incorrect cut
Net effect: maintenance concepts removed minus replacement or migration machinery added
```

Prove cut boundaries below file granularity when the candidate shares an artifact with surviving consumers. Account for candidate-exclusive selectors, members, fields, keys, registry entries, generated fragments, and fixtures without disturbing the surviving owners.

Keep or downgrade the candidate when a real consumer exists, dynamic reachability remains unresolved, a current decision still owns the design, the change merely relocates complexity, the result is outside scope or retires no meaningful obligation, or the available check cannot distinguish success from accidental breakage.

Rank confidence separately from benefit. A high-value guess does not outrank a smaller proved cut.

Report candidate footprint, confirmed removable code, and realized net deletion
separately. Mixed-purpose blocks are not wholly removable; account for surviving
code and replacements. Keep production, tests, and documentation counts separate,
and do not subtract totals from different scopes or revisions.

Candidate proof is complete when every qualifying lead is classified as ranked, rejected, or unresolved, and every unresolved lead names the fact required to decide it.

## Decide and act

In Survey mode, stop after reporting the ranked evidence. Include important rejected candidates when the rejection teaches something or identifies a concrete missing fact.

In Change mode, read [execution-and-recovery.md](references/execution-and-recovery.md) and select the strongest authorized cut. One ownership boundary is the default batch size, not a run limit: for an explicitly requested set of cuts, finish and validate each boundary before starting the next.

If the user requests a simplification proposal, local cleanup annotation, or design-record consolidation, or if a selected change invalidates an ADR, RFC, design note, or architectural inventory, read [decision-records.md](references/decision-records.md). Do not turn an ordinary code audit into a repository-wide documentation purge.

If the user asks to combine findings from another branch, pull request, task, or agent run, read [integrating-findings.md](references/integrating-findings.md). Preserve evidence, not finding counts.

## Deliver the result

For a survey, report coverage and ranked findings with decisive evidence. Include rejected or unresolved high-value leads when they change the recommendation.

For a change, use the proportional validation in [execution-and-recovery.md](references/execution-and-recovery.md). Report what changed, the evidence that the surviving contract works, and material limits. A narrow green check does not establish broader runtime, deployment, or user acceptance.
