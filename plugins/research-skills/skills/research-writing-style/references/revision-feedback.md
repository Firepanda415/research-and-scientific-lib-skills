# Delivering revision feedback on an existing document

When the deliverable is a set of edit suggestions against an existing file (manuscript, response letter, README) rather than fresh text, the user applies each edit by exact text search in their own editor (Overleaf). Every edit must therefore be self-locating and paste-ready. A diff, a patch hunk, or a prose description of a change is unusable.

Before writing any feedback, re-read the target file from disk, even if it was read earlier in the session. The user swaps updated copies into the folder between rounds, and suggestions computed against a stale version locate nothing. Check the modification time, verify that the anchors about to be quoted exist in the current file, and if the file shows no sign of the update the user described, say so before writing any feedback.

**Revision-set packaging.** Group edits by exact target path and assign stable edit IDs (`V1`, `V2a`, and so on). Map each edit to the specific defect or audit finding, then give one concise rationale before the mechanical instruction. Label each item `proposed`, `already applied`, `deferred`, or `no change`. Report verification such as anchor checks or builds separately so a proposed edit is never presented as completed. Keep deliberate `no change` decisions outside the paste instructions, with one concise reason and any optional alternative labeled explicitly.

**Per-edit format.** Every edit has exactly three parts, in this order:

1. **Position and operation**: the line number in the current file, plus one of *replace*, *insert after*, *insert before*.
2. **Anchor**: a span quoted character for character from the current file. Copy it out of the file, never retype or paraphrase it from memory. It must be long enough that an exact text search finds exactly one hit, and uniqueness must be verified by actually searching the file before delivering. For *replace*, the anchor is exactly the span being replaced, first character to last, so the user selects the search hit and pastes over it. For *insert after / insert before*, the anchor is an existing adjacent line, or a unique prefix of it, and that line stays untouched.
3. **New text**: a fenced block containing only what gets pasted, nothing else. No ellipses, no placeholders, no unchanged context mixed in. The block obeys [source layout](source-layout.md), and the parent [final gate](../SKILL.md) applies separately to every new replacement or insertion block. When a value is unresolved, supply a clearly labeled template or TODO instead of calling the block paste-ready.

A *replace* edit is delivered exactly like this:

> Line 1968, anchor (the exact span being replaced): `Ideal normalized kernel target before any coefficient or oscillator-space truncation.`
> Replace with:
> ```latex
> Ideal normalized kernel target before coefficient or oscillator-space truncation.
> ```

An *insert after* edit (the anchor line itself stays):

> Line 20, anchor: `\usepackage{xcolor}`
> Insert after that line:
> ```latex
> \usepackage{arydshln}
> ```

**Multiline and compact replacements.** For a multiline replacement, show the complete character-exact old block in a plain fenced block, followed by the complete new block in a language-appropriate fenced block. Identify the first and last boundaries when the block is long. Never abbreviate either block. For several independent one-token replacements, a compact `line, exact anchor` → `exact replacement` list is acceptable only when every anchor is unique and verified.

**Mechanical many-spot changes.** Use a global find-replace only when every hit is active and in scope. Search the complete file first, then provide the pattern, target, and expected hit count:

> Global replace `\delta t` → `\Delta t`, exactly 9 hits expected (verified that the file contains no other `\delta t`).

If the pattern also occurs in commented, legacy, or unrelated text, do not use a file-wide global replacement. Enumerate the unique active anchors, or give a verified bounded scope and expected hit count, and state explicitly that excluded occurrences stay untouched. Optionally add an equivalent sed command with the same bounded scope for the local copy.

**Never deliver:**

- a diff or patch hunk (`@@ ... @@`, leading `+`/`-` lines): it cannot be applied by text search,
- a paraphrased or from-memory anchor ("the sentence about the kernel target"): it will not match anything,
- a position without an anchor ("the third paragraph of Section 4"): line numbers alone go stale the moment the file changes,
- an anchor that matches more than one place in the file: lengthen it until unique,
- a block that mixes new text with unchanged context, forcing the user to hand-merge.

At the start of a revision set, state whether the edits are order-independent. Otherwise give the mandatory application order. When several edits touch neighboring lines, either merge them into one *replace* spanning the whole region, or anchor each edit on a distinct line so applying one edit does not invalidate the next anchor. The labels ("anchor", "replace with") follow the language of the conversation, and the three-part structure is fixed.
