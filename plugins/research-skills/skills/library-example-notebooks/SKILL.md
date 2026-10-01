---
name: library-example-notebooks
description: "Write, restructure, or review example notebooks and tutorials for a scientific software library so that a newcomer sees on the first screen what the library computes and how to substitute their own problem. Use for example galleries, tutorial notebooks, and notebooks derived from papers. Review of the library itself uses scientific-library-review."
---

# Library example notebooks

Design for a reader who gives an example notebook about one screen before deciding whether to continue. Within that screen, show what the library computes for this kind of problem and how the reader can substitute their own. Apply `research-writing-style` to the notebook's prose and `figure-designer` to its main figure. When notebooks are reviewed as part of a library review, `scientific-library-review` and its user-workflow acceptance reference own the execution and scientific checks. A review request reports findings without editing the notebooks. Finish written or revised notebooks with the [review before delivery](#review-before-delivery).

## What every example provides

- **A runnable minimal example** near the top, in one visible cell with every import, the problem input, and the call. Hide nothing the call needs, even to shorten it.
- **A way to substitute the reader's own problem**, as a tested template cell that runs without the notebook's plotting or problem-specific assumptions. Give it distinct variable names, such as `my_A` and `my_b`, so it cannot overwrite variables the notebook's tests read. Name the representation the method needs, such as dense, Pauli-sum, or stencil access, and when a conversion such as SciPy's `.toarray()` is reasonable.
- **The meaning of inputs and outputs.** Next to the template, state the input format, the size limits, and what the returned value represents.
- **Claims with their conditions.** Next to each claim or result, state the conditions that decide whether it applies. A full theorem statement, derivation, or proof can sit in a collapsed block.
- **Execution evidence.** The notebook runs within the library's default resource limits when it declares them, otherwise within a run time and memory a newcomer's laptop can meet, stated in the title cell. Its displayed results come from the run. Label each main figure and key number with its output quantity, for example a physical solution or a normalized direction, and with its execution mode when the library has more than one, such as exact readout, finite shots, or classical evaluation. Give each number the digits the claim needs, usually two or three significant digits.

## A pattern for introductory notebooks

This organization suits an introductory notebook. Use the parts a notebook's length and purpose call for. A short example may need nothing beyond the outcomes above.

Open the first screen with these parts, in this order:

1. A title cell that states the problem in one paragraph, gives one install line with only the extras this notebook needs, and gives the problem size and run time.
2. A reading map at the end of the title cell. Use a Markdown blockquote with a bold lead phrase, such as "How to read this notebook.", then one line per part in reading order with its section numbers and a few words, at most six lines. A reader who sees two short code cells may start experimenting without noticing the explanation follows. Refer to sections rather than cells, because a collapsed cell between visible ones makes a cell count wrong in Jupyter.
3. The minimal example.
4. A collapsed helper cell for display code, placed after the minimal example. Some renderers show hidden cells expanded (see the note below), and this placement still shows the problem and the call first there.
5. A light result card:
   - one sentence with two or three key numbers and the execution mode when the library has more than one
   - the main figure
   - the resources on both sides, quantum (qubits, two-qubit gates or circuits, shots) and classical (peak memory, planning work, measured seconds)
   - two to four concrete steps the library performed for this problem, such as the representation or method it selected, the parameters it computed and the post-processing it applied (for a quantum linear solver, the block encoding, phase angles and restored solution scale)
   - a pointer to the template cell

   Put any detailed cost table, such as predicted and compiled gate counts for a quantum library, further down.

An introductory notebook also executes one refusal, so that the reader sees what the library declines and what its message says to change.

As checked in September 2026, a blockquote rendered as a set-off block in JupyterLab, VS Code, GitHub, and nbconvert. GitHub and nbconvert showed `jupyter.source_hidden` cells expanded, and GitHub did not reliably render HTML alert classes or in-notebook anchor links. Check the rendered first screen again when a renderer or template changes.

After the first screen, a longer introductory notebook can use three layers:

