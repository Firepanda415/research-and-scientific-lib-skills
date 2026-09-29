# Maintaining this collection

Edit the `research-skills` Codex and Claude Code plugin in
`plugins/research-skills/`, including its skills, references, scripts, and writing
hook. Installed plugin caches are not source files.

Keep skills reusable across projects. Project-specific paths, document layout,
environment commands, and work-in-progress state belong in the project's own
guidance, which skills read when needed.

Extend an existing rule when it already covers the issue. Generalize lessons
from individual incidents, with at most one short example. Put topic-specific
detail in references, state when to read them, and keep required checks in the
skill's review section.

Keep each `SKILL.md` at most 16,000 characters, enforced by
`scripts/check-package.py`. Claude Code's [skill lifecycle documentation](https://code.claude.com/docs/en/skills#skill-content-lifecycle)
specifies 5,000 tokens per invoked skill after compaction and 25,000 shared across
re-attached skills. Its [glossary](https://platform.claude.com/docs/en/about-claude/glossary)
estimates 3.5 English characters per token, so the character limit leaves about
10% below 17,500 for Markdown and code. Both sources were checked on 2026-09-26.
If these figures change, update this paragraph and `MAX_SKILL_CHARS` together, and
recompute the README cost estimates when the characters-per-token figure changes.

Both READMEs estimate each skill's default load in the Skills table, from the
characters of its `SKILL.md` and of the references it reads by default, at 3.5
characters per token, rounded to the nearest thousand and shown as `<1k` below
1,000. The counted references are `durable-prose.md` and `prose-review.md` for
`research-writing-style`, `coverage-and-consequence.md` for
`quantum-computing-review`, `user-research-profile.md` for `quantum-research-radar`,
`production-pipeline.md` and `house-style.md` for `research-explainer-animation`,
and Ponytail's `SKILL.md` for `simplify-codebase`. Every other skill counts its
`SKILL.md` only. The Context cost sections estimate the skill listing (one line
per skill with its qualified name and description, as Claude Code lists them),
the hook text and the referee handbook the same way. When a change alters a rounded
figure or which references a skill reads by default, recompute every token figure
in both READMEs, including the totals and the figures repeated in the Context cost
bullets, and check which skills those bullets name.

Follow `README.md` for installation on the requested host. Install the single
`research-skills@research-skills` plugin, including every skill and the writing
hook, without a separate Ponytail plugin. Let Codex manage hook trust without
bypassing or manufacturing it.

Append new hook handlers and matcher groups without reordering existing entries.
Codex keys trust by event, matcher group, and handler index, and hashes the
registration fields `command`, `matcher`, `timeout`, `statusMessage`, and `async`.
Script bodies are outside that hash. Changes to registration fields or handler
order require a release note telling users to trust the hooks again in `/hooks`.

Preserve upstream notices and license boundaries in `LICENSE.md`. Keep
`README.md` and `README.zh-CN.md` in sync, including every skill and its source.
Record third-party sources and modifications in the plugin's `NOTICE.md`, and
update its `LICENSE.md` when applicable terms differ.

For package changes, run `node --test plugins/research-skills/tests/*.test.js` and
`python3 scripts/check-package.py`. The Python check needs PyYAML from
`requirements-dev.txt` and builds the Claude package offline in a temporary
directory. For job-prompt linter changes, also run
`(cd plugins/research-skills/skills/write-implementation-job-prompts/scripts && python3 -B -m unittest test_lint_job_prompt)`.
Run existing local script checks when their implementations change. Do not run
LLM benchmarks for packaging validation.

Once per release, run `python3 scripts/install-local.py --prepare-only` to refresh
the content version, then `python3 scripts/check-package.py --release` to enforce
it. Keep `plugins/research-skills/package.json`'s version equal to the base version
in `plugins/research-skills/.codex-plugin/plugin.json`.
