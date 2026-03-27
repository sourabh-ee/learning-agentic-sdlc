# Course Integration & TA Agent Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add curated course recommendations, an Opus-powered course designer agent, and a Sonnet-powered TA agent to learning-agentic-sdlc so engineers get structured learning paths from their Coach session.

**Architecture:** A static catalogue file maps rubric techniques to existing courses; The Coach reads it and appends links to the technique map. For advanced gaps with no catalogue entry, The Coach spawns a `.claude/agents/course-designer.md` subagent (Opus) that generates a lesson plan in two phases (outline → expand). Generated courses get a `CLAUDE.md` that activates a TA agent (Sonnet) when the engineer opens that folder.

**Tech Stack:** Markdown files, Claude Code agent system (`.claude/agents/`), YAML for progress tracking, no code dependencies.

---

## Plan-Spec Alignment

This plan implements `docs/superpowers/specs/2026-03-27-course-integration-design.md`. Key decisions that affect execution:

1. **Catalogue entries:** Use the exact 7-row table from this plan (Task 1). Do not add or modify courses.
2. **Course Designer:** Two-phase only — outline first, expand after confirmation. Never all-at-once.
3. **TA Escalation:** Three rules exactly — offer exercise → mark complete if attempted → redirect on repeated question. No variations.
4. **my-progress.md schema:** Exact YAML structure shown in Task 3. Do not alter field names.
5. **Advanced gap definition:** ALL three criteria must be true (Engineering/Pioneering level + not in catalogue + engineer is at Orchestrating or above). Not just one.

If any task instruction contradicts the spec, the spec takes precedence.

---

## File Map

| File | Action | Purpose |
|---|---|---|
| `courses/catalogue.md` | Create | Curated course list mapped to rubric techniques |
| `.claude/agents/course-designer.md` | Create | Opus-powered subagent that generates lesson plans |
| `.claude/agents/ta-agent.md` | Create | Sonnet TA template (populated per course by designer) |
| `CLAUDE.md` | Modify | Add course recommendation logic + handoff prompt to The Coach |
| `.gitignore` | Modify | Add `courses/*/my-progress.md` |
| `README.md` | Modify | Update with pitch + full feature description |

Generated at runtime (not in plan):
- `courses/<topic>/lesson-plan.md`
- `courses/<topic>/ta-prompt.md`
- `courses/<topic>/CLAUDE.md`
- `courses/<topic>/my-progress.md` (git-ignored)

---

## Task 1: Create the course catalogue

**Files:**
- Create: `courses/catalogue.md`

- [ ] **Step 1: Create `courses/` directory and `catalogue.md`**

```markdown
# Course Catalogue

This file maps rubric techniques to the best available online courses.
The Coach reads this file to append course recommendations to the Prioritized Technique Map.

## How to maintain

- To add a course: open a PR adding a row to the table below.
- To flag a broken URL: remove the row or update the URL.
- Update cadence: review quarterly or when a significant new course is released.

## Catalogue

| Technique | Rubric Transition | Course | URL | Duration | Notes |
|---|---|---|---|---|---|
| Claude Code basics, worktrees, GitHub integration, MCP | Prompting → Orchestrating | Claude Code: A Highly Agentic Coding Assistant | https://www.deeplearning.ai/short-courses/claude-code-a-highly-agentic-coding-assistant/ | ~2h | Free; covers parallel sessions, Playwright, MCP |
| Building agent skills, sub-agents, Claude API/SDK | Prompting → Orchestrating | Agent Skills with Anthropic | https://learn.deeplearning.ai/courses/agent-skills-with-anthropic/lesson/ldn5c3/introduction | ~1h | Beginner-friendly; skill authoring + Agent SDK |
| MCP server setup, building and connecting MCP servers | Prompting → Orchestrating | MCP: Build Rich-Context AI Apps with Anthropic | https://learn.deeplearning.ai/courses/mcp-build-rich-context-ai-apps-with-anthropic/lesson/fkbhh/introduction | ~99min | Intermediate; build + deploy remote MCP servers |
| Agentic patterns, tool use, reflection, autonomous agents | Orchestrating → Engineering | Agentic AI (Andrew Ng) | https://learn.deeplearning.ai/courses/agentic-ai/lesson/pu5xbv/welcome | ~6h | Intermediate; reflection, tool use, autonomous design |
| Agentic architecture, multi-agent orchestration, context management | Orchestrating → Engineering | Claude Certified Architect — Foundations | https://anthropic.skilljar.com/claude-certified-architect-foundations-access-request | TBD | Gated/invite-only; all 5 Certified Architect domains |
| Harness engineering, prompt harness design | Engineering → Pioneering | Harness Engineering (OpenAI) | https://openai.com/index/harness-engineering/ | ~20min read | Reference article; use with YouTube talk |
| Real-world Pioneering patterns, LLM usage evolution | Engineering → Pioneering | Update on LLM Usage Patterns (Tanvi Bhakta) | https://tanvibhakta.in/blog/update-on-my-llm-usage-patterns-jan-2026 | ~15min read | Personal account of Pioneering-level practice |

## Advanced gap definition

A gap is eligible for course generation (not just recommendation) when ALL of the following are true:
1. The required technique maps to Engineering or Pioneering level on the scorecard
2. No catalogue entry covers it
3. The engineer's current level in that dimension is at least Orchestrating
```

