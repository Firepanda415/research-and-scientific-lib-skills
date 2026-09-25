---
name: tech-paper-template
description: Plan, draft, or repair a technical paper's argument, Introduction, and section structure from its actual claims and evidence. Use for paper skeletons, Introduction drafting, logic-chain questions, and pre-drafting discussion. A local prose edit or a referee report does not need a full structure-planning workflow.
---

# Tech Paper Template

Make the central contribution, motivation, and supporting evidence easy to follow.
Start from what the work establishes rather than fitting it to a publication
template or requiring a separate idea-assessment verdict.

## Argument structure

Identify the research question, the relevant limitation or unresolved issue,
the main insight or result, and the evidence that supports it. For a method
paper, challenges and method components can expose gaps in the argument. For a
theory, impossibility, explanatory, replication, or resource-estimation paper,
use definitions, assumptions, results, and their implications as appropriate.

The "New method or mechanism" and "New problem or setting" rows of
[paper-types.md](references/paper-types.md) are useful narrative examples, not
exhaustive paper types. A benchmark contribution can use
`benchmark-paper-template` when its measurement-specific guidance is helpful.

Check the connections that bear the claim:

- Does prior work actually leave the stated problem open?
- Does the result or mechanism answer that problem under the stated assumptions?
- Does the evidence support the contribution and its claimed scope?
- Is each major section needed to explain, establish, or evaluate the result?

Do not invent limitations, challenges, modules, or contribution bullets to fill
cells. A method component need not be a standalone contribution, and a scientific
result need not map one-to-one onto an implementation module.

When turning experiment or validation records into a manuscript, organize the
results around the conclusions the evidence supports. Present each main result
with its evidence type and material conditions, distinguishing an identity, a
conditional bound, a numerical observation, and a physical interpretation.
State the supported result directly, and keep counterevidence and unsuccessful
controls visible when they explain or limit it. Move routine search chronology,
seeds, and refinement logs to methods, appendices, or linked records as appropriate.
Introduce the main result once its necessary assumptions and definitions are in
place. Give background, dictionaries, and classifications the space needed to
understand the argument.

## Output

Produce the requested skeleton, diagnosis, or structure proposal. A compact
claim-to-evidence table can help a complex argument; a short paragraph may be
enough for a local problem. Choose section count, labels, and order from the
venue, genre, and argument. Preserve an existing useful structure.

Rank gaps by their consequence for the central claim. Missing support or an
invalid argument matters more than an absent template cell. Do not label a
format preference as a submission-blocking scientific problem.

For Introduction drafting, use [introduction.md](references/introduction.md) with
the available claims and evidence. Draft prose when that is the user's request;
do not stop after an outline or require a separate handoff artifact. When
drafting or revising manuscript prose, follow `research-writing-style`.

## Optional references

- [thinking-template.md](references/thinking-template.md): prompts for method
  papers; use relevant cells only.
- [consistency-checks.md](references/consistency-checks.md): examples of broken
  argument links and their actual consequences.
- [paper-types.md](references/paper-types.md): common narrative axes.
- [worked-examples.md](references/worked-examples.md): illustrative outlines;
  inspect the named source before using its details as evidence.
