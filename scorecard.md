# AI-in-SDLC Self-Evaluation Scorecard

**Baseline** is the expected level for all engineers. Exceeds Expectations and Leading represent meaningful growth beyond it.

Place yourself at the level that describes your *consistent* practice — not your best day or your aspiration.

| Dimension | Baseline | Exceeds Expectations | Leading |
|---|---|---|---|
| **Workflow & Tooling** | Agentic workflow orchestrating analysis, coding, and testing. MCP connected for GitHub PRs and Figma designs. Prompted subagents used for code review and QA. Worktrees and `CLAUDE.md` / `AGENTS.md` in regular use. Experiments with new capabilities (agent teams, plugins) as they ship. | Specialized agent teams with defined roles (e.g. architect agent, reviewer agent, test agent). Custom MCP server built for an internal service or API. Prompt caching applied on large-context workflows. | Runs 2–4 concurrent worktrees with dedicated agent sessions per branch. Has a deliberate staged workflow for large features: exploration → design doc → parallel subagent implementation + TDD. Custom Skills replace manual clipboard prompts for every repeatable task. Parallel subagents (e.g. senior engineer agent + code review agent) run simultaneously on the same feature. |
| **QA** | Generates test plan from story before implementation. Uses subagents for QA runs. AI-assisted CI failure triage before manual investigation. | Agentic Playwright testing. Scripts to call APIs as part of integration flows. iOS/Android MCP for automating UI flows. Test plan created *and* peer-reviewed before a story begins. | End-to-end agentic test pipelines: TDD skill and implementation subagent run in parallel, with Playwright screenshots or test results used as verification before any commit. Owns and defines team QA benchmarks and standards. |
| **Skills & Community** | Writes at least one internal blog post per month — including what didn't work. Reviews code using specific agentic tools (e.g. Agentic Review). | Authors a Skill specific to a service, coding standard, or framework — checked in and approved by an L4 dev. Contributes to shared team `AGENTS.md` or `CLAUDE.md`. | Skills adopted across teams — e.g. a `/end` skill that handles CI checks and deployment, a brainstorming skill that proposes implementation decisions across surface areas. Writes publicly about their AI usage journey including honest tradeoffs (e.g. noticing knowledge decay from offloading implementation thinking and adapting their workflow to compensate). |
| **Leadership & Adoption** | AI usage is visible — shares techniques in PRs, Slack, demos, pair sessions. | Facilitates structured knowledge transfer: workshops, walkthroughs, or team sessions on a specific workflow. | Gets 1–2 engineers to actively adopt a new way of working (e.g. worktrees, parallel subagents, staged large-feature workflows). Writes about their AI journey over time — not just wins, but honest reflection on what changes, what gets harder, and what they had to unlearn. That writing becomes a reference others in the team point to. |

## Further Reading

- **Stack examples** (React/TS, Node/GraphQL, Java/Kotlin, Playwright/Jest, iOS/Android) → [`stack-examples.md`](./stack-examples.md)
- **Monthly check-in template** → [`monthly-reflection.md`](./monthly-reflection.md)
- **Harness engineering** → [Mitchell Hashimoto's AI adoption journey](https://mitchellh.com/writing/my-ai-adoption-journey#step-5-engineer-the-harness)
- **Agentic coding patterns** → [OpenAI: Harness Engineering](https://openai.com/index/harness-engineering/)
- **Example of Leading in practice** → [Tanvi Bhakta: Update on my LLM usage patterns (Jan 2026)](https://tanvibhakta.in/blog/update-on-my-llm-usage-patterns-jan-2026/)
