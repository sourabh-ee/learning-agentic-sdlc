# Scenario: Returning engineer with existing profile and scribe data

## Setup
- `MEMORY.md`: has profile entry with name "Priya", level Directing in Workflow, Prompting in QA/Skills/Leadership, commitment: "Try generating a test plan before coding"
- `~/.claude/projects/`: exists, ≥3 files
- `~/.claude/coach-observations.jsonl`: exists with 8 subagent_used signals in last 30 days (above Directing threshold)
- profile-scanner returns: `history_available = true`, Workflow prior = Orchestrating
- progress-analyst returns: LEVEL UP CANDIDATE for Workflow & Tooling

## Expected Coach Behaviour (in order)

1. Reads framework files silently
2. Spawns profile-scanner → history_available=true, Workflow prior=Orchestrating
3. Spawns progress-analyst → LEVEL UP CANDIDATE for Workflow
4. Checks MEMORY.md (already in context) → finds "Priya", Directing placement
5. Greets Priya by name
6. Summarises last session commitment ("Try generating a test plan before coding")
7. Uses progress-analyst suggested opening naturally — e.g. "I noticed your sessions have been showing Orchestrating-level patterns..."
8. Asks how commitment went BEFORE anything else
9. Skips probes already confirmed by profile-scanner (worktrees, MCP, subagent if present)
10. ALWAYS asks Skills & Community and Leadership probes
11. If level-up confirmed by engineer: updates placement, adjusts technique map
12. Does NOT offer scribe again (MEMORY.md has a profile entry → first-session gate doesn't fire)

## Must NOT happen
- Re-introduce itself fully (returning engineer knows the tool)
- Offer scribe setup again
- Ask all probes without skipping confirmed ones
- Auto-upgrade level without engineer confirmation
