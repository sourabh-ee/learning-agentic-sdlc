
# Level Playbooks

These playbooks describe what working at each level actually looks and feels like day-to-day. The Coach uses these to help engineers see where they are and where they're going — in practical, vivid terms rather than abstract rubric language.

**Prompting** is the baseline — no playbook needed. If you're here, you're using AI reactively, one task at a time, and you're ready to take the next step.

---

## Directing

### What it feels like

You've stopped treating Claude as a search engine. When a new task comes in, your first move isn't to open a file — it's to make sure Claude has what it needs: the stack, the conventions, what not to touch. Your CLAUDE.md is real, not a placeholder. You update it when you learn something about your codebase that Claude got wrong.

You understand why things go wrong. When Claude hallucinates an import or misses an edge case, you can diagnose it — missing context, a vague instruction, a thread that ran too long. You know when to `/clear`, when to summarise, and what happens when you don't. Compaction isn't a mystery anymore.

Your daily habits have shifted in a few concrete ways: you ask for a breakdown before the first line of code. You read the diff before accepting it. You ask "what else could go wrong?" before you call something done. You're not necessarily faster yet — the discipline takes practice — but what Claude produces is noticeably more useful because you're giving it what it actually needs.

You're not running agents or worktrees. This is still one session, one task. But it's a structured session with a clear outcome, not a collection of disconnected prompts hoping something sticks.

### What QA looks like

Claude is in the loop before tests run, not after they fail. You ask it to review your diff for edge cases before you write tests, and you ask it to explain failures before you start digging. Test execution is still manual — no agentic runs yet. But the loop is tighter: Claude catches things you would have caught in code review.

### Stack snapshots

- **Web (React/TS):** Agent reviews the component diff for missed loading states, prop-type gaps, or accessibility issues before the PR is opened — caught in the IDE, not in review.
- **Backend (Node/GraphQL, Java/Kotlin):** Agent explains a failing resolver or unit test and identifies the likely root cause before the engineer opens the debugger.
- **iOS (Swift/SwiftUI):** Agent reviews a Swift diff for force-unwraps, missing nil checks, or incorrect lifecycle scope before the build is submitted.
- **Android (Kotlin):** Agent flags null safety violations and incorrect coroutine scope usage in the diff, before the engineer runs the emulator.

---

## Orchestrating

### What it feels like

You open a new story and your first move isn't a code file — it's Claude Code. You paste the ACs and ask the agent to identify gaps, ambiguities, and missing edge cases before you write anything. Your CLAUDE.md already carries your project context — stack conventions, patterns to follow, things to avoid — so you're not repeating yourself every session. When implementation starts, you're not going solo: a subagent handles the code review while you move on to the next thing. You've connected a GitHub MCP server so the agent can read PR context, comments, and CI output directly. Worktrees let you run parallel sessions — one branch for the feature, one for a quick fix — without context bleed. You share what's working with your team at least once a month, in a PR note or Slack post. You're not just faster — you're catching problems earlier, before they become review comments or production bugs. The shift isn't about using AI more. It's about using it at the right moment in the workflow.

### What QA looks like

The test plan is generated from the story's ACs before any code is written. You run it agentically after implementation — not manually. CI failures get triaged by the agent first; you only investigate what it can't explain. Tests cover cases you would have missed writing them by hand.

### Stack snapshots

- **Web (React/TS):** Agent generates a component test plan from the Figma annotation and ACs — edge cases, loading states, accessibility gaps — before the editor opens.
- **Backend (Node/GraphQL, Java/Kotlin):** Agent reviews the schema or resolver diff for N+1 risks, missing error types, and null safety issues before the PR is raised.
- **iOS (Swift/SwiftUI):** Agent drafts XCUITest stubs from acceptance criteria, including VoiceOver and focus assertions, for you to refine and run.
- **Android (Kotlin):** Agent flags missing null safety, incorrect lifecycle scope usage, and missing accessibility labels in the diff before human review.

---

## Engineering

### What it feels like

You don't just orchestrate — you build the infrastructure other engineers benefit from. You've written a custom MCP server that connects the agent to an internal API, database, or service your team uses every day. You've authored a Skill that encodes a repeatable workflow — code review, test plan generation, schema validation — so teammates can invoke it without understanding the prompt engineering behind it. You've contributed to a shared CLAUDE.md or AGENTS.md that makes the whole team's agent sessions more consistent. When a new story arrives, you have a defined agent team: an architect agent, a reviewer agent, a test agent — each with a scoped role. You use prompt caching on large-context workflows so long sessions don't hit latency or cost walls. Your test plans are peer-reviewed before a story starts, not just generated. You've run a workshop or walkthrough that moved a teammate's practice forward in a measurable way. You think about harness engineering — what does the agent need to consistently produce good output? — and you build for that, not just for yourself.

### What QA looks like

Test plans are created before implementation and peer-reviewed by a teammate. Agentic Playwright scripts cover full user flows, not just unit tests. API integration tests run as part of the agentic workflow. Mobile UI flows are automated via iOS/Android MCP. You own the QA benchmark for your team's stories.

### Stack snapshots

- **Web (React/TS):** Agentic Playwright suite runs after every implementation, with screenshots used as verification before any commit is made.
- **Backend (Node/GraphQL, Java/Kotlin):** API integration tests run via agent-invoked scripts as part of the story completion flow, not as a separate manual step.
- **iOS (Swift/SwiftUI):** iOS MCP automates UI flows end-to-end; agent captures results and flags failures before the PR is raised.
- **Android (Kotlin):** Espresso or UI Automator flows run agentically; agent triages any failure before a human looks at it.

---

## Pioneering

### What it feels like

You're running 2–4 concurrent worktrees with dedicated agent sessions per branch — exploration, design, implementation, and review happening in parallel without context bleed. Large features follow a staged workflow: an exploration phase produces a design doc, which feeds parallel subagent implementation with TDD running alongside. Every repeatable manual prompt you've ever used has become a Skill — checked in, adopted by teammates, running across teams. You've gotten 1–2 engineers to meaningfully change how they work, not just try a technique once. You write honestly about your AI journey over time — what worked, what didn't, what you had to unlearn — and that writing becomes a reference others point to. You're not just using emerging capabilities; you're forming concrete opinions on them within a week of release and sharing those opinions. The techniques you've built are now part of how the team works by default, not optional add-ons. You lead adoption of new workflows the way a senior engineer leads architecture — by demonstrating, then enabling others.

### What QA looks like

TDD Skill and implementation subagent run in parallel — tests are written and failing before implementation starts, passing when it finishes. Playwright screenshots or test results are used as automated verification before any commit. You define the QA benchmarks your team works to, not just meet them.

### Stack snapshots

- **Web (React/TS):** TDD subagent writes failing tests from ACs; implementation subagent runs in parallel; Playwright screenshots verify the result before commit — no manual verification step.
- **Backend (Node/GraphQL, Java/Kotlin):** Staged workflow: design doc → parallel subagent implementation → integration test suite run agentically — all before the PR is opened.
- **iOS (Swift/SwiftUI):** Parallel worktrees for feature and test branches; iOS MCP verifies UI flows automatically as part of the commit gate.
- **Android (Kotlin):** Parallel subagent handles implementation while TDD subagent maintains a failing-then-passing test suite; agent-driven CI triage closes the loop.

---

Use the Write tool to write this content to /Users/sourabh/Projects/ai-learning/ai-in-sdlc/learning-agentic-sdlc/level-playbooks.md
