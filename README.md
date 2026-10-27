# How to run

Requires [Typst](https://typst.app/) >= 0.13.

```bash
make pdf
```

or:

```bash
typst compile main.typ main.pdf
```

To rebuild on changes:

```bash
make watch
```

If fonts are in a local `fonts/` directory:

```bash
typst compile --font-path fonts main.typ
```
