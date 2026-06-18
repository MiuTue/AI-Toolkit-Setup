---
name: test-driven-development
description: Drives development with tests. Use when implementing any logic, fixing any bug, or changing any behavior. Use when you need to prove that code works.
---

# Test-Driven Development

## Overview

Write a failing test before writing the code that makes it pass. For bug fixes, reproduce the bug with a test before attempting a fix. Tests are proof — "seems right" is not done.

## TDD Cycle

```
    RED                GREEN              REFACTOR
 Write a test    Write minimal code    Clean up the
 that fails  ──→  to make it pass  ──→  implementation  ──→  (repeat)
```

## The Prove-It Pattern (Bug Fixes)

```
Bug report → Write test that reproduces it → Test FAILS (confirms bug)
           → Implement fix → Test PASSES (proves fix) → Full suite (no regressions)
```

## Test Pyramid

```
          ╱╲
         ╱  ╲         E2E Tests (~5%)
        ╱────╲
       ╱      ╲       Integration Tests (~15%)
      ╱────────╲
     ╱          ╲     Unit Tests (~80%)
    ╱────────────╲
```

## Writing Good Tests

- **Test state, not interactions** — assert on outcomes, not method calls
- **DAMP over DRY** — each test tells a complete story
- **Prefer real implementations over mocks** — use fakes > stubs > mocks
- **Arrange-Act-Assert pattern** — clear setup, action, assertion
- **One assertion per concept** — separate tests for separate behaviors
- **Descriptive names** — reads like a specification

## Anti-Patterns

| Anti-Pattern | Fix |
|---|---|
| Testing implementation details | Test inputs and outputs |
| Flaky tests | Use deterministic assertions, isolate state |
| Mocking everything | Prefer real implementations > fakes > stubs > mocks |
| No test isolation | Each test sets up and tears down its own state |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'll write tests after the code works" | Tests written after the fact test implementation, not behavior. |
| "Tests slow me down" | They speed you up every time you change the code later. |
| "I tested it manually" | Manual testing doesn't persist. |

## Verification

- [ ] Every new behavior has a corresponding test
- [ ] All tests pass: `npm test`
- [ ] Bug fixes include a reproduction test
- [ ] No tests were skipped or disabled

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
