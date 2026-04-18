#!/usr/bin/env bash
# stage-redirect — block hand-edits to `stage:` or `outcome:` frontmatter in
# `orgs/*/index.md`. These fields must be flipped via `mdql org update` so the
# transition table is enforced and timestamps are consistent.

set -euo pipefail

input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // ""')
case "$tool_name" in Edit|Write) ;; *) exit 0 ;; esac

path=$(echo "$input" | jq -r '.tool_input.file_path // ""')
echo "$path" | grep -qE '/orgs/[^/]+/index\.md$' || exit 0

# Activation scope
cwd=$(pwd)
remote=$(git -C "$cwd" remote get-url origin 2>/dev/null || echo "")
marker="$cwd/.notambourine"
[ -f "$marker" ] || echo "$remote" | grep -q "notambourine/" || exit 0

new=$(echo "$input" | jq -r '.tool_input.new_string // .tool_input.content // ""')
old=$(echo "$input" | jq -r '.tool_input.old_string // ""')

# Detect changes to stage: or outcome: frontmatter
changed=""
if echo "$new" | grep -qE '^(stage|outcome):\s*\S+' && \
   ! echo "$old" | grep -qE '^(stage|outcome):\s*'"$(echo "$new" | grep -oE '^(stage|outcome):\s*\S+' | head -1 | awk '{print $2}')"; then
  changed="yes"
fi
# Simpler catch: if the new_string contains stage: or outcome: at line start, warn
echo "$new" | grep -qE '^(stage|outcome):' && changed="yes"

if [ -n "$changed" ]; then
  slug=$(echo "$path" | sed -E 's|.*/orgs/([^/]+)/index\.md$|\1|')
  cat >&2 <<EOF
nt:stage-redirect — don't hand-edit \`stage:\` or \`outcome:\` in frontmatter.

Use the mdql entity-update verb so the transition table is enforced:

    mdql org update $slug --stage <new-stage>
    mdql org update $slug --stage closed --outcome <won|lost|paused>

Or run the skill: /nt:stage-flip $slug <new-stage>

See \`kb/CLAUDE.md\` for the legal transition table.
EOF
  exit 2
fi

exit 0
