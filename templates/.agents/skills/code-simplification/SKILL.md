---
name: code-simplification
description: Simplifies code for clarity without changing behavior. Use when code works but is harder to read, maintain, or extend than it should be.
---

# Code Simplification

## Five Principles

1. **Preserve Behavior Exactly** — same inputs, outputs, side effects, error paths. If unsure, don't simplify.
2. **Follow Project Conventions** — match the codebase, don't impose external preferences.
3. **Prefer Clarity Over Cleverness** — explicit > compact when compact requires a mental pause.
4. **Maintain Balance** — inlining too aggressively, combining unrelated logic, or optimizing for line count are all failure modes.
5. **Scope to What Changed** — avoid drive-by refactors of unrelated code.

## Process

**Step 1: Understand Before Touching (Chesterton's Fence)**
Before removing anything, understand why it exists. Check git blame. If you can't answer "why was this written this way?", read more context first.

**Step 2: Identify Opportunities**

| Pattern | Signal | Simplification |
|---------|--------|----------------|
| Deep nesting (3+ levels) | Hard to follow | Extract guard clauses |
| Long functions (50+ lines) | Multiple responsibilities | Split into focused functions |
| Nested ternaries | Requires mental stack | Replace with if/else or switch |
| Generic names (`data`, `result`) | No context | Rename: `userProfile`, `validationErrors` |
| Dead code | Unreachable branches, unused vars | Remove (after confirming truly dead) |

**Step 3: Apply Incrementally** — one simplification at a time, run tests after each. Submit refactoring PRs separately from feature PRs.

**Rule of 500:** If refactoring touches >500 lines, use automation (codemods, AST transforms) not manual edits.

## Verification

- [ ] All existing tests pass without modification
- [ ] Build succeeds with no new warnings
- [ ] Linter passes
- [ ] Simplified code follows project conventions
- [ ] No error handling removed or weakened
- [ ] A teammate would approve this as a net improvement

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
