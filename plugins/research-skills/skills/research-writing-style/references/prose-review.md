# Adversarial review before delivery

Read this reference for the parent's mandatory review stage and for review-only requests. Review the text that exists. Do not generate another version merely to have something to compare, and do not rewrite a sound passage to demonstrate effort. The shared criteria remain in [durable prose](durable-prose.md).

The reader-oriented diagnostics here draw on Joseph M. Williams and Joseph Bizup, *Style: Lessons in Clarity and Grace*, 11th edition, Pearson, copyright 2014, ISBN 978-0-321-89868-5. Page references below use the book's printed numbering. This is an independently written review procedure informed by the book's ideas and the user's requirements, not a reproduction of its lessons, examples, or exercises. The book treats its principles as aids to diagnosis rather than universal prescriptions (Preface, p. vii).

## Review as a skeptical reader

Try to establish why the draft should not be delivered. Challenge the main claim, the logic connecting it to evidence, the reader's ability to follow it, and the need for each part. Do not accept the drafter's confidence, a previous approval, the user's preferred conclusion, or a polished tone as evidence. Read the actual draft and sources needed to check a finding.

Start with the artifact alone, as a reader who has not seen the conversation. Reconstruct its point, audience, necessary background, and line of reasoning. Then compare it with the brief and source material, kept separate from the draft. Do not silently fill gaps using private chat context and then judge the prose clear.

For a substantial document, use an independent reviewer when available. Give that reviewer the complete draft, intended reader, relevant source facts, and task limits, without the writer's self-assessment or desired verdict. The reviewer must be free to reject the draft. A short passage can receive a separate skeptical reread by the writer. The absence of another agent never waives review, and using another agent never transfers responsibility for the final version.

Adversarial review needs evidence. For each finding, identify the location, the exact defect, its likely effect on this reader, and the smallest adequate remedy. Distinguish factual or meaning errors, comprehension barriers, explicit house-style violations, and optional taste. Do not invent flaws, require a quota, inflate a minor preference into a blocker, or lead with praise to soften a real problem. If a claim cannot be checked, report what is missing without pretending it is either proved or false.

## Hard gate: exclude conversation and prompt leakage

Separate source facts the user supplied from instructions about how to write. Audience, scope, tone, prohibited moves, feedback on previous drafts, and generation plans control the work. They do not become content merely because they appeared in a message.

Inspect every reference to the user, a prompt, the conversation, an earlier draft, an instruction, or the writing process. Also inspect unexplained deictic phrases, declarations of compliance, defensive exclusions, and negative comparisons. Typical symptoms include “as you requested,” “the user emphasized,” “this version avoids,” “we do not discuss X,” “unlike the previous draft,” “根据你的要求,” “按前面讨论,” “这里不做 X,” and “不是 X，而是 Y.” These are prompts for inspection, not a string blacklist.

For each suspect sentence, ask:

1. Does it tell the intended reader something about the subject, or merely record how the assistant was told to write?
2. Would it belong here if that reader had never seen the prompt? Does the draft give the reader the needed context on its own?
3. Does a negative statement express a supported technical boundary, a necessary instruction to this reader, or a real alternative they need to distinguish? Or did it appear only because the user told the writer not to do something?

Remove process residue without replacing it with a smoother declaration of obedience. Express the supported positive content directly. A request not to discuss a topic does not establish that the method excludes it, cannot handle it, or deliberately rejected it. If excluding that topic needs no explanation for this reader, give none.

Original examples of this distinction:

| Writing brief | Failed artifact text | Required treatment |
|---|---|---|
| “不要夸大结果” | “We avoid overstating the significance of these results.” | Report the result with its actual evidence and limits. Remove the self-assessment. |
| “不要在这里讨论噪声” | “Our method does not consider noise.” | Delete the invented scope claim. The writing instruction is not evidence about the method. |
| “别提我们刚才试过的方案” | “Unlike the previous approach, this method is straightforward.” | State the current method and any reader-relevant rationale supported by the material. |
| Supplied fact: the bound assumes finite dimension | “The bound is proved only for finite-dimensional systems.” | Keep it when it states the actual scope. A necessary limitation is not prompt residue. |

Exceptions must follow the artifact's purpose. A requested conversation record, revision history, response letter, migration guide, or reusable instruction set may need process information or prohibitions. Include only the history or instruction the user intends that reader to receive. Do not expose incidental chat wording or private working notes. A skill about writing rules can state writing rules. A paper's result section normally cannot narrate compliance with its drafting prompt.

