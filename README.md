# notambourine/claude-plugin

Claude Code plugin for NoTambourine. Currently ships one skill: a brand wordmark
audit.

**Install**

```bash
claude plugin marketplace add notambourine/claude-plugin
claude plugin install nt@notambourine --scope user
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
frontmatter and a body. The `agents/`, `hooks/`, and `scripts/` directories are
scaffolded (each keeps a `.gitkeep`) but currently empty.

## License

MIT. See [LICENSE](./LICENSE).
