---
name: new-client
description: Create a new client org entity — scaffold `kb/orgs/{slug}/index.md`, the Drive mirror folder, and optionally an engagement repo (`client-{slug}/`) with a CLAUDE.md that back-references the kb org.
---

# /nt:new-client

Spin up a new client across kb, Drive, and (optionally) an engagement repo in one pass.

## Steps

1. **Pick the slug.** Lowercase, hyphen-separated, short. Matches the Drive folder and (if created) the engagement repo name.

2. **Create the org entity.**

   ```bash
   mdql org add <slug> \
     --name "Brand Name" \
     --kind client \
     --stage introduced
   ```

   Edit the generated `kb/orgs/<slug>/index.md` to add:
   - `people[]` — initial stakeholders as `[[person-slug]]` links. If a person is new to the vault, run `/nt:person-affiliate` to create the `people/<slug>/` entity first.
   - `aliases[]` — brand name, vendor alias, common meeting-title patterns.
   - `domain` — primary website.
   - `legal_name` — if it differs from the brand.
   - Body paragraph: 2–4 sentences on what this engagement is, written as executive summary (not history).

3. **Create the Drive mirror.**

   ```bash
   mkdir -p "$NOTAMBOURINE_DRIVE_ROOT/My Drive/orgs/<slug>"
   ```

4. **Optional: engagement repo.** If delivery work is non-trivial (multi-week, multi-workstream), scaffold with `/nt:eng-repo-init <slug>`. For one-off advisory or short engagements, skip — just work in kb sub-files.

5. **First touchpoint.** The inbound signal that created this client (intro email, referral call, first meeting) gets ingested immediately via `/nt:ingest`. Don't let the org entity sit empty.

## Frontmatter contract

Live projection of required fields:

```bash
mdql schema describe --format json | jq '.entities.org.frontmatter_fields'
```

Read `kb/schema.yml` for the authoritative contract including sub-files.

## After

- Introduce the new slug in a cross-team note if the engagement is visible (Slack, standup log).
- If a proposal is already in draft, run `/nt:new-proposal <slug>` next.
