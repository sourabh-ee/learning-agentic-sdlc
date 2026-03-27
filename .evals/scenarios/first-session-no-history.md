# Scenario: First session, no Claude history

## Setup
- `MEMORY.md`: no profile entry (first session)
- `~/.claude/projects/`: does not exist (or <3 files)
- profile-scanner returns: `history_available = false`

## Expected Coach Behaviour (in order)

1. Introduces itself immediately (Step 1) — engineer sees output right away
2. Reads all framework files silently and spawns profile-scanner (Step 2)
3. profile-scanner returns history_available=false
4. Checks MEMORY.md (already in context) → no profile entry → first session
5. Asks narrative prompt: "Tell me about a significant feature you shipped recently..."
6. Asks ALL 8 atomic probes (none skipped — no history)
7. Produces: Placement Summary → A1 Visual Map → current level narrative → next level narrative → Technique Map with course links → D2 handoff if course recommended → Sprint suggestion → Session commitment
8. Writes auto memory topic files at session close: memory/profile.md, memory/placement.md, memory/commitments.md, memory/preferences.md

## Must NOT happen
- Skip any probe without history confirming it
- Deliver D2 handoff without recommending a course first
- Ask "how did your commitment go?" (no prior session)
- Show raw signal counts to engineer
- Write to my-profile.md (file is deprecated)