## Challenge the document before polishing sentences

### Purpose, motivation, and argument

Find the statement that tells the reader what to understand or do. If the text merely announces a topic, determine whether its purpose requires an actual claim, question, result, or action. Ask why this particular reader needs it. Do not manufacture urgency, novelty, a research gap, a large social benefit, or a common misconception to make an introduction look complete. Practical costs and gaps in understanding are different reasons for writing (Lessons 7–8, pp. 98–124).

Reconstruct the chain from evidence to the main claim. Try a plausible counterinterpretation and check whether the text resolves it with evidence or an explicit limit. Test causal claims, comparisons, and scope against the source. Remove connectors such as “therefore” temporarily: does the inference still follow? A connector cannot supply a missing premise. Neither can a smooth narrative, a citation, or a confident conclusion (Lesson 5, pp. 77–78).

Trace the point and key concepts through the introduction, sections, and conclusion. Does each section develop what its opening led the reader to expect? Can the reader locate the relevant result without reconstructing the author's discovery process? Check for conclusions that answer a different question, introductions promising unsupported breadth, and paragraphs that serve the prompt's checklist rather than the document's argument.

For each questionable paragraph, identify its function: necessary background, claim, reason, evidence, explanation, qualification, or relevant alternative. If it serves none, remove or reposition it within the authorized scope. A chronological account is appropriate for a protocol, history, or requested process log. It is not the default organization for an argument just because the author worked in that order (Lesson 8, pp. 117–123).

Do not force every genre into a problem-and-solution introduction. Do not require every paragraph to announce its point in the first sentence, every section to contain a summary, or every conclusion to add a new future question. Check whether this reader can follow the actual form, including purposeful narrative or delayed disclosure.

### Evidence, responsibility, and meaning

Look for missing or invented actors, unsupported causal links, hidden responsibility, overstated certainty, omitted counterevidence, and implications created by word order. A clearer sentence can still mislead. Verify who acted, chose, experienced a consequence, or made a claim before moving subjects, changing voice, or strengthening verbs (Lesson 12, pp. 188–206).

Compare names, quantities, units, domains, exceptions, negation, comparisons, citations, and uncertainty with the input. Check strict versus inclusive bounds, necessary versus sufficient conditions, and the clause modified by each time, frequency, or scope qualifier. A style edit must not turn a condition into a cause, an association into an intervention, a lower bound into an exact value, or a possible outcome into a guaranteed one. If sources contradict the desired conclusion, flag the conflict rather than making the sentence sound more persuasive.

For research results, compare summary claims with the actual method variants, estimators, metrics, and test conditions in the evidence. A result for one variant does not establish the same result for the whole family. An observed sample property does not by itself establish a formal statistical property. Check that symbols name the intended objects, cross-references lead to the stated evidence, and caption conditions match the plotted variables. Verify a suspected extraction error against the rendered source before reporting it as an authoring defect.

Check quotations and paraphrases against the source when available. Preserve qualifications, agency, and the distinction between another author's view and the document's conclusion. Attribution verbs must preserve the source's evidential strength. A proposal is not a demonstration. A citation alone does not justify closely copied wording, and an ellipsis must not change a quotation's meaning. Verify new or changed source claims as required by the shared reference. Follow the destination's current citation conventions rather than treating a textbook's sample formats as universal (Appendix II, pp. 230–238).

These checks concern the draft's assertions and the evidence available for them. They do not silently expand a writing review into a new experiment, a complete literature review, or a formal scientific peer review.

## Diagnose the reader's difficulty

### Actors, actions, and syntax

For a hard sentence, locate the main subject and verb, then the actual participant and action. If a reader must decode a long abstract subject, a noun stack, or several nominalizations before discovering who does what, restore the underlying relation with the smallest useful change (Lessons 3–4, pp. 28–65).

A participant can be a mathematical object, an institution, a process, or an abstract concept. Do not invent a human actor or anthropomorphize a model to satisfy a template. Nominalizations can name defined concepts, connect to prior material, condense an already understood action, or serve as useful objects. Passive voice can preserve topic continuity or omit an irrelevant or unknown agent. Judge the reading problem, not the grammatical form in isolation.

Resolve ambiguous pronouns, modifiers, and parallel structures. Test alternative grammatical attachments: could a reasonable reader associate a condition, cause, or exception with the wrong clause? Treat grammar folklore and a personal punctuation preference separately from an actual ambiguity or grammar error (Lesson 2, pp. 9–26).

