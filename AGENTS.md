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

A rule that must fire belongs in a `SKILL.md` review section or evidence table,
worded as an event, an action and its evidence, because agents rarely open
references and a brief that names a skill does not load it. In the Claude Code
transcripts of one project from 2026-10-25 to 2026-11-03, counted from tool-call
requests, 1 of 44 transcripts that edited source read `resource-accounting.md`
and 2 of 33 library reviews read `user-workflow-acceptance.md`. Two implementation
sessions told to use `scientific-computing-correctness` made about 2,300 code edits
without loading it, while the writing skill the hook routes was loaded 31 times in
them. When `SKILL.md` is at its limit, pay for a new rule by removing what another
item, skill or reference already covers.

Keep each `SKILL.md` at most 16,000 characters, enforced by
`scripts/check-package.py`. Claude Code's [skill lifecycle documentation](https://code.claude.com/docs/en/skills#skill-content-lifecycle)
specifies 5,000 tokens per invoked skill after compaction and 25,000 shared across
re-attached skills. Its [glossary](https://platform.claude.com/docs/en/about-claude/glossary)
gives about 3.5 English characters per token for models before Claude 4.7 and says
later models produce about 30 percent more tokens for the same text. On Claude Opus
5.5 the four largest `SKILL.md` files, at 15,914 to 15,977 characters, measured
4,724 to 4,892 tokens, so the limit stays about 2 to 6 percent below 5,000 tokens.
Both sources were checked and the files measured on 2026-10-22. If these figures
change, update this paragraph and `MAX_SKILL_CHARS` together, and remeasure the
README figures when the tokenizer changes.

Both READMEs give each skill's default load in the Skills table as the Claude
tokens of its `SKILL.md` and of the references it reads by default, measured on
Claude Opus 5.5, rounded to the nearest thousand and shown as `<1k` below 1,000. The counted references are `durable-prose.md` and `prose-review.md` for
`research-writing-style`, `coverage-and-consequence.md` for
`quantum-computing-review`, `user-research-profile.md` for `quantum-research-radar`,
`production-pipeline.md` and `house-style.md` for `research-explainer-animation`,
and Ponytail's `SKILL.md` for `simplify-codebase`. Every other skill counts its
`SKILL.md` only. The Context cost sections give the skill listing (one line per
skill with its qualified name and description, as Claude Code lists them), the hook
text and the referee handbook the same way. A measurement prints each file in its
own turn of a fresh agent and takes the file's tokens from the growth of the
recorded input, less the turn's output and a few tokens of tool-result framing. On
2026-10-22 these files averaged about 3.2 characters per token. When a change
alters a rounded figure or which references a skill reads by default, remeasure the
changed files, or scale their previous counts by the change in characters, and
update every token figure in both READMEs, including the totals and the figures
repeated in the Context cost bullets, and check which skills those bullets name.

Follow `README.md` for installation on the requested host. A request to reinstall
that names no host means both, through `scripts/install-claude.py` and
`scripts/install-local.py`. Install the single
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
