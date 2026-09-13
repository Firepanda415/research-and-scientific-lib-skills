# LaTeX format rules

## Table of contents

1. File organisation
2. Macro definitions
3. Citations
4. Labels and references
5. Figures and tables
6. Equations
7. Quotation marks and dashes
8. Revision conventions

## 1. File organisation

Preserve the existing source organization unless it causes a concrete maintenance problem. Splitting a long collaborative paper into section files is an option, not a submission requirement. Example structure:

```
sections/
figs/
exps/
algs/
main.tex
commands.tex
bibfile.bib
```

A single `main.tex` is also valid. Do not restructure files during a scientific audit solely to match this example.

## 2. Macro definitions

Reuse existing macros. Add a macro when repeated mathematical notation or styling makes it useful, not for every recurring word.

Example in `commands.tex`:

```latex
\newcommand{\sys}{\texttt{Alpha-SQL}\xspace}
\newcommand{\hi}[1]{\vspace{.25em}\noindent \textbf{#1}}
\newcommand{\lgl}[1]{\textcolor{blue}{LGL: #1}}
\newcommand{\revision}[1]{\textcolor{blue}{#1}}
```

Renaming becomes a one-line change rather than a find-and-replace
across dozens of sections. When a system name changes mid-
revision, the macro is the only edit required.

## 3. Citations

Rule L1: always use the non-breaking tilde between a word and its
citation, to prevent awkward line breaks.

| Bad | Good |
|---|---|
| `ResNet\cite{X}` | `ResNet~\cite{X}` |
| `ResNet \cite{X}` | `ResNet~\cite{X}` |

Multiple citations go inside one command:

```latex
Artificial Intelligence~\cite{xxxx, yyyy, zzzz}
```

Rule L2: follow the venue's citation style. ACL uses natbib with
`\citep` for parenthetical and `\citet` for textual. Data
management venues (SIGMOD, VLDB) use IEEE or ACM numeric styles.
Convert before submission.

Rule L3: verify bibliographic fields against the source and the venue requirements. Journal, preprint, software, and conference entries need different metadata; DBLP is one possible source, not an authority for every field.

## 4. Labels and references

Rule L4: labels use a consistent prefix and contain no spaces.
Underscores and hyphens are both valid in LaTeX labels; follow the
project convention consistently.

- `\label{fig:system_overview}` (good).
- `\label{sec:intro}` (good).
- `\label{system overview}` (bad; contains a space).
- `\label{system-overview}` (valid if hyphens are the project convention).

Rule L5: references also use the non-breaking tilde.

```latex
as shown in Figure~\ref{fig:system_overview}
discussed in Section~\ref{sec:intro}
```

## 5. Figures and tables

Rule L6: figures and tables need captions that explain what they show and the conditions
needed to interpret them. Results captions may lead with a finding; setup and circuit
diagrams need not invent an experimental conclusion.

Rule L7: default placement is top of page (`[t!]`). If the figure
does not fit at the top, `[b!]` (bottom) is acceptable. Inline
`[h]` placement rarely works; let LaTeX decide.

Rule L8: use vector-native formats (PDF, EPS, SVG) for charts,
diagrams, text, and line art. Raster is appropriate for inherently
pixel-based sources such as photographs, microscopy, medical images,
screenshots, and some dense heatmaps. Verify adequate resolution at
final size and keep annotations vector when practical; a PDF wrapper
does not make an embedded bitmap vector.

Rule L9: always reference the figure or table in prose before it
appears. "Figure 2 shows..." is the canonical pattern.

## 6. Equations

Rule L10: use equation numbers when they help citation or navigation. An unreferenced numbered equation is not automatically an error; do not add redundant prose merely to cite it.

Rule L11: equation numbering should be contiguous within a
section. Use `\label` on each numbered equation to allow
rearranging without renumbering manually.

## 7. Quotation marks and dashes

Rule L12: use the LaTeX convention for quotation marks.

- Double quotes: use `` `` `` for open, `` '' `` for close.
- Single quotes: use `` ` `` for open, `` ' `` for close.
- Never use the straight ASCII typewriter `"` character.

Rule L13: distinguish the three dash types. The project forbids em
dashes in authored body prose.

- Hyphen `-`: compound adjectives (high-efficiency, zero-shot).
- En-dash `--`: number ranges (pages 10--15, 2024--2026).
- Em-dash `---`: semantic break. Project rule: do not use em-
  dashes in the body. Use commas, colons, or periods instead.

## 8. Revision conventions

For revision submissions, follow the requested venue and project format. The following is an optional multi-reviewer organization:

```
responses/
  meta.tex
  r1.tex
  r2.tex
  r3.tex
```

When change highlighting is requested, reuse the existing revision macro or venue mechanism. One possible approach uses `\revision{...}` and `\marginpar`:

```latex
\marginpar[]{\revision{R1.W1}}{\revision{text}}
\marginpar[\revision{R3.W2}]{}{\revision{text}}
```

A summary table can help a long response letter. Do not add it when the venue format or a short point-by-point response already supplies adequate navigation.
