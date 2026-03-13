# Stack-Specific AI Examples

This document maps the four scorecard dimensions to concrete examples in the stacks you work with every day. Use it when you're not sure what "Practicing" or "Fluent" looks like for a specific kind of task.

Each section covers: React/TypeScript, Node.js/GraphQL, Java/Kotlin, Playwright/Jest, and iOS/Android. For each stack, dimensions map to: Technique Adoption, Workflow Maturity, Harness Engineering, and Knowledge Sharing.

---

## React / TypeScript

### Technique Adoption

**Discovering**
Asking AI to generate a component from a description: "Write a React component that shows a price with a strikethrough for the original price."

**Practicing**
Providing a full context prompt: sharing your existing design system tokens, component conventions, and prop interface patterns before asking for a component. Using a context file that includes your team's accessibility standards and TypeScript strict-mode preferences.

```
Context: We use Tailwind for styling, our component library exposes a <Text> component
with variant props, and all interactive elements must have aria-label. We use strict
TypeScript. Here is an existing similar component for reference: [paste component].

Task: Generate a PriceDisplay component that accepts originalPrice, salePrice,
and currency as required props, renders the strikethrough when salePrice < originalPrice,
and meets our accessibility standard.
```

**Fluent**
Building a reusable Skill that generates a component stub from a prop interface — accepting a TypeScript interface as input and returning a full component skeleton with accessibility attributes, prop validation, and a test stub. Running this as part of your standard new-component workflow.

---

### Workflow Maturity

**Discovering**
Using AI only during implementation — writing JSX when you're not sure of the syntax.

**Practicing**
Using AI at PR review time: pasting a component diff and asking for a review scoped to accessibility gaps, missing loading/error states, or TypeScript strictness issues before requesting human review.

**Fluent**
A chained workflow: (1) paste a design spec or Figma annotation → ask AI to identify missing states (loading, error, empty, skeleton), (2) generate component with all states, (3) generate a test file covering each state, (4) use AI to verify the implementation handles each acceptance criterion from the original story.

---

### Harness Engineering

**Discovering**
When AI generates a component that misses your team's `aria-label` convention, add a line to your context file: "All interactive elements require an explicit aria-label — do not rely on text content alone."

**Practicing**
Maintaining a `AGENTS.md` or context file entry per known React failure mode — e.g., "AI consistently omits loading and error states in async components; always ask explicitly." Running ESLint after every AI-generated component to catch accessibility and TypeScript issues before review.

**Fluent**
Writing a small script that runs `eslint --rule 'jsx-a11y/...'` scoped to AI-generated files as a verification step agents can invoke. Contributing this to the team context file so every engineer benefits from the harness, not just you.

---

### Knowledge Sharing

**Practicing**
Posting in your team channel: "I've been generating edge case lists before writing component tests — here's the prompt structure I've been using and what it caught last week that I would have missed."

**Fluent**
Publishing a Skill that accepts a component file and acceptance criteria, and returns: (1) a gap analysis of missing states, (2) an accessibility checklist, and (3) a test plan outline. Writing a short internal post on what you built and how to use it.

---

## Node.js / GraphQL

### Technique Adoption

**Discovering**
Asking AI to help write a resolver when you're not sure how to structure it: "Write a GraphQL resolver for a user profile query."

**Practicing**
Using AI to validate a schema design before implementation: pasting a proposed schema and asking it to identify missing fields, type mismatches, or N+1 query risks given your data model.

```
Here is our current User type and a proposed extension for adding payment methods:
[paste schema].
Identify: (1) any fields that should be nullable vs non-null,
(2) any resolver patterns that would cause N+1 issues,
(3) missing error types for the mutation.
```

**Fluent**
Using AI as part of schema review in your PR workflow: a structured prompt that checks a schema diff against your team's federation conventions, naming standards, and deprecation patterns. Sharing this as a reusable review step for the whole team.

---

### Workflow Maturity

**Discovering**
Using AI to generate a resolver body when you know the shape of the query.

**Practicing**
Using AI during story refinement: pasting a new feature request and asking it to identify what resolver changes, schema additions, and data loader updates will be needed — before writing any code.

**Fluent**
A subgraph story verification workflow: (1) paste the story and the subgraph schema → AI identifies which resolvers are affected, (2) generate test cases for each resolver path, (3) after implementation, verify each resolver against the original story requirements.

---

### Harness Engineering

