# brand-kit

NoTambourine brand assets and guidance for design, decks, and copy. Use the
stylesheets, fonts, and logo together. Read `SKILL.md` for the relevant
guidance.

Correct a brand value here. Every other copy is downstream.

| Link this        | To get                                                             |
| ---------------- | ------------------------------------------------------------------ |
| `tokens.css`     | The whole system: the faces, every value, and styled bare HTML.    |
| `vars.css`       | The values alone, for a surface with its own faces and base layer. |
| `components.css` | `.nt-btn`, `.nt-card`, `.nt-nav`, and the rest, all `var()`-based. |
| `deck.css`       | The Marpit slide theme, 1280x720. Load `vars.css` on the page too. |
| `logo/`          | The mark, the lockup, the icons, and the rasters cut from them.    |

## Logo

`scripts/build-logo.py` holds the mark's path data and the wordmark's type
parameters, and writes every file under `logo/`. It traces the wordmark out of
`fonts/nunito-latin-var.woff2`, so the outlines cannot drift from the face the
stylesheets load. Change the logo by editing that script and re-running it:

```bash
./scripts/build-logo.py    # needs rsvg-convert on PATH
```

The raster half shells out to `rsvg-convert`, which ships in librsvg:
`brew install librsvg` on macOS or Linux, the GTK runtime on Windows. The vector
half runs without it.

### Vector

| File                                               | Use                                                                                                                       |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `logo/lockup.svg`                                  | Default. Mark plus wordmark, outlined, so it needs no font.                                                               |
| `logo/lockup-white.svg`                            | On dark, on pink, on a photo.                                                                                             |
| `logo/lockup-ink.svg`                              | One-color print or light backgrounds where pink lacks contrast.                                                           |
| `logo/lockup-text.svg`                             | The wordmark as live `<text>` over an inlined ten-glyph Nunito subset. Open this one to edit the type; ship `lockup.svg`. |
| `logo/monogram.svg`                                | Mark with `no` nested in the crescent, transparent, square. The short form: avatar, app icon, stamp.                      |
| `logo/monogram-white.svg`, `logo/monogram-ink.svg` | The same two reversals.                                                                                                   |
| `logo/mark.svg`                                    | Mark alone, no letters. Watermarks, a bullet, anywhere `no` would be read as a word.                                      |
| `logo/mark-white.svg`, `logo/mark-ink.svg`         | The same two reversals.                                                                                                   |
| `logo/favicon.svg`                                 | Browser tab: monogram on the dark tile, cut tight so 16px survives.                                                       |
| `logo/icon.svg`                                    | App tile, rounded corners, opaque.                                                                                        |
| `logo/icon-square.svg`                             | App tile, square edges, for iOS and anything else that masks the icon itself.                                             |
| `logo/icon-maskable.svg`                           | Android maskable: full bleed, monogram inside the 80% safe circle.                                                        |

The monogram uses the lockup's first two letters with the same face, size, and
position. The letters lose detail at 16px; use `favicon.svg` for browser
scaling.

`lockup-text.svg` overruns its viewBox in librsvg and resvg, which apply
`letter-spacing` differently than a browser does. That is why the outlined
`lockup.svg` is the default and the source of every raster.

### Raster

Everything in `logo/export/` is cut from the SVGs above, so treat it as output:
regenerate it, never retouch it.

| File                                                                                  | Cut from                             |
| ------------------------------------------------------------------------------------- | ------------------------------------ |
| `favicon.ico` (16, 32, 48)                                                            | `favicon.svg`                        |
| `favicon-16x16.png`, `favicon-32x32.png`, `favicon-48x48.png`                         | `favicon.svg`                        |
| `apple-touch-icon.png` (180)                                                          | `icon-square.svg`                    |
| `icon-192.png`, `icon-512.png`                                                        | `icon.svg`                           |
| `icon-maskable-512.png`                                                               | `icon-maskable.svg`                  |
| `monogram-256.png`, `monogram-512.png`, `monogram-1024.png`, `monogram-white-512.png` | `monogram.svg`, `monogram-white.svg` |
| `mark-256.png`, `mark-512.png`, `mark-1024.png`, `mark-white-512.png`                 | `mark.svg`, `mark-white.svg`         |
| `lockup-1024.png`, `lockup-2048.png`, `lockup-white-1024.png`, `lockup-ink-1024.png`  | the three lockups                    |

