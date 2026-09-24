---
name: ponytail-help
description: >
  Quick-reference card for Ponytail levels, skills, and commands, for
  /ponytail-help or questions about how to use Ponytail. One-shot display, not
  a persistent mode.
---

# Ponytail Help

Display this reference card when invoked. It leaves the Ponytail level unchanged.

## Levels

| Level | Trigger | What change |
|-------|---------|-------------|
| **Lite** | `$ponytail lite` | Prefer a straightforward solution. Mention alternatives when the tradeoff matters. |
| **Full** | `$ponytail full` | Use the simplest implementation meeting correctness and resource requirements. Default. |
| **Ultra** | `$ponytail ultra` | Challenge accidental complexity more aggressively while completing requested behavior. |

Ponytail applies to implementation, debugging, refactoring, and read-only
simplification or code/API/test retirement decisions. `simplify-codebase` and
the relevant review, scientific-computing and handoff skills load it under their
stated conditions. The correctness or review skill leads, without a second
audit. Factual code explanations and prose-only work do not trigger Ponytail.

Name a level with a trigger above or in plain words, such as "use ponytail
ultra". The level lasts until you name another or turn Ponytail off, and `full`
applies when no level is named. Companion skills respect the off state. It
governs code-design decisions, not the length or structure of paper reviews and
research explanations. Include the level or off state in briefs for applicable
subagent work.

The ladder: establish behavior and data flow; avoid speculative work; reuse
existing code and optimized numerical kernels; use stdlib/native facilities for
glue code; reuse suitable dependencies; then write the simplest clear solution.
Accuracy, runtime, peak memory, and scaling constrain every step. Verification
follows changed failure modes rather than a fixed test count.

## Skills

| Skill | Trigger | What it does |
|-------|---------|--------------|
| **ponytail** | `$ponytail` | Lazy mode itself. Simplest solution that works. |
| **ponytail-review** | `$ponytail-review` | Review a diff for justified simplifications that preserve its contracts. |
| **ponytail-audit** | `$ponytail-audit` | Whole-repo audit of removable complexity and its consequences. |
| **ponytail-debt** | `$ponytail-debt` | Harvest `ponytail:` shortcut comments into a tracked ledger. |
| **ponytail-gain** | `$ponytail-gain` | Historical upstream benchmark scoreboard, not validation of this customized fork. |
| **ponytail-help** | `$ponytail-help` | This card. |

In Codex, mention a skill with its `$` form from the table. Where the app
mentions skills with `@`, the `@` forms such as `@ponytail lite` also work. In
Claude Code, invoke a skill as `/research-skills:<skill>`, for example
`/research-skills:ponytail lite`. A plain-language request works on both hosts.

## Deactivate

Say "stop ponytail" or "normal mode", or use `$ponytail off`. Ponytail then
stays off until you ask for it again in this conversation, which turns it back
on at `full` unless you name another level.

## Update

To update, follow the repository README. A local checkout reinstalls with
scripts/install-local.py for Codex and scripts/install-claude.py for Claude
Code. Start a new task or session afterwards.

## More

Maintained here: https://github.com/Firepanda415/research-and-scientific-lib-skills/tree/main/plugins/research-skills

Upstream documentation and historical examples: https://github.com/DietrichGebert/ponytail
