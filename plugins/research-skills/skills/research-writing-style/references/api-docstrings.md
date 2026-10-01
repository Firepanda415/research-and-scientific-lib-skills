# API docstrings

Read for docstrings that render a scientific library's API reference. These rules stand alone and need no review stage beyond the check at the end. For the guide pages and the rendered reference as a whole, read [library documentation](library-docs.md).

- Follow the project's docstring convention, such as NumPy or Google style, in the NumPy section order: a one-line summary that says what the object does or returns without starting from variable names, what it is for, each parameter with its meaning, units and accepted format, the return value, the errors raised and when, an example for each user-facing object, and a link to its guide page. When the documentation generator cannot show a field's default, write the default into the docstring.
- Write for the scientist who calls the object. Replace words from the code's design, such as owner, ledger or admission, with the reader's words or the object's name, and define a term the reader needs once. Public API names stay as code.
- Copy statements of bounds and errors from their source without changing what they bound: relative or absolute, the order, the assumptions, and whether they cover the whole result or one component.
- Docstrings can flow into generated schemas, command-line help and error output. Prove a docstring-only change by comparing the syntax trees with docstrings removed, and name the other outputs the change reaches.

Before delivery, check each changed user-facing docstring for its summary, parameters, return value, errors and example, and check that no bound changed its meaning.
