#!/usr/bin/env bash
# pdf-force-add-guard — confirm before `git add -f` on a PDF under orgs/ or
# playbook/. The gitignore rule excludes these by default; force-adding should
# be deliberate (a signed/executed source-of-truth artifact Tom asked for).

set -euo pipefail

input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // ""')
[ "$tool_name" = "Bash" ] || exit 0

cmd=$(echo "$input" | jq -r '.tool_input.command // ""')

# Match: git add -f ... *.pdf with the -f anywhere in the flags
echo "$cmd" | grep -qE '\bgit\s+add\b.*\b-[A-Za-z]*f' || exit 0
echo "$cmd" | grep -qE '\.pdf(\s|$|"|'\')' || exit 0

# Activation scope
cwd=$(pwd)
remote=$(git -C "$cwd" remote get-url origin 2>/dev/null || echo "")
marker="$cwd/.notambourine"
[ -f "$marker" ] || echo "$remote" | grep -q "notambourine/" || exit 0

cat >&2 <<EOF
nt:pdf-force-add-guard — you're about to force-add a PDF.

Command: $cmd

\`kb/.gitignore\` excludes \`orgs/**/*.pdf\` and \`playbook/**/*.pdf\` by default.
Force-add only when:
  - Tom explicitly asked, OR
  - This is a signed/executed source-of-truth artifact AND the prior state was tracked.

If unsure, leave the PDF untracked. Drive is where client-facing PDFs live;
kb tracks the \`.marp.md\` / \`.md\` source, not the build output.

Re-run without \`-f\` to respect the ignore rule, or confirm with Tom first.
EOF
exit 2
