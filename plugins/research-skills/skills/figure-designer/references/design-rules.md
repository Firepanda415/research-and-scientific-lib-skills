# Scientific figure design checks

## Format and size

Prefer vector output for text, diagrams, and line art. Raster is appropriate for inherently pixel-based content and can be appropriate for dense numerical layers when it reduces rendering cost or file size without concealing relevant detail. Keep annotations vector when practical. Verify resolution at final size; a PDF container does not prove vector content.

Set the canvas for its final column or page dimensions. An approximately 8 pt font is a common lower-bound reference in two-column papers, not a universal rule. Verify actual readability and follow venue requirements. Use a consistent font family where practical; a serif paper does not automatically forbid sans-serif figure labels.

## Accessible encoding

Use distinguishable colors, adequate contrast, and line styles, markers, patterns, or labels where needed. Avoid relying on color alone for essential series distinctions. Choose sequential or diverging scales according to the data and its reference point. Several methods may need facets or direct labels rather than more colors.

Emphasis should identify the comparison, not manufacture a winner. Apply the same encoding consistently across figures and make relevant baselines readable.

## Captions

State what is shown, the important conditions, and the claim supported. Define abbreviations, uncertainty summaries, and data selection when the figure would otherwise be ambiguous. A results caption may lead with a finding; a setup or circuit diagram may instead lead with what it represents. No fixed caption sentence count is needed.

## Axes and uncertainty

Label axes with quantity and unit where applicable. A bar encodes magnitude by length and normally starts at zero. For a focused nonzero range, consider points or lines; disclose truncation, breaks, and clipping. Choose the range from the scientific question and variation, not from which choice makes the proposed method look best. Label logarithmic scales and invalid or missing values clearly.

Use error bars, intervals, or distributions when uncertainty matters to the claim. State what the interval represents, the sampling unit, and the number of independent runs. Standard deviation, standard error, confidence intervals, and a box plot's quartiles are different summaries. Do not invent uncertainty or request expensive repeated runs solely to add error bars.

## Circuit and schematic diagrams

Draw circuits with a tool that produces vector output, such as quantikz in LaTeX or a framework's circuit drawer exported as PDF or SVG. Check the drawing against the text as well as against the code that generated it.

- Order the wires so that the qubit order and endianness match the kets and indices in the text, and state the convention when it could be misread. Framework conventions differ. Qiskit, for example, writes bitstrings with qubit 0 as the rightmost bit.
- Show measurements explicitly, together with the classical wires or registers that receive their outcomes and any classically controlled operations.
- Use the gate names, parameters, and angle conventions of the equations, including sign and factor-of-two conventions for rotations.
- Mark ancillas, resets, mid-circuit measurements, and postselection, and state the postselected outcome.
- In other schematics, keep component names and signal directions consistent with the prose and equations.

## Decoration and severity

Remove decoration that obscures data, such as unnecessary perspective, gradients, or heavy grids. Three-dimensional encoding is useful when the scientific object is actually three-dimensional. Patterns can support accessibility.

Treat misleading encoding or unreadability as consequential. Styling differences and harmless decoration are usually editorial. Do not turn an aesthetic preference into a scientific defect.
