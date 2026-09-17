---
name: code-review-and-quality
description: Conducts multi-axis code review. Use before merging any change.
---

# Code Review and Quality

## Overview

Five-axis review before every merge. **Approval standard:** approve when a change definitely improves overall code health, even if imperfect.

## The Five Axes

**1. Correctness** — Does it match spec? Edge cases? Error paths? Tests actually testing the right things?

**2. Readability & Simplicity** — Clear names? Straightforward logic? No "clever" tricks? Could this be done in fewer lines?

**3. Architecture** — Follows existing patterns? Clean boundaries? No circular dependencies? Abstraction level appropriate?

**4. Security** — Input validated? No secrets in code? Auth checks in place? No injection vulnerabilities? External data treated as untrusted?

**5. Performance** — N+1 queries? Unbounded operations? Pagination on lists? Unnecessary re-renders?

## Change Sizing

```
~100 lines  → Good. Reviewable in one sitting.
~300 lines  → Acceptable for a single logical change.
~1000 lines → Too large. Split it.
```

## Comment Severity Labels

| Prefix | Meaning | Required? |
|--------|---------|-----------|
| *(none)* | Required change | Yes |
| **Critical:** | Blocks merge | Yes |
| **Nit:** | Minor, optional | No |
| **Optional:** | Suggestion | No |
| **FYI** | Informational | No |

## Honesty in Review

- Don't rubber-stamp. "LGTM" without evidence helps no one.
- Don't soften real issues.
- Quantify: "adds ~50ms per item" beats "could be slow."
- Push back on approaches with clear problems.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It works, that's good enough" | Working but unreadable/insecure code creates compounding debt. |
| "AI-generated code is probably fine" | AI code needs more scrutiny, not less. |
| "We'll clean it up later" | Later never comes. Use the review as the quality gate. |

## Verification

- [ ] All Critical issues resolved
- [ ] Tests pass, build succeeds
- [ ] Five-axis review completed

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
