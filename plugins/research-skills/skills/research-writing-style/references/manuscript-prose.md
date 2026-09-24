# Manuscript and response-letter prose

Use this reference for manuscript or response-letter drafting, substantial paragraph work, and additions driven by reviewer feedback. It does not require a new paper outline, scientific audit, or experiment.

## Write for the paper's reader

Make each sentence serve the paper's argument. Keep reviewer correspondence and the authors' working process out of manuscript prose. Explain disagreement with a reviewer in the response letter, factually and briefly; do not add a manuscript paragraph merely to disparage a suggested citation or pre-empt criticism.

Work from the active text. Commented-out source counts as deleted unless the user says otherwise, so do not cite it, derive from it, or describe it as the paper's content.

Keep code variable names, file layouts, and irrelevant implementation decisions out of the paper. State mathematics in the paper's notation. Report units, normalization, solver tolerances, cutoffs, initial conditions, and algorithm choices when they affect interpretation or reproduction, in Methods, captions, supplementary material, or a referenced configuration. An undisclosed code convention must not silently shape a formula or numerical claim.

Describe the actual runs. Budget exhaustion is not convergence to a poor local minimum, and adaptive numerical quadrature is not automatically Gaussian quadrature. Use the source, data, or logs; flag a claim that cannot be verified.

For every revision-driven addition, check whether a reader unfamiliar with the review correspondence or revision plan can understand it. Review prompts include `requested`, `suggested`, `as noted in the response`, `(cited source)`, `declared`, `pre-registered`, `frozen`, and `we report it as such`. Keep a term when the paper itself defines and needs it. Replace working-note shorthand with the underlying scientific fact, use the document's established citation/attribution convention, and delete self-praise about reporting it. Combine this check with the shared final gate.

## Give paragraphs a clear hierarchy

- Add interpretation, consequence, or a necessary bridge after a theorem, table, or equation. Do not merely restate the adjacent result. Repeat a headline finding where an independently read abstract, caption, or conclusion needs it.
- Give a detailed limitation one authoritative explanation, with concise local qualifications wherever a claim would otherwise mislead. Keep every necessary condition; avoid repeated defensive paragraphs and caveat stacking.
- Do not bolt qualifier upon qualifier onto an existing sentence. Rework the paragraph only when its argument requires it or the user requests structural revision; follow the local-edit constraints in [copyediting](copyediting.md).
- Use a contrast only when the alternative was just discussed or is a standard assumption the reader needs to distinguish. Repeated unnecessary foils obscure the main point.
- Three or more occurrences drawn from `but`, `while`, `whereas`, `rather than`, `by contrast`, `cannot`, `not`, and `only` trigger a paragraph-level review. This is an audit trigger, not a writing quota; keep logically necessary distinctions.
- Avoid `First, ... Second, ... Third, ...` scaffolds in results prose, symmetric two- or three-part constructions as the default paragraph shape, runs of equal-length sentences, and inventories that give every case equal weight. Lead with the finding that matters and subordinate secondary observations without deleting information.
- A bridge or announcement sentence must state a necessary logical connection. Remove sentences whose only purpose is to announce the next topic.
- State the one or two numbers that carry the conclusion and cite the table for the rest. Row-by-row narration adds no interpretation and obscures the main finding.
- Keep metrics and their reporting order uniform across comparable instances. Do not vary the reporting contract to create stylistic variety.
- Give each quantity class one displayed precision, chosen from its resolution or from the paper's existing tables, and use it in text, tables, captions and the response letter. Values added to an existing table in revision follow that table's column format. An approximate prose range marked with ≈ may use fewer digits. Exact counts and identifiers keep their exact form.
- When a quantity lies near one and its distance from one carries the result, report the complement. For example, report an infidelity 1 − F = 1.3 × 10⁻⁴ rather than F = 0.99987.
- Round once, from the unrounded result. Compute differences, ratios and other derived values before rounding, and check values that fall on a rounding boundary.
- A stated bound (`at least`, `at most`, a floor or ceiling) must hold for the unrounded value of every instance it covers. Round a lower bound down and an upper bound up.
- Let the abstract present the problem, method, and headline evidence, the summary organize the contribution and theorem chain, and the conclusion state the supported result and its limits. Reuse exact terminology and verified numbers without copying the same sentence mold across all three.

## Compose sentences without changing the claim

Use sentence length to clarify the argument. A short pivot must still be a supported technical statement, not a figurative or conversational substitute. Technical register takes priority over rhythm. Remove a sentence that only restates an adjacent quantitative result instead of finding a decorative paraphrase.

Lead with a methodological reason when it explains the choice, without imposing that order everywhere. Name the authors' agency when reporting a real decision; stock `we note` or `we emphasize` framing adds no agency. Use an integrated or parenthetical table reference according to its function, without forced alternation. Give a qualification its own sentence when that makes clear which claim it limits.

Treat clusters of stock openers, repeated `We + verb` sequences, paper roadmaps, balanced inventories, discourse markers, and decorative hedges as prompts for judgment. Terms such as `leverage`, `framework`, `promising`, `powerful`, `paradigm`, `robust`, `significant`, and `comprehensive` are not automatic targets. In a copyedit, remove a phrase for a concrete defect such as generic praise, redundancy, ambiguity, or unsupported scope. A requested style rewrite can change sentence and paragraph organization more broadly. Keep necessary technical meaning and stable terminology. Use [detector evaluation](detector-evaluation.md) for explicitly requested detector comparisons.
