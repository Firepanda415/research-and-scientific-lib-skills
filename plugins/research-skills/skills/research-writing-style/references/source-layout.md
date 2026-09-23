# Source layout for research documents

Use these rules when authoring prose or math in a LaTeX, Markdown, or other source document, including manual paste-ready replacements. They govern source layout, not the paper's scientific notation.

## Prose and captions

Follow the target file's existing paragraph wrapping and equation-row layout. When the file sets no convention, as in an Overleaf manuscript edited paragraph by paragraph, write one paragraph per physical source line and apply the same rule to figure and table captions. Display math and table rows keep their own line structure. These rules govern new or replaced text, so leave untouched paragraphs in their current layout.

## Display math

Use these defaults when the file has no equation-row convention of its own.

- Keep a short display equation (`\[...\]` or a one-row environment) on one source line, delimiters included.
- In an `align`-family environment, use one source line per equation row (one `\\` group) whenever it reasonably fits.
- When a row is split, put the relation symbol (`&=`, `&:=`, `&\le`, ...) at the start of the line carrying the right-hand side. Never strand it on its own line.
- If both sides are long, split the row once: the left-hand side on the first line and the relation symbol plus full right-hand side on the second.
- If the right-hand side is still too long, break only at top-level `+`, `-`, or product boundaries, with the operator starting the continuation line.

Use the document's existing macros and notation. Check these source conventions as part of the [shared final gate](../SKILL.md), without adding a separate review pass.
