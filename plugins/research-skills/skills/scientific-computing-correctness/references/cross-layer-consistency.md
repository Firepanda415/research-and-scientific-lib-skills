# Cross-layer consistency

Read this reference when a change touches a public record or its fields, a
relation between counts or populations, interacting options, a reuse key,
cache or dependency qualification, or metadata that describes a build.

- When a public record is affected, define the field's meaning and the units,
  population, event, or cross-field relations needed to interpret it. Do not
  introduce a new status schema or bookkeeping layer for an unchanged contract.
- Validate semantic relations, not only type conversion. Defaults must not
  overwrite observed facts. If the contract defines nested populations, check
  relations such as `0 <= completed <= submitted <= planned` together.
  Derive the relation from the actual populations, because retries or
  different counting units may require a different relation.
- Identify interactions that can violate the changed invariant. Use separating
  cases or equivalence classes, and enumerate a full Cartesian product only
  when the contract and cost justify it. Independent one-axis checks can miss
  coupling.
- Define each reuse key, memo, cache, equality check, or dependency
  qualification by every input its consumer reads, such as arguments,
  parameters, ordering and payload, and by no incidental handle. A dependency
  qualified at one revision stays qualified at a descendant revision while
  every input its guarantee reads, including source files and build settings,
  is unchanged. A key on an object address or transient
  wrapper id holds that object for the key's lifetime or keys on a stable value
  instead. Test a distinct input
  that could share the key alongside a legitimate reuse. An identity or
  manifest label does not verify contents it did not check, so report those
  contents as unverified.
- Metadata and error records must describe the same construction or execution
  that produced the shipped artifact, not a second nominally equivalent build.
