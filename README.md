# notambourine/claude-plugin

Internal Claude Code plugin for the NoTambourine consulting practice. Ships a
brand wordmark audit skill.

> Looking for the supply-chain malware scanner that used to live here? It now
> has its own home: **[notambourine/npm-malware-scan](https://github.com/notambourine/npm-malware-scan)**.

**Install**

```bash
claude plugin marketplace add notambourine/claude-plugin
claude plugin install nt@notambourine-internal --scope user
```

Slash commands become `/nt:<name>`.

## What's in here

- **`/nt:brand-check`** — audit a file, directory, or git diff for wordmark
  violations: lowercase `notambourine` in human-facing copy where the
  `NoTambourine` wordmark belongs, plus overuse of `NoTambourine LLC` outside
  contract signature blocks.

## Brand rules

- **`NoTambourine`** = wordmark. All human-facing copy.
- **`notambourine`** = slug. Only where tooling demands lowercase — paths, URLs,
  domains, the GitHub org, npm package names, CSS classes.
- **`NoTambourine LLC`** = legal form. Only in contract signature blocks and one
  Definitions anchor (e.g. `"Consultant" means NoTambourine LLC…`).

## Extending

Add a skill under `skills/<name>/SKILL.md` — a single markdown file with YAML
frontmatter and a body. To add hooks, create `hooks/hooks.json` referencing
bundled scripts in `scripts/` via `${CLAUDE_PLUGIN_ROOT}` (see
[npm-malware-scan](https://github.com/notambourine/npm-malware-scan) for a
worked example). The `agents/` directory is scaffolded (keeps a `.gitkeep`) but
currently empty.

## License

MIT. See [LICENSE](./LICENSE).
