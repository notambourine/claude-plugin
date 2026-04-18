---
name: person-affiliate
description: Add a new affiliation sub-file under `people/{slug}/affiliations/` — one per role at an org. Use when a known person takes a new title, joins a new org, or when a new stakeholder appears in client context and needs a multi-hat record.
---

# /nt:person-affiliate

Person entities are identity + aliases. Their relationships to orgs live as sub-files so one person can carry multiple hats (employee, contractor, board member, advisor) without duplicating the name.

## When to use

- A known person takes a new role at a new org.
- A new stakeholder shows up in a meeting; resolve them to an existing `person/{slug}` first (grep), create the `person` entity if missing, then attach an affiliation.
- A person's existing affiliation ends and a new one begins (don't delete the old one — append the new one with a start date).

## Check if the person exists

```bash
grep -l "Full Name" kb/people/*/index.md
```

No match → create the person first:

```bash
mdql person add <person-slug> --name "Full Name"
```

Edit `kb/people/<person-slug>/index.md` to add `aliases[]` (nicknames, email addresses, Slack handles).

## Add the affiliation

```bash
mdql person affiliation add <person-slug> \
  --org <org-slug> \
  --title "VP Product" \
  --start YYYY-MM-DD \
  --status current
```

File: `kb/people/<person-slug>/affiliations/<org-slug>-<title-slug>.md`.

## Wire into the org

In `kb/orgs/<org-slug>/index.md`, append `[[person-slug]]` to `people[]`. The link target resolves via schema; you don't need to specify the path.

## Multi-hat example

Brooke at DFC + TPS + SHI + NoTambourine staff role gets four files:

```
kb/people/brooke/affiliations/dfc-vp-product.md
kb/people/brooke/affiliations/tps-cmo-ish.md
kb/people/brooke/affiliations/shi-advisor.md
kb/people/brooke/affiliations/notambourine-staff.md
```

Each org's `index.md` references `[[brooke]]` in its `people[]` — the graph makes the multi-hat visible without duplicating Brooke's identity.

## Do not

- Duplicate a person to express multi-hat. That's what affiliations are for.
- Hand-edit affiliation frontmatter. Use `mdql person affiliation update` for status changes.
