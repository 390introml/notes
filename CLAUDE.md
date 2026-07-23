# 6.390 course notes (Quarto book)

- Dev setup, commands, and layout: see `DEV.md`. Renders need TeX; if `latex: command not found`, run `export PATH="/Library/TeX/texbin:$PATH"` first.
- Math notation rules live in `NOTATION.md`; follow them in any edit (word subscripts in `\text{}`, upright MDP letters, `\lVert \rVert` norms).
- Pseudocode `#| label:` values must not start with `alg-`; that prefix crashes Quarto's crossref filter. Use plain names (`Q-Learning`).
- Margin notes are `::: {.column-margin}`; do not invent other class names.
- Run a full `quarto render` and check for errors before opening a PR. Merging to `main` auto-deploys the live site.
