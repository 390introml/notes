# How to give this a spin?

Preview your changes locally (see below). When you're happy, push to `main`. This will update the live site at https://introml.mit.edu/notes/



# How to dev locally?

We need two things.

1. The engine [`quarto`](https://quarto.org/docs/get-started/). We just need that page's step-one `CLI` download. It should be a simple `curl` or `wget` command on the terminal. Or on MacOS, just a download and one-click installation. If the installation goes right, the executable `quarto` should be callable from the terminal.

2. Clone this repo. In the terminal, `cd` into the root of this repo. Run `quarto preview`. If all goes well, a `localhost:8888` link will pop up, and a browser tab will open. That tab will be "live": i.e. it'd be updated as we make local changes. 

In terms of content, book chapter source files are those `*.qmd` files. The `qmd` syntax is almost identical to `markdown` (which itself is pretty close to LaTeX). The `qmd` files are converted to `html` by `quarto` and then served on the website. 
