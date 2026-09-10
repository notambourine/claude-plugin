# Visual rules

Keep confident type, one decisive pink, and enough air to make the work clear.
Read exact values and component behavior from the CSS.

- Default to dark. Use light surfaces deliberately and rarely, such as print,
  press pages, or a one-off email. Never use pure white as a surface.
- Use pink as the only accent, with one pink CTA per screen. Mint supports
  structure, status, and supporting icons; never use it for a CTA.
- Do not use gradients. One radial halo behind a hero lockup is the sole
  exception; it must read as lighting.
- Use flat, geometric, two-color imagery. No stock photography, AI imagery, or
  hand-drawn textures. Ask for real assets when needed.
- Keep corners consistent within a component. Use full card borders, never
  colored left stripes.
- Keep hover stationary. No parallax or looping animation. Preserve visible
  focus rings when customizing controls.
- Use Lucide SVG icons with rounded caps and a 1.75px stroke: 20px in
  nav/buttons, 24px in features, 16px in inputs. No emoji in UI chrome or icon
  fonts.
- Use existing logo artwork; never redraw it. Follow README for asset selection
  and regeneration. Reserve `--font-wordmark` for the lockup, never headings.
  Monospace body is the practitioner signal; preserve it.
- Emphasize one word per headline with `<em>`; preserve the supplied drawn
  italic.
- Keep body copy in one column, at most about 640px wide. Use two or three
  columns for card grids, one on mobile, never four. Leave generous space
  between blocks.
- Make nav the only sticky element. No sticky CTAs, chat bubbles, or cookie
  banners.

## Locked surfaces

Never substitute a Google Fonts import, including in mocks. It sends a referrer
to a third party and violates a self-only CSP.

When a surface cannot load local fonts, choose the degradation explicitly.
Inline a supported face as a data URI when the surface warrants the bytes;
always inline the wordmark subset when using live wordmark text. Otherwise use
the fallback stacks from `vars.css` knowingly. Email clients and artifact hosts
may reject font loading even when a page works locally.

Inlining CSS moves relative font resolution to the HTML location. Preserve that
relationship or embed the faces; copying styles alone is insufficient. Use
README for normal package integration.

A self-only CSP requires assets served from the consumer's origin or permitted
embedded data, not a CDN. For a deck theme with no slide element to attach
artwork to, use the supplied logo data URI variables. A PDF or offline snapshot
cannot rely on an origin to retrieve artwork.
