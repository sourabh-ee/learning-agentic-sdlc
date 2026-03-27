# AI-in-SDLC Self-Evaluation Framework

Most engineers use AI reactively — one prompt, one task, move on. The gap between that and using AI as a structured collaborator across the full SDLC is wide, and most people never cross it because there's no map. This framework gives you the map: an honest picture of where you are today, a prioritised path to where you want to be, and the learning resources to get there.

It's built for software engineers who want to grow deliberately, not just use AI more.

## What You'll Get Out Of This

- An honest picture of where you are today across four dimensions of agentic practice
- A prioritised technique map showing exactly what to learn next and why
- Curated course links matched to each gap in your roadmap — no searching required
- A generated lesson plan + daily TA agent for advanced topics without a ready-made course
- A progress record you own and control — no manager sees it, no score is kept

## What This Is Not

- Not a manager reporting tool
- Not a productivity metric (does not measure lines generated, tickets closed, or AI usage %)
- Not a pass/fail assessment or a benchmark against teammates
- Not a framework to do your actual development in. That has to be done in a separate Claude agent or Cursor agent.

What you write here stays with you. Its purpose is to surface honest self-awareness, not to justify a rating.

## Getting Started

```bash
git clone <this-repo>
cd learning-agentic-sdlc
```

Open Claude Code in this directory:

```bash
claude
```

`CLAUDE.md` activates automatically. Then just say:

> **"Hi, I want to learn effective AI"**

That's it. The Coach introduces itself, explains what it can do, and takes it from there. Your profile is saved in Claude Code's built-in auto memory — it loads automatically next session, no setup needed.

> **Prerequisite:** [Claude Code](https://claude.ai/code) installed and authenticated.

### How The Coach learns about you

**On first session**, The Coach reads your local Claude Code session history (`~/.claude/projects/`) to infer your level before asking any questions. No permission needed — this is local to your machine and never leaves it. If you're running this on a fresh machine with no history, it falls back to a full interview.

**Optionally**, it can set up a lightweight scribe — a local hook that logs which AI tools you use (SubAgent, MCP, Skills) to `~/.claude/coach-observations.jsonl`. This lets The Coach track your progress over time automatically. It's opt-in, local-only, and uninstalls with two commands.

Nothing is sent anywhere. Everything stays in `~/.claude/` on your machine.

---

## How to Use It

Open Claude Code in this directory and start a session. The Coach will profile you through a narrative conversation — not a questionnaire. It identifies your gaps, places you on the scorecard, and gives you a prioritised technique map to reach the next level. Your profile is saved in Claude Code's auto memory so you don't repeat yourself between sessions.

**Sample Conversations**
Have a look at these conversations to understand how you can communicate with the Coach and what kind of feedback you might expect. Of course the Coach is an LLM so you can ask and have it respond in a way that suits you best (e.g. in a varhadi marathi dialect)

**Level Playbooks**
Post profiling, you can look at the Level Playbooks to understand what each level looks like at a high level and relevance to you tech stack.

**Monthly reflection** is optional. If you've been practicing for a month and want a quick self-check before your next session, fill out `monthly-reflection.md` and bring it to the session — the Coach will use it to accelerate profiling.

### Getting a Course

The Coach maps each technique in your roadmap to the best available online course. For beginner and intermediate gaps, it links directly to curated courses (deeplearning.ai, Anthropic Skilljar). For advanced topics with no ready-made course, it can generate a custom lesson plan on the spot — just say yes when it asks.

Generated courses land in `courses/<topic>/`. Open Claude Code there and a TA agent activates automatically. The TA handles daily Q&A and exercises. Come back to The Coach when you've finished or hit a wall.

---

## Files at a Glance

| File | What it does | How to use it |
|---|---|---|
| [`scorecard.md`](./scorecard.md) | Defines where you are in the journey across four dimensions | Read by the Coach during profiling; reference if you want to understand your placement |
| [`level-playbooks.md`](./level-playbooks.md) | Vivid narratives of what working at each level looks and feels like day-to-day | The Coach references this to show you your current level and destination |
| [`monthly-reflection.md`](./monthly-reflection.md) | Helps evaluate which activities you did and identifies what to focus on next month | Optional: fill in monthly, bring to your next session |
| [`CLAUDE.md`](./CLAUDE.md) | Activates The Coach — profiles you, places you, and gives you a roadmap | Open Claude Code in this directory and start a session |
| [`courses/catalogue.md`](./courses/catalogue.md) | Curated courses mapped to rubric techniques | Read by The Coach to recommend learning resources |
| [`.claude/agents/course-designer.md`](./.claude/agents/course-designer.md) | Opus-powered course generator | Invoked by The Coach for advanced gaps with no existing course |
| [`.claude/agents/ta-agent.md`](./.claude/agents/ta-agent.md) | Sonnet TA template | Populated per course; activates when engineer opens a course folder |

---

## Dimensions at a Glance

**Prompting** is where most engineers start. **Directing** is where intentional practice begins. Each level represents a meaningful shift in how you work — not just how much you use AI.

| Dimension | Prompting | Directing | Orchestrating | Engineering | Pioneering |
|---|---|---|---|---|---|
| **Workflow & Tooling** | Single-shot prompts + context file | CLAUDE.md set up, multi-turn sessions, context/compaction awareness, plan-before-code habit | Agentic orchestration, MCP, subagents, worktrees | Agent teams, custom MCP servers | Parallel worktrees, staged large-feature workflows, parallel subagents |
| **QA** | Tests written after implementation, manually | Claude in review loop — explains failures, suggests edge cases, reviews diffs; still manual runs | Test plan before coding, agentic QA runs | Playwright/API/mobile agentic testing, peer-reviewed test plans | TDD + implementation subagent in parallel, Playwright verification before every commit |
| **Skills & Community** | Techniques personal, not yet shared | Tracks what works personally; not yet shared | Monthly post, uses Agentic Review | Checked-in Skills approved by L4 dev | Skills adopted cross-team, writes honestly about the AI journey |
| **Leadership & Adoption** | AI use invisible to teammates | AI use deliberate but personal; technique mentioned to a teammate in passing | Visible sharing in PRs/Slack/demos | Workshops and structured knowledge transfer | 1–2 engineers adopt a new workflow; writing becomes a team reference |

---
