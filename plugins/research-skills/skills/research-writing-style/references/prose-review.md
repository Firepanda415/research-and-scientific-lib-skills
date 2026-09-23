# Adversarial review before delivery

Read this reference for the parent's mandatory review stage and for review-only requests. Review the text that exists. Do not generate another version merely to have something to compare, and do not rewrite a sound passage to demonstrate effort. The shared criteria remain in [durable prose](durable-prose.md).

The reader-oriented diagnostics here draw on Joseph M. Williams and Joseph Bizup, *Style: Lessons in Clarity and Grace*, 11th edition, Pearson, copyright 2014, ISBN 978-0-321-89868-5. Page references below use the book's printed numbering. This is an independently written review procedure informed by the book's ideas and the user's requirements, not a reproduction of its lessons, examples, or exercises. The book treats its principles as aids to diagnosis rather than universal prescriptions (Preface, p. vii).

## Review as a skeptical reader

Try to establish why the draft should not be delivered. Challenge the main claim, the logic connecting it to evidence, the reader's ability to follow it, and the need for each part. Do not accept the drafter's confidence, a previous approval, the user's preferred conclusion, or a polished tone as evidence. Read the actual draft and sources needed to check a finding.

Start with the artifact alone, as a reader who has not seen the conversation. Reconstruct its point, audience, necessary background, and line of reasoning. Then compare it with the brief and source material, kept separate from the draft. Do not silently fill gaps using private chat context and then judge the prose clear.

The primary review unit is a complete argument in its document context. Sentence construction and word choice belong primarily to the generation mechanisms in [durable prose](durable-prose.md). Review still catches local errors and ambiguity, but isolated words, sentence lengths, and detector labels do not establish a defect.

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

### Recover the context

Establish the source and role of the material before treating it as the author's prose. Publisher covers, advertisements, recommendations, and running headers or footers may accompany an article without belonging to it. Distinguish body paragraphs from captions, table cells, and displayed mathematics. Keep a source locator for each finding. Exclude unrelated material from an article review, but preserve captions and definitions needed to understand the article.

Read the containing paragraph and the relevant preceding and following paragraphs before judging an excerpt. Follow necessary definitions, equations, figures, tables, and citations to recover its referents, comparison baseline, and scope. Check the rendered source when columns, page breaks, floating tables, OCR, or copied selections may have joined different units or interrupted a sentence. Restore the actual reading order in the working transcription. If a passage cannot be recovered reliably, report that extraction uncertainty rather than inventing a correction to the author's meaning. If the needed context is unavailable, distinguish a question to verify from a demonstrated omission. Do not expand a local review beyond the context needed to assess it.

An opening claim may be developed immediately afterward, and a closing sentence may summarize evidence already given. Judge whether that support is present, adequate, and easy to find. Do not demand that every sentence repeat the mechanism, experiment, or qualification. Equally, do not let a broad conclusion quietly drop a restriction supplied earlier. Read an independently reusable abstract, caption, or excerpt in its intended destination as well as in the document.

### Purpose, motivation, and argument

Find the statement that tells the reader what to understand or do. If the text merely announces a topic, determine whether its purpose requires an actual claim, question, result, or action. Ask why this particular reader needs it. Do not manufacture urgency, novelty, a research gap, a large social benefit, or a common misconception to make an introduction look complete. Practical costs and gaps in understanding are different reasons for writing (Lessons 7–8, pp. 98–124).

Reconstruct the chain from evidence to the main claim. Try a plausible counterinterpretation and check whether the text resolves it with evidence or an explicit limit. Test causal claims, comparisons, and scope against the source. Remove connectors such as “therefore” temporarily: does the inference still follow? A connector cannot supply a missing premise. Neither can a smooth narrative, a citation, or a confident conclusion (Lesson 5, pp. 77–78).

Trace the point and key concepts through the introduction, sections, and conclusion. Does each section develop what its opening led the reader to expect? Can the reader locate the relevant result without reconstructing the author's discovery process? Check for conclusions that answer a different question, introductions promising unsupported breadth, and paragraphs that serve the prompt's checklist rather than the document's argument.

