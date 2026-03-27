# Spec: Passive Profiling & Coach Scribe

**Date:** 2026-03-27
**Status:** Implemented

---

## Overview

Two features that let The Coach learn about an engineer's agentic AI level from observable evidence rather than relying solely on self-reported narrative.

---

## Feature 1: Passive Profiling (Step 1B)

### Problem

The Coach's profiling flow relies entirely on an interview — the engineer tells a story, and The Coach asks follow-up probes. This works, but it's slow and redundant: an engineer who already uses worktrees, MCP servers, and subagents still has to describe all of that from scratch.

### Solution

Before speaking to the engineer, The Coach reads existing Claude Code history and artifacts to infer their rubric level per dimension. It then skips probes for signals already confirmed and only asks about what it can't see.

### Data Sources (in priority order)

1. **`~/.claude/projects/*/` JSONL session files** — tool_use events reveal:
   - `mcp__` prefixed tools → MCP usage (Orchestrating)
   - `Task` tool calls → SubAgent usage (Orchestrating)
   - `git worktree` in Bash → worktree usage (Orchestrating)
   - Parallel worktrees → Pioneering signal
   - Test files written before implementation files → early testing (QA)
   - `.claude/agents/` writes → custom agent authoring (Engineering)
   - `Skill` tool calls → skill usage (Engineering)

2. **`~/.claude/MEMORY.md`** — populated with project entries → Orchestrating signal

3. **`~/.claude/settings.json`** — hooks configured → Engineering signal

4. **Nearby CLAUDE.md files** — content sophistication indicates level

5. **`.claude/agents/` in nearby projects** → Engineering signal

6. **`~/.claude/coach-observations.jsonl`** — Scribe data (see Feature 2)

### Coverage by Dimension

| Dimension | Inferrable from history? |
|---|---|
| Workflow & Tooling | Yes — JSONL + artifacts |
| QA | Yes — file write ordering in sessions |
| Skills & Community | No — must ask |
| Leadership & Adoption | No — must ask |

### Fallback

If `~/.claude/projects/` doesn't exist or has fewer than 3 session files, skip inference entirely and fall back to the full interview. This handles the "different machine" or "new install" scenario.

### Signal-to-Level Mapping

- No signals → Prompting (default)
- SubAgent OR worktree OR MCP → at least Orchestrating
- Custom agents AND hooks AND skills → at least Engineering
- Parallel worktrees AND complex agent teams → Pioneering

---

## Feature 2: Coach Scribe (Global Hook)

### Problem

Passive profiling gives a snapshot at session start, but The Coach has no visibility into how the engineer's practices evolve between sessions. Self-reporting is unreliable and adds friction.

### Solution

A `PostToolUse` hook (`~/.claude/coach-scribe.sh`) logs structured observations to `~/.claude/coach-observations.jsonl` after every Claude Code tool call. The Coach reads this file at session start and uses signal counts to strengthen or update the passive profile.

### Hook Logic

The shell script receives the tool name as `$1` and logs a JSONL line for relevant signals:

- `Task` → `subagent_used`
- `mcp__*` → `mcp_used`
- `Skill` → `skill_invoked`
- `Bash` → `bash_used`

### Reading Scribe Data

At session start (Step 1B), if the observations file exists:

- Count signals per type over the last 30 days
- ≥3 events of a type → signal confirmed
- Counts feed into the passive profile prior

### Automatic Level Reassessment

If 30-day observations consistently show signals one full level above current placement, The Coach asks the engineer to confirm a level-up. No auto-upgrade without consent.

### Privacy

- Opt-in only — The Coach asks on first session and respects "no"
- All data stays in `~/.claude/` — nothing leaves the machine
- Engineer can uninstall at any time by deleting the script and removing the hook from settings

---

## Files Changed

| File | Change |
|---|---|
| `CLAUDE.md` | Added Step 1B (passive scan), updated profiling flow for history-aware skipping, added Scribe Setup / Reading Scribe Data / Automatic Level Reassessment sections |
| `README.md` | Added "How The Coach learns about you" privacy section |

---

## Design Decisions

1. **Threshold of 3 session files** — avoids false confidence from a single experimental session.
2. **≥3 signal events over 30 days** — filters out one-off usage from consistent practice.
3. **Never auto-upgrade levels** — always ask first. The engineer's self-awareness is part of the learning.
4. **Skills & Community / Leadership always asked** — these dimensions have no observable proxy in tool usage data.
5. **Scribe is opt-in** — privacy-first. Declining is recorded so The Coach doesn't re-ask.
