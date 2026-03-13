# AI-in-SDLC Self-Evaluation Framework

## What This Is

A self-directed framework for engineers who want to grow their agentic AI skills across the SDLC — and have a structure for tracking that growth honestly over time.

This is not a performance review tool. No manager sees it. There is no score. It exists because the gap between "using AI occasionally" and "using AI as a structured collaborator" is wide enough that most people benefit from an explicit map of what the journey looks like.

## What This Is Not

- Not a manager reporting tool
- Not a productivity metric (does not measure lines generated, tickets closed, or AI usage %)
- Not a pass/fail assessment or a benchmark against teammates

What you write here stays with you. Its purpose is to surface honest self-awareness, not to justify a rating.

## Getting Started

```bash
git clone <this-repo>
cd ai-self-eval
```

To use the self-directed framework, open any of the files below in your editor or wiki tool.

To start a coached session, open Claude Code in this directory:

```bash
claude
```

`CLAUDE.md` activates automatically. The Coach will read the framework files, check for your profile, and guide you from there. Your profile is saved to `my-profile.md` (git-ignored) so it persists between sessions.

> **Prerequisite:** [Claude Code](https://claude.ai/code) installed and authenticated.

---

## How to Use It

**Option A — Self-directed (monthly)**
1. Open [`scorecard.md`](./scorecard.md) to see where you are across four dimensions
2. Fill out [`monthly-reflection.md`](./monthly-reflection.md) — includes 8 quick yes/no checks and a short reflection (~15 min total)
3. Reference [`stack-examples.md`](./stack-examples.md) if you're unsure what a level looks like in your specific stack

**Option B — Coached session**
Open Claude Code in this directory and start a session. `CLAUDE.md` activates The Coach automatically — it will profile you, identify gaps, fetch the latest techniques from the docs, and build a personalized lesson plan. It saves your profile between sessions so you don't repeat yourself.

**One focus per month.** The reflection ends with a single next-month focus. One thing. If you try to move on all dimensions simultaneously you'll move on none of them.

---

## Files at a Glance

| File | What it does | How to use it |
|---|---|---|
| [`scorecard.md`](./scorecard.md) | Defines where you are in the journey across four dimensions (Good / Better / Best) | Open when self-placing; close it after |
| [`monthly-reflection.md`](./monthly-reflection.md) | Helps evaluate which activities you did and identifies what to focus on next month | Copy to a new file each month and fill it in (~15 min) |
| [`stack-examples.md`](./stack-examples.md) | Shows what each level looks like in your actual stack so you can self-place accurately | Reference when a scorecard level feels abstract |
| [`CLAUDE.md`](./CLAUDE.md) | Activates The Coach — profiles you, identifies gaps, builds a lesson plan, remembers where you left off | Open Claude Code in this directory and start a session |

---

## Dimensions at a Glance

**Baseline** is the expected level for all engineers. Exceeds Expectations and Leading represent meaningful growth beyond it.

| Dimension | Baseline | Exceeds Expectations | Leading |
|---|---|---|---|
| **Workflow & Tooling** | Agentic orchestration, MCP, subagents, worktrees | Agent teams, custom MCP servers | 2–4 parallel worktrees with dedicated agent sessions, staged large-feature workflows, parallel subagents |
| **QA** | Test plan before coding, agentic QA runs | Playwright/API/mobile agentic testing, peer-reviewed test plans | TDD skill + implementation subagent running in parallel, Playwright verification before every commit |
| **Skills & Community** | Monthly blog, uses Agentic Review | Checked-in Skills approved by L4 dev | Skills adopted cross-team, writes honestly about their AI journey including tradeoffs and what they had to unlearn |
| **Leadership & Adoption** | Visible AI use shared in PRs/Slack/demos | Workshops and structured knowledge transfer | 1–2 engineers adopt a new workflow; writing about the journey becomes a team reference |
