---
name: physics-from-math-explainer
description: "Explain physics-heavy mathematics (rotating frames and RWA, ladder operators, Josephson/transmon-to-Kerr reductions) to a mathematically strong reader who needs physical intuition and explicit conventions. Use for quantum, continuous-variable (CV) and circuit-physics explanations or study notes."
---

# Physics-from-Math Explainer

## Select depth

- **Short:** give the usable physical conclusion and any scale condition or
  limitation needed to interpret it correctly.
- **Standard:** add symbol definitions, frame or picture, statement status,
  derivation chain, physical interpretation, and failure conditions.
- **Study-note:** load `references/physics-study-note-handbook.md` and produce a
  reusable note with the relevant operator, RWA, or Hamiltonian-reduction template.

For a paper walkthrough or timed talk, also read Template D in
`references/physics-study-note-handbook.md`.

Infer depth and prerequisites from the question and supplied context. Do not ask for inputs
already clear or force the full study-note structure onto a narrow question. This skill
is specific to physics; ordinary nonphysics explanation needs no physics workflow.
Depth changes topic coverage, not logical completeness. Within the chosen scope,
show every step the reader needs to follow the result.

## Core workflow

1. **Assess prerequisites.** Name only the missing physics concepts needed for the
   current result.
2. **State the conclusion in words first.** Do not place undefined symbols in the
   opening conclusion.
3. **Define symbols and conventions.** State units, commutators, basis, frame or
   picture, sign conventions, and whether `\hbar=1`. Identify the concrete expression
   or objects behind labels such as correction, reference state, error, and cost.
4. **Label every load-bearing statement.** Distinguish definition, exact operator
   identity, basis-dependent equality, approximation, perturbative truncation,
   RWA replacement, effective model, convention, and empirical assumption.
5. **Make scale conditions explicit.** For a dropped rotating term with strength
   `g` and rotation frequency `Omega`, state the relevant requirement such as
   `|g| << |Omega|`, together with resonance and timescale qualifications.
6. **Derive in small steps.** Show the starting expression, the operation or assumption,
   and the resulting expression. Write out each group in a decomposition and the
   criterion assigning terms to it before saying a group is kept, dropped, or compiled.
   Name the basis, frame, ordering identity, or approximation that licenses each step.
   Carry coefficient matching through to the final effective model.
7. **Explain both views.** Give the mathematical meaning and the physical process or
   measurement meaning. Do not use metaphor as a substitute for derivation.
8. **State what fails.** Name the excitation, coupling, drive, resonance, multimode,
   decoherence, or truncation regime that invalidates the result.
9. **Correct a relevant near miss.** Explain a nearby interpretation when the user
   raises it or it would otherwise plausibly change the answer.

## Hamiltonian-to-circuit explanations

When explaining a correction implementation, show the concrete chain
`H_target = H_native + Delta H -> exp(-i h Delta H) -> C(h)`.
Write the terms in each Hamiltonian and map each correction term to its gate block.
Give gate definitions, parameter matching, and execution order, including which
factor acts first. Separate exact identities, outer splitting, and gate-compilation
approximations. Identify ancilla preparation and final treatment when used.
For fitted gates, state what input-output pairs are matched and how the parameters
are obtained. A resource claim must identify the counted operations, merging rules,
and whether a count is per block, per step, or for the complete evolution.

## Hamiltonian coefficient contract

Whenever reducing to a Kerr or Duffing form, state:

- whether the Hamiltonian is in energy or angular-frequency units;
- whether the nonlinear term is written as `K N(N-1)/2`, `K N^2`, or another convention;
- the sign convention for `K` and the corresponding anharmonicity;
- which constant and linear terms were dropped or absorbed into the frequency;
- the perturbative and excitation regime in which the coefficient is valid.

Never switch from `H` to `H/\hbar` without updating coefficient units.

## Source and evidence discipline

- Inspect a supplied derivation, manuscript, circuit model, or code artifact before
  explaining its claim.
- A published equation is not automatically correct. Identify abstract-only,
  inaccessible, or otherwise unverified material explicitly.
- Separate what the source states from what follows by reconstruction.
- For a paper walkthrough, pair each substantive step with its verified page and
  equation, figure, or table label. Identify unnumbered source text as unnumbered.
  For a reconstructed equation, cite the starting equation and show the derivation
  rather than giving it the starting equation's number. Mark unavailable evidence.
- In a requested talk or lesson sequence, put the necessary definitions, physics,
  and implementation steps where they are used. A page pointer does not replace
  that explanation. Meet a time limit by reducing scope, not by skipping logical
  connections or moving required explanations to an appendix.
- Do not present an approximation arrow as algebraic equality.
- Do not infer hardware-native dynamics from an effective Hamiltonian.
- Mark convention-dependent coefficients rather than forcing a universal sign or factor.

## Language and formatting

Follow the user's language. Define specialized English terminology bilingually on first
use when helpful, then remain consistent. Define symbols before the first formula that
uses them. Use compact tables only when they reduce notation load. Do not use em dashes
in authored prose unless the user or the destination requires them. Use commas,
parentheses, or separate sentences instead, as `research-writing-style` sets out.

## Completion check

Verify that:

- the conclusion is usable without undefined notation;
- the basis, frame, units, and conventions are explicit;
- each decomposition names its actual terms, and each transition has its operation
  or assumption with no ambiguous referent;
- exact and effective statements are separated;
- source locations match the explained objects and distinguish source equations
  from reconstructed equations;
- correction terms map to gate blocks with explicit parameters and execution order
  whenever a circuit implementation is explained;
- every approximation has a scale condition and failure regime;
- coefficient signs and factors are traceable;
- the formal derivation and physical intuition agree;
- the explanation matches the requested depth.
