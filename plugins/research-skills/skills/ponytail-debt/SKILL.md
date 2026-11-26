---
name: ponytail-debt
description: >
  Collect deliberate `shortcut:` comments, and older `ponytail:` ones, into a debt
  ledger. Use for Ponytail debt or shortcut inventory requests. Read-only and one-shot.
---

Every deliberate shortcut is marked with a `shortcut:` comment naming
its ceiling and upgrade path. This collects them into one ledger so a deferral
can't quietly become permanent. Repositories marked before the marker was renamed
still hold `ponytail:` comments, and the scan collects those too.

## Scan

Search repository source files for comment markers, skipping `.git`, `.agents`, `.claude`, `.gemini`, `node_modules`, `.venv`, `venv`, `.tox`, `__pycache__`, `build`, `dist`, `target`, and skill documentation (`SKILL.md`). Use ripgrep when available:

`rg -n --hidden --glob '!**/.git/**' --glob '!**/.agents/**' --glob '!**/.claude/**' --glob '!**/.gemini/**' --glob '!**/node_modules/**' --glob '!**/.venv/**' --glob '!**/venv/**' --glob '!**/.tox/**' --glob '!**/__pycache__/**' --glob '!**/build/**' --glob '!**/dist/**' --glob '!**/target/**' --glob '!**/SKILL.md' '(#|//|--|/\*|<!--)[ \t]*(shortcut|ponytail):' .`

Without `rg`, run `git grep -nE --untracked` or the host's search tool with the
same pattern and exclusions. Add the comment prefixes of the repository's
languages to the pattern, such as `!` for Fortran or `%` for MATLAB and LaTeX.
Where the project uses its own marker for deliberate shortcuts, search for that
marker as well.

Each hit in actual source code (excluding documentation examples that illustrate the marker convention) is one ledger row.

## Output

One row per marker, grouped by file:

`<file>:<line>, <what was simplified>. ceiling: <the limit named>. upgrade: <the trigger to revisit>.`

The convention is `shortcut: <ceiling>, <upgrade path>`, so pull the ceiling
and the trigger straight from the comment. Want an owner per row too? add
`git blame -L<line>,<line>`.

Flag the rot risk: any marker comment that names no upgrade path or
trigger gets a `no-trigger` tag, those are the ones that silently rot. A row
whose comment still says `ponytail:` gets a `rename` tag, because a marker that
names a tool tells a later maintainer nothing.

End with `<N> markers, <M> with no trigger.` Nothing found: `No shortcut debt. Clean ledger.`

## Boundaries

Reads and reports only, changes nothing. To persist it, ask and it writes the
ledger to a file (e.g. `SHORTCUT-DEBT.md`). One-shot.
