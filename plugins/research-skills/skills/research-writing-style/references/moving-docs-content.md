# Moving documentation content

Read before moving, splitting, summarizing, deduplicating, hiding or renaming content in a library's documentation.

## Before the edit

- Find what reads the documentation. Tests, source comments, notebook generators and scripts can cite page paths, anchors and numbered results, and a test can require every page to be in the navigation. Keep a page's path where its main content stays, and keep numbered results and anchors stable.
- When parallel jobs move text between pages, name both ends of every transfer with its destination anchor and both owners, and create destination headings before any job deletes text. Move transfers found during writing in a later wave.

## Scientific meaning

Moving, splitting, summarizing, deduplicating and hiding are scientific edits. A split can detach a premise, a summary can turn a sufficient condition into a necessary one, and hiding a member can take its scientific content off the site.

- Keep a passage table with each such passage's claim as it now reads and its support. Review each row in context against these questions: quantity, units, metric, strict or inclusive, necessary or sufficient, sampling assumptions, total or component error, per-attempt or whole cost, published or adapted.
- Writers move and split mathematical sentences and apply listed word replacements. Any other rewording of mathematics goes into the table for a reviewer who knows the mathematics.
- Locate changes with a diff of identifiers, numbers and formulas across every source the content moves between, such as pages, docstrings and notebook sources. The diff locates changes and the reviewer judges their meaning. Check library source with the syntax-tree comparison that strips docstrings, and notebooks and printed text with their own diff review.
- A later wave of small changes may skip the passage table when its final review reads the diff directly. That review then carries the table's checks.

## Old URLs

- Keep three kinds of alias: the slug of a renamed heading, a renamed page title's id as an anchor at the start of its first paragraph, and the old ids of moved API objects, listed on the old page with links to their new entries. Delete no page without a redirect.
- When a page's sections go to different pages, keep the old page as a short pointer page that keeps each old anchor and links it to the section's new place. A whole-page redirect sends every old anchor to one destination, which breaks the anchors of sections that went elsewhere. Keep the pointer page where the site's checks expect it, such as in the navigation when a test requires every page there.
- Retarget the internal links and citations that land on a pointer. Searching the diff for added anchors lists them.
- Exclude only generated assets from the URL checker, because a broader exclusion can hide a real page.

## Checks

- Every renamed heading, renamed page title and moved API object keeps an alias, no internal link lands on a pointer anchor, and the site's navigation checks still pass.
- Every moved, split, summarized, deduplicated or hidden scientific passage has a reviewed passage-table row, or its wave's diff was read in the final review.