- [ ] **Step 2: Commit**

```bash
git add courses/catalogue.md
git commit -m "feat: add course catalogue mapping rubric techniques to online courses"
```

---

## Task 2: Create the course-designer agent

**Files:**
- Create: `.claude/agents/course-designer.md`

- [ ] **Step 1: Create `.claude/agents/` directory**

Run from inside `learning-agentic-sdlc/`:

```bash
mkdir -p .claude/agents
```

- [ ] **Step 2: Write `.claude/agents/course-designer.md`**

```markdown
---
name: course-designer
description: Opus-powered agent that generates structured lesson plans for advanced agentic AI topics not covered by the course catalogue. Invoked by The Coach when an engineer has an advanced gap and consents to course generation.
model: claude-opus-4-5
---

# Course Designer

You are an expert curriculum designer specialising in agentic AI engineering. Your job is to generate a structured, practical lesson plan for a specific topic, calibrated to the engineer's current rubric level.

You are invoked with:
- **Topic:** the specific gap to address
- **Engineer level:** their current placement on the scorecard (Prompting / Orchestrating / Engineering / Pioneering)

---

## Phase 1: Generate High-Level Outline

Generate a high-level outline FIRST. Do not expand modules yet.

The outline must:
- Have 4–6 modules with a title and one-line description each
- Be scoped to the engineer's level (don't assume Pioneering skills for a Prompting engineer)
- Cover the topic end-to-end — from foundational concept to practical application
- Ensure all 5 Certified Architect domains are represented across the full course (proportionally):
  - Agentic Architecture & Orchestration (27%)
  - Tool Design & MCP Integration (18%)
  - Claude Code Configuration & Workflows (20%)
  - Prompt Engineering & Structured Output (20%)
  - Context Management & Reliability (15%)

Present the outline to the engineer and ask:
> "Does this structure make sense? Any modules you'd like to change before I expand it?"

**If engineer rejects the outline:** Ask what they'd like to change. Regenerate the outline once incorporating their feedback. If they reject again, respond: "No problem — I'll note this topic for a future session. Come back when you have a clearer idea of what you want to focus on." Then stop.

**If engineer wants a partial course:** "I'll generate modules 1–N and mark the rest as pending. You can ask me to expand them later." Mark ungenerated modules as `[PENDING - not yet expanded]` in `lesson-plan.md`.

---

## Phase 2: Expand Modules

After engineer confirms the outline, expand each module one at a time. For each module, write:

```
## Module N: [Title]

### Learning Objectives
- [2–3 specific, measurable outcomes]

### Key Concepts
- [Concept 1]: [1–2 sentence explanation]
- [Concept 2]: [1–2 sentence explanation]
- [Concept 3]: [1–2 sentence explanation]

### Hands-On Exercise
[Concrete exercise the engineer can do in their own codebase. Be specific: what to build, what success looks like, what signal tells them it worked.]

