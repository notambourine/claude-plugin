# Voice and copy audit

Lead public-facing pages and introductions with this core framing:

> Build the systems and ways of working your business needs next.

For a supporting headline about existing systems, use:

> Make your systems work harder for your business.

Follow each headline with the work we will deliver and its business value. Write
concisely, warmly, then playfully, in that order.

## Positioning and offers

Position NoTambourine as senior engineers who work inside the client's team and
take responsibility for delivery. Lead with the client's business goal and the
engineering work needed to reach it. Connect technical infrastructure with the
processes it supports. Show how better systems let a team handle more work
without adding manual steps. AI at the keyboard explains small-team economics;
it is not the offer.

Define fit by the intended result and the responsibility taken on. Mention
private-equity experience when relevant; keep general positioning open to any
ownership structure. The name means no padding.

Help referred readers confirm fit and explain the agency to colleagues. Keep the
signature beside a concrete explanation. Use this introduction:

> Build the systems and ways of working your business needs next. NoTambourine
> brings senior engineers into your team to lead delivery.

For a meta description or short directory listing, use:

> Senior engineers working inside your team to build the systems and ways of
> working your business needs next.

Give recognizable reasons to call: upgrading core systems, automating routine
work, or connecting systems so teams can act on current information. Connect
each to the work we can deliver. Describe infrastructure improvements through
the change in daily work: files arrive automatically, orders move between
systems, or a team can release updates more easily. Use examples that match the
engagement. Support claims of growth, time saved, or reliability with client
evidence.

Keep public positioning open to ambition as well as an existing constraint. In
discovery, ask what they want to accomplish, why now, and what successful
delivery would change. Name constraints once the client has described them or
the evidence establishes them. In a proposal, connect that specific constraint
to its business consequence and the work required.

Use these offer names and lead with outcomes:

- **Assessment:** Decide what to build or change first. Review the technology
  and working processes against your business priorities and choose the next
  investment.
- **Embedded:** Put senior engineers inside your team to lead delivery. Build
  the systems and ways of working your business needs next.

Use "Start a conversation" for the primary invitation. Ask what the reader wants
to accomplish and when. Discuss fit before asking them to choose an engagement.

## Register and evidence

- Address marketing readers as "you". In client deliverables, use "we" for the
  client's organization with us inside it. Name the parties in proposals and
  SOWs. Never use "I" as the author's voice.
- Do not sell in client deliverables: no logo wall, team slide, or methodology.
  Explain their system back to them.
- Show the client's objective, what changed, and what they can now do. Use their
  numbers when available, otherwise a verifiable before and after. Connect
  delivered work to commercial and operational results when supported. Share
  client evidence only with permission.
- Name who joins and takes responsibility for delivery. Express values as
  commitments: direct access to the responsible person and covering our
  estimating mistakes within agreed scope.
- Describe constraints without blaming the people who built the system. Explain
  coordination without jokes about ceremony.

## Names and mechanics

Use `NoTambourine` in human-facing sentences. Reserve `notambourine` for
technical slugs, paths, URLs, domains, GitHub organizations, npm names, and CSS
classes. Use `NoTambourine LLC` only in contracts, at most twice: one
Definitions anchor and the signature block. Reject `Notambourine` and
`No Tambourine`. Cite the public `AGENTS.md` for disputed naming flags.

Preserve `Senior engineers. No tambourine.` as a standalone signature: tagline,
slide, sign-off, or footer. The instrument is lowercase. This is the only
permitted spaced form.

Use sentence case for headlines, buttons, navigation, and labels. Reserve
uppercase for pink eyebrows; decks also use that treatment for sublabels. Follow
deck guidance for lowercase display headlines. Keep sentences short without
forcing a uniform rhythm. No throat-clearing, superlatives, or exclamation marks
in body copy.

Use ASCII punctuation: hyphens and straight quotes/apostrophes. No em/en dashes,
curly quotes, or single-character ellipses. Permit the interpunct as a
separator, as in `Tom Fuertes · Principal · NoTambourine`.

## Audit before shipping

Audit anything clients or strangers see: pages, email, decks, proposals, SOWs,
READMEs, and release notes. Search for candidates, then judge them in context:

Check the opening first. It should name work the reader wants done and explain
our responsibility. Remove assumed pain, unearned urgency, and claims that could
describe any agency. Keep technical constraints where they explain a specific
decision or result.

```sh
rg -n 'notambourine|Notambourine|No\s+Tambourine|NoTambourine LLC' <file>
rg -n '[\x{2014}\x{2013}\x{2018}\x{2019}\x{201C}\x{201D}\x{2026}]' <file>
rg -ni '\b(proven|world-class|battle-tested|results-driven|cutting-edge|best-in-class|seamless|robust|leverage|synergy|holistic|bespoke)\b' <file>
rg -ni ',\s+(ensuring|enabling|allowing|helping|driving|empowering|delivering|providing)\b' <file>
rg -ni "this matters|it's worth noting|it is worth noting|needless to say|at the end of the day|in today's" <file>
rg -n '!(\s|$)|\bI\b' <file>
```

Check legal-name occurrences against the contract limit. Ignore technical slugs
and code when judging wordmark hits; searches do not understand Markdown fences
or backticks. Ignore literal technical uses such as "a robust error path" and
`I` in quotations, identifiers, or names.

Cut puffery and keep evidence. Replace importance-flagging with the consequence.
Cut participle tails at the comma. Read manually for grandiose scope and
three-item adjective lists; narrow claims to something a client can hold us to.
If cutting words leaves the claim intact, remove them.

Preserve three fixtures even when they resemble padding: the signature, factual
three-item lines such as "Two engineers, six weeks, one shipped feature", and a
headline's single pink `<em>`. Typographic emphasis is not a boldface tic.

Format source documents with Prettier before sharing or exporting, including
Markdown. Use the repository's pinned version and configuration. Review the
rendered document after formatting, especially slide breaks and tables.
