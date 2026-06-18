---
name: incremental-implementation
description: Delivers changes incrementally. Use when implementing any feature or change that touches more than one file.
---

# Incremental Implementation

## Overview

Build in thin vertical slices — implement one piece, test it, verify it, then expand. Each increment leaves the system in a working, testable state.

## The Increment Cycle

```
Implement ──→ Test ──→ Verify ──→ Commit ──→ Next slice
```

## Slicing Strategies

**Vertical Slices (Preferred):** Build one complete path through the stack per slice. Each slice delivers working end-to-end functionality.

**Risk-First Slicing:** Tackle the riskiest piece first — if it fails, you discover before investing in the rest.

## Rules

1. **Simplicity First** — ask "What is the simplest thing that could work?"
2. **Scope Discipline** — touch only what the task requires. Note but don't fix things out of scope.
3. **One Thing at a Time** — each increment changes one logical thing.
4. **Keep It Compilable** — after each increment, project must build and tests must pass.
5. **Feature Flags** — for incomplete features that need merging.
6. **Rollback-Friendly** — each increment independently revertable.

## Increment Checklist

- [ ] Change does one thing completely
- [ ] All existing tests still pass
- [ ] Build succeeds
- [ ] Type checking passes
- [ ] Linting passes
- [ ] Committed with a descriptive message

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'll test it all at the end" | Bugs compound. Test each slice. |
| "It's faster to do it all at once" | Until something breaks and you can't find which of 500 lines caused it. |

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
