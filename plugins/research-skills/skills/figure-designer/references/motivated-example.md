# Motivated Example (Figure 1) design

## Table of contents

1. When an early figure helps
2. Paradigm A: Running Example plus Failure Case
3. Paradigm B: Existing vs Ours
4. Paradigm C: Performance Teaser
5. Design principles
6. Tool recommendations

The named paper figures cited below (with venue and year) were
representative examples at the time of writing; substitute newer
top-venue examples from the user's field where available, and do
not assert visual details of these figures beyond what is
described here.

## 1. When an early figure helps

An early figure can convey in a quick scan (a) what problem the
paper tackles and (b) why current methods do not solve it. When it
helps, place it near the text that motivates it, such as the
Introduction's statement of the limitation, within the venue's float
placement.

Budget deliberate iteration time for Figure 1. One to two working
days is a useful planning heuristic for a complex figure, not a
requirement; scope the effort to the venue and figure complexity.

## 2. Paradigm A: Running Example plus Failure Case

Show a real, specific scenario and then show what goes wrong under
the current method.

### Layout

A two-panel or three-panel figure:

- Panel 1 (top or left): the real input. Natural language query,
  image, sensor trace, or whatever the task takes.
- Panel 2 (middle or centre): what a current method produces. Label
  the incorrect output and mark the error with a cross or annotation.
  Red can supplement these cues.
- Panel 3 (optional, right or bottom): what the paper's method
  produces or promises. Label the correct output and use a check
  mark or annotation. Green can supplement these cues. The distinction
  must remain clear without color.

### When to use

- The problem is concrete and the failure is easy to show.
- Text-to-SQL, code generation, visualisation, agent workflows.
- Any case where a side-by-side output comparison exists.

### Canonical example

Text-to-SQL: show a natural-language query such as "find all
professors who published at least 3 papers in 2024 and their
departments", then show the current-method SQL missing a GROUP BY,
yielding thousands of duplicated rows; then the correct SQL.

## 3. Paradigm B: Existing vs Ours

The figure splits into two side-by-side panels. Left shows how the
existing method works and why it fails; right shows how the paper's
method works and why it succeeds.

### Layout

Two vertical columns. Each column has:

- A schematic of the method's internal structure.
- An annotated failure or success indicator.
- A one-line caption inside the panel naming the method.

### When to use

- The contribution is a structural change to the method's internal
  architecture rather than a failure on a specific input.
- Visualisation is possible at the mechanism level (operator graph,
  data flow, component layout).

### Canonical example

AFlow (ICLR 2025) Figure 2 shows Node, Operator, Edge concepts
side-by-side against traditional workflow representations.

## 4. Paradigm C: Performance Teaser

A carefully designed performance figure placed inside the
Introduction as a preview of results.

### Layout

A compact chart previewing the headline comparison, using the same
metric, uncertainty, and legible baselines as the full results
figure. The chart is paired with a one-sentence text annotation
explaining what the reader is seeing.

### When to use

- The method's performance gain is the headline contribution and
  is large enough to speak for itself.
- Benchmark-style results are available.
- The paper is short (conference style) and needs to hook the
  reader with numbers.

### When to avoid

- Gains are marginal; a teaser shows this weakness unkindly.
- The paper's value is qualitative (ambiguity handling, robustness)
  and does not fit a single metric.

## 5. Design principles

- **Sketch first (optional suggestion)**. For a complex figure,
  the agent may suggest that the user sketch it by hand and show the
  sketch to a collaborator before detailed drawing.
- **Real entities only**. Name real queries, real datasets, real
  outputs. Placeholder names ("Entity1", "X") undermine credibility.
- **Quick-scan test (optional suggestion)**. The agent may suggest
  that the user show the figure to someone unfamiliar with the paper.
  If that reader cannot describe the problem after a brief scan, the
  figure needs revision.
- **Reusing the example**. Reusing the example in later sections can
  help when it clarifies the method. Reuse is optional.

## 6. Tool recommendations

Primary: PowerPoint (draft), Figma (polish). See tools.md for the
full matrix and trade-offs.

Code snippets inside the figure: prefer typeset or syntax-highlighted
vector text. If a screenshot is necessary to preserve an interface
or rendering, capture it at sufficient final-size resolution, avoid
repeated resampling, and keep surrounding labels and arrows vector.
