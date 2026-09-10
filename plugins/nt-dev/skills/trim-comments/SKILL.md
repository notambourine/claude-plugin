---
name: trim-comments
description: Remove comments that restate code and shorten comments that preserve necessary rationale or traps. Use before committing or when a diff is over-commented.
effort: high
allowed-tools: Bash, Read, Edit, Glob, Grep, AskUserQuestion
argument-hint: "[path-or-glob | --repo]"
disable-model-invocation: true
---

# Trim comments

Delete a comment unless both conditions hold:

- The fact is not derivable from the surrounding code or config.
- Removing it could cause a competent editor to make a wrong change.

Survivors explain why a choice wins or warn about a trap. Keep them to one line when possible, two lines maximum, and never more lines than the code they explain.

Delete comments that describe code, explain well-named values or routine config switches, narrate a change, repeat another comment or memory rule, or carry authorship, tags, or dates. Age does not exempt a comment. When uncertain, keep it only if deletion could hide a footgun.

## Scope

Inspect the union of:

- the path or glob argument
- files edited or comments deferred this session
- staged, unstaged, and untracked source files

`--repo` includes every tracked source file. State the resolved files before editing.

Do not touch generated, vendored, dependency, lock, or prose files. Preserve shebangs, licenses, directives, lint and type suppressions, issue-linked TODOs and FIXMEs, hook headers, `FIX RUNBOOK` blocks, and comment-like text inside strings or embedded programs.

## Apply

Read each comment in context. Delete failures before shortening survivors. Keep point-of-use traps; ask before moving broader rationale into a commit body, PR, or repo memory file. Write commit and PR rationale for a PM or user: state outcomes and impact, not engineering narrative. Leave edits uncommitted.

Inspect every diff hunk and confirm only comments changed:

```bash
git diff -U0 | grep -E '^[+-]' | grep -vE '^(\+\+\+|---)' | grep -vE '^[+-][[:space:]]*(#|//|/\*|\*|--|$)'
```

Output is acceptable only for trailing comments. Do not run checks covered by CI.

Report changed files plus delete, shorten, keep, and skipped counts.
