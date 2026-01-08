# ICIIS Workshop — RTL2GDS Guidebook (LaTeX project)

This repository contains a LaTeX scaffold for the ICIIS workshop guidebook. It includes chapter templates for the five demonstrations and supporting material. Fill each chapter's placeholder sections with the workshop content and step-by-step instructions.

## Quick start

Recommended: install a TeX distribution (TeX Live / MiKTeX) and `latexmk`.

To build the PDF (from project root `latex-guide/`):

```bash
cd latex-guide
make      # uses latexmk -pdf
```

Or run directly:

```bash
latexmk -pdf main.tex
```

If compilation fails, install missing packages listed in `main.tex` preamble (geometry, hyperref, graphicx, listings, xcolor, caption, subcaption, booktabs, amsmath, etc.).

## Project structure

- `main.tex` — master document
- `chapters/` — chapter files (placeholders to edit)
- `images/` — figures and screenshots (add IO-package final image here)
- `bibliography/` — .bib file(s) if needed
- `Makefile` — build helper
- `.gitignore` — ignore LaTeX aux files

## Notes

- Chapters contain an "Installation" subsection intended for step-by-step commands and prerequisites.
- For the final IO package product: try to use open tools (OpenROAD, QFlow, Yosys, NextPNR, OpenLane) first. If not feasible, Synopsys tools can be used for final packaging as requested — document any tool-specific steps in the Appendix.

---

Edit chapter files under `chapters/` to add content. When ready, build and review `main.pdf`.
