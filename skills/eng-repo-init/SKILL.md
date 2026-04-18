---
name: eng-repo-init
description: Scaffold a new engagement repo at `client-{slug}/` — git init, initial CLAUDE.md that back-references the kb org entity, conventional directory layout for delivery work.
---

# /nt:eng-repo-init

Spin up a new delivery repo for a non-trivial engagement. Sister folder to `kb/`, `ops/`, `site/`.

## When to use

- Engagement is multi-week with multiple workstreams.
- Delivery includes code, scripts, config, data transformations, or anything version-controlled beyond markdown.
- Multiple people on the NoTambourine side will contribute.

## When NOT to use

- One-off advisory. Work in kb sub-files (`decision`, `task`, `touchpoint`).
- Short engagement (< 2 weeks) with only doc/slide deliverables. `kb/orgs/<slug>/slides/` and `kb/orgs/<slug>/*.md` are enough.

## Scaffold

```bash
SLUG=<slug>
PARENT=$(dirname "$PWD")  # should be ~/sandbox/git-repos/notambourine
cd "$PARENT"
mkdir -p "client-$SLUG"
cd "client-$SLUG"
git init
```

## Initial `CLAUDE.md`

Write `client-<slug>/CLAUDE.md` that back-references kb:

```markdown
# client-<slug>

Delivery repo for the <Brand Name> engagement.

**Source of truth about this client** lives in the NoTambourine kb vault:
`../kb/orgs/<slug>/index.md`.

- Stage, people, aliases, domain → `../kb/orgs/<slug>/index.md`
- Touchpoints → `../kb/orgs/<slug>/touchpoints/`
- Proposals and SOWs → `../kb/orgs/<slug>/proposals/`
- Decisions and post-mortems → `../kb/orgs/<slug>/decisions/`
- Delivery tasks → `../kb/orgs/<slug>/tasks/`
- Slides and docs → `../kb/orgs/<slug>/slides/` and `../kb/orgs/<slug>/*.md`

**This repo** contains code, scripts, config, and delivery artifacts that
don't belong in kb. Do not duplicate kb content here.

**Drive mirror:** client-facing PDFs from this engagement still land at
`$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/<slug>/`.

For NoTambourine workspace context (brand, boundary, persistence hierarchy),
run `/nt:orientation`.
```

## Conventional directory layout

```
client-<slug>/
  CLAUDE.md
  README.md          # client-visible if the repo gets shared
  .gitignore
  scripts/           # one-off data pulls, migrations
  src/               # code
  config/            # env-shaped configs
  data/              # gitignored data dumps
  reports/           # markdown analyses that become PDFs via pandoc
```

Adapt to the engagement — not every folder is needed. A Shopify migration looks different from a content audit.

## GH repo

```bash
gh repo create "notambourine/client-$SLUG" --private --source . --remote origin
git add CLAUDE.md README.md .gitignore
git commit -m "init: scaffold client-$SLUG engagement repo"
git push -u origin main
```

## After

- Update `kb/orgs/<slug>/index.md` body to note the engagement repo exists.
- Add the repo URL to the client's `index.md` (or as a `reference` in a new decision sub-file).
