---
name: weekly-recap
description: Cross-client touchpoint roll-up for the past week — groups events by client and channel, highlights stage flips and new proposals, produces a markdown summary ready to paste into a standup note or status update.
---

# /nt:weekly-recap

Pulls the past 7 days of activity across all orgs into one readable summary.

## Collect

```bash
WEEK_START=$(date -v-7d +%F)  # macOS; on Linux: $(date -d '7 days ago' +%F)

for s in $(mdql org list -q); do
  mdql org touchpoint list $s -f tsv --fields date,channel,subject 2>/dev/null \
    | tail -n +2 | awk -v s=$s -v ws=$WEEK_START -F'\t' \
      '$1 >= ws {print s"\t"$0}'
done | sort -k2
```

Parallel scans:

```bash
# Proposals sent or signed this week
for s in $(mdql org list -q); do
  mdql org proposal list $s -f tsv --fields date,title,status 2>/dev/null \
    | tail -n +2 | awk -v s=$s -v ws=$WEEK_START -F'\t' \
      '$1 >= ws && ($3=="sent" || $3=="signed") {print s"\t"$0}'
done

# Decisions recorded this week
for s in $(mdql org list -q); do
  mdql org decision list $s -f tsv --fields date,title 2>/dev/null \
    | tail -n +2 | awk -v s=$s -v ws=$WEEK_START -F'\t' \
      '$1 >= ws {print s"\t"$0}'
done
```

## Summary shape

Produce a markdown block like:

```markdown
# Week of YYYY-MM-DD

## Touchpoints by client
- **sportsattack** — 3 meetings, 1 email. Topics: Q2 planning, Shopify migration kickoff.
- **acme** — 1 email sent, no reply. Proposal age: 15 days.

## Proposals
- **widgetco** — proposal sent 2026-04-14 ("Audit & Roadmap"). Status: sent.
- **acme** — proposal signed 2026-04-16 ("Quarterly Advisory"). Stage: active.

## Decisions
- **sportsattack** — "Pricing held at Q1 rate for Q2" (2026-04-15).

## Stage changes
- widgetco: proposing → signing
- acme: signing → active
```

## Who's this for

- Your own weekly review / what-did-we-ship ritual.
- Pasted into a team standup doc.
- Raw material for a NoTambourine partner update if you have one.

## Do not

- Paste client-confidential content into a public channel. The recap is a **shape** summary (counts, topics, names), not a content dump.
