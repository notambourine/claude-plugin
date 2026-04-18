---
name: orientation
description: Output the NoTambourine every-session operating context — brand rules, workspace boundary, persistence hierarchy, MCP sources, Drive mirror convention. Invoke at the start of an ambiguous session or when onboarding a new teammate.
---

# NoTambourine orientation

## Brand

- `NoTambourine` = wordmark. Use in all human-facing copy: PDFs, decks, emails, client-facing docs, commit messages that narrate to humans.
- `notambourine` = slug. Use only where tooling demands lowercase: GH org, domains, paths, CSS classes, npm packages.
- `NoTambourine LLC` = legal form. Appears only where legally load-bearing — contract signature blocks and one Definitions anchor.

The forms are not interchangeable. Brand-vs-slug split like `iPhone`/`iphone`.

## Workspace boundary

- **`kb/`** — team-shared Obsidian vault. Default here. Client deals, pricing, proposals, coaching, post-mortems, templates.
- **`ops/`** — Tom-only superadmin. Owner comp, tax, banking, benefits design, vendor agreements. Employees do not work here.
- **`site/`** — marketing site (Cloudflare Workers). Public.
- **`client-{slug}/`** — delivery work for a specific engagement. Separate git repo. Source of truth about the client lives in `kb/orgs/{slug}/`, not here.

## Persistence hierarchy

- **Cross-repo operational work** → GitHub Issues. `gh search issues --owner notambourine --state open`.
- **Client-scoped delivery work** → `mdql org task` sub-files. Queryable alongside touchpoints and proposals.
- **Knowledge not recoverable from code** → CLAUDE.md.
- **Rationale at point of use** → `// KEY-DECISION <date>: <why>` comments.

## Ingest sources

- **Meetings** → granola MCP. Transcripts, attendees, titles.
- **Email** → gmail (claude.ai connector).
- **Calendar** → calendar (claude.ai connector).

Paste permalinks into `--source`. Never paraphrase from memory.

## mdql ingest pattern

Every `add` command takes `--body-file -` so long content is stdin-piped and bleve-indexed:

```bash
pbpaste | mdql org touchpoint add <slug> --date YYYY-MM-DD --channel email \
  --subject "..." --source "<permalink>" --body-file -
```

## Drive mirror

Client-facing PDFs land at:

```
$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/{slug}/{subproject}/
```

Set `NOTAMBOURINE_DRIVE_ROOT` in your shell (typically `~/Library/CloudStorage/GoogleDrive-<your-email>`).

## Private-vault content

Proposal templates, pricing, coaching, positioning, voice rules live in `kb/playbook/`. Skills that require them (`/nt:new-proposal`, `/nt:write`, `/nt:client-intake`) graceful-fail if the vault isn't mounted.

## Subtree pointers (read on-demand)

- In `kb/`? Also read `kb/CLAUDE.md` + `kb/AGENTS.md`.
- Slide work? Read `kb/playbook/templates/slides/README.md`.
- Doc work? Read `kb/playbook/templates/docs/README.md`.
- In `ops/`? Read `ops/AGENTS.md`. If you're not Tom, you shouldn't be here.
