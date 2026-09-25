# Adversarial review before delivery

Read this reference for the parent's mandatory review stage and for review-only requests. Review the text that exists. Do not generate another version merely to have something to compare, and do not rewrite a sound passage to demonstrate effort. The shared criteria remain in [durable prose](durable-prose.md).

Also read [document review](document-review.md) when a deliverable's reasoning depends on its structure or surroundings. This covers a document of several paragraphs or sections, a passage added to or revised within a longer document such as a manuscript, report, README, or instruction file, a review-only request about an existing document or an excerpt from one, and a short text such as an abstract or a caption whose claims rest on the results, figure, or text around it. That reference covers extracted material, purpose and argument, and continuity. A short self-contained text, such as an email, a commit message, or a standalone brief instruction, completes review with this reference. The evidence checks below apply to every claim, number, and citation at any length.

The reader-oriented diagnostics here draw on Joseph M. Williams and Joseph Bizup, *Style: Lessons in Clarity and Grace*, 11th edition, Pearson, copyright 2014, ISBN 978-0-321-89868-5. Page references below use the book's printed numbering. This is an independently written review procedure informed by the book's ideas and this collection's requirements, not a reproduction of its lessons, examples, or exercises. The book treats its principles as aids to diagnosis rather than universal prescriptions (Preface, p. vii).

## Review as a skeptical reader

Try to establish why the draft should not be delivered. Challenge the main claim, the logic connecting it to evidence, the reader's ability to follow it, and the need for each part. Do not accept the drafter's confidence, a previous approval, the user's preferred conclusion, or a polished tone as evidence. Read the actual draft and sources needed to check a finding.

Start with the artifact alone, as a reader who has not seen the conversation. Reconstruct its point, audience, necessary background, and line of reasoning. Then compare it with the brief and source material, kept separate from the draft. Do not silently fill gaps using private chat context and then judge the prose clear.

The primary review unit is a complete argument in its document context. Sentence construction and word choice belong primarily to the generation mechanisms in [durable prose](durable-prose.md). Review still catches local errors and ambiguity, but isolated words, sentence lengths, and detector labels do not establish a defect.

For a substantial document, use an independent reviewer when available. Give that reviewer the complete draft, intended reader, relevant source facts, and task limits, without the writer's self-assessment or desired verdict. Treat a report or pull-request description about completed work as substantial for this purpose, and also give the reviewer access to the sources it describes, such as the diff, logs, and results, so that it can check numbers, the order of events, and compatibility statements. The reviewer must be free to reject the draft. A short passage can receive a separate skeptical reread by the writer. The absence of another agent never waives review, and using another agent never transfers responsibility for the final version.

Adversarial review needs evidence. For each finding, identify the location, the exact defect, its likely effect on this reader, and the smallest adequate remedy. Distinguish factual or meaning errors, comprehension barriers, explicit house-style violations, and optional taste. Do not invent flaws, require a quota, inflate a minor preference into a blocker, or lead with praise to soften a real problem. If a claim cannot be checked, report what is missing without pretending it is either proved or false.

## Hard gate: exclude conversation and prompt leakage

Separate source facts the user supplied from instructions about how to write. Audience, scope, tone, prohibited moves, feedback on previous drafts, and generation plans control the work. They do not become content merely because they appeared in a message. Removals made during the work change what the artifact describes. They do not become statements about the removed item.

Inspect every reference to the user, a prompt, the conversation, an earlier draft or version, an instruction, or the writing process. Also inspect unexplained deictic phrases, declarations of compliance, defensive exclusions, negative comparisons, and mentions of removed items. Typical symptoms include “as you requested,” “the user emphasized,” “this version avoids,” “we do not discuss X,” “unlike the previous draft,” “X is no longer used,” “now uses Y,” “ignore the old X,” “根据你的要求,” “按前面讨论,” “这里不做 X,” “不再使用 X,” “改为 Y,” and “不是 X，而是 Y.” These are prompts for inspection, not a string blacklist.

For each suspect sentence, ask:

1. Does it tell the intended reader something about the subject, or merely record how the assistant was told to write?
2. Would it belong here if that reader had never seen the prompt? Does the draft give the reader the needed context on its own?
3. Does a negative statement express a supported technical boundary, a necessary instruction to this reader, or a real alternative they need to distinguish? Or did it appear only because the user told the writer not to do something, or because an earlier draft or version contained the item?

Remove process residue without replacing it with a smoother declaration of obedience. Express the supported positive content directly. A request not to discuss a topic does not establish that the method excludes it, cannot handle it, or deliberately rejected it. If excluding that topic needs no explanation for this reader, give none.

Original examples of this distinction:

| Writing brief | Failed artifact text | Required treatment |
|---|---|---|
| “不要夸大结果” | “We avoid overstating the significance of these results.” | Report the result with its actual evidence and limits. Remove the self-assessment. |
| “不要在这里讨论噪声” | “Our method does not consider noise.” | Delete the invented scope claim. The writing instruction is not evidence about the method. |
| “别提我们刚才试过的方案” | “Unlike the previous approach, this method is straightforward.” | State the current method and any reader-relevant rationale supported by the material. |
| “去掉 `--fast` 选项” | “The CLI no longer offers `--fast`. Do not reintroduce it.” | Document the current options. Put the removal in the commit message, and in the changelog when users must change their commands. |
| Supplied fact: the bound assumes finite dimension | “The bound is proved only for finite-dimensional systems.” | Keep it when it states the actual scope. A necessary limitation is not prompt residue. |
| Supplied decision: dense storage exhausted memory above 24 qubits, so the project uses MPS | “Use MPS at every system size. Dense storage exhausted memory above 24 qubits.” | Keep it. It states the current rule and its measured reason. |

