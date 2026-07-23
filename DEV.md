# Developing locally

## Prerequisites

1. **Quarto CLI**. Install from [quarto.org](https://quarto.org/docs/get-started/); the step-one CLI download is enough. Check with `quarto --version`.
2. **A TeX distribution** (MacTeX on macOS, TeX Live elsewhere). The tikz figures in the notes compile through the `imagify` filter, which shells out to `latex` and `dvisvgm`. Both must be on your PATH.

If a render fails with `sh: latex: command not found`, TeX is installed but not on the PATH of the shell running Quarto. On macOS:

```sh
export PATH="/Library/TeX/texbin:$PATH"
```

## Preview and render

```sh
quarto preview   # live-reload server at localhost:8888
quarto render    # full build into _book/
```

Run a full `quarto render` before opening a PR; some errors (crossref problems, LaTeX failures in tikz blocks) only show up on a full build.

## Repo layout

- Chapter sources are the root `*.qmd` files, in the order listed under `chapters:` in `_quarto.yml`. Appendices are listed under `appendices:`.
- `NOTATION.md` is the course-wide notation and style guide. Follow it for any math edits.
- `figures/` holds chapter images; `logo/` the site assets; `_extensions/` the Quarto filters (`pseudocode`, `imagify`).
- `style.css`, `ga.html`, and `pre-title.html` are site chrome wired up in `_quarto.yml` and `index.qmd`.

## Conventions that will bite you

- Pseudocode blocks take a `#| label:` cell option so algorithms number correctly, but the label must not start with `alg-`. That prefix collides with the custom `alg` crossref type in `_quarto.yml` and crashes the render. Plain names like `Q-Learning` work.
- Margin notes use `::: {.column-margin}`. Other class names render as unstyled divs.
- Avoid referring to pseudocode line numbers in prose. The HTML and PDF renderers number `\Procedure` lines differently, so refer to steps by content.

## Deploying

Merging to `main` triggers a webhook that rebuilds and publishes the live site at [introml.mit.edu/notes](https://introml.mit.edu/notes/). No manual deploy step.
