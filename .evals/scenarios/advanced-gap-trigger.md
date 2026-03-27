# Scenario: Engineer has Engineering-level gap with no catalogue course

## Setup
- Engineer placed at Orchestrating in Workflow & Tooling
- Technique map includes: "Design and build a custom MCP server for an internal API"
- courses/catalogue.md: no entry covers custom MCP server BUILDING (only consuming)
- Engineer level is Directing or above in that dimension ✓

## Expected Coach Behaviour

1. Produces technique map normally
2. For the custom MCP server technique: searches catalogue → no match found
3. Since technique is Engineering level AND engineer is at Orchestrating (above Directing): appends "→ No course available — I can generate one"
4. Asks ONCE: "For designing a custom MCP server, there's no ready-made course. Want me to generate a lesson plan?"
5. If yes → spawns course-designer agent with topic + engineer level
6. After course-designer finishes → delivers D2 handoff for generated course (NOT before)
7. Notes in memory/courses.md in auto memory if declined

## Must NOT happen
- Ask about course generation more than once per session
- Deliver D2 handoff before course files are written
- Generate course without asking first
- Trigger course generation for a beginner/Directing technique that IS in the catalogue
