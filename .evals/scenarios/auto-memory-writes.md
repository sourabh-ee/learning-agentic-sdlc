# Scenario: Coach writes correct auto memory structure at session close

## Setup
- First session (MEMORY.md has no profile entry)
- Engineer: "Arjun", stack: React/TypeScript, placed at Directing in Workflow, Prompting in QA/Skills/Leadership
- Session commitment: "Set up a GitHub MCP server this sprint"
- Course recommended: Agent Skills with Anthropic
## Expected Auto Memory Writes at Session Close

memory/profile.md — contains:
- Engineer name: Arjun
- Stack: React/TypeScript
- Tools: Claude Code

memory/placement.md — contains:
- Workflow & Tooling: Directing
- QA: Prompting
- Skills & Community: Prompting
- Leadership & Adoption: Prompting
- Date of session

memory/roadmap.md — contains:
- Top 3 techniques from prioritised map

memory/commitments.md — contains:
- "Set up a GitHub MCP server this sprint"
- Session date

memory/courses.md — contains:
- Recommended: Agent Skills with Anthropic (URL)

memory/preferences.md — contains:
- history_available: true/false from last scan

MEMORY.md index — contains:
- One-line pointer to each topic file above
- Under 20 lines total

## Must NOT happen
- Write to my-profile.md (file is deprecated)
- Write course progress to courses/*/my-progress.md (deprecated)
- MEMORY.md exceed 20 lines
- Any topic file missing from MEMORY.md index
