---
name: upgrade-research-inputs
description: Investigate a research question, literature gap, closest prior work, or disputed claim using primary sources. Use for literature reviews, evidence and novelty checks, or planning expert input for a specific knowledge gap. A generic manuscript critique does not by itself trigger literature retrieval. Scale retrieval and records to the uncertainty; ordinary reading does not require a full research workflow.
---

# Upgrade Research Inputs

Answer the user's question from inspected sources and identify what the evidence
supports, what is inferred, and what remains unresolved.
Search by mechanism and mathematical structure as well as current terminology.

## Evidence that matters

- Inspect the primary source behind load-bearing claims, including the relevant
  appendix, theorem assumptions, figure, configuration, or code when necessary.
  If only an abstract is accessible, mark detailed method, proof, resource, or
  experiment claims unverified.
- Record an exact location and source version when the detail affects the
  conclusion or must be reusable. A citation beside the claim is often enough.
- Match the claim's scope, conditions, magnitude, and comparison to the source.
  Distinguish a paper's reported result from independent proof or reproduction.
- Look for the strongest alternative and relevant counterevidence when judging
  novelty, validity, or an improvement. Several papers using the same evidence
  do not supply independent confirmation.
- A bounded search with no match does not prove novelty. State the meaningful
  search/access limits without turning them into a blanket disclaimer.
- Verify changeable facts using current authoritative sources. Do not infer
  correctness from prestige or a mechanism from aggregate performance alone.

## Scale the inquiry

For a narrow question, inspect the sources needed to answer it and stop when the
remaining uncertainty cannot change that answer. Batch independent searches;
let follow-ups address actual gaps rather than a quota of rounds or viewpoints.

For a broad review, organize evidence around the user's claims or decisions.
Historical lineage, adjacent fields, resource assumptions, and contradictory
results are useful lanes when relevant. Use independent agents only for separable
work that improves coverage or judgment. Keep source inspection distinct from
the act of assigning a perspective to an agent.

Use Research-STORM-style iterative inquiry only when its multiple question lanes
and evolving outline help the task; see [method-workflow.md](references/method-workflow.md).
User checkpoints are for requested collaboration or a consequential choice,
not a mandatory pause between rounds.

For reading or summarizing a paper, preserve its definitions, assumptions, scope,
and distinctions between claims and evidence. For source-to-code work, use
`scientific-computing-correctness` to resolve result-sensitive conventions and
validate the computation. A literature search does not replace that checking.

## Check before delivering

Before delivering a synthesis, answer or comparison, check the draft against
these items using the sources already inspected, in a pass separate from
writing it, and fix what fails.

- Each load-bearing claim cites a primary source that was inspected, with a
  location when the detail matters.
- A detailed method, proof, resource or experiment claim that rests on an
  abstract alone is marked unverified.
- Each claim keeps the source's scope, conditions, magnitude and comparison.
- A novelty or improvement judgment names the closest alternative found and
  the limits of the search.

## Deliverable and retention

Return the requested synthesis, answer, reading list, or comparison with citations
near the claims. Add a next test only if it helps the user's decision. Do not
require a decision verdict for a descriptive question.

Use an evidence ledger only when many claims, contradictions, or later handoffs
make it useful. Preserve enough provenance to revisit important conclusions;
avoid duplicating whole sources, raw datasets, and the same claim across maps.
Do not create durable files unless requested or needed for the ongoing work.

Optional references:

- [source-protocol.md](references/source-protocol.md): lineage or novelty
  inquiries, query planning, or deciding which kind of source can support a claim.
- [evidence-ledger.md](references/evidence-ledger.md): compact reusable records.
- [expert-inputs.md](references/expert-inputs.md): requested collaboration or
  outside critique focused on a specific knowledge gap.

Problem choice, idea generation, evidence gathering, and evaluation can interact
in either order. Use other research skills when their specific job is needed,
not as prerequisites for this one. For a date-bounded scan of what is new in
quantum research, use `quantum-research-radar`.
