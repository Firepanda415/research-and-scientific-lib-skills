---
name: figure-designer
description: Design, produce, or audit research figures with accurate scientific encoding, legible layout, and reproducible data-driven plots. Use for figure design, circuit or method diagrams, experimental plots, chart selection, or figure critique.
---

# Figure Designer

Design, produce, or audit the figure the research argument needs. Motivated examples, method overviews, and result plots are useful families, not a requirement for every paper. Circuit diagrams, spectra, geometry, derivation sketches, and other scientific figures need not fit those three categories.

## Work from the claim and available evidence

1. Identify what the reader should learn and which source, equation, or data supports it. Inspect supplied figures and relevant manuscript context directly. Distinguish a numerical result from a conceptual illustration.
2. Choose an encoding and layout that make the comparison or relationship legible. Axis direction, normalization, units, uncertainty, selection, and aggregation must match the actual data. Do not position or highlight the proposed method according to a desired conclusion.
3. Reuse the project's plotting tools and style. For a standalone plot, ordinary plotting-library settings are sufficient. Add shared utilities only when existing repeated use justifies them.
4. When inputs permit, create the requested artifact and keep enough source to reproduce a data-driven plot. Render and inspect it at its intended size. If only a design can be produced, label that deliverable accurately.

Load only relevant references:

- `references/motivated-example.md`: optional comparison or motivating-example layouts.
- `references/solution-overview.md`: optional method and architecture layouts.
- `references/experimental-results.md`: chart selection and quantitative encoding.
- `references/design-rules.md`: format, legibility, captions, axes, uncertainty, and circuit and schematic conventions.
- `references/tools.md`: tool options when the existing workflow does not settle the choice.

## Scientific and visual checks

- Trace plotted values, transformations, and selections to data or explicitly labeled illustrative inputs. Never alter data to improve appearance.
- Use meaningful axes, units, scales, and ranges. Bars generally need their length baseline at zero; use a point or line plot when a focused nonzero range is scientifically useful. Show breaks or clipping explicitly.
- Show uncertainty or distributions when they bear on the claim, and label the statistic, sample unit, and number of independent runs. Do not run extra simulations merely to decorate a plot with error bars.
- Prefer vector output for line art and labels. Dense numerical layers may be rasterized to control file size and rendering cost; verify resolution at final size. A PDF wrapper alone does not prove vector content.
- Check text and line visibility after scaling. Use accessible palettes and redundant encoding when needed to distinguish series. Fonts and dimensions follow the venue and final layout rather than a fixed canvas.
- Captions must state what is shown and the scope needed to interpret it. Lead with a finding when that suits the figure; a circuit or setup diagram need not invent an experimental conclusion.

## Delivery

Return the artifact or actionable design with the important decisions and remaining uncertainties. Audit findings should distinguish misleading scientific encoding, unreadability, and optional polish. No fixed eight-section report, named paradigm, alternate-tool essay, or user confirmation checklist is required. For a comprehensive audit, cover every supplied figure and all relevant issues without repeating boilerplate.