**Discovering**
When AI generates a resolver that ignores your dataloader pattern, add it to your context file: "We use DataLoader for all batched DB calls — never query inside a resolver loop."

**Practicing**
Maintaining a context file entry for every GraphQL pattern AI consistently gets wrong (federation directives, nullable vs. non-null conventions, error union types). Running `graphql-inspector` or a schema lint after AI-generated schema changes as a standard verification step.

**Fluent**
Building a script that validates a schema diff against your federation conventions (naming, deprecation format, required directives) that agents can invoke automatically. Keeping this in a shared team context file so the harness is team-wide, not personal.

---

### Knowledge Sharing

**Practicing**
Adding a team-shared context file for the subgraph that captures schema conventions, common resolver patterns, and the data loader setup — so any team member can include it in a prompt and get consistent AI behavior.

**Fluent**
Documenting the subgraph story verification workflow end-to-end and running a short demo for the team. Writing up what the AI consistently gets wrong (e.g., dataloader usage, federation directives) so teammates know where to apply extra scrutiny.

---

## Java / Kotlin

### Technique Adoption

**Discovering**
Pasting a Java class and asking AI to explain it: "What does this class do and what are the main risks?"

**Practicing**
Using AI to scaffold a unit test class with proper setup: providing the class under test, its dependencies, your test framework (JUnit 5, Mockito), and asking for a complete test class with mocks wired up.

```
Here is a Kotlin service class with three dependencies injected via constructor: [paste class].
We use JUnit 5 and Mockito-Kotlin. Generate a test class with:
- @ExtendWith(MockitoExtension::class)
- mocked dependencies
- a test for each public method covering happy path and the most likely failure mode
```

**Fluent**
Using AI to systematically review a class for null safety issues in Kotlin: asking it to identify every call site where a nullable type is used without a safe call operator, and suggesting either safe-call rewrites or explicit null checks with logging.

---

### Workflow Maturity

**Discovering**
Using AI to help with syntax when writing new Java/Kotlin code.

**Practicing**
Using AI as part of refactor review: before submitting a large refactor, pasting the before/after diff and asking AI to identify: (1) any behavior changes not described in the PR, (2) missing null checks introduced by the refactor, (3) any exception handling that was removed.

**Fluent**
A structured review workflow before every PR: AI review scoped to the change type. Refactors get a behavioral-equivalence check. New features get an edge-case and error-handling check. Both get a null-safety review for Kotlin code. This runs before human review every time.

---

### Harness Engineering

**Discovering**
When AI generates Kotlin code that uses `!!` instead of safe calls, add to your context file: "Never use the non-null assertion operator `!!` — use `?.let`, `?: return`, or an explicit null check with logging."

**Practicing**
Maintaining a context file entry for each recurring Java/Kotlin failure mode (missing `@Nullable`/`@NonNull` annotations, incorrect Mockito-Kotlin DSL, missing `@ExtendWith`). Running `./gradlew compileKotlin` or `ktlint` after AI-generated code as a mandatory pre-review step.

**Fluent**
Writing a shell script that compiles AI-generated Kotlin files in isolation and runs `detekt` checks, which agents can invoke as a verification gate before presenting output for review. Documenting the failure patterns it catches in a shared team AGENTS.md.

---

### Knowledge Sharing

**Practicing**
Sharing a test scaffolding prompt in a team channel that generates a full Kotlin test class from a service class — with the Mockito-Kotlin setup your team uses — so teammates don't have to write boilerplate.

**Fluent**
Writing an internal post on using AI for null safety review during Kotlin migrations: what the prompt looks like, what it reliably catches, and where it needs human validation. Including two or three real examples from your own code.

---

## Playwright / Jest

### Technique Adoption

**Discovering**
Asking AI to write a Playwright test for a specific button click: "Write a test that clicks the checkout button and verifies the cart modal opens."

**Practicing**
Providing a full page structure and user story before asking for tests:

```
Here is the user story: [paste story].
Here is the relevant page component: [paste component].
Here is our Playwright helper setup: [paste page object or fixture].
Generate a test file with: (1) happy path, (2) the three most likely failure modes,
(3) a check that the correct element receives focus after the action.
```

**Fluent**
Building a Skill that accepts a user story and returns a Playwright test plan: organized by user flow, including accessibility checks (keyboard navigation, ARIA roles), and edge cases derived from the ACs. Running this before any implementation starts so tests are written to requirements, not to code.

---

### Workflow Maturity

