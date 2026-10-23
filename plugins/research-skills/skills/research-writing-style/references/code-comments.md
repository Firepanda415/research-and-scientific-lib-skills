# Code comments

Read when writing, editing, or reviewing code comments and internal docstrings. This reference stands alone, with only the check below. Comments or docstrings that render a public API reference follow [API docstrings](api-docstrings.md) instead.

## Explain what a maintainer needs

- Read the relevant code before describing it. Add information a maintainer cannot readily recover from that code, such as the reason for a choice, an invariant, an input convention, or a failure the implementation prevents. A non-obvious operation or mathematical meaning can need explanation too. Omit a comment that only repeats clear code.
- Use the code's identifiers and the project's terminology precisely. Outside identifiers, use words a scientist maintainer knows. Replace process words such as candidate pool, accepted, archived, stored, or a call meaning a pulse or gate with the object they mean, and keep everyday words such as pipeline. Physicists read readout as a measurement, so a computed or sampled value is not a readout, and calling it a measurement changes the claim. Name the object a condition applies to, and connect the condition to its consequence. Keep related assumptions and conclusions together when splitting them would make the reader guess their scope. Follow the project's comment and docstring conventions.
- Explain numerical assumptions, units, normalization, tolerances, or resource limits when they affect interpretation or safe modification. For a formula, include the reasoning needed locally or link to its maintained derivation. Identify a cited paper by its DOI, versioned arXiv identifier, or the project's citation convention.
- Support a claimed reason with the implementation, a maintained design record, or other evidence. When the reason is unknown or the code contradicts the explanation, report the uncertainty or discrepancy rather than inventing an intention.
- Treat tool directives in comments, such as type-checker suppressions, formatter controls, and executable examples, as functional content. Preserve them in a prose-only edit. Apply the project's relevant validation if the task changes their behavior.

For example, where sorting would modify storage shared with the caller, a useful comment is `Copy before sorting because the caller still uses the original order.` It explains the reason a future edit must consider.

## Check the changed comments

Read each changed comment beside the code it describes. Confirm that it supplies needed information, matches the current behavior and evidence, keeps conditions, mathematical meaning, and identifiers intact, and uses no word outside identifiers that needs a software background. Check that a prose-only edit leaves tool directives and executable examples unchanged. A request to review comments alone reports findings without rewriting them.
