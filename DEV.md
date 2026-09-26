# Developing locally

## Prerequisites

1. **Quarto CLI**, matching the version the server builds with (1.6.39). Check yours with `quarto --version`. Download that version directly rather than taking the latest from [quarto.org](https://quarto.org/docs/get-started/):

   | Platform | Download |
   |---|---|
   | macOS installer | [quarto-1.6.39-macos.pkg](https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-macos.pkg) |
   | macOS tarball | [quarto-1.6.39-macos.tar.gz](https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-macos.tar.gz) |
   | Linux x86-64 | [.deb](https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-linux-amd64.deb) or [.tar.gz](https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-linux-amd64.tar.gz) |
   | Linux arm64 | [.deb](https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-linux-arm64.deb) or [.tar.gz](https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-linux-arm64.tar.gz) |

   The tarballs need no installer and no admin rights: unpack one anywhere and run its `bin/quarto`, which is handy for keeping this version alongside a newer Quarto you use for other projects.
2. **A TeX distribution** (MacTeX on macOS, TeX Live elsewhere). The tikz figures in the notes compile through the `imagify` filter, which shells out to `latex` and `dvisvgm`. Both must be on your PATH.
2. **A TeX distribution** (MacTeX on macOS, TeX Live elsewhere). The tikz figures in the notes compile through the `imagify` filter, which shells out to `latex` and `dvisvgm`. Both must be on your PATH.

The published site is built on the web server, not in CI: the GitHub workflow only POSTs to a webhook that runs `git pull && quarto render` on the host, so the host's Quarto is what ships. A newer local version parses a few constructs differently, so a page can render correctly for you and still break on the site, which is why the table above pins a version. To confirm what the server is running:

```sh
curl -s https://introml.mit.edu/notes/ | grep -o 'quarto-[0-9.]*' | head -1
```

For anything beyond ordinary markdown and math, check the live page after it deploys, and follow the raw HTML rule below.

**The server's Quarto stays where it is.** Quarto 1.10 ships MathJax 4, and the `pseudocode` extension's `pseudocode.js` recognizes only the MathJax 3 global. Under 1.10 it throws `Uncaught EvalError: No math backend found. Please setup KaTeX or MathJax.` and every algorithm block silently disappears: the container is still in the page, but nothing renders inside it, while the surrounding prose goes on referring to the algorithm. Upgrading the extension to its current release does not help. Everything else in the book renders the same on 1.10 (content is identical; only vertical spacing shifts slightly), so the algorithms are the sole blocker. Before moving the server to 1.10 or later, confirm the algorithm blocks render.

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
