# Routing evals

These cases check which `research-skills` skill Claude Code loads for requests near the boundary between two or more skills. Use them to assess changes to skill descriptions or companion routing instructions before release, subject to the cost approval below.

Each case directory holds one `case.yaml` in the format that `claude plugin eval` reads. A case sends one prompt and grades only the session's Skill tool calls. Each required skill, including a required companion, must be called at least once. An excluded skill gets a grader with `min: 0`, `max: 0` and `arm: both`, so these checks still count toward the score if the suite is later run with the default no-plugin comparison arm. The `input_match` pattern accepts both the qualified name `research-skills:<skill>` and the bare skill name. The checker rejects unknown skills, duplicate or contradictory graders for a skill, and cases without any required skill.

| Case prefix | Boundary |
| --- | --- |
| `review-` | refereeing another author's manuscript and auditing the requester's own paper |
| `lit-` | a briefing on recent papers and a targeted literature or novelty check |
| `direction-` | choosing a new research direction and reconsidering an existing one |
| `writing-` | a brief for another agent and instructions that other people read |
| `scicode-` | review of a scientific library, general code review, and work on one computation |
| `simplify-` | deletion and API retirement decisions, including a session-level Ponytail opt-out |
| `handoff-` | resume state for a later session, project memory, a research log entry, and an implementer prompt |
| `project-` | leading a multi-agent project, one implementer prompt, and monitoring a running job |

To add a case, copy an existing `case.yaml` into a new directory named after the case. The dry run checks the fields, the grader rules above, and that each skill name exists in the Claude package, which carries all 31 skills.

## Cost and approval

The package checks, `scripts/check-package.py` and the Node tests, do not run this suite. Each run of a case is a full Claude Code session on the maintainer's own credentials, and the cost of a complete suite has not been measured. The 21 cases at the default of three runs each start 63 sessions. Running the suite needs the maintainer's explicit approval, and a first run should be a one-case pilot. The `--max-cost-usd` ceiling is checked before each run starts, so a run already in progress can finish above it.

## Dry run

The plugin source does not contain `evals/`, so installed packages never ship it. `scripts/run-routing-evals.py` builds the Claude package in a temporary directory, copies this directory to `evals/` inside the staged plugin, checks the case files, and prints the `claude plugin eval` command. Without `--run` it executes nothing beyond `claude plugin eval --help` and makes no model call. It needs PyYAML from `requirements-dev.txt`.

```sh
python3 scripts/run-routing-evals.py
```

Pass `--claude-bin` when the `claude` on `PATH` does not provide `plugin eval`. Add `--keep-stage` to inspect the staged plugin afterwards.

## Run

A one-case pilot:

```sh
python3 scripts/run-routing-evals.py --run --max-cost-usd 2 \
  --results-dir ../routing-eval-results --case review-referee-report --runs 1
```

Omit `--case` and `--runs` for the full suite at three runs per case. The runner always passes three further flags. `--ablation none` skips the no-plugin comparison arm, which a routing check does not need and which would double the number of sessions. `--no-publish` keeps the HTML report local. `--trust-plugin` skips the first-use trust prompt that Claude Code would otherwise show for the staged plugin, which is a new directory on every invocation.

The aggregate result, the JSON run record and the HTML report go to `--results-dir`, which must lie outside the temporary stage. The stage is deleted afterwards unless `--keep-stage` is given. The command exits with status 1 when any case scores below 1, and with status 2 when the cost ceiling stops the suite early.

## Reading results

Skill graders do not observe file reads. The writing hook names a `SKILL.md` path, and companion instructions link to one, so a compliant agent may use Read instead of Skill. Before treating a grader result as a routing outcome, inspect the trace for relevant file reads as well as Skill calls.

`simplify-retirement-proposal` requires both `simplify-codebase` and `ponytail`, even though the prompt names neither skill and authorizes only a review. `scicode-library-remediation` requires `scientific-library-review` and `ponytail` for a repair decision. `simplify-ponytail-off` requires the simplification workflow while forbidding Ponytail, and `writing-contributing-guide` forbids Ponytail for prose about coding. The other `scicode-` cases leave Ponytail calls ungraded. These cases test selection boundaries, not the quality of a simplification or repair.

The graders count Skill calls without checking their order or whether the agent followed the loaded guidance. When a run loads Ponytail alongside another workflow, inspect its trace to check that the owning workflow was loaded first. For the retirement case, check whether the response separates evidence that an interface is callable from evidence that it is worth maintaining. For the remediation case, check whether it compares fixes at the shared contract with adapters at individual callers while preserving scientific meaning.

## Quality evals

The routing cases check which skill loads. The cases in `evals-quality/` check what a skill contributes to the result. Each case pairs a realistic request with graders: regular expressions for checkable rules, such as numbers kept from the source, house punctuation and prompt leakage, and rubric graders that another model judges. The default run adds the no-plugin arm, so the report gives the score with the plugin, the score without it, and their difference.

