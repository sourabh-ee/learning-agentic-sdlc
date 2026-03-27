# Scenario: profile-scanner uses cached result on warm session

## Setup
- memory/scan-cache.md exists with:
  last_scan_date: 2026-03-27T10:00:00Z
  PRIOR PER DIMENSION: Workflow=Orchestrating, QA=Prompting, ...
- Most recent JSONL file in ~/.claude/projects/ has mtime BEFORE 2026-03-27T10:00:00Z
  (no new sessions since last scan)

## Expected Behaviour

1. profile-scanner reads memory/scan-cache.md
2. Checks mtime of most recent JSONL vs last_scan_date
3. No new JSONL files → returns cached prior immediately
4. Does NOT re-parse JSONL session files
5. Returned prior matches cached values exactly

## Warm path timing expectation
- One stat/ls call to check JSONL recency
- No JSONL file reads

## Setup (cold — cache stale)
- memory/scan-cache.md last_scan_date: 2026-03-20T10:00:00Z
- Most recent JSONL mtime: 2026-03-25T14:00:00Z (AFTER cache date)

## Expected Behaviour (cold)
1. profile-scanner reads cache, sees it's stale
2. Runs full JSONL scan
3. Updates memory/scan-cache.md with new timestamp and result
4. Returns fresh prior

## Must NOT happen
- Return cached result when JSONL is newer than cache
- Re-scan when cache is fresh
