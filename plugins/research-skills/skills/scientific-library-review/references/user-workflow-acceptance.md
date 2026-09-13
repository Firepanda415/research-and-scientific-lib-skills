# Acceptance from the user's workflow

Use when the reviewed change affects examples, notebooks, reports, error messages
or the ability to complete a public task. Judge the intended audience: a scientist
may need precise terminology, equations and provenance. Do not replace necessary
technical terms with vague language or assume every user is a beginner.

## Follow the task through its visible result

Start with the documented public entry and representative valid options. Check
whether the user can discover prerequisites, perform the task, interpret the
result and take the next appropriate action without undocumented internal calls.
Use the interface actually consumed: a notebook kernel, CLI, Python API or
browser as applicable. A browser is not required for a library workflow.

Treat a success message or returned object as a signal to inspect, not proof
that the whole task completed. When persistence or downstream use is in scope,
verify the relevant saved/read-back result, ordered values, identifiers, units
and status through that consumer. Reuse existing applicable evidence; a changed
caption alone does not justify rerunning an expensive experiment.

Compare visible explanations with the actual selected behavior. Examples and
reports should distinguish approximations, missing evidence, unavailable data,
unsupported execution and genuine zero results. Important caveats in an internal
record do not help a user if the rendered result hides them. Look for stale
defaults, removed options and claims that changed code no longer supports.

For failure or empty states, assess whether the user can understand what happened
and identify a valid next step. Preserve the original failure identity and useful
context. Guidance must not silently add retries, change scientific inputs or
promote an exploratory result into a certified one.

## Evidence and completion

Keep execution success, completion of the user's task and scientific validity
distinct. Observe the actual symptom and distinguish it from a proposed cause.
For a persistence defect, a save followed by the real read path can separate
reported success from usable output; another assertion on the save message cannot.

Use the smallest evidence that resolves the affected claim. Keep writes and test
data within the authorized workspace, preserve existing artifacts and account for
cleanup. No live provider call, publication, external message or expensive replay
is authorized merely by requesting usability review.

Report the affected user task, entry/options, observable result, expected behavior,
evidence and limitation. An agent completing a workflow is execution evidence;
it does not substitute for a user's own usability acceptance when that remains
an explicit project obligation.