**Discovering**
Writing Playwright tests after implementation is complete to confirm the feature works.

**Practicing**
Generating a test plan from the story before implementation:

```
Here is the acceptance criteria for a new checkout flow: [paste ACs].
Generate a Playwright test plan organized by: (1) core user flows,
(2) edge cases (network failure, timeout, empty states),
(3) accessibility (keyboard nav, screen reader announcements, focus management).
Flag any AC that is ambiguous or untestable as written.
```

**Fluent**
Using AI for CI failure triage: when a Playwright test fails in CI with a non-obvious error, pasting the error, the test, and the relevant component code and asking AI to identify the likely cause before spending time investigating manually.

```
This Playwright test is failing intermittently in CI: [paste test].
The error is: [paste error].
The relevant component is: [paste component].
Identify the three most likely causes of intermittent failure,
ranked by probability, with a suggested fix for each.
```

---

### Harness Engineering

**Discovering**
When AI generates a Playwright test with a fragile `page.locator('button:nth-child(2)')` selector, add to your context file: "Always use `data-testid` or accessible role selectors — never positional or tag-only selectors."

**Practicing**
Maintaining AGENTS.md entries for known Playwright failure modes (missing `await`, hardcoded timeouts instead of `waitFor`, missing `expect` assertions after actions). Running `npx playwright test --grep @smoke` as a quick harness check after AI-generated test files before committing.

**Fluent**
Building a filtered test runner script that agents invoke to verify a specific user flow after generating a test — scoped by tag or file so CI time is minimal. Sharing selector and assertion conventions in a team AGENTS.md so AI-generated tests are consistent across the team from day one.

---

### Knowledge Sharing

**Practicing**
Contributing a prompt template to a shared team doc for generating Playwright tests from acceptance criteria — including the framing you've found produces the best results.

**Fluent**
Facilitating a short team session on AI-assisted test planning: showing the workflow from story → test plan → test stubs → verification, and collecting feedback on what to improve. Writing up the session as an internal post or wiki page.

---

## Native Mobile (iOS / Android)

### Technique Adoption

**Discovering**
Asking AI to generate a UI component in Swift or Kotlin: "Write a SwiftUI view for a product card with image, title, and price."

**Practicing**
Using AI with platform-specific context: providing your team's component patterns, accessibility guidelines for iOS/Android, and the relevant design tokens before asking for a component.

```
We use SwiftUI with a custom design system. Our components use ViewModifiers
for accessibility. Here is an existing product card for reference: [paste view].
Generate a CartItemView that accepts a CartItem model, follows the same
accessibility pattern, and handles the empty image state with a placeholder.
```

**Fluent**
Using AI to generate UI test scripts (XCUITest or Espresso) from design mockup annotations or acceptance criteria, with accessibility assertions included by default.

---

### Workflow Maturity

**Discovering**
Using AI to help with syntax or API lookup during implementation.

**Practicing**
Using AI to review a Swift or Kotlin implementation before submitting for review: asking specifically for missing null/optional handling, missing error states, and accessibility gaps.

**Fluent**
A mobile PR review workflow: pasting the diff and running a structured AI review for each concern area — optional chaining in Swift, nullability in Kotlin, ViewModel state handling, accessibility attributes — before requesting human review.

---

### Harness Engineering

**Discovering**
When AI generates Swift code using `!` force-unwrap on an optional, add to your context file: "Never force-unwrap optionals — use `guard let`, `if let`, or provide a default value."

**Practicing**
Maintaining AGENTS.md entries for recurring iOS/Android failure modes (missing `@MainActor` for UI updates in Swift, incorrect `lifecycleScope` usage in Kotlin, missing VoiceOver labels). Running `xcodebuild -scheme App -destination 'platform=iOS Simulator' build` or `./gradlew lint` after AI-generated code as a verification step.

**Fluent**
Building a build-and-lint script for both platforms that agents invoke after generating code — catching compile errors and lint warnings before output reaches review. Documenting Swift optionality and Android lifecycle patterns in a shared team AGENTS.md so the harness guides AI across the whole mobile team.

---

### Knowledge Sharing

**Practicing**
Sharing an XCUITest generation prompt in your mobile team channel with an example of the output — specifically noting the accessibility assertions it includes that you might have omitted.

**Fluent**
Writing an internal post on using AI for crash log triage: the prompt structure, what information to include for reliable results, and two or three real examples where it correctly identified the root cause. Including cases where it was wrong and why.
