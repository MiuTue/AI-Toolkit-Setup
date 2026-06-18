---
name: doubt-driven-development
description: Adversarial fresh-context review of every non-trivial decision. Use when stakes are high (production, security, irreversible), in unfamiliar code, or when a confident output would be cheaper to verify now than debug later.
---

# Doubt-Driven Development

## Overview

A confident answer is not a correct one. This skill spawns a fresh-context reviewer biased to **disprove**, not approve — before any non-trivial output stands.

## When a Decision Is "Non-Trivial"

At least one of:
- Introduces or modifies branching logic
- Crosses a module/service boundary
- Asserts unverifiable properties (thread safety, idempotence, ordering)
- Blast radius is irreversible (production deploy, data migration, public API)

## The Process

```
Step 1: CLAIM  — Name the decision + why it matters
Step 2: EXTRACT — Isolate artifact + contract, strip reasoning
Step 3: DOUBT  — Invoke fresh-context reviewer with adversarial prompt
Step 4: RECONCILE — Classify each finding: contract misread / actionable / trade-off / noise
Step 5: STOP   — trivial findings, 3 cycles, or user says "ship it"
```

**Adversarial reviewer prompt (must be hostile, not validating):**
```
Adversarial review. Find what is wrong with this artifact.
Assume the author is overconfident. Look for:
- Unstated assumptions
- Edge cases not handled
- Hidden coupling or shared state
- Ways the contract could be violated
- Failure modes under unexpected input

Do NOT validate. Do NOT summarize. Find issues only.

ARTIFACT: <paste artifact>
CONTRACT: <paste contract>
```

**Pass ARTIFACT + CONTRACT only — never pass the CLAIM** (biases toward agreement).

## Reconcile Findings (in precedence order)

1. **Contract misread** — reviewer flagged because CONTRACT was unclear → fix contract, re-classify
2. **Valid + actionable** — real issue requiring a change → change it, re-loop
3. **Valid trade-off** — real issue, cost of fixing exceeds acceptance → document the trade-off
4. **Noise** — reviewer lacked context you have → note it, move on

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'm confident, skip doubt" | Confidence correlates poorly with correctness on novel problems. |
| "I'll do doubt at the end with /review" | /review is post-hoc. Doubt-driven catches wrong directions early when course-correction is cheap. |
| "If I doubt every step I'll never ship" | The skill applies only to non-trivial decisions. Re-read "When NOT to use." |

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
