# Grammar rules for non-native English authors

## Table of contents

1. Article usage
2. Subject-verb agreement
3. Tense consistency
4. Sentence complexity
5. Which versus that
6. Passive voice
7. Chinglish patterns
8. Punctuation in quotations

## 1. Article usage

Rule G1: singular countable nouns require an article (a, an, the)
unless they are generic plurals or proper nouns.

| Bad | Good |
|---|---|
| We propose novel method. | We propose a novel method. |

Note: fixed idioms such as "in descending order" and "in
practice" take no article; do not "correct" them.

Quick test: if the noun is countable and singular, and the
sentence is about a specific instance, the article is required.
For generic plurals, articles are omitted. For uncountable nouns
(information, evidence), articles are usually omitted.

## 2. Subject-verb agreement

Rule G2: third-person singular subjects take third-person
singular verbs.

- it predicts, it proposes, it improves.
- we propose, we show, we introduce.
- they demonstrate, they report.

The ICML or VLDB paper (singular) uses the third-person singular
verb form:

- The method predicts accurately.
- Not: The method predict accurately.

## 3. Tense consistency

Rule G3: choose tense from the sentence's meaning and the discipline,
not a fixed section rule.

- Present tense commonly states a definition, a method's operation,
  or a claim the paper establishes: "The estimator is unbiased."
- Past tense reports completed actions and observations: "We ran
  the experiment and observed a smaller error."
- Present perfect can connect completed work to its current
  consequence: "We have established the bound under these assumptions."

Related work may describe a past research action or a currently
applicable result. Conclusions follow the same distinction. Mixed
tenses are appropriate when the time or logical role changes:
"We verified numerically that the method preserves the norm."
Correct unexplained shifts, not meaningful changes in tense.

## 4. Sentence complexity

Rule G4: one sentence, one main idea. Two verbs in one sentence
require a connector. Avoid sentences with two independent clauses
joined only by a comma (comma splice).

| Bad | Good |
|---|---|
| We propose a method has high efficiency. | We propose a method that has high efficiency. |
| We propose a method has high efficiency. | We propose a high-efficiency method. |
| Our model supports the case changed. | Our model supports the case that changed. |
| We propose a method, it has high efficiency. | We propose a method. It has high efficiency. |
| We propose a method, it has high efficiency. | We propose a method with high efficiency. |

Long sentences should be split at natural boundaries. Use
"Specifically," or "In particular," to start the continuation
sentence rather than stuffing everything into one complex
sentence.

## 5. Which versus that

Rule G5: use "that" for restrictive clauses (essential to the
meaning); use "which" for non-restrictive clauses (parenthetical
and set off by commas).

- Restrictive: "the method that achieves state of the art" (out
  of a set, the one that achieves).
- Non-restrictive: "the method, which achieves state of the art,"
  (an aside).

Non-native authors commonly use "which" in both cases. Correct
to "that" when the clause is restrictive.

## 6. Passive voice

Rule G6: prefer active voice unless the subject is genuinely not
important. "The method was evaluated" is acceptable when the
evaluator's identity does not matter; "We evaluated the method"
is stronger when it does.

Over-use of passive voice makes prose feel evasive. Audit
paragraphs for strings of passive constructions and replace the
most important sentences with active voice.

## 7. Chinglish patterns

Common Chinglish patterns to flag:

- Direct translation of Chinese idioms that do not carry in
  English.
- Overuse of "very", a common carry-over from Chinese; often
  unnecessary.
- Awkward repetition of general-purpose words where restructuring
  would be clearer. Do not vary defined technical terms merely to
  avoid repetition; terminology consistency takes precedence.
- Over-hedged statements ("it may be the case that perhaps the
  method possibly") when a direct statement is clearer.
- Translating a Chinese draft with a machine translator. Never do
  this; the output accumulates un-idiomatic phrasing that
  reviewers notice immediately. Write in English from the start.

## 8. Punctuation in quotations

Rule G8: this is a venue-dependent style rule, not a grammar
rule. Default to logical punctuation (punctuation inside
quotation marks only if part of the quoted material), but if the
target venue's template mandates American typography (as most
ACM/IEEE templates do), follow the venue and skip this check.

| American (avoid) | Logical (use) |
|---|---|
| approach is called "data-centric AI," which emphasises | approach is called "data-centric AI", which emphasises |
| outputs what it calls "semantic summaries." | outputs what it calls "semantic summaries". |

Also: use backticks and single or double quotation marks per
LaTeX convention: `` `` `` for open and `'' '` for close, not the
straight typewriter character.
