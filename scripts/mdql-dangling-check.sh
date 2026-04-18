#!/usr/bin/env bash
# mdql-dangling-check — on Stop, if any mdql sub-files were touched this
# session, run `mdql wiki dangling` and surface broken `[[slug]]` refs. Cheap
# sanity check that catches typos and renames before handoff.

set -euo pipefail

input=$(cat)

# Only run when called from a notambourine repo
cwd=$(pwd)
remote=$(git -C "$cwd" remote get-url origin 2>/dev/null || echo "")
marker="$cwd/.notambourine"
[ -f "$marker" ] || echo "$remote" | grep -q "notambourine/" || exit 0

# Only run if mdql is on PATH and a vault structure exists
command -v mdql >/dev/null 2>&1 || exit 0
[ -d "orgs" ] || [ -d "kb/orgs" ] || exit 0

# Check if any mdql-tracked files were edited in this session
# Claude Code Stop hook receives session context; we scan transcript for touches
# to orgs/*/ or people/*/ subtrees. If jq can't find transcript data, skip.
transcript=$(echo "$input" | jq -r '.transcript_path // ""' 2>/dev/null)
touched=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  touched=$(grep -oE '"file_path":\s*"[^"]*(orgs|people)/[^"]+\.md"' "$transcript" 2>/dev/null | head -1)
fi
# If we can't tell, run the check anyway — it's fast
dangling=$(mdql wiki dangling 2>/dev/null || true)

if [ -n "$dangling" ]; then
  cat >&2 <<EOF
nt:mdql-dangling-check — found unresolved [[wiki-refs]] in the vault:

$dangling

Fix before handoff: either update the ref to a real slug, or create the
missing entity (\`mdql org add <slug> ...\` / \`mdql person add <slug> ...\`).
EOF
  # Stop hooks shouldn't hard-block; this is informational.
  exit 0
fi

exit 0
