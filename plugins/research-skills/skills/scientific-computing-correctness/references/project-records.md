# Authority of project records

Read this reference when a plan, policy, framework, constants registry, review
report, or earlier AI-authored summary could change a scientific decision.
Classify the record by the authority the user or project assigns:

- **Constitutional:** an invariant or decision the user explicitly designates
  as requiring an explicit amendment before it changes.
- **Living:** current engineering guidance that should be revised when better
  first-principles reasoning, executable evidence, or an authorized design
  change makes it stale. Update its enforcement and downstream representations
  together.
- **Descriptive or generated:** a record of code, environment, results, or
  artifacts. Refresh it from the semantic owner, and do not use it to overrule
  the state it is meant to describe.

Only the user or a delegated project owner designates constitutional status.
Do not infer it from a filename, location, tone, age, test, or prior agent's
wording. When an undesignated or living record conflicts with current evidence,
decide from the intended quantity and first principles whether the code, the
record, or both must change. Ask the user only when the classification or
amendment authority would materially change the result and has not already
been recorded.

The same authority may designate an implementation of record or frozen
evidence. Produce results of record with the designated implementation, and use
an independent implementation only to validate them. Write regenerated evidence
beside frozen evidence rather than over it. Replacing either requires the
user's decision.

## Documenting formulas

Read before adding or changing a formula or numerical rule, or documenting an existing one.

- Document each formula or numerical rule the work adds or changes where
  the project keeps derivations, linked from the definition, and otherwise in
  the docstring or a comment above the definition, with the derivation steps a
  reader needs, its assumptions, its error bound when it has one, and its
  source with a stable identifier. Copy a derivation made elsewhere, such as in
  a report, into the code or algorithm documentation, because such records may
  not last. Owners sharing a
  derivation name each other, and a test asserting a derived bound names the
  owner that derives it. When documenting existing code, derive each step,
  and report one that contradicts the derivation as a finding rather than
  inventing a reason for it.
