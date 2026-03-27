# Design Spec: Course Integration & TA Agent System

**Date:** 2026-03-27
**Status:** Revised v2

---

## Problem

The Coach currently profiles engineers and gives them a technique map, but leaves them to find learning resources on their own. For beginner-level gaps, good courses exist but aren't surfaced. For advanced topics, no structured learning path exists at all. Engineers need both a curated map to existing resources and an on-demand course generator for topics not covered by public courses.

---

## Goals

1. The Coach recommends curated online courses for beginner/intermediate gaps — always deferring to existing courses first
2. For advanced gaps not covered by existing courses, The Coach can generate a custom lesson plan on demand
3. Generated courses get a dedicated TA agent (Sonnet) engineers interact with daily
4. Engineers know how to use the course and TA effectively — The Coach explains this at handoff
5. Everything is checked into the repo — no per-engineer installation required

---

## Out of Scope

- Building a web UI or dashboard
- Grading or tracking course completion
- Auto-generating courses for beginner topics (always defer to existing courses)
- Integrating with LMS platforms

---

## Architecture

### New Files

```
learning-agentic-sdlc/
  .claude/
    agents/
      course-designer.md     ← Opus-powered subagent; generates lesson plans
      ta-agent.md            ← Sonnet-powered TA template (used per course)
  courses/
    catalogue.md             ← Curated courses mapped to rubric levels & techniques
    <topic>/                 ← Generated on demand, one folder per topic
      lesson-plan.md         ← High-level outline + expandable modules
      ta-prompt.md           ← Populated TA instructions for this course
      CLAUDE.md              ← Activates the TA when engineer opens this folder
```

### Modified Files

- `CLAUDE.md` (root) — The Coach gains three new behaviors:
  1. Course recommendation logic (reads `courses/catalogue.md`)
  2. Course designer invocation (spawns `.claude/agents/course-designer.md`)
  3. Course handoff prompt (tells engineer how to use course + TA)

---

## Component Details

### `courses/catalogue.md`

Maps each rubric technique to the best available course. Structure:

```
| Technique | Rubric Transition | Course | URL | Duration | Notes |
```

**Initial catalogue (complete):**

| Technique | Rubric Transition | Course | URL | Duration | Notes |
|---|---|---|---|---|---|
| Claude Code basics, worktrees, GitHub integration | Prompting → Orchestrating | Claude Code: A Highly Agentic Coding Assistant | https://www.deeplearning.ai/short-courses/claude-code-a-highly-agentic-coding-assistant/ | ~2h | Free; covers MCP, parallel sessions, Playwright |
| Building agent skills, sub-agents, Claude API | Prompting → Orchestrating | Agent Skills with Anthropic | https://learn.deeplearning.ai/courses/agent-skills-with-anthropic/lesson/ldn5c3/introduction | ~1h | Beginner-friendly; covers skill authoring + SDK |
| MCP server setup and integration | Prompting → Orchestrating | MCP: Build Rich-Context AI Apps with Anthropic | https://learn.deeplearning.ai/courses/mcp-build-rich-context-ai-apps-with-anthropic/lesson/fkbhh/introduction | ~99min | Intermediate; teaches building + connecting MCP servers |
| Agentic patterns, tool use, reflection, autonomous agents | Orchestrating → Engineering | Agentic AI (Andrew Ng) | https://learn.deeplearning.ai/courses/agentic-ai/lesson/pu5xbv/welcome | ~6h | Intermediate; reflection, tool use, autonomous agent design |
| Agentic architecture, multi-agent systems, context management | Orchestrating → Engineering | Claude Certified Architect — Foundations | https://anthropic.skilljar.com/claude-certified-architect-foundations-access-request | TBD | Gated/invite-only; covers all 5 Certified Architect domains |
| Harness engineering, prompt harness design | Engineering → Pioneering | Harness Engineering (OpenAI) | https://openai.com/index/harness-engineering/ | ~20min read | Reference article; use alongside YouTube talk |
| Real-world Pioneering practice patterns | Engineering → Pioneering | Tanvi Bhakta: Update on LLM Usage Patterns | https://tanvibhakta.in/blog/update-on-my-llm-usage-patterns-jan-2026 | ~15min read | Personal account of Pioneering-level practice |

