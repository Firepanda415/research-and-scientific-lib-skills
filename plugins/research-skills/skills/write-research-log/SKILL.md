---
name: write-research-log
description: Draft or append requested experiment notes, observation records, hypotheses, forecasts, and resolutions. Use for explicit research-journal, preregistration, prediction calibration, or paper-result-masking requests. Ordinary research advice or paper reading does not create a log or require a prediction exercise.
---

# Write Research Log

Record what was known or expected, what was done or observed, and what the evidence
changes, at the level useful for later understanding. An observation-only note,
retrospective failed-run record, or unresolved question is valid without a prior
hypothesis or prediction. Do not invent expectations or ask for one merely to
complete a template. Durable project decisions and reusable lessons belong to
`maintain-project-memory`.

## Record the relevant evidence

- Use the existing log's conventions when available. Otherwise choose a concise
  entry with the actual observation or question, relevant setup/source,
  and interpretation where one is justified.
- Preserve the result-sensitive parameters, code revision, command and
  environment that produced a result, source locations, and uncertainty, as far
  as a later reader needs them to reconstruct the finding. The environment is
  the interpreter or toolchain, plus key library versions, hardware or backend
  when they matter. Link large artifacts rather than copying them into the note.
- Distinguish observation from interpretation and a prospective prediction from
  a post hoc explanation. Include contradictory evidence and alternative
  explanations when they matter; do not manufacture fields or alternatives.
- Retain prior predictions when results arrive. Append a resolution linked to
  the original entry rather than rewriting history to match the outcome.

For an explicitly requested forecast, calibration exercise, or result-masking
task, use [prediction-and-calibration.md](references/prediction-and-calibration.md).
Recording a note does not imply a forecast exercise, and a forecast can be
complete before an outcome exists.

## Persistence and delivery

Return the entry in the response by default. Write or append a file only when
the user asks for persistence or an established authorized logging workflow
already supplies that scope. Use a supplied or established destination; do not
silently create a research log during ordinary consultation.

When saving, follow the log's existing order (newest last if none), and preserve
prior observations and predictions.
Use an entry ID only when linking or resolving entries needs it. A correction to
a prior error should identify the correction without disguising when it was
learned. No fixed field set, confidence label, public-sharing suggestion, or
review cadence is required.

## Check before delivering

Before returning or saving an entry, check it against the rules above in one
pass separate from drafting, and fix what fails. The pass adds no runs.

- Each reported result carries the parameters, code revision, command and
  environment a later reader needs to reconstruct it.
- Observations, interpretations and post hoc explanations are marked as such.
- A resolution is appended and linked to its prediction, and earlier
  predictions and observations are unchanged.
- A correction identifies what it corrects without hiding when the error was
  found.
