---
name: new-proposal
description: Scaffold a new proposal sub-file for a client from the team's proposal template. Reads `kb/playbook/templates/proposal.md` at runtime — graceful-fails if the team vault is not mounted.
---

# /nt:new-proposal

Scaffold `kb/orgs/{slug}/proposals/{YYYY-MM-DD}-{title-slug}.md` from the team template.

## Prerequisite — private vault

This skill requires `kb/playbook/templates/proposal.md`. If that path does not exist:

> **Missing:** `kb/playbook/templates/proposal.md`
>
> This skill scaffolds from a private template. If you're on the NoTambourine team, clone the `kb/` vault into the workspace and retry. If you're exploring the plugin, this template isn't open — it carries pricing guardrails and framing language that stay internal.
>
> Skills that work without the vault: `/nt:client-status`, `/nt:ship`, `/nt:brand-check`, `/nt:stage-flip`, `/nt:ingest` (for mechanics; you still need a vault to write into).

Stop with that message. Do not fabricate a template.

## Steps

1. Run `mdql org proposal add <slug> --date $(date +%F) --title "<title>" --status draft` to register the proposal. This creates the sub-file with frontmatter.
2. Copy the body of `kb/playbook/templates/proposal.md` into the new sub-file, after the frontmatter separator.
3. Strip the template's internal comments (marked in the template itself — follow the template's instructions, do not improvise).
4. Fill in: executive summary, phases, pricing, assumptions, signature block.
5. Wordmark check: brand form `NoTambourine` throughout body; `NoTambourine LLC` only in the signature block and one Definitions anchor. Run `/nt:brand-check` on the file before sending.
6. Build the PDF with `/nt:ship`.
7. When sent: `mdql org proposal update <slug> <date-title-slug> --status sent`. Stage flip: `/nt:stage-flip <slug> signing`.

## After signing

```bash
mdql org proposal update <slug> <date-title-slug> --status signed
```

Then `/nt:stage-flip <slug> active`.

## Pricing and deal framing

Pricing guardrails live in the template and in `kb/playbook/sales/coaching.md`. Read both before filling in rates. Do not quote from memory.
