#!/bin/bash
# Coach Scribe — logs tool use patterns for learning level inference
# Data stays local. Never sent anywhere. Read only by The Coach.
# Template: copied to ~/.claude/coach-scribe.sh during Coach setup.

TOOL_NAME="$1"
LOG_FILE="$HOME/.claude/coach-observations.jsonl"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

case "$TOOL_NAME" in
  Task)
    echo "{\"ts\":\"$TIMESTAMP\",\"signal\":\"subagent_used\",\"tool\":\"$TOOL_NAME\"}" >> "$LOG_FILE"
    ;;
  mcp__*)
    echo "{\"ts\":\"$TIMESTAMP\",\"signal\":\"mcp_used\",\"tool\":\"$TOOL_NAME\"}" >> "$LOG_FILE"
    ;;
  Skill)
    echo "{\"ts\":\"$TIMESTAMP\",\"signal\":\"skill_invoked\",\"tool\":\"$TOOL_NAME\"}" >> "$LOG_FILE"
    ;;
  Bash)
    echo "{\"ts\":\"$TIMESTAMP\",\"signal\":\"bash_used\",\"tool\":\"$TOOL_NAME\"}" >> "$LOG_FILE"
    ;;
esac
