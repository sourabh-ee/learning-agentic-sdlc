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
