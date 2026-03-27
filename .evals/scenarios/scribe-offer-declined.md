# Scenario: Engineer declines scribe on first session, returns next session

## Session 1 Setup
- MEMORY.md: no profile entry (first session)
- Engineer declines scribe offer

## Session 1 Expected Behaviour
1. Offers scribe → engineer says no
2. Writes `scribe_declined: true` to memory/preferences.md in auto memory at session close
3. Does NOT set up ~/.claude/coach-scribe.sh

## Session 2 Setup
- MEMORY.md: has profile entry (returning engineer)

## Session 2 Expected Behaviour
1. MEMORY.md has profile entry → first-session gate does not fire
2. Does NOT offer scribe again (no hook-based risk; gate is sufficient)
3. Proceeds normally without scribe

## Must NOT happen
- Set up ~/.claude/coach-scribe.sh without consent
- Fail to persist scribe_declined in memory/preferences.md (useful signal even without a guard)
