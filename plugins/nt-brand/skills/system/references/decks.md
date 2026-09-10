# Deck guidance

Explain the client's system with typographic concept diagrams built from brand
tokens. Do not substitute photography or icons for a chart.

Use this slide grammar: numbered eyebrow, lowercase display headline with one
emphasized word, short body, uppercase sublabel, concept diagram, running
footer. Use `.eyebrow` for both labels and write their source in sentence case.
Let the theme apply uppercase.

Use one `lead` cover per deck. Use `divider` for later section breaks. Select
existing theme classes for other slide shapes; inspect `deck.css` for their
behavior. Never add a deck-local `<style>` block or hand-picked brand values.
Shared decks are immutable artifacts, so embedded overrides cannot receive later
brand corrections.

Feed Markdown through Marpit. Separate slides with `---`, enable numbering with
`<!-- paginate: true -->`, and select a slide variant with
`<!-- _class: lead -->`. Use Marpit's `footer:` directive for the running
footer.

Load `tokens.css` on the containing page with `deck.css`. The theme reads the
document root; its color fallbacks do not provide font faces or logo data. Do
not mistake a deck that renders for one whose assets loaded.

Keep the supplied lockup so an exported PDF identifies itself without the share
page. Marpit's `![bg]` slides hide corner furniture, including that lockup;
account for the loss when choosing that layout. Use the logo data URI variables
for offline output, never retype the brand name in display type.
