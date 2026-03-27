#!/bin/bash
# scan-history.sh — Shared Claude session history scanner
# Used by profile-scanner and progress-analyst agents.
# Outputs JSON — no interpretation, just counts.
#
# Usage:
#   bash .claude/scripts/scan-history.sh [--test-path PATH] [--days 30]
#
# Options:
#   --test-path PATH   Read JSONL from PATH instead of ~/.claude/projects/
#   --days N           Look back N days (default: 30). Doubles for prior window.

set -euo pipefail

CLAUDE_PROJECTS="${HOME}/.claude/projects"
DAYS=30
TEST_PATH=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --test-path) TEST_PATH="$2"; shift 2 ;;
    --days)      DAYS="$2";      shift 2 ;;
    *)           shift ;;
  esac
done

SCAN_DIR="${TEST_PATH:-$CLAUDE_PROJECTS}"

# ── Directory check ────────────────────────────────────────────────────────────
if [[ ! -d "$SCAN_DIR" ]]; then
  echo '{"history_available":false,"reason":"projects directory not found"}'
  exit 0
fi

# ── Collect all JSONL files ───────────────────────────────────────────────────
ALL_JSONL_LIST=$(find "$SCAN_DIR" -name "*.jsonl" -type f 2>/dev/null | sort)
FILE_COUNT=$(echo "$ALL_JSONL_LIST" | grep -c . 2>/dev/null || echo 0)

if [[ "$FILE_COUNT" -lt 3 ]]; then
  echo "{\"history_available\":false,\"reason\":\"insufficient_files\",\"file_count\":$FILE_COUNT}"
  exit 0
fi

# ── Date buckets ──────────────────────────────────────────────────────────────
NOW=$(date +%s)
CUTOFF_RECENT=$((NOW - DAYS * 86400))
CUTOFF_PRIOR=$((NOW  - DAYS * 86400 * 2))

RECENT_FILES=""
PRIOR_FILES=""
LATEST_MTIME=0
SESSIONS_30=0
SESSIONS_PRIOR=0

while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  # portable stat: macOS uses -f %m, Linux uses -c %Y
  MTIME=$(stat -f %m "$f" 2>/dev/null || stat -c %Y "$f" 2>/dev/null || echo 0)
  if [[ "$MTIME" -gt "$CUTOFF_RECENT" ]]; then
    RECENT_FILES="$RECENT_FILES $f"
    SESSIONS_30=$((SESSIONS_30 + 1))
    [[ "$MTIME" -gt "$LATEST_MTIME" ]] && LATEST_MTIME=$MTIME
  elif [[ "$MTIME" -gt "$CUTOFF_PRIOR" ]]; then
    PRIOR_FILES="$PRIOR_FILES $f"
    SESSIONS_PRIOR=$((SESSIONS_PRIOR + 1))
  fi
done <<< "$ALL_JSONL_LIST"

# ── Signal counting helper ────────────────────────────────────────────────────
# Count occurrences of a grep pattern across a space-separated file list.
count_in() {
  local pattern="$1"
  local filelist="$2"
  [[ -z "$filelist" ]] && { echo 0; return; }
  echo "$filelist" | tr ' ' '\n' | while IFS= read -r f; do
    [[ -f "$f" ]] && grep -c "$pattern" "$f" 2>/dev/null || echo 0
  done | awk '{s+=$1} END{print s+0}'
}

# ── Signals (recent 30 days) ──────────────────────────────────────────────────
if [[ -z "$RECENT_FILES" ]]; then
  CLAUDE_MD_READS=0; COMPACT_CLEAR=0; SUBAGENT_USED=0
  WORKTREE_USED=0;   MCP_USED=0;      SKILL_INVOKED=0
  AGENTS_ACCESS=0;   HOOKS_BASH=0
else
  CLAUDE_MD_READS=$(count_in 'CLAUDE\.md'    "$RECENT_FILES")
  COMPACT_CLEAR=$(  count_in '/clear\|/compact' "$RECENT_FILES")
  SUBAGENT_USED=$(  count_in '"name":"Task"' "$RECENT_FILES")
  WORKTREE_USED=$(  count_in 'git worktree'  "$RECENT_FILES")
  MCP_USED=$(       count_in '"name":"mcp__' "$RECENT_FILES")
  SKILL_INVOKED=$(  count_in '"name":"Skill"' "$RECENT_FILES")
  AGENTS_ACCESS=$(  count_in '\.claude/agents/' "$RECENT_FILES")
  HOOKS_BASH=$(     count_in '"hooks"'       "$RECENT_FILES")
fi

# ── Pioneering: multiple worktree adds in a single session ────────────────────
CONCURRENT_WORKTREES=0
for f in $RECENT_FILES; do
  [[ -f "$f" ]] || continue
  C=$(grep -c 'git worktree add' "$f" 2>/dev/null || echo 0)
  C=$(echo "$C" | tr -d '[:space:]')
  [ "$C" -gt 1 ] 2>/dev/null && CONCURRENT_WORKTREES=$((CONCURRENT_WORKTREES + 1)) || true
done

# ── Momentum: prior window ────────────────────────────────────────────────────
PRIOR_SUBAGENT=0; PRIOR_MCP=0; PRIOR_SKILL=0
if [[ -n "$PRIOR_FILES" ]]; then
  PRIOR_SUBAGENT=$(count_in '"name":"Task"'  "$PRIOR_FILES")
  PRIOR_MCP=$(     count_in '"name":"mcp__'  "$PRIOR_FILES")
  PRIOR_SKILL=$(   count_in '"name":"Skill"' "$PRIOR_FILES")
fi

# ── Output JSON ───────────────────────────────────────────────────────────────
cat <<JSON
{
  "history_available": true,
  "scan_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "latest_jsonl_mtime": $LATEST_MTIME,
  "sessions_30d": $SESSIONS_30,
  "sessions_prior_30d": $SESSIONS_PRIOR,
  "signals_30d": {
    "claude_md_reads":      $CLAUDE_MD_READS,
    "compact_clear_used":   $COMPACT_CLEAR,
    "subagent_used":        $SUBAGENT_USED,
    "worktree_used":        $WORKTREE_USED,
    "mcp_used":             $MCP_USED,
    "skill_invoked":        $SKILL_INVOKED,
    "agents_path_access":   $AGENTS_ACCESS,
    "hooks_bash":           $HOOKS_BASH,
    "concurrent_worktrees": $CONCURRENT_WORKTREES
  },
  "signals_prior_30d": {
    "subagent_used":  $PRIOR_SUBAGENT,
    "mcp_used":       $PRIOR_MCP,
    "skill_invoked":  $PRIOR_SKILL
  }
}
JSON
