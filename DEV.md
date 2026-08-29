# Developing locally

## Prerequisites

1. **Quarto CLI**. Install from [quarto.org](https://quarto.org/docs/get-started/); the step-one CLI download is enough. Check with `quarto --version`.
2. **A TeX distribution** (MacTeX on macOS, TeX Live elsewhere). The tikz figures in the notes compile through the `imagify` filter, which shells out to `latex` and `dvisvgm`. Both must be on your PATH.

The published site is built on the web server, not in CI: the GitHub workflow only POSTs to a webhook that runs `git pull && quarto render` on the host, so the host's Quarto is what ships. Your local version can be newer, and a few constructs parse differently between versions, so a page can render correctly for you and still break on the site. To see which version the server is running:

```sh
curl -s https://introml.mit.edu/notes/ | grep -o 'quarto-[0-9.]*' | head -1
```

For anything beyond ordinary markdown and math, check the live page after it deploys, and follow the raw HTML rule below.

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
- `NOTATION.md` is the course-wide notation and style guide. Follow it for any math edits; the rules most often violated are word subscripts in `\text{}` (`\mathcal{D}_{\text{train}}`, not `\mathcal{D}_{train}`), upright `\mathrm{R}, \mathrm{T}, \mathrm{V}, \mathrm{Q}` for MDP functions, and `\lVert \cdot \rVert` for norms (never raw `||`).
- `figures/` holds chapter images and embedded widgets; `_extensions/` the Quarto filters (`pseudocode`, `imagify`).
- `assets/` holds the site chrome: `style.css`, `ga.html`, `pre-title.html`, and `logo/`, wired up in `_quarto.yml` and `index.qmd`.

## Conventions that will bite you

- Pseudocode blocks take a `#| label:` cell option so algorithms number correctly, but the label must not start with `alg-`. That prefix collides with the custom `alg` crossref type in `_quarto.yml` and crashes the render. Plain names like `Q-Learning` work.
- Margin notes use `::: {.column-margin}`. Other class names render as unstyled divs.
- Avoid referring to pseudocode line numbers in prose. The HTML and PDF renderers number `\Procedure` lines differently, so refer to steps by content.
- Put raw HTML (interactive widgets, hand-written SVG) inside a ```` ```{=html} ```` block. Pandoc parses the contents of an HTML block as markdown, so markup indented four spaces inside a `<div>` becomes a code block and renders as visible source rather than as elements. Whether that happens depends on the Quarto version, so a plain HTML block can look fine locally and break on the server. A raw block passes the markup through verbatim; `figures/cnn_2d_conv_anim.html` is written this way.

## Deploying

Merging to `main` triggers a webhook that rebuilds and publishes the live site at [introml.mit.edu/notes](https://introml.mit.edu/notes/). No manual deploy step.
