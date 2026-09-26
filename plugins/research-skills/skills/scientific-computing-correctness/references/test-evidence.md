# Test evidence

Read this reference when adding or changing tests or numeric assertions, when
deciding whether a test needs a failure demonstration, or when a result varies
across platforms or dependency versions.

## Failure demonstrations

Each test that the current work adds or changes must observe the promised
property, for example that pilot information changed an allocation, not only
that the pilot ran. It must also be able to fail for a plausible defect in that
property. A fix's regression test shows this by failing on the pre-change code,
in a new run or an earlier one that still applies. For other tests, run a new
deliberate small breakage only when a plausible defect could still escape the
checks and the cost is justified, whatever the number of changed tests. Use a
small instance when the test is expensive. Evidence still valid for the current
code and behavior can be reused, and one breakage can support several tests
when the report names the property it covers. A rename or reorganization that
leaves what every assertion checks unchanged needs no new failure
demonstration.

An import, attribute, or missing-symbol failure on the pre-change code is valid
evidence when importability or that public export is the contract. Otherwise
such an error, caused only by the feature's absence, does not show that a
behavior check works. No added or changed test may restate the implementation,
take the expected value from the same code path, or only check that a string,
symbol, file, or key exists when that text or artifact is not itself the
contract. A characterization test that pins current behavior before a refactor
is acceptable when labeled as such, with expected values recorded from the
pre-change code. When a fixed discriminating counterexample separates the
defect, prefer it to a repeated random-seed scan.

## Numeric assertions

Classify numeric assertions before writing them. Compare floating-point values
numerically with a tolerance derived from the method and with explicit margin
from decision boundaries. For APIs that combine absolute and relative
tolerances, set both explicitly, so that an omitted library default neither
defines nor dominates the effective acceptance window. Require exact text only
when byte-level serialization or formatting is itself the contract.

## Platform-dependent results

When a floating-point boundary decision varies with platform, dependency
version or rounding direction, make its regression deterministic. Construct
the adjacent representable value (for example with `nextafter`) at the owner
that makes the decision, and keep the natural case as supplementary evidence.
A passing retry does not resolve a deterministic counterexample. Attribute the
variation to a dependency only after isolating it.

A result can depend on an arbitrary sign or phase that a dependency returns,
such as eigenvector signs from LAPACK, and then differ across platforms. Fix
the convention where the object is built, with a rule that ties cannot decide,
such as making the first component above a relative threshold positive. A
largest-component rule leaves equal components to roundoff, and a sign rule
does not fix the basis within a degenerate subspace. Test the convention by
flipping that sign or phase in a case where the flip changes the downstream
result, because symmetric cases can hide the dependence.
