# Source and lineage protocol

Use this reference whenever the workflow retrieves literature, documentation,
code, data, or current facts.

## Table of contents

1. Seed lineage map
2. Query families
3. Source hierarchy
4. Direct-inspection rules
5. Current-fact and coverage rules

## 1. Seed lineage map

For a lineage or novelty inquiry, inspect the parts of this backbone that can
change the answer. A narrow source question does not require a complete map:

1. closest recent work;
2. earliest identifiable formulation;
3. major rediscoveries or renamings;
4. prior failures or reasons the idea was not adopted;
5. strongest current alternative;
6. relevant supplements, appendices, code, datasets, and official docs;
7. forward and backward citation paths; and
8. repeated claims from the same author group across papers.

When an older idea appears newly viable, name both the changed condition and its
mechanistic consequence. Candidate changed conditions include compute, data,
hardware, control fidelity, theory, tooling, cost, deployment setting, and
evaluation standards. "Conditions improved" is not enough; explain why the
change alters feasibility, scaling, or value.

## 2. Query families

Use only families relevant to the current question:

- exact claim, phrase, equation, or theorem;
- original or earliest source;
- closest prior work;
- review, correction, comment, replication, or retraction;
- limitation, failure, counterexample, or negative result;
- appendix, supplement, code, dataset, and benchmark protocol;
- author-group continuity and earlier versions;
- adjacent-field structural analogue;
- current official documentation, specification, or release; and
- strongest baseline and resource comparison.

Search by mechanism and mathematical structure as well as current terminology.
Different fields often give the same object different names.

## 3. Source hierarchy

Use sources according to role, not prestige alone:

1. **Primary research evidence**: original paper, theorem, experiment, dataset,
   supplement, or pre-registration.
2. **Implementation evidence**: official repository, tagged release, commit,
   issue, configuration, benchmark script, or hardware documentation.
3. **Authoritative current facts**: official standards, maintained project or
   vendor docs, institutional pages, and maintained databases.
4. **Terrain maps**: surveys, reviews, textbooks, and tutorials.
5. **Discovery surfaces**: talks, blogs, news, social media, and LLM summaries.

Terrain maps and discovery surfaces locate candidates. They do not replace
inspection of the original source for a load-bearing claim.

## 4. Direct-inspection rules

- Record the exact section, page, theorem, figure, table, dataset, code path, or
  version that supports a load-bearing claim.
- Treat abstract-only access as insufficient for detailed method, proof,
  resource, or experiment claims. Mark the claim unverified.
- Separate direct support from the workflow's inference.
- Check whether the source supports the claimed scope, magnitude, conditions,
  and comparison, not merely a nearby statement.
- Multiple papers from one group, dataset, benchmark, or recycled argument are
  not independent confirmation.
- Citation count and venue prestige do not establish correctness.
- Seek relevant counterevidence, corrections, and failure regimes when they
  could change a consequential validity, novelty, or comparison judgment.
- Do not infer a relationship merely because two facts occur in the same source
  set. Require an explicit connection or supply and label the inference.
- Do not transfer results across domains, hardware models, datasets, or
  asymptotic regimes without checking assumptions.

## 5. Current-fact and coverage rules

For software behavior, standards, product capabilities, documentation,
leadership, policies, prices, schedules, or other changeable facts, verify a
current official source and record its date or version. Do not rely on remembered
details when cheap current verification is available.

Never claim exhaustive literature coverage without a specified corpus, query
strategy, access boundary, and stopping rule. Report inaccessible, abstract-only,
outdated, paywalled, terminology-limited, or corpus-limited evidence explicitly.