For each questionable paragraph, identify its function: necessary background, claim, reason, evidence, explanation, qualification, or relevant alternative. If it serves none, remove or reposition it within the authorized scope. A chronological account is appropriate for a protocol, history, or requested process log. It is not the default organization for an argument just because the author worked in that order (Lesson 8, pp. 117–123).

Factual accuracy alone does not complete this review. A passage can preserve every fact yet leave the reader to assemble its point from a sequence of definitions, benefits, caveats, and cross-references. Check whether the reader can tell what is chosen and why, what operation uses a stated capability, and which claim a condition limits. Identify the missing or buried connection before proposing a reordering. A paragraph may serve several functions, and their useful order depends on its neighbors and audience rather than a fixed template.

Assess information density over that function and the surrounding argument. Technical nouns and numbers alone do not establish useful density. A short qualification can materially change a conclusion, while several different-sounding benefit statements can repeat one unsupported promise. For a suspected filler paragraph, determine what the reader would lose if it were removed. If it could move to an unrelated project with only names changed, check for a missing specific relationship, but allow background and summaries that this audience needs. Do not enforce a quota of new facts per sentence.

For claims about future benefits, identify the supplied mechanism, enabling condition, beneficiary, or observable outcome that makes the claim informative. Check whether an outlook follows from the document's results and limitations. A prospective claim need not pretend the benefit has already been demonstrated, and a benefits section need not be rewritten as criticism. Treat a specific research gap or negative result with the same evidence standard as a positive claim.

Do not force every genre into a problem-and-solution introduction. Do not require every paragraph to announce its point in the first sentence, every section to contain a summary, or every conclusion to add a new future question. Check whether this reader can follow the actual form, including purposeful narrative or delayed disclosure.

### Evidence, responsibility, and meaning

Look for missing or invented actors, unsupported causal links, hidden responsibility, overstated certainty, omitted counterevidence, and implications created by word order. A clearer sentence can still mislead. Verify who acted, chose, experienced a consequence, or made a claim before moving subjects, changing voice, or strengthening verbs (Lesson 12, pp. 188–206).

Compare names, quantities, units, domains, exceptions, negation, comparisons, citations, and uncertainty with the input. Check strict versus inclusive bounds, necessary versus sufficient conditions, and the clause modified by each time, frequency, or scope qualifier. A style edit must not turn a condition into a cause, an association into an intervention, a lower bound into an exact value, or a possible outcome into a guaranteed one. If sources contradict the desired conclusion, flag the conflict rather than making the sentence sound more persuasive.

For research results, trace the main quantitative and comparative claims in independently read summaries, especially abstracts and conclusions, to their defining result, table, or method before passing them. Recover the evaluated population or input set, method variant, metric and normalization, comparison baseline, and material test conditions. Check the summary against those conditions, not just against another summary or a matching number. A measured maximum over tested inputs does not establish a maximum over all inputs. A result for one variant does not establish the same result for the whole family, and an observed sample property does not establish a formal statistical property. This is part of the contextual review, not a requirement to reproduce experiments or audit every reported number.

When comparing a bound, diagnostic, and implementation result, verify that their symbols refer to the same objects or that the relationship between different objects is explained. Check that cross-references lead to the stated evidence and caption conditions match the plotted variables. Verify a suspected extraction error against the rendered source before reporting it as an authoring defect.

Check quotations and paraphrases against the source when available. Preserve qualifications, agency, and the distinction between another author's view and the document's conclusion. Attribution verbs must preserve the source's evidential strength. A proposal is not a demonstration. A citation alone does not justify closely copied wording, and an ellipsis must not change a quotation's meaning. Verify new or changed source claims as required by the shared reference. Follow the destination's current citation conventions rather than treating a textbook's sample formats as universal (Appendix II, pp. 230–238).

These checks concern the draft's assertions and the evidence available for them. They do not silently expand a writing review into a new experiment, a complete literature review, or a formal scientific peer review.

## Check continuity and reader comprehension

Read adjacent sentence pairs and then the whole paragraph. Does the next sentence begin from information the intended reader can recognize? Does it introduce unfamiliar terminology before supplying any usable context? Do the paragraph's subjects and recurring concepts form a coherent line, or merely a chain of locally related sentences drifting away from the point? Check information the audience knows, not information the writer knows from the conversation (Lessons 5–6, pp. 66–95).

