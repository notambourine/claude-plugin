---
name: recall
description: Recover context from prior sessions in this repo.
allowed-tools:
  - Bash
  - Read
---

# Recall

Read `~/.claude/projects/` JSONL. Match trailing repo name; verify recorded `cwd`. Usually
second-newest is prior session. Order with `/bin/ls`; read JSONL timestamps, not file times.

Extract with `jq`. Drop every record type not listed; `attachment`, `system`, and the
mode/cost/history records are harness noise.

| Signal | Filter |
|---|---|
| User prompts | `type=="user"`, `isMeta!=true`, string content or `text` blocks; skip `tool_result` |
| Model text | `type=="assistant"`, `text` blocks; `thinking` only for depth |
| Tool index | `type=="assistant"`, `tool_use` blocks as `name` + truncated `input`; grep bodies (`tool_result`, `toolUseResult`) only on a miss |
| Subagents | `<sessionId>/subagents/agent-*.jsonl` beside the transcript, same shape, first `user` record is the delegation prompt |

```sh
jq -r 'select(.type=="user" and .isMeta!=true) | .message.content
  | if type=="string" then . else (map(select(.type=="text").text)|join("\n")) end
  | select(length>0)' "$f"
jq -r 'select(.type=="assistant") | .message.content[] | select(.type=="text").text' "$f"
jq -r 'select(.type=="assistant") | .message.content[] | select(.type=="tool_use")
  | "\(.name)\t\(.input|tostring|.[:120])"' "$f"
```

Use `tool-results/` only when transcript references persisted output or misses an expected
keyword.

Ambiguous session: show start, ID, first prompt. Search same repo by topic before other
repos. Summarize decisions, work, unfinished thread; continue task. Never copy long
transcripts into repo; they may contain secrets.
