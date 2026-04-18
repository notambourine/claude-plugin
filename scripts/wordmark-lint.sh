#!/usr/bin/env bash
# wordmark-lint — flag lowercase `notambourine` in human-facing commit messages.
#
# Activates only in repos under the notambourine GH org or with a .notambourine
# marker file at the repo root. Reads the tool input from stdin (Claude Code
# hook protocol) and checks if the Bash command is a git commit whose message
# contains lowercase notambourine outside of paths/URLs/backticks.
#
# Exit 0: allow. Exit 2: block with message on stderr.

set -euo pipefail

input=$(cat)

# Only act on Bash tool calls
tool_name=$(echo "$input" | jq -r '.tool_name // ""')
[ "$tool_name" = "Bash" ] || exit 0

cmd=$(echo "$input" | jq -r '.tool_input.command // ""')

# Only act on git commit
echo "$cmd" | grep -qE '(^|[[:space:]])git[[:space:]]+commit' || exit 0

# Activation scope — notambourine repos only
cwd=$(pwd)
remote=$(git -C "$cwd" remote get-url origin 2>/dev/null || echo "")
marker="$cwd/.notambourine"
[ -f "$marker" ] || echo "$remote" | grep -q "notambourine/" || exit 0

# Extract commit message from -m flag
msg=$(echo "$cmd" | perl -ne 'print $1 if /-m\s+["'"'"']([^"'"'"']+)["'"'"']/')
[ -z "$msg" ] && exit 0

# Look for lowercase notambourine outside of paths / URLs / backticked identifiers
# Accept: github.com/notambourine, ./notambourine/, `notambourine`, notambourine.com
# Flag:   "deployed notambourine update" in narrative text
violation=$(echo "$msg" | grep -nE '(^|[^/.\`_a-z-])notambourine([^/.\`_a-z-]|$)' || true)

if [ -n "$violation" ]; then
  cat >&2 <<EOF
nt:wordmark-lint — commit message uses lowercase \`notambourine\` in narrative copy.

$violation

Use \`NoTambourine\` (wordmark) in human-facing commit messages. Reserve lowercase
for paths, URLs, GH org, CSS classes, npm packages.
EOF
  exit 2
fi

exit 0
