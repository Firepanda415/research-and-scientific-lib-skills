# Library documentation

Read for a scientific library's documentation: its user guides, its API reference as a whole, and reviews of either. Docstrings themselves follow [API docstrings](api-docstrings.md). Before moving, splitting, summarizing, deduplicating, hiding or renaming documentation content, also read [moving documentation content](moving-docs-content.md).

Readers are scientists who use the library and arrive with a task. Each page tells them what a call does, what to pass, what comes back, how accurate it is, what it costs and where it stops working, in compact technical text. Where a detail here differs from the project's documentation conventions or from established practice, follow those. Established practice includes [Diátaxis](https://diataxis.fr/), the [NumPy docstring standard](https://numpydoc.readthedocs.io/en/latest/format.html), the [Rust API guidelines on documentation](https://rust-lang.github.io/api-guidelines/documentation.html), [Google's developer documentation style guide](https://developers.google.com/style/highlights) and the reference pages of libraries the readers already use.

## Plan from the readers

- Name the readers, from the project's reader research where it exists, and write each page for one of them arriving with a task, not for a maintainer checking contracts. Scientists usually come for concrete resource counts with their constants, the data structures to define, and how to translate their problem's mathematics into the library's input, rather than for internal mechanisms. (In a survey of quantum-computing researchers, resource counts were the most-selected hard question, translating mathematics into tool input was the largest time sink, and no respondent named an internal mechanism.)
- Keep Diátaxis's four kinds of page apart, and keep user pages apart from contributor pages in the navigation. User content often ends up on contributor pages, such as a table of supported problems, an accuracy check, a glossary, conventions such as qubit order, or install extras. Move it to the user path.
- Open each page with what the reader can do with it and for whom it is written, by naming the task and the result rather than announcing the page.
- Turn a paragraph that carries many rules into a main statement followed by a list or table of its conditions, keeping every value, bound and condition.

## Use the reader's words

Words from the code's design, such as owner, ledger, admission or receipt, are jargon on user pages. Replace each with what the reader calls the thing or with the object's name, or define it once on that page when the reader needs the concept, and keep that one name. A public API name stays as code and gets a plain explanation where it first appears. Contributor pages may keep the terms they define. Where the plain word would be less exact, keep the term and define it.

- Before: "Admission charges the plan against the work ceiling before acquisition."
- After: "Before running any circuit, the library estimates the plan's work and rejects plans above `max_work`."

Keep an internal-word list for the project, with each word's meaning there and the reader's word, and let every writer and reviewer add to it. Such words cluster on pages about the library's own workflow and execution machinery. Text the library prints can be a stored value that code compares, such as a label field, so edit only pure messages, such as an install hint, as text.

## Accuracy, cost and examples

- Keep each statement from numerical analysis exactly as its source states it: relative or absolute, the order, any remainder or subnormal term, and the assumptions. Light rewording changes it. ("Within 3u of its exact value" turned a relative first-order bound into an absolute one.)
- A table that attributes a difference to one cause holds every other cause fixed, such as random inputs, conventions that two code paths choose differently, and the backend. Otherwise present each row as a possible explanation with what to inspect.
- When a measurement's environment was not recorded, say what is missing and how far the number can be used. The current machine says nothing about a past run, and a rerun's machine says nothing about a claim the rerun did not measure.
- For an error budget or a cost, a layout that reads well is a table with the source of every value, one stacked bar of the components against the target, and a table across problem sizes or tolerances. Add a measured error only when it is the same quantity in the same metric as the bound, with its environment and what else it contains, such as rounding or sampling. A budget with one component, or without a target, needs no bar. Generate the figure with a script that names its inputs, reruns byte-identically and reads in light and dark color schemes.
- An example of an extension point keeps the checks the framework leaves to the author, such as checking the requested output, even when shortened. (A shortened custom-method example dropped that check and returned a value for outputs it never computed.)

## The rendered API reference

- Configure the generator before polishing docstrings. Its options usually cause most of the rendered noise, such as empty duplicate field headings, private base classes and module names as headings, and a table of contents that lists every field. (In one library, 1,220 of 1,843 rendered objects were such noise.) Read the generator's documentation or source for how its options interact, render each object once on one page, and try an extension in a trial build before relying on it. Show user-facing objects first, put extension hooks on the extension page, and hide internal hooks.
- Build the site and check the rendered pages before delivery. Without a shell, tell the user what to build and what to check. After merging changes, compare each page's intended members and fields with the rendered inventory, since a passing strict build or link check does not show that a member disappeared. Check tables at phone width, about 375 px. A list layout for parameter sections, where the generator offers one, avoids sideways scrolling.

## Reviewing existing documentation

Report findings without editing. Cover an enumerated file list, such as one from `git ls-files`, rather than area names, and decide explicitly whether notebooks are in scope. (Four reviews assigned by navigation section once left two Markdown files unassigned.) Read the rendered pages as each named reader arriving with a task. Look in particular for user content on contributor pages, internal words on user pages, empty or duplicate rendered objects, and claims without their accuracy, cost, limits or source. Give each finding its location and a short quote, and list what works under Keep so that a later rewrite does not lose it. When several reviewers work in parallel, give them one brief with the reader personas, the file assignment and a fixed set of finding categories.

## Checks before delivery

Add these checks to the review stage and final gate for library documentation, and fix what fails:

- Every intended member and field appears once, on one page, in the merged rendered reference, and no table scrolls sideways at phone width. When the site could not be built, the reply says what to build and check.
- No user page uses a word from the internal-word list without a definition, and no printed value was edited as text.
- Each statement of a bound or an error matches its source in relative or absolute, order and assumptions.
- Extension-point examples keep the checks the framework leaves to the author.
- A review lists what works under Keep.
- After content moved or was renamed, the checks in [moving documentation content](moving-docs-content.md) pass.
- Edited notebooks were re-executed as `library-example-notebooks` describes.