### Wire it up

`logo/site.webmanifest` names its icons relative to itself, so it works wherever
`logo/` is served as a unit.

```html
<link rel="icon" href="/logo/favicon.svg" type="image/svg+xml" />
<link rel="icon" href="/logo/export/favicon.ico" sizes="32x32" />
<link rel="apple-touch-icon" href="/logo/export/apple-touch-icon.png" />
<link rel="manifest" href="/logo/site.webmanifest" />
```

## Consume it

Install the package and import its stylesheets from `node_modules`. Keep copied
assets tied to the installed version.

```bash
npm install @notambourine/brand-kit
```

There is no `exports` map, so import or copy any shipped path directly:

```js
import "@notambourine/brand-kit/tokens.css";
```

```bash
cp -R node_modules/@notambourine/brand-kit/{fonts,logo} public/
```

`tokens.css` declares the `@font-face` rules and every `var()` the other two
read, so load it first and serve `fonts/` beside it. The paths inside it are
relative to the CSS file, so inlining it into a `<style>` block breaks the
faces.

### With Tailwind or StyleX

A surface with its own faces and base layer imports `vars.css` alone and writes
`var()` against the semantic aliases. Neither system needs anything from this
kit beyond the custom properties.

```js
import "@notambourine/brand-kit/vars.css";

const styles = stylex.create({
  card: { backgroundColor: "var(--bg-card)", padding: "var(--sp-6)" },
});
```

Tailwind claims the `--font-*` and `--ease-*` namespaces for its own utilities,
which is why those two groups ship a `--nt-*` primitive under the alias: a
Tailwind surface reads the primitive. StyleX hashes the names it generates and
collides with neither.

Two StyleX-specific traps. Bridging through `stylex.defineVars` breaks
`.theme-light`, because StyleX declares those properties on `:root` and a custom
property resolves where it is declared, so a `.theme-light` subtree still
inherits the dark value; a raw `var()` string resolves at the element and themes
correctly. And StyleX outranks the element styles in `elements.css` only while
`useCSSLayers` is off - turn layers on and an unlayered `h1` wins, so import
into a layer StyleX orders itself against:

```css
@import "@notambourine/brand-kit/tokens.css" layer(base);
```

The package ships the stylesheets, `fonts/`, `logo/`, and `SKILL.md`. The logo
build script and `hello-world.html` stay in the repo. Pin an exact version and
bump it on purpose; a caret range moves the brand under a consumer with no diff
to review.

Consumers today:

|                                 |                                                                                        |
| ------------------------------- | -------------------------------------------------------------------------------------- |
| `notambourine/claude`           | Ships it as the `/nt-brand:system` skill.                                              |
| `notambourine/share`            | Serves `tokens.css` and `deck.css` from its own origin; a self-only CSP forbids a CDN. |
| `notambourine/notambourine.com` | The site's stylesheet.                                                                 |

## Gate a consumer

A `var(--x)` that reads a token this repo stopped declaring falls through to its
fallback and the page still renders, so a bump can go wrong quietly. Check three
things in the consumer's CI: the font bytes hash against `fonts/`, every color
is one this kit defines, and every `var()` reads a property it still declares.
`notambourine/share`'s `npm run brand` is the reference implementation.

## Format documents

Install dependencies with `npm ci`. Run `npm run format` before sharing
documents or exporting them. Markdown and MDX are included, along with HTML and
JSON/YAML. Review rendered output after formatting.

## Release

Update `version` in `package.json` and the lockfile, then merge to main. The
publish workflow releases versions that are not already on npm and tags the
published commit. Formatting must pass before the package is packed or
published.

Publishing uses npm trusted publishing with provenance.

## License

MIT for the stylesheets and `SKILL.md`. The faces in `fonts/` are SIL Open Font
License; see `fonts/OFL.txt`.
