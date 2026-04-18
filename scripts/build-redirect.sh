#!/usr/bin/env bash
# build-redirect — nudge direct calls to `marp`, `pandoc`, or `tectonic` toward
# the npm scripts (`slides:build`, `docs:build`) so the universal theme and
# print preamble stay wired in. Direct calls bypass the theme; the build
# scripts apply it consistently across every deck and doc.

set -euo pipefail

input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // ""')
[ "$tool_name" = "Bash" ] || exit 0

cmd=$(echo "$input" | jq -r '.tool_input.command // ""')

# Detect direct calls (not via npm run)
is_direct=""
if echo "$cmd" | grep -qE '(^|\s)(marp|pandoc|tectonic)\s'; then
  if ! echo "$cmd" | grep -qE 'npm\s+run\s+(slides|docs):build'; then
    is_direct="yes"
  fi
fi
[ -z "$is_direct" ] && exit 0

# Activation scope
cwd=$(pwd)
remote=$(git -C "$cwd" remote get-url origin 2>/dev/null || echo "")
marker="$cwd/.notambourine"
[ -f "$marker" ] || echo "$remote" | grep -q "notambourine/" || exit 0

cat >&2 <<EOF
nt:build-redirect — don't call \`marp\` / \`pandoc\` / \`tectonic\` directly.

Command: $cmd

Use the npm scripts so the universal theme and print preamble stay applied:

    npm run slides:build -- <path-to-.marp.md>
    npm run docs:build   -- <path-to-.md>

Direct calls bypass \`playbook/brand/notambourine.css\` and
\`playbook/brand/notambourine-print.tex\`, producing unbranded output.

If you need to debug the build itself, that's fine — but add a \`# debugging\`
comment so the intent is clear.
EOF
exit 2
