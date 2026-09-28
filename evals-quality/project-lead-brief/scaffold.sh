#!/usr/bin/env bash
set -euo pipefail
git init -q
cat > 'README.md' <<'QDEMO_EOF_0'
# qdemo

A small library for Trotterized time evolution under a work budget.

Run the tests with `python3 -m pytest`.
QDEMO_EOF_0
mkdir -p 'qdemo'
cat > 'qdemo/__init__.py' <<'QDEMO_EOF_1'

QDEMO_EOF_1
mkdir -p 'qdemo'
cat > 'qdemo/evolve.py' <<'QDEMO_EOF_2'
"""Trotterized evolution with an admission check on the work budget."""
import math

WORK_PER_STEP = 3  # passes over the state per Trotter step: kinetic, potential, normalization


def admit_steps(norm_h, t, eps, max_work, dim):
    """Return the number of second-order Trotter steps for accuracy eps.

    The count follows the bound steps >= (norm_h * t) ** 1.5 / eps ** 0.5.
    Raises ValueError when the work exceeds max_work.
    """
    steps = math.ceil((norm_h * t) ** 1.5 / eps ** 0.5)
    work = WORK_PER_STEP * steps * dim
    if work > max_work:
        raise ValueError("work exceeds max_work")
    return steps


def split_budget(total, n_parts):
    """Split a work budget into n_parts equal shares (private helper)."""
    return [total / n_parts] * n_parts
QDEMO_EOF_2
mkdir -p 'qdemo'
cat > 'qdemo/runs.py' <<'QDEMO_EOF_3'
"""Durable runs that can be resumed."""
import json
import os


def resume(run_dir):
    """Resume a run from its directory."""
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    with open(os.path.join(run_dir, "run.json")) as handle:
        return json.load(handle)
QDEMO_EOF_3
mkdir -p 'tests'
cat > 'tests/test_evolve.py' <<'QDEMO_EOF_4'
from qdemo.evolve import admit_steps


def test_small_problem_is_admitted():
    assert admit_steps(1.0, 1.0, 1e-2, 10**6, 4) >= 1
QDEMO_EOF_4
mkdir -p 'docs'
cat > 'docs/guide.md' <<'QDEMO_EOF_5'
# qdemo guide

## Quick start

```python
from qdemo import evolve
state = evolve(H, t=1.0, steps='auto')
```

## Budget

The number of steps is the smallest integer with steps >= (||H|| t)^{3/2} / eps^{1/2}.
Each step makes three passes over the state, and a request is refused when
the work exceeds `max_work`.
QDEMO_EOF_5
mkdir -p 'docs'
cat > 'docs/constants.md' <<'QDEMO_EOF_6'
# Engineering constants

| Name | Value | Meaning |
| --- | --- | --- |
| WORK_PER_STEP | 3 | passes over the state per Trotter step |
QDEMO_EOF_6
mkdir -p 'plans'
cat > 'plans/PLAN-0.3.md' <<'QDEMO_EOF_7'
# qdemo 0.3 plan

Status: approved by the user on 2026-10-02

## Scope and public API

- `admit_steps(c, t, eps, max_work, dim)` replaces `admit_steps(norm_h, t, eps, max_work, dim)`. The step count follows the commutator-scaled bound D-3, and a refusal states how to change the inputs.
- `resume(run_dir)` accepts a relative directory (J2).
- The guide's Budget section states D-3.

## Decisions the user took

- The caller computes the commutator scale `c`; qdemo does not estimate it (user, 2026-10-01).

## Jobs

| Job | Owns | Needs | Completion |
| --- | --- | --- | --- |
| J1 | docs/guide.md, outside the Budget section | nothing | typos fixed, strict docs build passes |
| J2 | qdemo/runs.py, tests/test_runs.py | nothing | resume from a relative directory works; its detector fails before the fix |
| J3 | qdemo/evolve.py, docs/guide.md Budget section | D-3 | admit_steps follows D-3 in every case; the refusal states the remedy; every place stating the bound changed |

## Verification policy

