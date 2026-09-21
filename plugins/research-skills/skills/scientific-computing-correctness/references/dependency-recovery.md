## Dependency failures and recovery

- If a dependency raises, recover only with an applicable scientific or numerical
  method that addresses that failure and preserves the required result. Otherwise
  propagate the failure. Do not repeat expensive work merely to bypass an error.
- Keep an error wrapper when it adds actionable context such as the failing
  branch, shape, parameter, or budget. Preserve the original traceback and
  exception identity where practical, or chain the cause when translation is
  necessary. Remove wrappers that only restate the error or misclassify it.
- If a dependency silently misinterprets invalid or inconsistent input, prefer
  cheap rejection at the owning boundary and require the caller to correct it.
  Avoid automatic repair or compatibility machinery solely for that input.
  Preserve supported representations, scientific domain checks, and trust boundaries.

For retries, restarts, and fallbacks, distinguish preservation of the mathematical
target, a mechanism that can improve the specific failure, and evidence for the
chosen schedule's benefit and cost. Equivalence after compensation proves only
preservation. A bounded heuristic with a credible numerical mechanism and an
acceptance condition can be legitimate without a theorem; do not present its
particular retry count as proven effective when that benefit is unmeasured.
Catch only failures the recovery can address, state acceptance and termination,
and account for nested dependency work and repetition at the intended scale.
In authorized remediation, remove unsupported automatic retries and work with no required result or evidence consumer. Before extra costly validation, read and apply the [resource approval rules](../SKILL.md#resource-proportionality-and-retention). Do not run a benchmark merely to justify a retry.
