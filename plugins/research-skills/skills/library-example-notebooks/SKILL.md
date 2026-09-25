---
name: library-example-notebooks
description: "Write, restructure, or review example notebooks and tutorials for a scientific software library so that a newcomer sees on the first screen what the library computes and how to substitute their own problem. Use for example galleries, tutorial notebooks, and notebooks derived from papers. Review of the library itself uses scientific-library-review."
---

# Library example notebooks

Design for a reader who gives an example notebook about one screen before deciding whether to continue. Within that screen, show what the library computes for this kind of problem and how the reader can substitute their own. Apply `research-writing-style` to the notebook's prose and `figure-designer` to its main figure. When notebooks are reviewed as part of a library review, `scientific-library-review` and its user-workflow acceptance reference own the execution and scientific checks. A review request reports findings without editing the notebooks.

## First screen

Open an introductory notebook with these parts, in this order:

1. A title cell that states the problem in one paragraph, gives one install line with only the extras this notebook needs, and gives the problem size and run time.
2. A reading map at the end of the title cell. Use a Markdown blockquote with a bold lead phrase, such as "How to read this notebook.", then one line per part in reading order with its section numbers and a few words, at most six lines. A reader who sees two short code cells may start experimenting without noticing that the explanation follows. Refer to sections rather than cells, because a collapsed cell between visible ones makes a cell count wrong in Jupyter.
3. A visible cell with every import, the problem input, and the minimal call. Hide nothing the call needs, even to shorten it.
4. A collapsed helper cell for display code, placed after the minimal call. GitHub and nbconvert ignore `jupyter.source_hidden` and show the cell expanded, so this placement still shows the problem and the call first there.
5. A light result card:
   - one sentence with two or three key numbers and, when the library has more than one, the execution mode, such as exact readout, finite shots, or classical evaluation
   - the main figure
   - two to four concrete steps the library performed for this problem, such as the encoding it chose, the phases it computed, and the physical scale it restored
   - a pointer to the "your own problem" cell

   Put any detailed cost table, such as predicted and compiled gate counts for a quantum library, further down.

A blockquote renders as a set-off block in JupyterLab, VS Code, GitHub, and nbconvert. HTML alert classes and in-notebook anchor links do not render reliably on GitHub, as checked in September 2026. Check the rendered first screen again when a renderer or template changes.

## Body

Give an introductory notebook three layers:

- **Main path**, about ten minutes of reading. Label every main figure and key number with its output quantity, for example a physical solution or a normalized direction, and with its execution mode when that varies. Use the digits the claim needs, usually two or three, and keep full precision in the appendix.
- **Go deeper** sections for research choices, sweeps, and theory. Open each with the question it answers in bold, then one sentence giving its cost, such as the number of solves and the run time. Place theorem conditions in `<details>` blocks next to the text they support.
- **Appendix** with the full resource estimate and any report or saved result the library produces.

A notebook derived from a paper gives the answer first, then the paper's scope and derivations, in two layers, main text and appendix. Collapse its appendix tables rather than deleting them, except the parameter table and the table that checks the paper's equations, which stay open.

## Your own problem

Provide a tested template cell that runs without the notebook's plotting or problem-specific assumptions. Give it distinct variable names, such as `my_A` and `my_b`, so that it cannot overwrite variables the notebook's tests read. Beside it, state the input format, the size limits, and the meaning of the returned value. Name the representation the method needs, such as dense, Pauli-sum, or stencil access, and when a conversion such as SciPy's `.toarray()` is reasonable.

## Keep examples light and current

- Run demonstrations on the smallest system that shows the point, within the library's default resource limits, because cost can grow steeply with problem size. Give larger sizes as planning numbers that are not executed.
- Compute the result card's sentence from the run. Check it by swapping in another problem, such as another molecule, so that the text cannot silently go stale.
- When notebooks compare the library with other packages, put the comparison on one dated page that states the scope of each claim. Notebooks link to it and give only their own concrete reasons.

## Rewriting a set of notebooks

Start from an adopter review that reads the notebooks as a newcomer and tests their claims with small scripts. Reviews by different models can find different problems, so when more than one adopter review is authorized, merge their findings into one plan. Pilot the pattern on one notebook, and have the owner review it as rendered HTML before applying it to the others, which can then proceed in parallel. Check each rendered first screen, including what appears before the first result and whether collapsed blocks render collapsed. Re-execute each notebook whose code, cell order, or outputs changed, within the approved workload. When the project tests its notebooks, keep an independent reference check for each one.