- **Main path**, about ten minutes of reading, with full precision kept in the appendix.
- **Go deeper** sections for research choices, sweeps, and theory. Open each with the question it answers in bold, then one sentence giving its cost, such as the number of solves and the run time.
- **Appendix** with the full resource estimate and any report or saved result the library produces.

## Notebooks derived from a paper

A notebook derived from a paper gives the answer first, then the paper's scope and derivations, in a main text and an appendix. Collapse its appendix tables rather than deleting them, but keep open the tables a reader needs to reproduce or check the paper, such as its parameters and a check of its key equations.

## Keep examples light and current

- Follow the library's existing notebook naming. Without one, name an introductory notebook by its algorithm and the mathematical problem it solves, such as `<algorithm>_<problem>_intro`, so a reader from another field with the same mathematical problem finds it. Merge variants of one algorithm that share the problem and call pattern, such as its kernels, state preparations or input routes, into one notebook.
- Show the method in a setting where it works, say why that setting matters, and state where the method stops working. A default whose result is negative gives a newcomer no reason to try the library.
- Keep the example code to the call and its result. Defensive checks that repeat the library's own validation, and dumps of raw records or JSON, bury the result.
- Run demonstrations on the smallest system that shows the point, within the resource limits above, because cost can grow steeply with problem size. Give larger sizes as planning numbers, labeled as not executed.
- Execute notebooks with a kernel in the environment the project declares, or record the one used when none is declared, and ensure it imports the library from the checkout being documented rather than an installed release. Stored outputs go stale silently when the library changes under an unchanged source, and a source comparison does not see it, so a release re-executes every notebook.
- Compute the result card's sentence from the run. Check it by swapping in another problem, such as another molecule, so the text cannot silently go stale.
- When notebooks compare the library with other packages, put the comparison on one dated page that states the scope of each claim. Notebooks link to it and give only their own concrete reasons.

## Rewriting a set of notebooks

Start from an adopter review that reads the notebooks as a newcomer and tests their claims with small scripts. Reviews by different models can find different problems, so when more than one adopter review is authorized, merge their findings into one plan. Pilot the planned changes on one notebook and check it as rendered HTML before applying them to the others, which can then proceed in parallel. Give parallel workers the approved pilot as their pattern, together with the execution environment and command, and run them so their results return to the agent that merges and checks them, for example in the foreground. When the user or project asks to approve the changes, get that approval on the rendered pilot first. Re-execute each notebook whose code, cell order, or outputs changed, within the authorized workload. When the project tests its notebooks, keep an independent reference check for each one. Each notebook job also reports what the library did not expose that the notebook needed, such as a peak memory it only admits, a bound it cannot return, the degree a refusal needs, or a predicted size or time; these are the library's next usability items. (One rewrite of eight notebooks, a pilot of 16 minutes and six parallel rewrites of 12 to 30 minutes each, took the set from 205 paragraphs over 50 words to none.)

## Review before delivery

Review each written or revised notebook as rendered, in a pass separate from writing it, and combine this pass with `research-writing-style`'s review stage and final gate for its prose and `figure-designer`'s check of its main figure. Render with `jupyter nbconvert --to html` or the renderer the library's readers use. When the rendered page cannot be viewed, check cell order, `source_hidden` metadata and outputs in the notebook file, and report that the visual check remains for the user. Fix what fails and recheck the affected cells.

- The first screen shows the problem, the minimal call and the result before any long explanation. Collapsed Markdown blocks render collapsed, and where a renderer expands a hidden cell, the problem and the call still come first.
- The template cell runs on its own with its own variable names, next to its input format, size limits and the meaning of the returned value.
- Each main figure and key number names its output quantity and, where the library has several, its execution mode. The result card's sentence comes from the run.
- The code holds no defensive checks that repeat the library's validation, no raw record or JSON dumps, and no text addressed to the conversation or its instructions.
- The notebook ran after the last code change of its own or of the library, within the resource limits above and with the library imported from the documented checkout, its stored outputs come from that run, and the report names the environment, execution command and code revision.
