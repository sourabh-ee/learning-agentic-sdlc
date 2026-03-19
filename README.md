
# AI-in-SDLC Self-Evaluation Framework

## What This Is

A framework for engineers who want to grow their agentic AI skills across the SDLC — and have a structure for tracking that growth honestly over time.

This is not a performance review tool. No manager sees it. There is no score. It exists because the gap between "using AI occasionally" and "using AI as a structured collaborator" is wide enough that most people benefit from an explicit map of what the journey looks like.

## What This Is Not

- Not a manager reporting tool
- Not a productivity metric (does not measure lines generated, tickets closed, or AI usage %)
- Not a pass/fail assessment or a benchmark against teammates

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

`CLAUDE.md` activates automatically. The Coach will read the framework files, check for your profile, and guide you through a profiling session. Your placement, technique map, and session commitment are saved to `my-profile.md` between sessions.

> **Prerequisite:** [Claude Code](https://claude.ai/code) installed and authenticated.

---

## How to Use It

Open Claude Code in this directory and start a session. The Coach will profile you through a narrative conversation — not a questionnaire. It identifies your gaps, places you on the scorecard, and gives you a prioritized technique map to reach the next level. Your profile is saved to `my-profile.md` (git-ignored) so you don't repeat yourself between sessions.

**Monthly reflection** is optional. If you've been practicing for a month and want a quick self-check before your next session, fill out `monthly-reflection.md` and bring it to the session — the Coach will use it to accelerate profiling.

---

## Files at a Glance

| File | What it does | How to use it |
|---|---|---|
| [`scorecard.md`](./scorecard.md) | Defines where you are in the journey across four dimensions | Read by the Coach during profiling; reference if you want to understand your placement |
| [`level-playbooks.md`](./level-playbooks.md) | Vivid narratives of what working at each level looks and feels like day-to-day | The Coach references this to show you your current level and destination |
| [`monthly-reflection.md`](./monthly-reflection.md) | Helps evaluate which activities you did and identifies what to focus on next month | Optional: fill in monthly, bring to your next session |
| [`CLAUDE.md`](./CLAUDE.md) | Activates The Coach — profiles you, places you, and gives you a roadmap | Open Claude Code in this directory and start a session |

---

## Dimensions at a Glance

**Prompting** is where most engineers are today. Each level represents a meaningful shift in how you work — not just how much you use AI.

| Dimension | Prompting | Orchestrating | Engineering | Pioneering |
|---|---|---|---|---|
| **Workflow & Tooling** | Single-shot prompts + context file | Agentic orchestration, MCP, subagents, worktrees | Agent teams, custom MCP servers | Parallel worktrees, staged large-feature workflows, parallel subagents |
| **QA** | Tests written after implementation, manually | Test plan before coding, agentic QA runs | Playwright/API/mobile agentic testing, peer-reviewed test plans | TDD + implementation subagent in parallel, Playwright verification before every commit |
| **Skills & Community** | Techniques personal, not yet shared | Monthly post, uses Agentic Review | Checked-in Skills approved by L4 dev | Skills adopted cross-team, writes honestly about the AI journey |
| **Leadership & Adoption** | AI use invisible to teammates | Visible sharing in PRs/Slack/demos | Workshops and structured knowledge transfer | 1–2 engineers adopt a new workflow; writing becomes a team reference |

---
