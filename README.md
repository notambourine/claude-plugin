# notambourine/claude-plugin

Claude Code plugin for NoTambourine. Ships a brand wordmark audit skill and an
npm/node supply-chain malware scanner hook.

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
- **npm malware scanner hook** (`scripts/npm-malware-scan.sh`) — runs
  automatically, no command to invoke. Scans are **tiered by cost**: cheap
  persistence/source checks run on every event, the expensive `node_modules` walk
  runs only when dependencies actually changed (keyed off the lockfile hash +
  `node_modules` mtime, cached under `~/.cache/notambourine/`).
  - **On `npm`/`pnpm`/`yarn`/`bun`/`npx`/`node` commands** (`PreToolUse`): scans
    `package.json` install-lifecycle scripts and project source for known
    supply-chain IOCs and **blocks** the command before a dropper can run.
  - **Right after an install** (`PostToolUse`, install-class commands only):
    re-scans the freshly written `node_modules` tree and surfaces findings.
  - **On session start** (`SessionStart`): scans the repo and surfaces any
    findings to Claude as context.

  Signatures live in one place — `scripts/malware-patterns.sh`, sourced by the
  hook so a new pattern reaches every tier at once. Detects Shai-Hulud 1.0–3.0
  and the Mini variant (filename + SHA256 + JS fingerprint IOCs), the Axios/DPRK
  RAT (`com.apple.act.mond`), `SANDWORM_MODE` AI-toolchain poisoning, and
  agent-hijack persistence dropped into `.claude/` or `.vscode/`. Requires `jq`
  on `PATH`.

## Brand rules

- **`NoTambourine`** = wordmark. All human-facing copy.
- **`notambourine`** = slug. Only where tooling demands lowercase — paths, URLs,
  domains, the GitHub org, npm package names, CSS classes.
- **`NoTambourine LLC`** = legal form. Only in contract signature blocks and one
  Definitions anchor (e.g. `"Consultant" means NoTambourine LLC…`).

## Extending

Add a skill under `skills/<name>/SKILL.md` — a single markdown file with YAML
frontmatter and a body. Hooks live in `hooks/hooks.json` and reference bundled
scripts in `scripts/` via `${CLAUDE_PLUGIN_ROOT}`. The `agents/` directory is
scaffolded (keeps a `.gitkeep`) but currently empty.

## License

MIT. See [LICENSE](./LICENSE).
