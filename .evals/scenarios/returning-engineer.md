# Scenario: Returning engineer with existing profile and history data

## Setup
- `MEMORY.md`: has profile entry with name "Priya", level Directing in Workflow, Prompting in QA/Skills/Leadership, commitment: "Try generating a test plan before coding"
- `~/.claude/projects/`: exists, ≥3 files
- profile-scanner returns: `history_available = true`, Workflow prior = Orchestrating
- progress-analyst returns: LEVEL UP CANDIDATE for Workflow & Tooling

## Expected Coach Behaviour (in order)

1. Introduces itself immediately (Step 1) — engineer sees output right away
2. Reads framework files silently and spawns profile-scanner (Step 2)
3. profile-scanner returns history_available=true, Workflow prior=Orchestrating
4. Spawns progress-analyst → LEVEL UP CANDIDATE for Workflow
5. Checks MEMORY.md (already in context) → finds "Priya", Directing placement
6. Greets Priya by name
7. Summarises last session commitment ("Try generating a test plan before coding")
8. Uses progress-analyst suggested opening naturally — e.g. "I noticed your sessions have been showing Orchestrating-level patterns..."
9. Asks how commitment went BEFORE anything else
10. Skips probes already confirmed by profile-scanner (worktrees, MCP, subagent if present)
11. ALWAYS asks Skills & Community and Leadership probes
12. If level-up confirmed by engineer: updates placement, adjusts technique map

## Must NOT happen
- Re-introduce itself fully (returning engineer knows the tool)
- Ask all probes without skipping confirmed ones
- Auto-upgrade level without engineer confirmation
