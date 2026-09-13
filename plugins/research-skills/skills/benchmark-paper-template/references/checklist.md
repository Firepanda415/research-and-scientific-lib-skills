# Targeted benchmark pre-submission checks

Use the checks relevant to the manuscript and its intended claim. Resolve clear
issues directly within the user's scope; do not require a line-by-line session
with the user or a printed checklist for every review.

- Is the evaluation question meaningful and positioned against relevant work?
- Are instance construction, reference answers, measurement definitions, and
  result-sensitive parameters sufficiently specified to reproduce the result?
- Are tested methods compared under appropriate assumptions, tuning effort,
  accuracy targets, and resource budgets?
- Does aggregation or selection hide a consequential failure or comparison?
- Are uncertainty, approximation, and finite-regime claims reported accurately?
- Do the conclusions follow from the observed evidence, including negative
  results and limitations that change interpretation?
- For learned or tuned systems, is held-out evaluation isolated from training
  and selection as required by the claim?
- Are cited sources, artifact references, and version/configuration information
  correct where they support the result?

Check the current official venue requirements when submission compliance is
part of the task. Do not inherit dated metadata, licensing, checklist, or
formatting rules from an example venue. A human baseline, new companion method,
particular figure, or numbered RQ is not a universal submission requirement.

Rank issues by consequence: invalid measurement, leakage, or missing evidence for
the central claim can block the conclusion; an unclear local description or
format preference may need a small correction. Do not equate absent template
elements with scientific failure. Report only unresolved issues and the evidence
or change needed to address them.
