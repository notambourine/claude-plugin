---
name: system
description:
  Build or review NoTambourine-branded surfaces, decks, and copy. Use for brand
  styling, color questions, positioning, and copy audits before shipping.
---

# NoTambourine brand

Apply the brand without padding. Keep the design restrained and the work
concrete.

## Read only what the task needs

- For visual design or styling, read [visual rules](references/visual.md),
  including locked-surface font and logo traps.
- For writing or auditing anything clients or the public see, read
  [voice and copy audit](references/voice.md). Lead with its core framing and
  use its supporting headline for existing systems.
- For slide authoring or export, read [deck guidance](references/decks.md). Load
  visual or voice guidance only when designing slides or writing/reviewing their
  copy.
- For a color, type, spacing, or component value, inspect the relevant CSS
  directly. Do not load prose references for a value lookup.
- For installation, asset selection, logo regeneration, or consumer integration,
  read the relevant section of [README.md](README.md).

## Source of truth

Treat `notambourine/brand-kit` as canonical. Read values from its CSS and
artwork from its assets. Correct brand values here, never by syncing a
downstream copy back in. Update consumer pins after a correction; a consumer's
limited theme support does not narrow the brand system.

Use semantic CSS aliases. Reach for primitives only when no alias fits or the
consumer integration requires it; consult README for framework exceptions. Never
hardcode colors outside renderer `var()` fallbacks.

Fetch fuller doctrine only when needed: `http://notambourine.com/llms.txt`
indexes the public documents; `AGENTS.md` covers positioning and citation rules,
`SOUL.md` beliefs, and `CULTURE.md` working practices. Use the local voice
reference for current messaging. Do not infer internal policy from omissions in
the public cuts. Keep client material unpublished; `/reports/` and `/pog/` are
disallowed to agents.
