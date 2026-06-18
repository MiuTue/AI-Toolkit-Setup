---
name: spec-driven-development
description: Creates specs before coding. Use when starting a new project, feature, or significant change and no specification exists yet. Use when requirements are unclear, ambiguous, or only exist as a vague idea.
---

# Spec-Driven Development

## Overview

Write a structured specification before writing any code. The spec is the shared source of truth between you and the human engineer — it defines what we're building, why, and how we'll know it's done. Code without a spec is guessing.

## When to Use

- Starting a new project or feature
- Requirements are ambiguous or incomplete
- The change touches multiple files or modules
- You're about to make an architectural decision
- The task would take more than 30 minutes to implement

**When NOT to use:** Single-line fixes, typo corrections, or changes where requirements are unambiguous and self-contained.

## The Gated Workflow

```
SPECIFY ──→ PLAN ──→ TASKS ──→ IMPLEMENT
   │          │        │          │
   ▼          ▼        ▼          ▼
 Human      Human    Human      Human
 reviews    reviews  reviews    reviews
```

### Phase 1: Specify

Surface assumptions immediately. Before writing any spec content:

```
ASSUMPTIONS I'M MAKING:
1. This is a web application (not native mobile)
2. Authentication uses session-based cookies (not JWT)
3. The database is PostgreSQL (based on existing Prisma schema)
→ Correct me now or I'll proceed with these.
```

Write a spec document covering these six core areas:

1. **Objective** — What are we building and why?
2. **Commands** — Full executable commands with flags.
3. **Project Structure** — Where source code lives, where tests go.
4. **Code Style** — One real code snippet showing your style.
5. **Testing Strategy** — Framework, locations, coverage expectations.
6. **Boundaries** — Always do / Ask first / Never do.

**Spec template:**

```markdown
# Spec: [Project/Feature Name]

## Objective
[What we're building and why.]

## Tech Stack
[Framework, language, key dependencies with versions]

## Commands
[Build, test, lint, dev — full commands]

## Project Structure
[Directory layout with descriptions]

## Code Style
[Example snippet + key conventions]

## Testing Strategy
[Framework, test locations, coverage requirements]

## Boundaries
- Always: [...]
- Ask first: [...]
- Never: [...]

## Success Criteria
[Specific, testable conditions]

## Open Questions
[Anything unresolved]
```

### Phase 2: Plan

Generate a technical implementation plan with components, dependencies, order, risks, and verification checkpoints.

### Phase 3: Tasks

Break into discrete tasks:
- Completable in a single focused session
- Has explicit acceptance criteria
- Includes a verification step
- Touches no more than ~5 files

### Phase 4: Implement

Execute tasks one at a time using `incremental-implementation` and `test-driven-development`.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "This is simple, I don't need a spec" | Simple tasks still need acceptance criteria. A two-line spec is fine. |
| "I'll write the spec after I code it" | That's documentation, not specification. |
| "The spec will slow us down" | A 15-minute spec prevents hours of rework. |

## Verification

- [ ] The spec covers all six core areas
- [ ] The human has reviewed and approved the spec
- [ ] Success criteria are specific and testable
- [ ] The spec is saved to a file in the repository

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