Exceptions must follow the artifact's purpose. A requested conversation record, revision history, response letter, migration guide, or reusable instruction set may need process information or prohibitions. Include only the history or instruction the user intends that reader to receive. Do not expose incidental chat wording or private working notes. A skill about writing rules can state writing rules. A paper's result section normally cannot narrate compliance with its drafting prompt.

## Check evidence, responsibility, and meaning

Look for missing or invented actors, unsupported causal links, hidden responsibility, overstated certainty, omitted counterevidence, and implications created by word order. A clearer sentence can still mislead. Verify who acted, chose, experienced a consequence, or made a claim before moving subjects, changing voice, or strengthening verbs (Lesson 12, pp. 188–206).

Compare names, quantities, units, domains, exceptions, negation, comparisons, citations, and uncertainty with the input. Check strict versus inclusive bounds, necessary versus sufficient conditions, and the clause modified by each time, frequency, or scope qualifier. A style edit must not turn a condition into a cause, an association into an intervention, a lower bound into an exact value, or a possible outcome into a guaranteed one. If sources contradict the desired conclusion, flag the conflict rather than making the sentence sound more persuasive.

For research results, trace the main quantitative and comparative claims in independently read summaries, especially abstracts and conclusions, to their defining result, table, or method before passing them. Recover the evaluated population or input set, method variant, metric and normalization, comparison baseline, and material test conditions. Check the summary against those conditions, not just against another summary or a matching number. A measured maximum over tested inputs does not establish a maximum over all inputs. A result for one variant does not establish the same result for the whole family, and an observed sample property does not establish a formal statistical property. This is part of the contextual review, not a requirement to reproduce experiments or audit every reported number.

When comparing a bound, diagnostic, and implementation result, verify that their symbols refer to the same objects or that the relationship between different objects is explained. Check that cross-references lead to the stated evidence and caption conditions match the plotted variables. Verify a suspected extraction error against the rendered source before reporting it as an authoring defect.

Check quotations and paraphrases against the source when available. Preserve qualifications, agency, and the distinction between another author's view and the document's conclusion. Attribution verbs must preserve the source's evidential strength. A proposal is not a demonstration. A citation alone does not justify closely copied wording, and an ellipsis must not change a quotation's meaning. Verify new or changed source claims as required by the shared reference. Follow the destination's current citation conventions rather than treating a textbook's sample formats as universal (Appendix II, pp. 230–238).

These checks concern the draft's assertions and the evidence available for them. They do not silently expand a writing review into a new experiment, a complete literature review, or a formal scientific peer review.

## Decide, repair, and check the delivered version

Inspect the final visible text in the format's existing preview workflow when the task uses a rendered artifact. Include headings, captions, tables, footnotes, labels, and pasted text blocks in the review. Do not assume that a correct source file guarantees an intact visible sentence, citation, or cross-reference.

For each suspected defect, try to disprove the finding too. Is the detail supported? Does the intended audience already know the context? Is the apparently awkward form preserving scope or responsibility? Is the passage serving a legitimate genre function? Drop findings that depend only on taste, the existence of a watched word, or a rule used without its exceptions. Adversarial scrutiny applies to the reviewer's proposed fix as well as the draft.

When using an author's earlier papers as samples, distinguish observed habits from explicit preferences. A coauthored paper does not establish who chose each phrase or that its historical punctuation governs new work. Apply the user's current constraints to new deliverables without treating every departure in an old paper as a substantive defect. State which paper version was reviewed, especially when only a preprint is accessible.

When detector results accompany samples, keep the reported classifications separate from editorial findings. Compare similar passage functions and their context before proposing a stylistic explanation. A whole-paper score does not establish why a sentence received its label, and a human-classified sample can contain weak prose. An AI-classified span can contain necessary reasoning. Report counterexamples to a proposed explanation instead of selecting only supporting passages. Do not infer the detector's mechanism or upload supplied private text without authorization. Ordinary review does not optimize detector scores. An explicit request for detector-directed rewriting uses [detector evaluation](detector-evaluation.md), with this review checking the revised prose and its fidelity.

For generated or authorized edited prose, look for repeated contrasts, canned openings, empty endings, decorative triads, generic importance claims, borrowed authority, and chat residue. Repair supported defects and compare the revised claims with the input, including quantities and qualifications. Rework a clumsy paragraph around its actual point rather than exchanging one stock phrase for another. Recheck the changed passages and their transitions. After assembling sections, review the complete deliverable, not just each contributor's part. A previous pass does not cover subsequent changes to text, citations, or meaningful formatting.

The final version must have no unresolved prompt leakage, known factual or meaning error, necessary reasoning gap, material comprehension barrier, or violation of the user's explicit writing constraints. If resolving an issue requires missing facts or permission to change the substantive claim, report that precise limitation and do not label the affected text finished. Optional polish is not a reason for endless rewriting. A reviewed passage can remain unchanged.

For review-only work, lead with the substantiated findings, each with a usable location, reader consequence, and remedy. State when no actionable issue was found and disclose any material verification limits. Give paste-ready replacements only when requested, using the parent's applicable revision-feedback contract. Do not alter the source under a review-only request.

For generation or editing, keep the review internal unless the user requests its record. Deliver the reviewed text in the requested format, without embedding the review transcript, compliance claims, or criticism of the prior draft. Apply the parent's final lexical and semantic gate. The review stage does not require a second reviewer recursively to review its own findings.
