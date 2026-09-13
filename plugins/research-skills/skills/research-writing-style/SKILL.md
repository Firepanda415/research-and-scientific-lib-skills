---
name: research-writing-style
description: "Apply this user's house style and preserve scientific meaning in research prose, math, captions, responses, and research documentation. Use the relevant reference for manuscript editing or paste-ready revisions."
---

# Research writing style

Apply these shared rules to research-facing text, including explanations, code comments, READMEs, manuscripts, and response letters. Infer the discipline and audience from context. Ask only when an unresolved choice materially changes the terminology or meaning.

## Shared constraints

- Use the discipline's established terms. Define a technical object at first mention and reuse its name without synonym drift. Keep software labels such as `frozen`, `anchor`, `artifact`, and `golden reference` for actual software concepts; do not import them into mathematics or physics prose where a discipline term is needed.
- Preserve scientific meaning, evidence, author voice, and epistemic strength. Keep values, units, signs, indices, quantifiers, inequality and comparison directions, citations, and qualifications associated with the same claim. Describe computations from the actual source, runs, or outputs; flag an unverified statement instead of asserting it.
- State the supported content directly. Remove generic praise, redundant transitions, unsupported claims, and unnecessary contrasts. Standard technical terms are not automatic edit targets. Code comments explain mathematical meaning or real constraints, rather than narrating the next line.
- House style and detector scores do not establish authorship. Do not add errors, colloquialisms, random variation, or decorative synonym changes to influence a score.
- No semicolons in prose; mathematical notation is exempt. Avoid em-dash constructions. If a dash is truly needed in LaTeX prose, use `---`, not a Unicode em dash.
- Do not stack colon/semicolon lists inside prose or join independent explanatory clauses with a colon. State the logical relation with a connective or separate sentences. Colons may introduce displayed equations or enumerated lists, or label caption panels.

## Load only the relevant detail

- For an ordinary research explanation or a short code comment, use the shared rules and final gate here. Do not load manuscript, Overleaf, or copyediting guidance solely because the topic contains mathematics.
- For prose or display math being written into a LaTeX, Markdown, or other source document, read [source layout](references/source-layout.md). It preserves the user's one-paragraph-per-source-line and equation-row conventions.
- For manuscript or response-letter drafting, substantial paragraph work, or additions driven by reviewer feedback, read [manuscript prose](references/manuscript-prose.md).
- For proofreading or sentence/paragraph editing, read [copyediting](references/copyediting.md). A local prose edit does not trigger a referee review, submission audit, or new experiment.
- For suggestions the user will paste into an existing manuscript, response letter, or README, read [revision feedback](references/revision-feedback.md). Its current-file, exactly-once full-span anchor and complete paste-ready text requirements apply even in short follow-ups. Authorized direct file edits do not require a separate manual replacement package.

## Mandatory final gate

This delivery requirement takes priority over softer prose guidelines. After all edits and blocks have been assembled, scan the final newly generated prose case-insensitively for `\bretain(?:s|ed|ing)?\b` and `\bhonest(?:ly)?\b`. These ban `retain`, `retains`, `retained`, `retaining`, `honest`, and `honestly`. Rewrite any match and scan the final text again; do not deliver until there are zero matches. Prefer `keep`, `remain`, `continue to use`, `include`, `report`, or a sentence that states the intended meaning directly. State limitations without praising the writer's candor.

Apply that scan separately to every `Replace with` and `Insert` block. An earlier draft's scan, merely loading this skill, or asking the user to check does not satisfy the gate. Verbatim reviewer comments, quotations, code identifiers, and character-exact old-text anchors are exempt and must stay exact.

Check scientific meaning after a style-only edit. A numeric-token or citation diff can locate changes but does not prove semantic preservation. Label any substantive correction separately. Check that revision-driven manuscript additions make sense without the review correspondence or working notes.

Combine the applicable terminology, meaning, audience, source-layout, and lexical checks in one final review. They do not require independent passes or repeated unchanged-file scans. This does not replace the separate check of each new replacement/insertion block or verification against the current target file.
