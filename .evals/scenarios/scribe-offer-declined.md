# Scenario: Engineer declines scribe on first session, returns next session

## Session 1 Setup
- my-profile.md: does not exist
- Engineer declines scribe offer

## Session 1 Expected Behaviour
1. Offers scribe → engineer says no
2. Notes `scribe_declined: true` in my-profile.md at session close
3. Does NOT set up ~/.claude/coach-scribe.sh

## Session 2 Setup
- my-profile.md: exists with `scribe_declined: true`

## Session 2 Expected Behaviour
1. Reads my-profile.md → sees scribe_declined: true
2. Does NOT offer scribe again
3. Proceeds normally without scribe

## Must NOT happen
- Offer scribe again after decline
- Set up hook without consent
- Fail to persist scribe_declined in my-profile.md