Workers run the test files that cover the modules they change and the related mutation probes, through the checked runner, and no full suite. The principal grades its integration checks.

## Test policy

A test protects a public contract, or a scientific relation checked against an independent reference through a public workflow; it can also be a canary, one test per recurring failure mechanism, or a detector a review names. No tests that pin values or old behavior, that only show a change happened, or that test notebooks or documentation.

## Derivation package D-3 (mathematics advisor, thread 0412; checked by thread 0415)

Premises: A and B are Hermitian, H = A + B, t >= 0, eps > 0, and c = ||[[A,B],A]|| + ||[[A,B],B]|| >= 0 is supplied by the caller.

1. One second-order (Strang) step of size h has error at most c h^3 / 12, because each of the two commutator terms has a coefficient of at most 1/12.
2. r steps with h = t / r give a total error of at most r c (t / r)^3 / 12 = c t^3 / (12 r^2).
3. The error is at most eps if and only if r >= sqrt(c t^3 / (12 eps)).
4. Cases the code reaches: t == 0 needs no step (r = 0, no work). Otherwise r = max(1, ceil(sqrt(c t^3 / (12 eps)))), which is 1 when c == 0.
5. The work is WORK_PER_STEP * r * dim. With r_max = floor(max_work / (WORK_PER_STEP * dim)):
   - if r_max >= 1, the smallest eps that fits is eps_min = c t^3 / (12 r_max^2); raising eps to at least eps_min, or max_work to at least the reported work, admits the request;
   - if r_max == 0, no eps fits, and only max_work >= WORK_PER_STEP * dim * r admits it.

Code to copy:

```python
    if t == 0:
        return 0
    steps = max(1, math.ceil(math.sqrt(c * t**3 / (12 * eps))))
    work = WORK_PER_STEP * steps * dim
    if work > max_work:
        r_max = max_work // (WORK_PER_STEP * dim)
        if r_max >= 1:
            eps_min = c * t**3 / (12 * r_max**2)
            raise ValueError(f"work {work} exceeds max_work {max_work}; raise eps to at least {eps_min:.3g} or max_work to at least {work}")
        raise ValueError(f"work {work} exceeds max_work {max_work}; raise max_work to at least {work}")
    return steps
```

Text to copy into the docstring and the guide's Budget section: "The number of steps is the smallest r >= 1 with c t^3 / (12 r^2) <= eps, where c = ||[[A,B],A]|| + ||[[A,B],B]||; t = 0 needs no step."

Places that state the bound: the `admit_steps` docstring and code in qdemo/evolve.py, the guide's Budget section, and the refusal message.
QDEMO_EOF_7
mkdir -p 'notes'
cat > 'notes/SETTINGS.md' <<'QDEMO_EOF_8'
# Settings for the 0.3 run (asked on 2026-10-02)

- Code advisor: Claude Opus 5.5, high reasoning.
- Mathematics advisor: GPT-6 Astra, Max reasoning, in the ChatGPT desktop app.
- Code worker: Claude Opus 5.5 through the `opus-xhigh` agent type.
- Mathematics worker: not used.
- Counselor: GPT-6 Astra.
- Decisions the user keeps: scope, behavior changes, extra cost on a default path, push, merge, release and archive. Notify by push notification.
- Channel for the other vendor's models: the desktop app only.

## Environment

- Checked runner: `./run-checked.sh refs/heads/<branch> <full SHA> -- <command>`, which checks the interpreter, the SHA, and that qdemo imports from that checkout.
- Interpreter: /opt/conda/envs/qdemo/bin/python, Python 3.12.
- Integration branch: `develop`, at 1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b.
- Worktrees: `wt/<job>` on branch `v03/<job>`.
- Repository rules: no AI-facing material in the repository, no AI attribution, no `git stash`.
- Working directory for briefs, reports and advisor requests: `work/` (outside version control).
QDEMO_EOF_8
mkdir -p 'work'
cat > 'work/.keep' <<'QDEMO_EOF_9'

QDEMO_EOF_9
