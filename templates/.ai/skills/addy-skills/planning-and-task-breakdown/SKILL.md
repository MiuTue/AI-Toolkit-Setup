---
name: planning-and-task-breakdown
description: Breaks work into ordered tasks. Use when you have a spec and need to break work into implementable tasks.
---

# Planning and Task Breakdown

## Overview

Decompose work into small, verifiable tasks with explicit acceptance criteria. Every task should be completable, testable, and verifiable in a single focused session.

## Task Sizing

| Size | Files | When to break further |
|------|-------|----------------------|
| XS | 1 | Never |
| S | 1-2 | Rarely |
| M | 3-5 | If 2+ independent subsystems |
| L | 5-8 | Always — break into M tasks |
| XL | 8+ | Always — never implement XL |

## Task Template

```markdown
## Task [N]: [Short title]

**Description:** What this accomplishes.

**Acceptance criteria:**
- [ ] Specific, testable condition
- [ ] Specific, testable condition

**Verification:**
- [ ] Tests: `npm test -- --grep "feature"`
- [ ] Build: `npm run build`
- [ ] Manual: [what to verify]

**Dependencies:** [Task numbers or "None"]
**Files:** `src/path/to/file.ts`
```

## Vertical Slicing (Preferred)

Build one complete feature path at a time — not all DB, then all API, then all UI.

```
Bad:  Task 1: All DB schemas → Task 2: All APIs → Task 3: All UI
Good: Task 1: User create (DB+API+UI) → Task 2: User login (DB+API+UI)
```

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'll figure it out as I go" | 10 minutes of planning saves hours of rework. |
| "Planning is overhead" | Implementation without a plan is just typing. |

## Verification

- [ ] Every task has acceptance criteria
- [ ] Every task has a verification step
- [ ] Task dependencies are identified and ordered
- [ ] No task touches more than ~5 files
- [ ] Human has reviewed and approved the plan

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
