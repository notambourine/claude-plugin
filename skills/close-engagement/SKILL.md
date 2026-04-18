---
name: close-engagement
description: Run the engagement-close checklist — flip stage and outcome, archive Drive deliverables, write post-mortem decision sub-file, append cross-deal coaching lesson if applicable, close any open tasks.
---

# /nt:close-engagement

End-of-engagement runbook. Run after the final handoff, not when verbal "we're done" first hits.

## Prerequisites

- All scope completed or re-scoped with client acknowledgement.
- Final deliverables (PDFs, dashboards, docs) sitting in `$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/<slug>/`.
- No open `mdql org task` items without resolution.

## Checklist

1. **Close open tasks.**
   ```bash
   mdql org task list <slug> -f tsv --fields opened,status,title \
     | tail -n +2 | awk -F'\t' '$2=="open" || $2=="doing"'
   ```
   For each: close with `mdql org task update <slug> <task-slug> --status done` or `--status cancelled` with a reason in the body.

2. **Flip stage and outcome.**
   ```bash
   mdql org update <slug> --stage closed --outcome <won|lost|paused>
   ```
   `won` — engagement delivered, client satisfied, follow-on likely.
   `lost` — engagement ended before delivery (client pulled, we walked).
   `paused` — on hold, may resume.

3. **Write a post-mortem decision sub-file.**
   ```bash
   mdql org decision add <slug> --date $(date +%F) \
     --title "Engagement close-out: what we'd do again, what we wouldn't" \
     --body-file -
   ```
   Body: pricing held or didn't, scope creep source, what made handoff smooth or painful, relationship pattern to remember.

4. **Coaching entry (if a cross-deal lesson emerged).** Append to `kb/playbook/sales/coaching.md` sourced to this deal. Strengths get `S*` prefix, antipatterns get `A*`. Template shape is in the playbook file itself.

5. **Archive the Drive folder.** Move `$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/<slug>/` → `$NOTAMBOURINE_DRIVE_ROOT/My Drive/_archive/orgs/<slug>/`. Keep kb `orgs/<slug>/` in place; it's the permanent record.

6. **Update `index.md` body.** Rewrite the executive summary paragraph as past tense. Keep `people[]` and `aliases[]` — they're still useful for follow-on work if `outcome: won`.

7. **If engagement repo exists**, commit a final `ENGAGEMENT-CLOSED.md` note at its root linking back to `kb/orgs/<slug>/decisions/<date>-engagement-close-out.md`, then archive the repo (GH repo settings → Archive).

## Do not

- Delete the Drive folder or kb org. History is queryable; queries assume it stays there.
- Skip the post-mortem decision even on `lost` — especially on `lost`. That's where coaching.md earns its keep.