Prefer a stable topic when it helps comprehension. Do not vary subjects or technical terms merely to avoid repetition. At the same time, repair exact repeated phrasing when it creates padding or hides development. Check whether sentence endings emphasize the actual claim, qualification, or new concept, rather than an incidental phrase or a declaration of the author's effort.

Judge a proposed rewrite inside the same surrounding text as the original. A new opening may repeat the preceding paragraph, require a definition that still comes later, or leave the next paragraph disconnected. Check whether the edit clarifies the relationship between claims or merely changes transitions and synonyms. When an authorized structural rewrite addresses a buried argument, preserving the original sentence-by-sentence order is not itself a success criterion. Keep an original passage when the alternative adds no reader benefit.

The movement from familiar to new, and from simple to complex, is a diagnostic tool for difficult prose. It is not a rule that every sentence must have the same order. Moving a clause can change emphasis and perceived responsibility, so check meaning after the move.

When a local construction causes a demonstrated misunderstanding, use the generation mechanisms in [durable prose](durable-prose.md) to repair it. Check alternative readings and preserve mathematical signs, qualifiers, and comparison scope. A review should explain the reader's difficulty rather than merely name a nominalization, passive verb, long sentence, or watched word. Apply explicit house-style constraints without presenting them as universal grammar laws.

Inspect the final visible text in the format's existing preview workflow when the task uses a rendered artifact. Include headings, captions, tables, footnotes, labels, and pasted text blocks in the review. Do not assume that a correct source file guarantees an intact visible sentence, citation, or cross-reference.

## Decide, repair, and check the delivered version

For each suspected defect, try to disprove the finding too. Is the detail supported? Does the intended audience already know the context? Is the apparently awkward form preserving scope or responsibility? Is the passage serving a legitimate genre function? Drop findings that depend only on taste, the existence of a watched word, or a rule used without its exceptions. Adversarial scrutiny applies to the reviewer's proposed fix as well as the draft.

When using an author's earlier papers as samples, distinguish observed habits from explicit preferences. A coauthored paper does not establish who chose each phrase or that its historical punctuation governs new work. Apply the user's current constraints to new deliverables without treating every departure in an old paper as a substantive defect. State which paper version was reviewed, especially when only a preprint is accessible.

When detector results accompany samples, keep the reported classifications separate from editorial findings. Compare similar passage functions and their context before proposing a stylistic explanation. A whole-paper score does not establish why a sentence received its label, and a human-classified sample can contain weak prose. An AI-classified span can contain necessary reasoning. Report counterexamples to a proposed explanation instead of selecting only supporting passages. Do not infer the detector's mechanism or upload supplied private text without authorization. Ordinary review does not optimize detector scores. An explicit request for detector-directed rewriting uses [detector evaluation](detector-evaluation.md), with this review checking the revised prose and its fidelity.

For generated or authorized edited prose, look for repeated contrasts, canned openings, empty endings, decorative triads, generic importance claims, borrowed authority, and chat residue. Repair supported defects and compare the revised claims with the input, including quantities and qualifications. Rework a clumsy paragraph around its actual point rather than exchanging one stock phrase for another. Recheck the changed passages and their transitions. After assembling sections, review the complete deliverable, not just each contributor's part. A previous pass does not cover subsequent changes to text, citations, or meaningful formatting.

The final version must have no unresolved prompt leakage, known factual or meaning error, necessary reasoning gap, material comprehension barrier, or violation of the user's explicit writing constraints. If resolving an issue requires missing facts or permission to change the substantive claim, report that precise limitation and do not label the affected text finished. Optional polish is not a reason for endless rewriting. A reviewed passage can remain unchanged.

For review-only work, lead with the substantiated findings, each with a usable location, reader consequence, and remedy. State when no actionable issue was found and disclose any material verification limits. Give paste-ready replacements only when requested, using the parent's applicable revision-feedback contract. Do not alter the source under a review-only request.

For generation or editing, keep the review internal unless the user requests its record. Deliver the reviewed text in the requested format, without embedding the review transcript, compliance claims, or criticism of the prior draft. Apply the parent's final lexical and semantic gate. The review stage does not require a second reviewer recursively to review its own findings.
