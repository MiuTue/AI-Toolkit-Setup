---
name: debugging-and-error-recovery
description: Guides systematic root-cause debugging. Use when tests fail, builds break, or behavior doesn't match expectations.
---

# Debugging and Error Recovery

## Overview

Systematic debugging with structured triage. Stop adding features, preserve evidence, find and fix the root cause. Guessing wastes time.

## Stop-the-Line Rule

```
1. STOP adding features or changes
2. PRESERVE evidence (errors, logs, repro steps)
3. DIAGNOSE using triage checklist
4. FIX the root cause
5. GUARD against recurrence
6. RESUME after verification passes
```

## Triage Checklist

**Step 1: Reproduce** — Make the failure happen reliably.

**Step 2: Localize** — Which layer? UI / API / DB / Build / External?

**Step 3: Reduce** — Create the minimal failing case.

**Step 4: Fix Root Cause** — Fix the underlying issue, not the symptom.
```
Symptom fix (bad): deduplicate in UI with [...new Set(users)]
Root cause fix (good): fix the JOIN query that produces duplicates
```

**Step 5: Guard** — Write a test that catches this specific failure.

**Step 6: Verify** — Run specific test → full suite → build → manual check.

## Error-Specific Patterns

```
TypeError: Cannot read property 'x' of undefined
→ Something is null/undefined: trace where value comes from

Network/CORS error
→ Check URLs, headers, server CORS config

Build fails
→ Type error: check types at cited location
→ Import error: check module exists and exports match
```

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I know what the bug is, I'll just fix it" | Reproduce first. You're right 70% of the time; the other 30% costs hours. |
| "The failing test is probably wrong" | Verify. If wrong, fix the test. Don't skip it. |
| "It works on my machine" | Environments differ. Check CI, config, dependencies. |

## Verification

- [ ] Root cause identified and documented
- [ ] Fix addresses root cause, not symptoms
- [ ] Regression test exists that fails without the fix
- [ ] All existing tests pass, build succeeds

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
