# Recap output contract

Shared by `shipped` and `weekly-recap`. Each skill supplies its own header line, section
names, and section emoji; everything below is fixed.

Draft only. Never post.

## Slack markup, not markdown

The reader pastes this into Slack, which strips markdown on paste. Emit Slack mrkdwn:

- Bold is `*one asterisk*`. Never `**two**`; it pastes as literal asterisks.
- Italic is `_underscores_`.
- Bullets are a literal `•` character. Never `-` or `*` at line start.
- No headings, tables, links, or fenced blocks. Slack drops them.

Emit the block as bare text, never wrapped in a fence; a fence makes the reader copy the
markup instead of the message.

## Bullets

```text
• *Label:* Outcome in one short sentence.
```

Label is a bolded one-or-two-word noun for the surface that changed, followed by a colon.
The sentence names the effect on the reader, not the mechanism.

## Sections

Bold the header line and every section header with single asterisks. Bullets start on the
line directly under their header, with no blank line between them. One blank line between
sections, and one under the header line. Omit empty sections. Use exactly the emoji the skill
names, in the order it names them.

## Compression

One bullet per theme, never per commit or PR. Merge until every bullet earns its line. Whole
block under 200 words. Skip bots, imports, dependency bumps, and immaterial docs.

## Vocabulary

Widely read shorthand is fine (9s, 404, RSS, zip). No PRs, hashes, branches, files,
functions, database internals, implementation jargon, attribution, names, stock openings,
inflated adjectives, or rhetorical framing.

## Degradation

Missing `gh`: fall back to git and warn. Apply later wording edits to the full block.