### Information order and continuity

Read adjacent sentence pairs and then the whole paragraph. Does the next sentence begin from information the intended reader can recognize? Does it introduce unfamiliar terminology before supplying any usable context? Do the paragraph's subjects and recurring concepts form a coherent line, or merely a chain of locally related sentences drifting away from the point? Check information the audience knows, not information the writer knows from the conversation (Lessons 5–6, pp. 66–95).

Prefer a stable topic when it helps comprehension. Do not vary subjects or technical terms merely to avoid repetition. At the same time, repair exact repeated phrasing when it creates padding or hides development. Check whether sentence endings emphasize the actual claim, qualification, or new concept, rather than an incidental phrase or a declaration of the author's effort.

The movement from familiar to new, and from simple to complex, is a diagnostic tool for difficult prose. It is not a rule that every sentence must have the same order. Moving a clause can change emphasis and perceived responsibility, so check meaning after the move.

### Concision, sentence shape, and emphasis

Find repeated meanings, obvious implications, inflated verbs, empty openings, redundant categories, and detours that delay the point. Remove words only when they contribute no needed meaning. Preserve evidence-sensitive hedges, necessary background, contrast, emphasis, and reader guidance (Lesson 9, pp. 126–142).

Trace the main clause and its dependencies. Check delayed verbs, interrupted subject-verb links, stacked relative clauses, ambiguous attachment, and clauses appended without a clear relation. Repair the particular obstruction. Do not impose a sentence-length ceiling, split every long sentence, or condense everything into short fragments. Repetition and balanced phrasing can clarify an actual comparison. Rhythm, parallelism, and emphasis must not imply causal or logical symmetry that the evidence does not support (Lessons 10–11, pp. 143–186).

Do not add a dramatic triad, a “not X but Y” construction, a poetic ending, or a metaphor solely to make prose elegant. Do not remove them automatically when their purpose and meaning are justified. For this user's technical prose, precision and the explicit house style take priority over decorative effects.

### Punctuation and the final visible artifact

Check sentence boundaries, modifier scope, restrictive versus supplemental information, parenthetical attachment, list parallelism, quotation boundaries, and target rendering where they can change the reading. Preserve mathematical signs and machine syntax. Report the user's semicolon, colon, and dash restrictions as house style, not universal grammar law (Appendix I, pp. 207–229).

Inspect the final visible text in the format's existing preview workflow when the task uses a rendered artifact. Include headings, captions, tables, footnotes, labels, and pasted text blocks in the review. Do not assume that a correct source file guarantees an intact visible sentence, citation, or cross-reference.

## Decide, repair, and check the delivered version

For each suspected defect, try to disprove the finding too. Is the detail supported? Does the intended audience already know the context? Is the apparently awkward form preserving scope or responsibility? Is the passage serving a legitimate genre function? Drop findings that depend only on taste, the existence of a watched word, or a rule used without its exceptions. Adversarial scrutiny applies to the reviewer's proposed fix as well as the draft.

When using an author's earlier papers as samples, distinguish observed habits from explicit preferences. A coauthored paper does not establish who chose each phrase or that its historical punctuation governs new work. Apply the user's current constraints to new deliverables without treating every departure in an old paper as a substantive defect. State which paper version was reviewed, especially when only a preprint is accessible.

For generated or authorized edited prose, repair supported defects and compare the changes against the source meaning. Recheck the changed passages and their transitions. After assembling sections, review the complete deliverable, not just each contributor's part. A previous pass does not cover subsequent changes to text, citations, or meaningful formatting.

The final version must have no unresolved prompt leakage, known factual or meaning error, necessary reasoning gap, material comprehension barrier, or violation of the user's explicit writing constraints. If resolving an issue requires missing facts or permission to change the substantive claim, report that precise limitation and do not label the affected text finished. Optional polish is not a reason for endless rewriting. A reviewed passage can remain unchanged.

For review-only work, lead with the substantiated findings, each with a usable location, reader consequence, and remedy. State when no actionable issue was found and disclose any material verification limits. Give paste-ready replacements only when requested, using the parent's applicable revision-feedback contract. Do not alter the source under a review-only request.

For generation or editing, keep the review internal unless the user requests its record. Deliver the reviewed text in the requested format, without embedding the review transcript, compliance claims, or criticism of the prior draft. Apply the parent's final lexical and semantic gate. The review stage does not require a second reviewer recursively to review its own findings.
