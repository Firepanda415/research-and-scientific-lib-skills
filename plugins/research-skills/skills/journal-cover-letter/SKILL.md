---
name: journal-cover-letter
description: Draft, revise, or check journal submission cover letters. Use for new letters, submission-readiness checks, or local edits to an existing letter.
---

# Journal Cover Letter

## Select the requested outcome

- **New letter:** inspect the manuscript metadata, supporting claims, and current journal requirements, then draft the requested letter.
- **Submission-readiness check:** compare the existing letter with its sources, current venue requirements, and confirmed declarations. Report unresolved blockers; rewrite only when requested.
- **Local edit:** revise the requested passage using the existing letter and conversation. Read manuscript material or refresh journal policy only when the change affects technical claims, factual declarations, metadata, or venue requirements. A grammar-only change does not require the whole manuscript or a new policy check.

Determine submission type from the existing artifact and conversation. Preserve an established resubmission, appeal, response-to-review, or transfer context. Default to first submission only when creating a new letter and its type is otherwise unknown.

## New-letter and readiness workflow

1. Identify the target manuscript source, journal, article type, corresponding author, intended output file, and submission date or cycle.
2. Check the current official journal author instructions and submission portal requirements for cover letters, required declarations, prohibited content, editor addressing, and length or file-format rules. Prefer official journal or publisher sources. Record the access date and the specific policy page. If current policy cannot be verified, label it unverified and do not present remembered requirements as current.
3. Read the manuscript title, author list, affiliations, corresponding email, abstract, summary/results section, and conclusion. Treat the manuscript and its accompanying data/supplementary materials as the source of truth for technical claims.
4. If examples are provided, separate format from content:
   - If multiple examples are provided, reuse layout, document class, sender block, and signature style from the example with the best formatting, and reuse tone and contribution framing from the example with the strongest wording. Reuse declaration phrasing only after current-policy and factual confirmation.
   - If only one example is provided, reuse its format and tone, not its manuscript facts or unconfirmed declarations.
5. Draft only when the user requests a new letter or authorizes revisions. Follow the submission type established above and preserve a useful existing structure.
6. Keep the letter journal-facing and non-hype. State why the manuscript fits the journal, then use the smallest useful set of concrete contributions supported by the manuscript; three to five is a common default, not a quota.
7. Treat submission declarations as factual attestations, not boilerplate. Before asserting a declaration, use the user's established confirmation from this assignment or an authoritative submission record. Ask only for a consequential fact that is still missing:
   - all authors approved this submission;
   - the manuscript is not under consideration elsewhere;
   - conflicts of interest and special-handling issues;
   - preprints, related manuscripts, prior submissions, or overlap;
   - suggested or excluded reviewers and the journal's rules for them.
   Do not infer these facts from an example letter. If confirmation is missing, omit an optional statement or leave a clearly marked `[AUTHOR CONFIRMATION REQUIRED: ...]` placeholder; never silently assert it.
8. For LaTeX output, make the cover letter compile independently. Avoid manuscript-specific macros unless they are defined in the cover-letter file.
9. Prefer exact manuscript numbers over vague ranges when the manuscript provides them.

## Recommended Structure

Use this order for a standard journal submission:

1. Sender block with name, title, institution, and email.
2. Recipient block: named editor if known; otherwise `Editors` and the journal name.
3. Subject line with the manuscript title.
4. Opening: `Dear Editors,` unless a named editor is known.
5. Submission paragraph: manuscript title, article type, target journal, and on-behalf-of-all-authors wording only when that authorization is established.
6. Fit paragraph: one concise sentence tying the work to the journal scope.
7. Contribution bullets: a compact set of concrete, defensible claims; three to five is a useful default.
8. Declarations paragraph containing only journal-required or author-confirmed statements.
9. Polite closing and signature with title/institution.

## Style Rules

- Use direct academic prose; avoid marketing language such as "groundbreaking," "transformative," or "paradigm-shifting."
- Keep claims aligned with the manuscript. Do not introduce novelty, performance, or scope claims that are not supported in the paper.
- Prefer precise nouns over generic phrases: "postselection success probability" is better than "robustness" if that is what the manuscript proves.
- Keep the letter short, usually one page.
- Follow `research-writing-style` for the user's punctuation and vocabulary preferences. Do not introduce em dashes or semicolons into authored research prose.
- Mention a working-paper or preprint version when current journal policy requires it, or when the user provides the details and requests disclosure. Never invent or infer preprint metadata.
- For IOP/QST-style letters, `moderncv` is acceptable if examples use it, but a standard `letter` class is safer when the local/Overleaf environment lacks `moderncv`.

## LaTeX Checks

For a new letter or submission-readiness check, apply the metadata and declaration checks below to the complete letter. For a local edit, apply those checks only to affected claims, declarations, metadata, or venue requirements. Compile and visually inspect an actual `.tex` artifact after creating or editing it; a grammar-only request does not become a new submission-readiness judgment.

1. Confirm the title, corresponding email, journal name, and article type match the manuscript and current journal instructions.
2. List every factual submission declaration and its confirmation source. Any unresolved declaration remains a visible placeholder and blocks a "ready to submit" verdict.
3. Check for template leftovers inconsistent with the established submission type. Review-related terms such as `reviewer`, `response`, `revised`, and `resubmission` are legitimate when that type requires them; inspect stale `verbatim` or revision-color markup where relevant.
4. Compile the standalone letter with the available TeX workflow and inspect the result. Diagnose undefined commands or layout problems from that build; a separate audit of every package command is unnecessary. Manuscript-only macros are a common source of undefined commands.
5. Confirm that the final PDF has the intended complete letter and signature.
6. If local TeX tools are unavailable, say so and report source-level checks instead of claiming compilation.

## Common Fixes

- If `moderncv` does not display `\title{...}` in letter mode, put the title/job role in the visible `\address{...}` block and in the signature.
- If LaTeX warns that a font shape such as `OT1/cmss/m/n` is unavailable, add:

```tex
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}
```

- If `hyperref` warns about math in PDF strings for section headings or bookmarks, use `\texorpdfstring{printed math}{plain text}` in the manuscript heading. Cover letters usually should avoid math in headings.
