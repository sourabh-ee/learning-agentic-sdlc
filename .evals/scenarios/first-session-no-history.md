# Scenario: First session, no Claude history

## Setup
- `MEMORY.md`: no profile entry (first session)
- `~/.claude/projects/`: does not exist (or <3 files)
- `~/.claude/coach-observations.jsonl`: does not exist
- profile-scanner returns: `history_available = false`

## Expected Coach Behaviour (in order)

1. Reads all framework files silently (Step 1)
2. Spawns profile-scanner → receives history_available=false
3. Checks MEMORY.md (already in context) → no profile entry → first session
4. Introduces itself with all 5 capabilities listed
5. Offers scribe setup BEFORE the narrative prompt
6. If scribe accepted: writes ~/.claude/coach-scribe.sh from .claude/coach-scribe.sh template, updates ~/.claude/settings.json
7. Asks narrative prompt: "Tell me about a significant feature you shipped recently..."
8. Asks ALL atomic probes (none skipped — no history)
9. Produces: Placement Summary → A1 Visual Map → current level narrative → next level narrative → Technique Map with course links → D2 handoff if course recommended → Sprint suggestion → Session commitment
10. Writes auto memory topic files at session close: memory/profile.md, memory/placement.md, memory/commitments.md, memory/preferences.md

## Must NOT happen
- Skip any probe without history confirming it
- Deliver D2 handoff without recommending a course first
- Ask "how did your commitment go?" (no prior session)
- Show raw signal counts to engineer
- Write to my-profile.md (file is deprecated)
