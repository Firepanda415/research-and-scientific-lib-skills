## Source-to-code fidelity

For paper-based implementation, locate the actual equations, algorithm, and
parameter definitions before coding. Check sign, units, normalization, basis and
index ordering, boundary conditions, initialization, truncation, precision,
stopping rules, and library defaults where they affect the result. Explain the
notation map and derivation when an equivalent formula is used.

Preserve the source's quantifiers, domains, and order of choices: `at most`
is not `exactly`, an asymptotic statement is not a finite-instance guarantee,
and an instance-dependent choice is not a uniform one. State any additional
assumption needed to turn a source bound into an executable rule.

Resolve a suspected typo from the surrounding derivation or an independent
check; record the interpretation instead of silently changing the method. If
an ambiguity changes the result and cannot be resolved, expose the alternatives
and the missing fact. Prototype status reduces implementation scope, not fidelity
to the chosen mathematical specification. Use a small independent reference
case before scaling; a successful run alone does not establish reproduction.

When a task audits, implements or relies on a proof-assistant formalization of
paper claims, a successful build establishes only the formal statements as
written, under their hypotheses and axioms. Check the current proof sources
rather than cached build artifacts, and require a fresh build only when cached
artifacts could hide a missing or changed source. Compare each cited formal
statement with the paper claim it is cited for, including hypotheses,
quantifiers, the side of any projection or truncation, and whether the
statement is vacuous or only existential. A formal statement covers a claim when
it asserts the claim, a special case or weaker version of it, or a stronger
statement that implies it. Classify in both directions from the statements
themselves rather than from a coverage summary, starting with each paper claim.

- Faithful: one formal statement, or several together, assert the claim with
  its hypotheses, quantifiers and conclusion, or imply it.
- Partial: formal statements cover only a special case or a weaker version.
- Missing: no formal statement, alone or jointly with others, covers the claim.

Then classify each formal statement that the development presents as a result
or cites for a paper claim. Other statements, such as auxiliary lemmas, are not
classified.

- Matched: the statement covers at least one paper claim, alone or as part of
  a split proof that covers it jointly.
- Formal-only: the statement covers no paper claim.

Report each citation of a formal statement for a claim it does not cover as a
mismatch, whatever the statement's class. A statement that changes the claim,
for example by taking a truncation on the other side, or that contradicts it
gives a mismatch. The parts of a split proof and special cases do not.

Classify the dependencies of each cited statement by the foundations the
project adopts. A hypothesis discharged within the development is not a
dependency of the result.

- Logical foundations: the proof assistant's standard axioms as the project
  uses them, such as Lean's `propext`, `Quot.sound` and `Classical.choice`.
- Trusted computation: evaluation trusted beyond ordinary kernel checking, such
  as compiled-code evaluation through Lean's `native_decide`, or a result
  imported from an external solver or oracle. A result the kernel checks, such
  as `decide` or a solver certificate replayed in the kernel, is ordinary
  checking.
- Model assumptions: hypotheses or axioms that state the paper's model or the
  claim's assumptions, or stronger ones that narrow the claim. An axiom does not
  appear in the statements that use it, so check that the stated model
  satisfies it. A result that uses an axiom no model satisfies does not cover
  the claim.
- Extra scientific premises: unproven domain axioms beyond the stated model,
  including literature theorems stated as axioms.
- Proof placeholders: `sorry`, `admit` and their equivalents.

State the logical foundations and trusted computations the development uses,
naming the mechanism each trusted computation relies on. One project-level
statement can cover those shared across results. These foundations and
trusted computations lie inside the theorem's trust boundary and do not by
themselves make a result conditional. When the research requires a
constructive proof, or claims computability or an explicit witness, check
whether `Classical.choice` or another non-constructive foundation enters the
construction of the claimed algorithm or witness, or the proof itself when a
constructive proof is required, since it can then affect the claim.
Per claim, record and disclose only the dependencies beyond these foundations
that affect it. An extra scientific premise or proof placeholder, wherever it
enters the proof, makes the result conditional support for the claim. A
hypothesis or axiom stronger than the claim's assumptions narrows the claim, so
the coverage is Partial. An assumption is not by itself a defect. When claims
change, derive new formal statements from the current claims rather than from
retired drafts.
