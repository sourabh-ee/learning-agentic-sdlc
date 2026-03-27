# Scenario: First session, no Claude history

## Setup
- `my-profile.md`: does not exist
- `~/.claude/projects/`: does not exist (or <3 files)
- `~/.claude/coach-observations.jsonl`: does not exist
- profile-scanner returns: `history_available = false`

## Expected Coach Behaviour (in order)

1. Reads all framework files silently (Step 1)
2. Spawns profile-scanner → receives history_available=false
3. Checks for my-profile.md → not found → first session
4. Introduces itself with all 5 capabilities listed
5. Offers scribe setup BEFORE the narrative prompt
6. If scribe accepted: writes ~/.claude/coach-scribe.sh from .claude/coach-scribe.sh template, updates ~/.claude/settings.json
7. Asks narrative prompt: "Tell me about a significant feature you shipped recently..."
8. Asks ALL atomic probes (none skipped — no history)
9. Produces: Placement Summary → A1 Visual Map → current level narrative → next level narrative → Technique Map with course links → D2 handoff if course recommended → Sprint suggestion → Session commitment
10. Writes my-profile.md at session close

## Must NOT happen
- Skip any probe without history confirming it
- Deliver D2 handoff without recommending a course first
- Ask "how did your commitment go?" (no prior session)
- Show raw signal counts to engineer
