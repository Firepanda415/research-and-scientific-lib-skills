# Experimental results figures

## Choose an encoding for the scientific question

| Question | Useful options | Check |
|---|---|---|
| Compare methods on fixed instances | Points with intervals, grouped bars, small multiples | Preserve baseline semantics and uncertainty |
| Study a parameter or scale | Lines, points, facets | Show sampled locations and avoid implying unsupported interpolation |
| Inspect a matrix or grid | Heatmap | Define color scale, normalization, missing values, and ordering |
| Compare cost and error | Scatter, Pareto plot | State which direction is better on each axis; do not assume upper-right is best |
| Inspect variation across runs | Raw points, histogram, box plot, ECDF | Define sampling unit and summary; a box plot normally shows quartiles, not variance |

Other chart forms are valid when the data warrants them. Failure to fit this table is not evidence that the experiment is poorly designed. Use annotations selectively rather than labeling every dense matrix cell or every point.

## Evidence fidelity

Trace plotted values and transformations to the source data. Record the data selection and aggregation needed to regenerate the figure. Show the actual statistic and uncertainty. Separate illustrative values from computed results, and do not silently change a scale, normalization, metric, or excluded-case rule for visual convenience.

## Axes and comparison

Bars normally need a zero baseline because their length encodes magnitude. Use points or lines for a focused nonzero range when appropriate. Disclose breaks, clipping, and log scales. Axis direction follows the metric: low error and low cost may both be better. Highlight a method only to aid comparison, with equally legible baselines and consistent styling.

## Reproducible implementation

Reuse the project's plotting script or style. A standalone plot can use ordinary Matplotlib settings or an existing style file. Create `plot_utils.py` only when repeated plots require shared behavior and no existing mechanism covers it. Keep the source needed to regenerate a data-driven figure without building an unnecessary plotting framework.

Render at the final paper dimensions and inspect labels, line widths, uncertainty, and color/marker distinctions. Dense numerical layers can be rasterized when this materially reduces output size or rendering cost while preserving the information needed for the claim.

See `design-rules.md` for accessibility, captions, and uncertainty, and `tools.md` only when tool selection is unresolved.
