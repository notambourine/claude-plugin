---
name: client-status
description: One-shot dashboard for a single client — stage, people, open tasks, live proposal, three most recent touchpoints. Reads mdql; returns a JSON summary. Use before any client call, any proposal conversation, or when orienting on an engagement.
---

# /nt:client-status

Step 1 of every client question: `mdql org show <slug> --format json`. Returns the entity plus every sub-file as one graph. Filter with `jq` from there — don't walk the filesystem.

## Core recipe

```bash
mdql org show <slug> --format json | jq '{
  stage,
  outcome,
  people,
  open_tasks:    [.tasks[]?     | select(.status=="open" or .status=="doing")],
  live_proposal: [.proposals[]? | select(.status=="draft" or .status=="sent")],
  recent: (.touchpoints // [] | sort_by(.date) | reverse | .[0:3]
           | map({date, channel, subject}))
}'
```

## Common follow-ups

Flat list of all proposals, TSV:

```bash
mdql org proposal list <slug> -f tsv --fields date,title,status
```

Flat list of open tasks, TSV:

```bash
mdql org task list <slug> -f tsv --fields opened,priority,status,assignee,title
```

Recent touchpoints by channel:

```bash
mdql org touchpoint list <slug> -f tsv --fields date,channel,subject \
  | tail -n +2 | awk -F'\t' '$2=="meeting"'
```

Who references this client:

```bash
mdql wiki backlinks <slug>
```

## Cross-client recipes

Roster at a glance:

```bash
mdql org list -f csv
```

All signed proposals this quarter:

```bash
for s in $(mdql org list -q); do
  mdql org proposal list $s -f tsv --fields date,status,title 2>/dev/null \
    | tail -n +2 | awk -v s=$s -F'\t' '$2=="signed"{print s"\t"$0}'
done
```

## Interpretation

- `stage: introduced` with no recent touchpoint → stale lead, consider `/nt:followup`.
- `stage: proposing` with a `sent` proposal > 14 days old → chase.
- `stage: signing` with no `signed` proposal → contract held up; check decisions/.
- `stage: active` with zero open tasks → delivery gap; check what's next.
- `stage: closed` without `outcome` → data hygiene issue, flip with `/nt:stage-flip`.
