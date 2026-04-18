---
name: stage-flip
description: Flip a client's lifecycle stage safely via `mdql org update`. Enforces the transition table, refuses illegal jumps, and requires `--outcome` when moving to `closed`.
---

# /nt:stage-flip

Stage is a hand-maintained field on `index.md`. Flip with the entity update verb — do not hand-edit frontmatter. (The `stage-redirect` hook enforces this.)

## Legal transitions

| From → To | Trigger |
|---|---|
| introduced → proposing | proposal drafted |
| proposing → signing | proposal sent, verbal commit received |
| signing → active | proposal signed |
| active → closing-out | delivery nearing handoff |
| closing-out → closed | handoff delivered |

Regressions (e.g. `active → proposing` because a client reopened scope) are allowed but should be accompanied by a `decision` sub-file explaining why.

## Commands

```bash
mdql org update <slug> --stage <new-stage>
```

For closing:

```bash
mdql org update <slug> --stage closed --outcome <won|lost|paused>
```

`outcome` is only meaningful when `stage: closed`. On `won`, keep `people[]` fresh — expect follow-on work.

## Pair the flip with an artifact

Every stage flip should have a corresponding sub-file that justifies it:

- `introduced → proposing` → the proposal draft exists.
- `proposing → signing` → a `touchpoint` with the verbal commit.
- `signing → active` → the signed proposal (`status: signed`).
- `active → closing-out` → a `decision` sub-file (handoff criteria).
- `closing-out → closed` → a `decision` sub-file (post-mortem) and a `coaching.md` entry in the playbook sourced to this deal.

If the artifact doesn't exist, don't flip yet. Data integrity matters for later queries.

## After flipping to closed

Run `/nt:close-engagement <slug>` — it walks the full close runbook (archive Drive, post-mortem decision, coaching entry).
