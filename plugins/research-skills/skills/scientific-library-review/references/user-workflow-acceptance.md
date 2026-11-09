# Acceptance from the user's workflow

Use when the reviewed change affects examples, notebooks, reports, error messages
or the ability to complete a public task, and for the first-contact walk of a
release or a whole library below. Judge the intended audience: a scientist
may need precise terminology, equations and provenance. Do not replace necessary
technical terms with vague language or assume every user is a beginner.

## Follow the task through its visible result

Start with the documented public entry and representative valid options,
including documented switches that select a different method or execution path,
not the defaults alone. Check whether the user can discover prerequisites,
perform the task, interpret the result and take the next appropriate action
without undocumented internal calls.
Use the interface actually consumed: a notebook kernel, CLI, Python API or
browser as applicable. A browser is not required for a library workflow.

For scripts, examples and command-line entries, help and an unknown or
misspelled option should stop before scientific work starts or files are
written. A control that is silently ignored runs a configuration the user did
not request. Check this through the parser path or with a no-work guard, so that
a faulty entry cannot launch its full workload during the check.

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
promote an exploratory result into a certified one. Check a refusal's stated
remedy on the same input, by derivation when running is costly. Advice the input
already satisfies, a retry that repeats the same refusal, or a state that cannot
continue is a defect in the message or the route. A later stage reaching its own
limit is not a defect of this remedy.

Probe limits and caps at values a user would set. A finding that needs a cap far
below its default, such as a byte limit of a few thousand bytes against a default
of gigabytes, is an observation, not a defect, and a remedy for such a cap needs
only the right direction.

## First contact with the public surface

Use when the review covers a release or the library as a whole, or the change
adds public names, options or returned objects. A review scoped to a diff sees
each addition and not their sum, so read the surface as a newcomer following the
first documented steps, with a few small scripts on the smallest documented
example:

- Display each object the workflow returns, as a notebook's last line and with
  `print`. A default dump of nested records or identifiers hides what the user
  built.
- Start from a problem and ask the library which methods accept it, then omit
  the method. The answer or the error names the candidates the library already
  knows.
- List what the method namespace and a result offer to completion, and count the
  entries a user never calls.
- Read a method's options from its signature, then set each option on a route
  that does not read it. It is refused, or it is documented as having no effect
  there and leaves the result unchanged.
- Run the first resource or accuracy query the quickstart shows. An example that
  introduces a capability returns a result for its own input.
- Give a documented problem type to a method that declines it. The refusal names
  the entry that accepts it when the library has one.
- Check that documented extension examples import only public names.

Report each observation with the documented task it belongs to, and give totals
where growth is the finding, such as the number of options or exported names.
(In November 2026 such a walk of one released library took minutes and found a
34,000-character default display of a plan, 82 names in one import namespace and
nine options accepted on routes that never read them.)

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
