# Routing evals

These cases check which `research-skills` skill Claude Code loads for requests near the boundary between two or more skills. Use them to assess changes to skill descriptions or companion routing instructions before release, subject to the cost approval below.

Each case directory holds one `case.yaml` in the format that `claude plugin eval` reads. A case sends one prompt and grades only the session's Skill tool calls. Each required skill, including a required companion, must be called at least once. An excluded skill gets a grader with `min: 0`, `max: 0` and `arm: both`, so these checks still count toward the score if the suite is later run with the default no-plugin comparison arm. The `input_match` pattern accepts both the qualified name `research-skills:<skill>` and the bare skill name. The checker rejects unknown skills, duplicate or contradictory graders for a skill, and cases without any required skill.

| Case prefix | Boundary |
| --- | --- |
| `review-` | refereeing another author's manuscript and auditing the requester's own paper |
| `lit-` | a briefing on recent papers and a targeted literature or novelty check |
| `direction-` | choosing a new research direction and reconsidering an existing one |
| `writing-` | a brief for another agent and instructions that people will keep |
| `scicode-` | review of a scientific library, general code review, and work on one computation |
| `simplify-` | deletion and API retirement decisions, including a session-level Ponytail opt-out |
| `handoff-` | resume state for a later session, project memory, a research log entry, and an implementer prompt |

To add a case, copy an existing `case.yaml` into a new directory named after the case. The dry run checks the fields, the grader rules above, and that each skill name exists in the Claude package, which carries all 28 skills.

## Cost and approval

The package checks, `scripts/check-package.py` and the Node tests, do not run this suite. Each run of a case is a full Claude Code session on the maintainer's own credentials, and the cost of a complete suite has not been measured. The 18 cases at the default of three runs each start 54 sessions. Running the suite needs the maintainer's explicit approval, and a first run should be a one-case pilot. The `--max-cost-usd` ceiling is checked before each run starts, so a run already in progress can finish above it.

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
