---
name: ponytail-help
description: >
  Quick-reference card for all ponytail modes, skills, and commands.
  One-shot display, not a persistent mode. Trigger: /ponytail-help,
  "ponytail help", "what ponytail commands", "how do I use ponytail".
---

# Ponytail Help

Display this reference card when invoked. One-shot, do NOT change mode,
write flag files, or persist anything.

## Levels

| Level | Trigger | What change |
|-------|---------|-------------|
| **Lite** | `/ponytail lite` | Prefer a straightforward solution; mention alternatives when the tradeoff matters. |
| **Full** | `/ponytail` | Use the simplest implementation meeting correctness and resource requirements. Default. |
| **Ultra** | `/ponytail ultra` | Challenge accidental complexity more aggressively while completing requested behavior. |

Level sticks until changed or session end and governs coding decisions, not the
length or structure of paper reviews and research explanations.

The ladder: establish behavior and data flow; avoid speculative work; reuse
existing code and optimized numerical kernels; use stdlib/native facilities for
glue code; reuse suitable dependencies; then write the simplest clear solution.
Accuracy, runtime, peak memory, and scaling constrain every step. Verification
follows changed failure modes rather than a fixed test count.

## Skills

| Skill | Trigger | What it does |
|-------|---------|--------------|
| **ponytail** | `/ponytail` | Lazy mode itself. Simplest solution that works. |
| **ponytail-review** | `/ponytail-review` | Review a diff for justified simplifications that preserve its contracts. |
| **ponytail-audit** | `/ponytail-audit` | Whole-repo audit of removable complexity and its consequences. |
| **ponytail-debt** | `/ponytail-debt` | Harvest `ponytail:` shortcut comments into a tracked ledger. |
| **ponytail-gain** | `/ponytail-gain` | Historical upstream benchmark scoreboard; not validation of this customized fork. |
| **ponytail-help** | `/ponytail-help` | This card. |

Codex uses `@ponytail`, `@ponytail-review`, and `@ponytail-help`; Claude Code
and OpenCode use the slash-command forms above (OpenCode ships all six as
slash commands).

## Deactivate

Say "stop ponytail" or "normal mode". Resume anytime with `/ponytail`.
`/ponytail off` also works.

## Configure Default Mode

Default mode = `full`, auto-active every session. Change it:

**Environment variable** (highest priority):
```bash
export PONYTAIL_DEFAULT_MODE=ultra
```

**Config file** (`~/.config/ponytail/config.json`, Windows: `%APPDATA%\ponytail\config.json`):
```json
{ "defaultMode": "lite" }
```

Set `"off"` to disable auto-activation on session start, activate manually
with `/ponytail` when wanted.

Resolution: env var > config file > `full`.

## Update

For this fork's local Codex installation, edit the configured checkout, then run
`codex plugin add research-skills@research-skills` and start a new task. Check the configured
marketplace source before updating; an upstream source will not include local
customizations. Other hosts use their own installation flow.

## More

Maintained here: https://github.com/Firepanda415/research-and-scientific-lib-skills/tree/main/plugins/research-skills

Upstream documentation and historical examples: https://github.com/DietrichGebert/ponytail
