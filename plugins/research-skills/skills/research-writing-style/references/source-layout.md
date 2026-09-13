# Source layout for research documents

Use these rules when authoring prose or math in a LaTeX, Markdown, or other source document, including manual paste-ready replacements. They govern source layout, not the paper's scientific notation.

## Prose and captions

One paragraph is one physical source line. Apply the same rule to figure and table captions. Hard wraps inside a paragraph interfere with the user's paragraph-by-paragraph Overleaf workflow. Display math and table rows keep their own line structure.

## Display math

- Keep a short display equation (`\[...\]` or a one-row environment) on one source line, delimiters included.
- In an `align`-family environment, use one source line per equation row (one `\\` group) whenever it reasonably fits.
- When a row is split, put the relation symbol (`&=`, `&:=`, `&\le`, ...) at the start of the line carrying the right-hand side. Never strand it on its own line.
- If both sides are long, split the row once: the left-hand side on the first line and the relation symbol plus full right-hand side on the second.
- If the right-hand side is still too long, break only at top-level `+`, `-`, or product boundaries, with the operator starting the continuation line.

Use the document's existing macros and notation. Check these source conventions as part of the [shared final gate](../SKILL.md), without adding a separate review pass.
