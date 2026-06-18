---
name: performance-optimization
description: Optimizes application performance. Use when performance requirements exist, Core Web Vitals need improvement, or profiling reveals bottlenecks. Measure first.
---

# Performance Optimization

## Core Web Vitals Targets

| Metric | Good | Poor |
|--------|------|------|
| LCP (Largest Contentful Paint) | ≤ 2.5s | > 4.0s |
| INP (Interaction to Next Paint) | ≤ 200ms | > 500ms |
| CLS (Cumulative Layout Shift) | ≤ 0.1 | > 0.25 |

## Workflow: Always Measure First

```
1. MEASURE  → Establish baseline with real data
2. IDENTIFY → Find the actual bottleneck (not assumed)
3. FIX      → Address the specific bottleneck
4. VERIFY   → Measure again, confirm improvement
5. GUARD    → Add monitoring/tests to prevent regression
```

**Never optimize without measurement.** Premature optimization adds complexity without improving what matters.

## Common Anti-Patterns

**N+1 Queries (Backend):**
```typescript
// BAD: N+1
for (const task of tasks) {
  task.owner = await db.users.findUnique({ where: { id: task.ownerId } });
}
// GOOD: Include
const tasks = await db.tasks.findMany({ include: { owner: true } });
```

**Unbounded Fetching:**
```typescript
// GOOD: Paginated
const tasks = await db.tasks.findMany({ take: 20, skip: (page - 1) * 20 });
```

**Unnecessary React Re-renders:**
```tsx
// BAD: new object every render
<TaskFilters options={{ sortBy: 'date' }} />
// GOOD: stable reference
const DEFAULT_OPTIONS = { sortBy: 'date' } as const;
<TaskFilters options={DEFAULT_OPTIONS} />
```

**Images without optimization:**
```html
<img src="/hero.jpg" width="1200" height="600" fetchpriority="high" alt="..." />
<!-- below fold: -->
<img loading="lazy" decoding="async" ... />
```

## Verification

- [ ] Before and after measurements exist (specific numbers)
- [ ] Specific bottleneck identified and addressed
- [ ] Core Web Vitals within "Good" thresholds
- [ ] No N+1 queries in new data fetching code
- [ ] Existing tests still pass

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
