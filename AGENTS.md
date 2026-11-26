# Maintaining this collection

Edit the `research-skills` Codex, Claude Code, and Antigravity plugin in
`plugins/research-skills/`, including its skills, references, scripts, and writing
hook. Installed plugin caches are not source files.

Keep skills reusable across projects. Project-specific paths, document layout,
environment commands, and work-in-progress state belong in the project's own
guidance, which skills read when needed.

Whatever a skill has an agent write into a user's repository, such as a comment
marker, a file name, a message or generated documentation, names no skill, plugin,
agent or model. The repository outlives them, and the people who maintain it may
use none of them. For this reason the comment that marks a deliberate shortcut
is `shortcut:` here, where upstream Ponytail writes `ponytail:`.

Extend an existing rule when it already covers the issue. Generalize lessons
from individual incidents, with at most one short example. Put topic-specific
detail in references, state when to read them, and keep required checks in the
skill's review section.

A rule that must fire belongs in `SKILL.md`, in its generation text or evidence
table, worded as an event, an action and its evidence, because agents rarely open
references and a brief that names a skill does not load it. A completion review
holds only what shows on the finished result and adds no runs, so a rule that must
act before the work stays out of it. In the Claude Code
transcripts of one project from 2026-10-25 to 2026-11-03, counted from tool-call
requests, 1 of 44 transcripts that edited source read `resource-accounting.md`
and 2 of 33 library reviews read `user-workflow-acceptance.md`. Two implementation
sessions told to use `scientific-computing-correctness` made about 2,300 code edits
without loading it, while the writing skill the hook routes was loaded 31 times in
them. When `SKILL.md` is at its limit, move a topic's detail verbatim to a reference
read at that step, and propose the move first because it changes the default load.

Keep each `SKILL.md` at most 16,000 characters, enforced by
`scripts/check-package.py`. The limit follows from how the hosts load a skill and
keep it after compaction, checked on 2026-11-26. Claude Code's [skill lifecycle documentation](https://code.claude.com/docs/en/skills#skill-content-lifecycle)
says that after compaction it re-attaches each invoked skill up to 5,000 tokens,
within 25,000 tokens shared by all of them and filled from the most recently
invoked. Claude Code 2.1.331 estimates these tokens as characters divided by four,
so a skill is kept up to about 20,000 characters, the shared budget holds about
100,000, and a skill that does not fit the remaining budget is dropped whole. Six
skills of 16,000 characters fit that budget, and of 18,000 only five would. Codex
has no skill tool. Its agent reads the file with a shell command, and Codex removes
the middle of long command output, so a longer file loses more of its middle.
Antigravity reads up to 46,080 bytes per call. In context a `SKILL.md` at the limit
costs about 4,900 tokens on Claude Opus 5.5, where the four largest files, at 15,914
to 15,977 characters, measured 4,724 to 4,892 tokens on 2026-10-22. If a host
changes these mechanisms, update this paragraph and `MAX_SKILL_CHARS` together, and
remeasure the README figures when the tokenizer changes.

Both READMEs give each skill's default load in the Skills table as the Claude
tokens of its `SKILL.md` and of the references it reads by default, measured on
Claude Opus 5.5, rounded to the nearest thousand and shown as `<1k` below 1,000. The counted references are `durable-prose.md` and `prose-review.md` for
`research-writing-style`, `coverage-and-consequence.md` for
`quantum-computing-review`, `reporting-findings.md` for `scientific-library-review`,
`user-research-profile.md` for `quantum-research-radar`,
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
that names no host means all three supported hosts, through `scripts/install-local.py` (Codex),
`scripts/install-claude.py` (Claude Code), and `scripts/install-antigravity.py` (Antigravity).
Install the single `research-skills` plugin, including every skill and the writing
route, without a separate Ponytail plugin. Let Codex manage hook trust without
bypassing or manufacturing it.

Append new hook handlers and matcher groups without reordering existing entries.
Codex keys trust by event, matcher group, and handler index, and hashes the
registration fields `command`, `matcher`, `timeout`, `statusMessage`, and `async`.
A second hash covers every file of the installed plugin except Python bytecode,
`.venv` and `.egg-info` (Codex 0.169.0-alpha.11, `plugin_trust.rs` and
`plugin_fingerprint.rs` under `codex-rs/hooks/src/engine/`, read 2026-11-26). Codex
recomputes it before each run and skips the hook when it differs from the approved
one. An install that changes any plugin file therefore turns the hooks off until the
user trusts them again in `/hooks`, and so does a file that appears in the installed
folder later, such as `.DS_Store`. Tell the user to trust the hooks after every
reinstall. Changes to registration fields or handler order also require a release
note telling users to trust the hooks again in `/hooks`.

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