**Maintenance:** The catalogue is updated when the Coach or a team lead identifies a new course worth cataloguing. To add a course, open a PR adding a row to this file. To flag a broken URL, file an issue or remove the row.

**"Advanced gap" definition:** A gap is considered advanced — and eligible for course generation — when:
1. The required technique is at the Engineering or Pioneering level AND
2. No catalogue entry covers it AND
3. The engineer's current level in that dimension is at least Orchestrating (they have the foundations to absorb advanced material)

### `.claude/agents/course-designer.md`

Invoked by The Coach when:
- The engineer has an advanced gap
- No catalogue entry covers the topic
- The engineer consents to having a course generated

**Invocation trigger:** The Coach asks the engineer once per session per unique advanced gap topic. If the engineer declines, The Coach does not ask again in that session but may ask in a future session if the gap is still unresolved.

**Behavior:**
1. Takes topic + engineer's current level as input
2. Generates a **high-level outline first** (module titles + 1-line descriptions) — pauses, shows the engineer, and waits for confirmation
3. **If engineer rejects outline:** Ask "What would you like to change?" — redesign the outline once based on feedback, then ask again. If the engineer rejects a second time, abort and let The Coach note the topic for a future session.
4. **If engineer requests partial course:** If engineer says "generate only modules 1–3," do exactly that. Mark remaining modules as "pending" in `lesson-plan.md`.
5. **On confirmation:** Expand each module with: learning objectives, key concepts, hands-on exercises, success criteria
6. Applies Certified Architect grade plan weightings as a coverage check (not every module maps to every domain — check that the full course covers all 5 domains proportionally):
   - Agentic Architecture & Orchestration (27%)
   - Tool Design & MCP Integration (18%)
   - Claude Code Configuration & Workflows (20%)
   - Prompt Engineering & Structured Output (20%)
   - Context Management & Reliability (15%)
7. Writes `courses/<topic>/lesson-plan.md` and `ta-prompt.md`
8. Writes `courses/<topic>/CLAUDE.md` to activate the TA in that folder

**Token discipline:**
- High-level outline is generated first (~500 tokens) — engineer reviews before expansion
- Modules expanded one at a time on demand, not all upfront
- TA agent handles depth during daily sessions, not the designer
- If engineer is idle or aborts mid-generation, incomplete modules are left with a `[PENDING]` marker — the designer can resume later

### `.claude/agents/ta-agent.md`

A template. The course designer populates it with the specific curriculum before saving as `courses/<topic>/ta-prompt.md`.

**TA behavior:**
- Answers questions within the scope of the lesson plan
- Can run exercises with the engineer interactively
- Tracks module progress in `courses/<topic>/my-progress.md` (YAML format, git-ignored like `my-profile.md`)
- Does NOT re-explain the full lesson plan — links back to `lesson-plan.md` for reference
- Knows the engineer's rubric level (passed in at session start via `../../my-profile.md` if it exists)
- Context per session: `lesson-plan.md` + `ta-prompt.md` + `my-progress.md` (Sonnet 200k window is sufficient)

**TA escalation rules:**
- After completing the concept portion of a module, the TA offers one hands-on exercise from `lesson-plan.md`
- If the engineer completes or meaningfully attempts the exercise, the TA marks the module complete in `my-progress.md` and moves on
- If the engineer asks the same conceptual question twice within a session, the TA says: *"You've got this — now test it in your actual codebase. Come back with what you find."* and stops answering new hypothetical variants of that question
- Escalation is a suggestion, not a hard stop: the engineer can still ask clarifying questions about the exercise itself
- Engineer can return to a completed module at any time; the TA re-engages without making them restart

**`my-progress.md` schema (per course folder):**
```yaml
course: <topic>
started: YYYY-MM-DD
modules:
  - name: "Module 1 Title"
    status: complete  # complete | in-progress | pending
    completed: YYYY-MM-DD
    exercise_attempted: true
  - name: "Module 2 Title"
    status: in-progress
```
The Coach reads this file (if it exists) at session start to include in the profile summary.