`evals-quality/variants.yaml` defines ablation variants that remove named sections of a skill in the staged copy only, for example the pattern catalogue of the writing skill. Run the same cases on the unmodified plugin and on each variant with `--ablation none`, and compare the responses and the session cost per case as described below. A part whose removal changes neither beyond the spread between repeated runs is a candidate for removal or for a conditional reference. The runner fails when a named heading no longer exists.

`scripts/run-quality-evals.py` stages the package, applies `--variant` when given, and prints or runs the command. By the maintainer's choice on 2026-09-26, the sessions under test run `claude-opus-5-5` at effort `medium`, set through `CLAUDE_CODE_EFFORT_LEVEL`, and the rubric graders also use `claude-opus-5-5`. The same approval rule as for the routing suite applies, and `--run` needs `--max-cost-usd` and `--results-dir`. Eval sessions use the Claude Code CLI's own login, not the desktop app's, so run `claude auth login` once first. A run that fails to start still passes the graders that require an absence, so exclude runs with an error before comparing scores.

Tags group the cases. `writing` and `email` cover the writing route and work-email, and their `variant` subset serves the ablation variants above. `tier2` covers five workflow skills (scientific-library-review, scientific-computing-correctness, ponytail, write-implementation-job-prompts and maintain-project-memory) at three runs per arm. `tier3` screens the remaining skills, except ponytail-help, ponytail-gain and ponytail-debt, and is meant for `--runs 1`. Most `tier2` and `tier3` cases seed their workspace from a `scaffold.sh` in the case directory, so pass `--scaffold` and `--allow-tools Write Edit`. The eval sandbox refuses any `Bash` grant on a machine whose Docker configuration directory holds symbolic links, such as those Docker Desktop installs. No case therefore needs to run code, and graders about tests check that a response does not claim a run it could not perform. On 2026-09-26 each of the three groups cost about 36 USD at list price, including 4 to 13 USD for the rubric judge.

```sh
python3 scripts/run-quality-evals.py
python3 scripts/run-quality-evals.py --variant no-patterns --ablation none --tag variant
python3 scripts/run-quality-evals.py --tag tier2 --scaffold --allow-tools Write Edit
```

The rubric judge receives only its criteria and the agent's final response, not the prompt. A criterion therefore states every fact it checks, such as the original text of a copyedit or the points supplied for a letter. The result JSON keeps a final response only as the evidence of a rubric grader, so every case whose responses will be compared needs at least one. `--keep-temp` also keeps each run's directory, with its trace and the files the agent changed. Under `--ablation none`, the graders that serve as indicators in the default run, those with `arm: with-only` and every `tool_used: Skill` grader, count toward the score. Compare a variant with the unmodified plugin only on graders that both runs score.

Absolute graders separate the arms only where the model fails without the plugin. In the first run of these cases, on 2026-09-26, Claude Opus 5.5 without the plugin passed most of them. A blind pairwise comparison of the stored responses was far more sensitive. An Opus 5.5 judge that saw only the request and two unlabelled responses in random order preferred the response with the plugin in 18 of 24 pairs and the other response in 2. Compare variants in the same way, because their differences are smaller than the plugin's. The cases are short, so they do not show the effect of guidance that matters only in long documents, such as structure and continuity across sections.

## Usage in real sessions

`scripts/skill-usage.py` reports which skills recent Claude Code and Codex sessions actually loaded, using the local transcripts of both hosts, including archived Codex sessions. It calls no model and needs only the Python standard library.

```sh
python3 scripts/skill-usage.py --days 7
python3 scripts/skill-usage.py --days 7 --list research-writing-style
python3 scripts/skill-usage.py --days 7 --cost
```

A skill counts as loaded when a Skill call names it or a file read or shell command names its installed `SKILL.md`, and the report separates main sessions from subagents. It covers Codex, which has no routing cases, and reads through the writing hook's path, which Skill graders do not observe. It cannot tell whether a load was appropriate. `--refs research-writing-style` also counts the sessions that read each of that skill's reference files. `--cost` estimates, for each skill, the tokens that its `SKILL.md` and references brought into the sessions that read them, counting each version of a file once per session, at about 3.5 characters per token for Claude Code and about 5 for Codex, the ratio measured for this plugin's Markdown in Codex sessions on 2026-09-27. It leaves out the skill descriptions and hook text that every session carries and the text re-sent on later requests, so it ranks skills by cost rather than pricing them. `--list` shows the start of each matching session's first prompt so that you can judge that by hand. For a Codex subagent it shows the parent session's first prompt, because the subagent's own brief is not stored as a plain message. The counts come from tool-call requests, so they do not confirm that a read succeeded, how much of a file was read, or why, and several reads in one session count once. Installed paths carry the plugin version, which the report lists. To assess a change to routing text, compare sessions that read the old version with sessions that read the new one, using `--plugin-version`, which leaves out Skill calls because they carry no version.
