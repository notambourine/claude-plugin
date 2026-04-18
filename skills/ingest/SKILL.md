---
name: ingest
description: Ingest an inbound signal (email, Slack thread, meeting, call, DM) into the mdql knowledge base as a typed touchpoint sub-file under the right client org. Takes pasted content via stdin. Resolves unknown names via alias lookup before classifying.
---

# /nt:ingest

Turn an inbound event into one typed sub-file. One command per event.

## Before ingesting

1. **Query the source.** Meetings → granola MCP. Email → gmail connector. Calendar → calendar connector. Get the permalink.
2. **Resolve the counterparty to a client slug.** Grep `people[]` and `aliases[]` in org index files:

   ```bash
   grep -l "David Glazer" kb/orgs/*/index.md
   ```

   If no match, either (a) `mdql org add <slug> ...` for a new client, or (b) append the name to an existing `people[]` or `aliases[]`.

3. **Pick the channel.** `email | slack | meeting | call | dm | doc`.

## Ingest command

Stdin pattern. Body is bleve-indexed — long content goes in body, not frontmatter.

```bash
pbpaste | mdql org touchpoint add <slug> \
  --date YYYY-MM-DD \
  --channel email \
  --from "sender@example.com" \
  --to "recipient@example.com" \
  --subject "Thread subject" \
  --source "<gmail-permalink>" \
  --body-file -
```

Field mapping per channel:

| Channel | Required flags |
|---|---|
| email | `--from --to --source <gmail-permalink>` |
| slack | `--from --source <slack-permalink>` |
| meeting | `--attendees --outcome --source <granola-url>` |
| call | `--attendees --outcome` |

## After ingesting

- If this signal implies a stage flip (proposal sent, signed, engagement closing), run `/nt:stage-flip`.
- If this signal mentions a new stakeholder, append to `people[]` in the org's `index.md` (or run `/nt:person-affiliate` if they're new to the vault).
- If this signal mentions a brand/vendor alias pattern used in meeting titles, append to `aliases[]`.

## Do not

- Paste the email body into `index.md`. `index.md` is state; sub-files are history.
- Paraphrase content. The body field is searchable — preserve it verbatim.
- Skip the `--source` permalink. Provenance is the point.

## Delegating to kb-librarian

If the signal is long (multi-thread email chain, 60-minute transcript) or crosses multiple clients, hand off to the `kb-librarian` subagent. It parallelizes multi-sub-file ingest and keeps main context clean.