**`my-progress.md` is git-ignored** (personal state, like `my-profile.md`). Generated `lesson-plan.md` and `ta-prompt.md` **are committed** so the whole team benefits from a generated course once it exists.

### Coach: Course Recommendation Logic (CLAUDE.md addition)

After producing the Prioritized Technique Map (Section D), The Coach:

1. For each technique in the map:
   - Checks `courses/catalogue.md` for a matching course
   - If found: appends course name, URL, duration to the technique entry
   - If not found and technique is advanced: notes "no course available — I can generate one"

2. If any "no course available" entries exist, asks once:
   > *"For [topic], there's no ready-made course. Want me to generate a lesson plan? It takes a few minutes and gives you a TA you can work with daily."*

3. If yes → spawns course-designer agent

### Coach: Course Recommendation Logic — Advanced Gap Trigger

"Advanced gap" means: the technique is required for the next rubric level above the engineer's **current lowest dimension**, it maps to Engineering or Pioneering on the scorecard, and no catalogue entry covers it.

The Coach asks **once per session per unique gap topic**. If declined, note it in `my-profile.md` and do not ask again that session.

### Coach: Course Handoff Prompt (CLAUDE.md addition)

Delivered **once, immediately** after a course recommendation is shown (existing) or course files are written (generated). If the engineer returns to a previously-recommended course in a later session, The Coach does not re-deliver the handoff — the TA takes over.

**For existing courses:**
> *"Here's how to get the most out of [Course Name]: Watch the first module, then pause and try applying the concept to something in your actual codebase before continuing. Don't binge-watch — one module + one application attempt per day beats three modules in a sitting."*

**For generated courses:**
> *"Your course is ready in `courses/<topic>/`. Here's how to use it:*
> *1. Open Claude Code in that folder — your TA activates automatically*
> *2. Tell the TA which module you're starting and what you already know*
> *3. After each module, try the exercise in real code before moving on*
> *4. Come back here (The Coach) when you've finished the course or hit a wall*
>
> *The TA is for daily practice — questions, exercises, getting unstuck. The Coach is for placement and deciding what to learn next. Don't use the TA to ask 'what should I learn?' — that's my job."*

---

## Data Flow

```
Engineer opens learning-agentic-sdlc/
  → Coach reads scorecard, profile, catalogue
  → Coach profiles engineer
  → Coach produces technique map WITH course links
  → Advanced gap with no course?
      → Coach asks to generate
      → Yes → course-designer agent runs (Opus)
          → High-level outline shown
          → Engineer confirms
          → Modules expanded
          → courses/<topic>/ written
          → Coach delivers handoff prompt
      → No → Coach notes it, moves on
  → Engineer opens courses/<topic>/
      → TA activates (Sonnet)
      → Daily practice sessions
  → Engineer returns to Coach after course completion
      → Re-profiled, technique map updated
```

---

## Token Budget Awareness

| Operation | Approx Tokens | Strategy |
|---|---|---|
| Catalogue lookup | ~200 | Static file read |
| Course outline generation | ~500 | Show before expanding |
| Single module expansion | ~400–600 | On demand only |
| Full course (5 modules) | ~2500–3000 | Never generated all at once |
| TA session (daily) | ~1000–2000 | Sonnet, not Opus |

The designer uses Opus only for the initial outline + module writes. The TA uses Sonnet for all daily interactions.

---

## Success Criteria

- The Coach surfaces a course link for every beginner/intermediate technique in the map
- For advanced topics, the Coach asks before generating (never auto-generates)
- The handoff prompt is delivered every time a course is recommended or generated
- Generated courses follow the Certified Architect grade plan weightings
- A new engineer can `git clone` and get the full system with no additional setup
- Token usage for course generation stays under 3000 tokens total

---

## Resolved Questions

- **Generated courses committed or git-ignored?** Committed (`lesson-plan.md`, `ta-prompt.md`, `CLAUDE.md`). Personal progress (`my-progress.md`) is git-ignored.
- **TA progress tracking location?** Per-course `my-progress.md` in YAML format. The Coach reads it at session start when it exists.
- **"Advanced gap" definition?** Engineering/Pioneering-level technique, no catalogue entry, engineer is at Orchestrating or above in that dimension.
