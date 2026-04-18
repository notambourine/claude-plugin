---
name: ship
description: Build a slide deck or long-form doc to PDF and deliver it to the client Drive mirror. Handles .marp.md (slides) and .md (docs). Runs the appropriate npm script, renames to the client-facing filename convention, copies to Drive.
---

# /nt:ship

One command from source to client-delivered PDF.

## Slides

Source: `kb/orgs/{slug}/slides/{YYYY-MM-DD}-{descriptor}.marp.md`

Build:

```bash
cd kb && npm run slides:build -- orgs/{slug}/slides/{YYYY-MM-DD}-{descriptor}.marp.md
```

PDF lands next to the source. Theme is `playbook/brand/notambourine.css`. Do not fork per client.

**Before editing or shipping any slide, read `kb/playbook/templates/slides/README.md`.** It owns the filename convention, client-facing rename rules, theme helper classes, voice rules, and density limits.

## Docs

Source: `kb/orgs/{slug}/{YYYY-qN}-{descriptor}.md`

Build:

```bash
cd kb && npm run docs:build -- orgs/{slug}/{YYYY-qN}-{descriptor}.md
```

Renders via pandoc + tectonic against `playbook/brand/notambourine-print.tex` and `playbook/brand/logo.pdf`.

**Before editing or shipping any long-form doc (SOW, proposal, contract, audit, exec summary, handoff), read `kb/playbook/templates/docs/README.md`.** It owns document voice, frontmatter contract, and cross-references to the slides README for filename and Drive delivery.

## Drive mirror (both flows)

After build:

1. Copy the PDF to `$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/{slug}/{subproject}/`.
2. Rename to the client-facing filename format defined in the slides README (not the repo-internal name).

Folder structure mirrors `kb/orgs/{slug}/` one level deep. Drive is where client-facing artifacts live. kb is the source of truth for `.marp.md` / `.md` inputs.

## Do not

- Call `marp`, `pandoc`, or `tectonic` directly. Use the npm scripts — they wire in the theme and preamble. (The `build-redirect` hook will nudge you.)
- Fork the theme per client. Client logos and inline callouts are allowed; color/typography forks are not.
- Commit the PDF unless it's a signed/executed source-of-truth artifact. `orgs/**/*.pdf` is gitignored by default.
- Use the repo-internal filename in the Drive copy. Rename on the way out.

## System installs (one-time per machine)

```bash
brew install pandoc tectonic
brew install --cask font-literata font-source-code-pro
# Only if regenerating logo.pdf from logo.svg:
brew install librsvg
```
