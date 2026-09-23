# Routing evals

These cases check which `research-skills` skill Claude Code loads for requests near the boundary between two or more skills. Run them after editing a skill's `description` to catch a change in skill selection before release.

Each case directory holds one `case.yaml` in the format that `claude plugin eval` reads. A case sends one prompt and grades only the session's Skill tool calls. The expected skill must be called at least once. Each adjacent skill gets a grader with `min: 0`, `max: 0` and `arm: both`, so these checks still count toward the score if the suite is later run with the default no-plugin comparison arm. The `input_match` pattern accepts both the qualified name `research-skills:<skill>` and the bare skill name.

| Case prefix | Boundary |
| --- | --- |
| `review-` | refereeing another author's manuscript and auditing the requester's own paper |
| `lit-` | a briefing on recent papers and a targeted literature or novelty check |
| `direction-` | choosing a new research direction and reconsidering an existing one |
| `writing-` | a brief for another agent and instructions that people will keep |
| `scicode-` | review of a scientific library, general code review, and work on one computation |
| `handoff-` | resume state for a later session, project memory, a research log entry, and an implementer prompt |

To add a case, copy an existing `case.yaml` into a new directory named after the case. The dry run checks the fields, the grader rules above, and that each skill name exists in the Claude package, which carries all 27 skills.

## Cost and approval

The package checks, `scripts/check-package.py` and the Node tests, do not run this suite. Each run of a case is a full Claude Code session on the maintainer's own credentials, and the cost of a complete suite has not been measured. The 15 cases at the default of three runs each start 45 sessions. Running the suite needs the maintainer's explicit approval, and a first run should be a one-case pilot. The `--max-cost-usd` ceiling is checked before each run starts, so a run already in progress can finish above it.

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

The plugin's writing hook tells each session to read `research-writing-style/SKILL.md` by file path. A session that follows it uses the Read tool, which the Skill graders do not see. Before counting a pass or failure on a `research-writing-style` grader as a routing result, check the run's trace for that read.

The agent may load `ponytail` alongside the expected skill in the `scicode-` cases, because Ponytail applies to writing or changing code and may join `deep-code-review`, `scientific-library-review` or `scientific-computing-correctness`. No grader limits these calls. The graders count Skill calls without checking their order, so when a `scicode-` run calls `ponytail`, check in its trace that the expected skill was called first.
