---
name: source-driven-development
description: Grounds every implementation decision in official documentation. Use when building with any framework or library where correctness matters.
---

# Source-Driven Development

## Overview

Every framework-specific decision must be backed by official documentation. Training data goes stale. This skill ensures code traces to authoritative sources the user can verify.

## Process

```
DETECT stack → FETCH official docs → IMPLEMENT following docs → CITE sources
```

**Step 1: Detect Stack** — Read `package.json` (or equivalent) for exact versions. State findings:
```
STACK DETECTED:
- React 19.1.0 (from package.json)
- Vite 6.2.0
→ Fetching official docs for relevant patterns.
```

**Step 2: Source Hierarchy**
1. Official documentation (react.dev, docs.djangoproject.com)
2. Official blog / changelog
3. Web standards references (MDN, web.dev)

Never cite: Stack Overflow, blog posts, AI-generated docs, training data.

**Step 3: Implement** — Use API signatures from docs, not memory. If docs deprecate a pattern, don't use it.

**Step 4: Cite** — Every framework-specific pattern gets a citation:
```typescript
// React 19 form handling with useActionState
// Source: https://react.dev/reference/react/useActionState#usage
const [state, formAction, isPending] = useActionState(submitOrder, initialState);
```

If you cannot find docs for a pattern:
```
UNVERIFIED: Could not find official documentation for this pattern.
This is based on training data and may be outdated. Verify before production.
```

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'm confident about this API" | Confidence is not evidence. Training data contains outdated patterns. |
| "Fetching docs wastes tokens" | Hallucinating an API wastes more — user debugs for hours. |

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
