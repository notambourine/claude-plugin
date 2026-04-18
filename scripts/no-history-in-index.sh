#!/usr/bin/env bash
# no-history-in-index — flag edits to orgs/*/index.md that look like event history
# instead of state. `index.md` is the living executive-summary snapshot; dated
# paragraphs, quoted emails, and meeting notes belong in touchpoint sub-files.
#
# Activates only for notambourine repos. Blocks the edit with a redirect message
# suggesting `/nt:ingest`.

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

# Content to check: Edit → new_string; Write → content
content=$(echo "$input" | jq -r '.tool_input.new_string // .tool_input.content // ""')
[ -z "$content" ] && exit 0

# Heuristics for event-history content:
#  1. Dated paragraph like "On 2026-04-15, ..."
#  2. Quoted email header: "From: ", "Subject: ", "> wrote:"
#  3. Meeting-notes phrasing: "Action items:", "Attendees:", "Discussed ..."
violations=""
echo "$content" | grep -qE '^(On |)20[0-9]{2}-[0-9]{2}-[0-9]{2}[,:]' && \
  violations="$violations\n- dated paragraph (looks like a touchpoint entry)"
echo "$content" | grep -qE '^(From:|Subject:|To:) ' && \
  violations="$violations\n- email header (should be a touchpoint)"
echo "$content" | grep -qE '^> .* wrote:$' && \
  violations="$violations\n- quoted email body (should be a touchpoint)"
echo "$content" | grep -qE '(^|\n)(Attendees|Action items|Notes):\s*$' && \
  violations="$violations\n- meeting-notes structure (should be a meeting touchpoint)"

if [ -n "$violations" ]; then
  cat >&2 <<EOF
nt:no-history-in-index — this edit looks like event history, not state.

Detected:$(echo -e "$violations")

\`index.md\` is the living executive summary. Dated events, email threads,
and meeting notes belong in typed sub-files under \`touchpoints/\`.

Use \`/nt:ingest\` to file this content correctly. For state changes
(new stakeholder, new alias, stage flip), edit \`index.md\` but keep it
in summary voice.
EOF
  exit 2
fi

exit 0
