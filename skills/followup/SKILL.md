---
name: followup
description: Scan all active clients for stale touchpoints — surfaces a nudge list of engagements where the last inbound/outbound event is old enough to warrant a check-in, weighted by stage.
---

# /nt:followup

Surface clients that need a touch. Heuristic: how stale the last touchpoint is, relative to what the stage expects.

## Staleness thresholds by stage

| Stage | Threshold | Rationale |
|---|---|---|
| introduced | 7 days | Leads go cold fast. |
| proposing | 10 days | Proposal in flight; silence = risk. |
| signing | 5 days | Contract held up. Follow up firmly. |
| active | 14 days | Delivery cadence varies. Check in bi-weekly min. |
| closing-out | 7 days | Handoff should wrap quickly. |
| closed (won) | 90 days | Dormant; nurture for follow-on. |
| closed (lost/paused) | — | Do not auto-surface. |

## Scan

```bash
for s in $(mdql org list -q); do
  stage=$(mdql org show $s --format json | jq -r '.stage // "unknown"')
  last=$(mdql org touchpoint list $s -f tsv --fields date 2>/dev/null \
         | tail -n +2 | sort -r | head -1)
  [ -z "$last" ] && last="never"
  echo -e "$s\t$stage\t$last"
done | column -t
```

Filter by stage and sort by staleness in jq/awk as needed.

## Output format

```
slug              stage       last-touchpoint   days-stale   suggested-action
sportsattack      active      2026-04-11        7            on cadence
acme              proposing   2026-04-03        15           chase — proposal aging
widgetco          signing     2026-04-13        5            contract check-in
```

## After surfacing

For each stale client, either:

- Send a check-in (then `/nt:ingest` the outbound so the staleness resets).
- Note in a `decision` sub-file why you're *not* chasing (client asked for space, deal paused informally).
- Flip stage if the reality is different from the vault (`/nt:stage-flip`).

## Do not

- Surface the same client twice in one week without acting. If a nudge is ignored for 3 scans, the client needs a real decision, not another nudge.
