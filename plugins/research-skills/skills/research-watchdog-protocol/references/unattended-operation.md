# Requested unattended operation

Use only when the user requests continued work without being present. Use an
actual persistent task, scheduler, cluster, or supervisor; a skill cannot create
background execution by itself. If persistence is unavailable, state the limit
and complete useful foreground work without promising an unattended run.

Treat a mechanism as persistent only if it survives the end of the current
session or app, lasts long enough for the expected run, and can reach the job's
state (scheduler, logs, and any network or ssh path it needs). For example, an
in-session loop stops with the session, and a cloud routine may not see local
files. Tell the user which mechanism was chosen, when it stops, and what it
cannot see.

Establish the objective, completion condition, allowed work, resource budget,
and relevant retry/stop conditions from existing authorization. Ask only for a
missing decision that prevents launch or exceeds that authority. A bounded
authorization can cover a class of retries without a new approval per attempt.

Resume an existing task when its context remains useful. Start fresh when a
different direction, isolation need, or corrupted context justifies it. Use
[research-continuity.md](research-continuity.md) for a minimal handoff where
native state is insufficient; do not copy all history into each iteration.

The worker performs authorized research or implementation and evaluates the
evidence. The monitor reports health and recommends or sends authorized bounded
nudges; it does not certify conclusions. One independent monitor can be enough.
Additional guard layers need a demonstrated failure mode.

Before scaling, consider relevant runtime, peak memory, output size, communication,
and retry costs. Preserve enough configuration and evidence for reproduction and
failure diagnosis with bounded retention. Do not add full simulations, repeated
test suites, dense diagnostics, or duplicate checkpoints solely for monitoring.

Validate affected behavior at meaningful milestones and reuse evidence that
remains valid for the code, inputs, environment, and claim. Restarts follow the
limits in the skill's [Actions](../SKILL.md#actions) section.

Set cadence, delay thresholds, and notifications from expected runtime, normal
artifact cadence, costs, and user preference. Stay quiet during unchanged healthy
operation unless periodic updates were requested. Escalate a precise missing
authority, exhausted budget, unrecoverable dependency, or consequential choice,
while continuing independent authorized work when possible.