### Success Criteria
- [ ] [Observable outcome 1]
- [ ] [Observable outcome 2]
```

**Token discipline:** Expand one module, pause, then continue. Do not generate all modules in one response.

---

## Phase 3: Write Course Files

After all modules are expanded, write these files:

### `courses/<topic-slug>/lesson-plan.md`

```markdown
# [Topic] — Lesson Plan

**Level:** [Engineer's current level]
**Generated:** [Date]
**Certified Architect coverage:** Agentic Architecture (27%) | Tool Design (18%) | CC Config (20%) | Prompt Engineering (20%) | Context Management (15%)

---

[All expanded modules here]
```

### `courses/<topic-slug>/ta-prompt.md`

Populate the TA template with this specific course's context:

```markdown
# TA Agent — [Topic]

You are a Teaching Assistant for the "[Topic]" course in the learning-agentic-sdlc framework.

## Your Role
- Answer questions within the scope of `lesson-plan.md`
- Run exercises interactively with the engineer
- Track progress in `my-progress.md`
- Escalate to "go try this in real code" at the right moment
- Do NOT re-explain the full lesson plan — point to `lesson-plan.md` for reference
- Do NOT answer "what should I learn next?" — direct the engineer back to The Coach

## Engineer Context
At session start, check for `../../my-profile.md`. If it exists, read the engineer's current rubric level and use it to calibrate your explanations.

## Progress Tracking
After each module is completed, update `my-progress.md`:

```yaml
course: [topic-slug]
started: YYYY-MM-DD
modules:
  - name: "Module 1 Title"
    status: complete
    completed: YYYY-MM-DD
    exercise_attempted: true
```

## Escalation Rules
1. After covering a module's concepts, offer the hands-on exercise from `lesson-plan.md`
2. If the engineer completes or meaningfully attempts the exercise → mark module complete, move on
3. If the engineer asks the same conceptual question twice in one session → say: *"You've got this concept — now test it in your actual codebase. Come back with what you find."* Stop answering new hypothetical variants of that question. They can still ask questions about the exercise itself.
4. Escalation is a suggestion — engineer can still ask clarifying questions

## Modules in This Course
[List module titles from lesson-plan.md]
```

### `courses/<topic-slug>/CLAUDE.md`

```markdown
# TA Agent — [Topic]

[Paste full contents of ta-prompt.md here]
```

---

## After Writing Files

Tell the engineer:

> "Your course is ready in `courses/[topic-slug]/`. Here's how to use it:
>
> 1. Open Claude Code in that folder — your TA activates automatically
> 2. Tell the TA which module you're starting and what you already know
> 3. After each module, try the exercise in real code before moving on
> 4. Come back to The Coach when you've finished or hit a wall
>
> The TA is for daily practice — questions, exercises, getting unstuck. The Coach is for placement and deciding what to learn next. Don't ask the TA 'what should I learn?' — that's The Coach's job."
```

- [ ] **Step 3: Commit**

```bash
git add .claude/agents/course-designer.md
git commit -m "feat: add course-designer agent (Opus) for generating custom lesson plans"
```

---

## Task 3: Create the TA agent template

**Files:**
- Create: `.claude/agents/ta-agent.md`

- [ ] **Step 1: Write `.claude/agents/ta-agent.md`**

This is the base template. The course-designer populates a copy of it per course.

```markdown
---
name: ta-agent
description: Sonnet-powered Teaching Assistant for a generated course in learning-agentic-sdlc. Activated automatically when an engineer opens a courses/<topic>/ folder. Handles daily Q&A, exercises, and progress tracking.
model: claude-sonnet-4-5
---

# TA Agent (Template)

> This is the base template. The course-designer agent populates a course-specific copy as `courses/<topic>/ta-prompt.md` and `courses/<topic>/CLAUDE.md`.

You are a Teaching Assistant for an agentic AI engineering course. See `ta-prompt.md` in this folder for the course-specific instructions and module list.

## Session Start

1. Read `lesson-plan.md` — know all modules and exercises
2. Read `my-progress.md` if it exists — know where the engineer is
3. Read `../../my-profile.md` if it exists — calibrate to their rubric level
4. Ask: "Which module are you working on today, and what do you already know about this topic?"

## Core Rules

- Stay within the scope of `lesson-plan.md`
- Point to `lesson-plan.md` for full reference — don't re-explain everything
- Track completions in `my-progress.md`
- For "what should I learn next?" → "That's a question for The Coach — open Claude Code in the parent directory."
- Engineer can return to any completed module; re-engage without restart

## Escalation

After module concepts: offer the exercise from `lesson-plan.md`.
Same conceptual question twice: *"You've got this — go test it in real code. Come back with what you find."*
Escalation is a suggestion, not a hard stop.
```

- [ ] **Step 2: Commit**

```bash
git add .claude/agents/ta-agent.md
git commit -m "feat: add ta-agent template (Sonnet) for daily course practice sessions"
```

---

## Task 4: Update CLAUDE.md — Course recommendation + handoff

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Read current CLAUDE.md**

Read the full file before editing.

- [ ] **Step 2: Add course recommendation logic after Section D (Prioritized Technique Map)**

Find the section `### D. Prioritized Technique Map` and add after its closing content (before `### E. Sprint-Specific Suggestion`):

```markdown
### D1. Course Recommendations

After producing the Prioritized Technique Map, read `courses/catalogue.md`.

For **each technique** in the map:
- Search the catalogue for a matching course by technique keyword
- If found: append to that technique entry — `→ Course: [Name] ([Duration]) — [URL]`
- If not found AND the technique is at Engineering or Pioneering level AND the engineer's current level in that dimension is Orchestrating or above: append `→ No course available — I can generate one`

If any "no course available" entries exist, ask **once per session**:
> *"For [topic], there's no ready-made course. Want me to generate a lesson plan? It takes a few minutes and gives you a TA you can work with daily."*

If yes → spawn the `course-designer` agent with the topic and engineer's current level.
If no → note it in `my-profile.md` as `course_generation_declined: [topic]` and do not ask again this session.
```

- [ ] **Step 3: Add Course Handoff section after Section D1**

```markdown
### D2. Course Handoff

Deliver this **once, immediately** after recommending or generating a course. Do not re-deliver it if the engineer returns to a course in a later session.

**For an existing course:**
> *"Here's how to get the most out of [Course Name]: Watch the first module, then pause and try applying the concept to something in your actual codebase before continuing. Don't binge-watch — one module + one application attempt per day beats three modules in a sitting."*

**For a generated course (after course-designer finishes):**
> *"Your course is ready in `courses/[topic]/`. Here's how to use it:*
> *1. Open Claude Code in that folder — your TA activates automatically*
> *2. Tell the TA which module you're starting and what you already know*
> *3. After each module, try the exercise in real code before moving on*
> *4. Come back here when you've finished the course or hit a wall*
>
> *The TA is for daily practice — questions, exercises, getting unstuck. The Coach is for placement and deciding what to learn next. Don't ask the TA 'what should I learn?' — that's my job."*
```

- [ ] **Step 4: Update Step 1 in Session Start Protocol to also read catalogue**

Find `### Step 1 — Read the Framework Files`. The current bullet list ends with `- \`README.md\``. Add this new bullet immediately after that line:

```markdown
- `courses/catalogue.md` — curated courses mapped to rubric techniques (for technique map recommendations)
```

- [ ] **Step 5: Update Step 2 to check for course progress**

Find `### Step 2 — Check for an Existing Profile`. The section for **existing profile** ends with the sentence: `"Ask how it went before doing anything else."` Insert this new paragraph immediately after that sentence:

```markdown
Also check for any `courses/*/my-progress.md` files. If found, summarise which courses the engineer has started and their module progress before asking how their practice went.
```

- [ ] **Step 6: Update Closing Each Session to log declined generation**

Find `## Closing Each Session`. Locate the numbered list item `3. Write or update \`my-profile.md\` with:` and its bullet sub-list. Add these two bullets at the end of that sub-list:

```markdown
   - Courses recommended this session (name + URL)
   - Any course generation declined (topic name) — so Coach doesn't ask again next session until gap is re-confirmed
```

- [ ] **Step 7: Commit**

```bash
git add CLAUDE.md
git commit -m "feat: add course recommendation logic and handoff prompt to The Coach"
```

---

## Task 5: Update .gitignore

**Files:**
- Modify: `.gitignore`

- [ ] **Step 1: Read current .gitignore**

- [ ] **Step 2: Add progress files**

Add to `.gitignore`:

```
# Personal course progress (like my-profile.md, stays local)
courses/*/my-progress.md
```

- [ ] **Step 3: Commit**

```bash
git add .gitignore
git commit -m "chore: ignore personal course progress files"
```

---

## Task 6: Update README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Read current README.md**

- [ ] **Step 2: Rewrite README.md**

Replace the full contents with the following structure. Preserve the exact tables from the current file (Files at a Glance, Dimensions at a Glance) — update them to add new rows, don't rewrite them from scratch.

**Target structure:**

```
# AI-in-SDLC Self-Evaluation Framework

[Opening pitch — 3–4 sentences: the problem (gap between "using AI occasionally" and
 "structured AI collaborator"), what this gives you, who it's for]

## What You'll Get Out Of This

[Bullet list of 4–5 concrete outcomes: e.g., "An honest picture of where you are today",
 "A prioritised technique map to reach the next level", "Curated course links matched to
 your gaps", "A generated lesson plan + daily TA for topics without a ready-made course",
 "A progress record you own and no one else sees"]

## What This Is Not
[Keep existing content verbatim]

## Getting Started
[Keep existing content verbatim]

## How to Use It
[Keep existing content verbatim, then append:]

### Getting a Course

The Coach maps each technique in your roadmap to the best available online course.
For beginner and intermediate gaps, it links directly to curated courses (deeplearning.ai,
Anthropic Skilljar). For advanced topics with no ready-made course, it can generate a
custom lesson plan on the spot — just say yes when it asks.

Generated courses land in `courses/<topic>/`. Open Claude Code there and a TA agent
activates automatically. The TA handles daily Q&A and exercises. Come back to The Coach
when you've finished or hit a wall.

## Files at a Glance

[Keep existing table, add these rows:]
| `courses/catalogue.md` | Curated courses mapped to rubric techniques | Read by The Coach to recommend learning resources |
| `.claude/agents/course-designer.md` | Opus-powered course generator | Invoked by The Coach for advanced gaps with no existing course |
| `.claude/agents/ta-agent.md` | Sonnet TA template | Populated per course; activates when engineer opens a course folder |

## Dimensions at a Glance
[Keep existing content verbatim]
```

- [ ] **Step 3: Commit**

```bash
git add README.md
git commit -m "docs: update README with pitch and course system documentation"
```

---

## Task 7: Verify end-to-end flow

- [ ] **Step 1: Open Claude Code in `learning-agentic-sdlc/`**

Verify The Coach starts correctly and reads the new `courses/catalogue.md` without error.

- [ ] **Step 2: Confirm technique map includes course links**

After a profiling session (or simulated one), check that technique map entries now include course URLs for known beginner/intermediate techniques.

- [ ] **Step 3: Confirm advanced gap prompt appears**

If a technique at Engineering/Pioneering level is in the map with no catalogue match, verify The Coach asks once about generating a course.

- [ ] **Step 4: Verify course-designer produces correct file structure**

Trigger course generation manually: in a Coach session, say "Generate a lesson plan for designing agentic QA workflows" (or any Engineering-level topic not in the catalogue).

Confirm the following in `courses/agentic-qa-workflows/` (or whatever slug was used):
- `lesson-plan.md` exists — open it and check: has header with "Certified Architect coverage" percentages, has 4–6 modules each with Learning Objectives / Key Concepts / Hands-On Exercise / Success Criteria sections
- `ta-prompt.md` exists — open it and check: starts with `# TA Agent — [topic]`, includes Escalation Rules section, lists module titles
- `CLAUDE.md` exists — open it and check: contains the same content as `ta-prompt.md`
- `my-progress.md` does NOT exist (it is created on first TA session, not by the designer)

- [ ] **Step 5: Open Claude Code in generated course folder**

Verify TA activates, reads `lesson-plan.md`, and asks which module the engineer is starting.

- [ ] **Step 6: Final commit if any fixes needed**

```bash
git add -p
git commit -m "fix: end-to-end verification fixes"
```
