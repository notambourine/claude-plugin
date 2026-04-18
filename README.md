# notambourine/claude-plugin

Claude Code plugin for running a consulting practice on top of a markdown-first
knowledge base ([mdql](https://github.com/notambourine/mdql)) and a marp + pandoc
build pipeline.

**Install**

```bash
claude plugin marketplace add notambourine/claude-plugin
claude plugin install nt@notambourine --scope user
```

Slash commands become `/nt:<name>`.

## What's in here

- **Skills** — slash commands for ingesting touchpoints, shipping deliverables, checking brand hygiene, and scaffolding new clients.
- **Hooks** — schema + brand hygiene enforced automatically (wordmark lint, no-history-in-index, stage-redirect, build-redirect, pdf-force-add guard, mdql dangling check).
- **Subagents** — `kb-librarian` (ingest specialist), `brand-pedant` (wordmark + voice audit), `deal-coach` (next-action suggestions from client context).

## What's not in here

Proposal templates, pricing, sales coaching, positioning, client data — that's all private. This plugin is infrastructure; skills that depend on private content (`/nt:new-proposal`, `/nt:write`, `/nt:client-intake`) graceful-fail with a "mount the team vault at `kb/`" message when it's missing.

**The infrastructure isn't the moat. The content is.**

A peer consulting shop can install this plugin, point skills at their own `playbook/` directory with the same shape, and get 80% of the team-operator experience without seeing a line of our playbook.

## Every-session orientation

This plugin does **not** auto-inject a CLAUDE.md. Run `/nt:orientation` at the start of an ambiguous session to get the brand rules, workspace boundary, persistence hierarchy, and Drive mirror convention in one shot.

Permanent reference (for humans browsing the repo):

- **Brand.** `NoTambourine` = wordmark (human-facing). `notambourine` = slug (only where tooling demands lowercase). `NoTambourine LLC` = legal form (contract sig blocks + one Definitions anchor).
- **Workspace boundary.** Default to `kb/` (team-shared vault). `ops/` is superadmin (Tom-only). `site/` is the marketing site. `client-{slug}/` is delivery work.
- **Persistence hierarchy.** GitHub Issues for cross-repo operational work. `mdql org task` sub-files for client-scoped delivery work. CLAUDE.md for knowledge not recoverable from code. `// KEY-DECISION <date>: <why>` comments at point of use.
- **Ingest sources.** granola MCP (meetings), gmail connector (email), calendar connector (events). Paste permalinks into `--source`. Never paraphrase from memory.
- **Drive mirror.** Client-facing PDFs land at `$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/{slug}/{subproject}/`. Set that env var in your shell.

## Activation scope

Hooks gate by checking the git remote of the current repo — they fire only when the remote matches `notambourine/*` or a `.notambourine` marker file exists at the repo root. Safe to global-install.

## Extending

Fork the skill prompts or add new ones under `skills/<name>/SKILL.md`. Each skill is a single markdown file with YAML frontmatter and a body. To change an enforced rule, edit the script under `scripts/` — the hook reference in `hooks/hooks.json` stays the same.

## License

MIT. See [LICENSE](./LICENSE).
