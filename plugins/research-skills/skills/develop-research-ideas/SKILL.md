---
name: develop-research-ideas
description: Form, generate, compare, or evaluate research directions using their scientific value, mechanisms, evidence, and actual constraints. Use for topic selection, brainstorming, proposal assessment, a cross-field transfer, or deciding whether a result or idea is worth pursuing or writing up and what to do next. A narrow factual question or implementation of a chosen approach does not need this workflow.
---

# Develop Research Ideas

Help the user choose a meaningful question or approach and identify what would
make progress trustworthy. Start with the actual uncertainty: problem formation,
candidate mechanisms, evaluation of a concrete proposal, or a cross-field idea.
These are lenses to select, not consecutive stages to complete.

## Judgment that matters

- Establish what would become understood or possible if the work succeeded.
  Treat prior work, existing code, and invested effort as evidence and constraints,
  not the boundary of the design space. Generated candidates tend to favor old,
  highly cited problems the field has stopped pursuing. Prefer what becomes newly
  possible over a gain that only makes an existing result faster or more precise,
  and pursue an old problem only when its answer would still change current work.
- Explore structurally different approaches when alternatives are wanted. A new
  parameter, kernel, or application label is not a new mechanism by itself.
  Stop generating when new candidates no longer differ in mechanism.
- State the strongest credible hypothesis, then identify its load-bearing
  assumptions. Repair a local defect without discarding unrelated ideas, and
  abandon a premise when the evidence actually contradicts it.
- Ground novelty and comparison claims in inspected primary sources. Distinguish
  established facts, source-backed inferences, and open hypotheses. Missing
  literature is uncertainty, not proof of novelty or failure.
- Judge scientific value and feasibility from the actual question, proof or
  mechanism, data or query access, resources, and strongest alternative. A theorem,
  explanation, negative result, or replication can be valuable without multiple
  performance improvements. When agents will do most of the technical work, favor
  a problem whose final answer can be checked without trusting them, for example
  against an independent high-precision evaluation, a certificate, or published
  numbers, since otherwise verifying their work can cost as much as doing it.
- Account for relevant preparation, execution, measurement, memory, storage, and
  repeated-run costs. Use the cheapest informative check when one is needed,
  and run a larger experiment only when its result could change the judgment.

Use independent agents when separable evidence or judgment work improves the
result. No fixed perspective, candidate, round, or score count is required.
Ask only for missing information that materially changes the work; otherwise use
the supplied artifacts and state consequential assumptions.

Lead with the strongest current recommendation and its decisive reasons. When
the user asked for options, present the distinct candidates first, then which one
you would pursue and why. Explain the remaining uncertainty and next proof, source
check, or experiment when useful. A search can restrict itself silently to the
simplest class of a problem, such as the easiest function family or data regime.
When the candidates or a successful result rest on such a restriction, name it
and say whether the same method could reach the next class, as a suggestion
rather than added work.
Do not require a ranked portfolio for a single proposal or an accept/reject verdict
for an exploratory discussion. A feasible project may still lose to a more useful
alternative; no candidate needs to be preserved just because work has begun.

## Check before delivering

Before delivering, check the answer against these items in a pass separate from
writing it, using what was already inspected. Fix what fails and recheck what
changed.

- A claim that a cross-field result or transfer matters to the target field
  states what that field already knows and currently asks, or marks that value
  unverified and names the question for a domain expert.
- When the candidates or a successful result rest on the simplest class of the
  problem, the answer names that restriction.

## Optional lenses

Read only what the current question needs:

- [problem-framing.md](references/problem-framing.md): an unclear outcome or reason
  to pursue the topic.
- [evaluate-proposal.md](references/evaluate-proposal.md): a concrete proposal's
  value, decisive flaws, and feasibility.
- [cross-field-transfer.md](references/cross-field-transfer.md): whether an analogy
  transfers under the target assumptions, and whether a cross-field result matters
  to the target field.

Use `upgrade-research-inputs` when source retrieval is the missing work. Use
`rethink-design` when the user wants to challenge an already committed direction
or design as too limited. Either can come before or after this one as the work
requires. Keep durable records only when the user asks for them or ongoing work
needs them.
