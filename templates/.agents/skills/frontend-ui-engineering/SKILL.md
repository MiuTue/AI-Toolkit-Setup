---
name: frontend-ui-engineering
description: Builds production-quality UIs. Use when building or modifying user-facing interfaces — components, layouts, state management, accessibility.
---

# Frontend UI Engineering

## Component Architecture

- Colocate everything: `TaskList.tsx`, `TaskList.test.tsx`, `use-task-list.ts` in same folder
- Prefer composition over configuration
- Separate data fetching (container) from presentation (display)

## Avoid the AI Aesthetic

| AI Default | Problem | Production Quality |
|---|---|---|
| Purple/indigo everything | Every app looks identical | Use project's actual color palette |
| Excessive gradients | Visual noise | Subtle gradients matching design system |
| Rounded everything | Ignores hierarchy | Consistent border-radius from design system |
| Equal generous padding everywhere | Destroys visual hierarchy | Consistent spacing scale |

## State Management (choose simplest that works)

```
useState       → Component-specific UI state
Lifted state   → Shared between 2-3 siblings
Context        → Theme, auth, locale (read-heavy)
URL state      → Filters, pagination (shareable)
React Query    → Remote data with caching
Zustand        → Complex shared client state
```

## Accessibility (WCAG 2.1 AA — non-negotiable)

```tsx
// Always prefer <button> over div with onClick
<button onClick={handleClick}>Click</button>  // ✓
<div onClick={handleClick}>Click</div>         // ✗

// Label interactive elements
<button aria-label="Close dialog"><XIcon /></button>

// Empty states must exist
if (tasks.length === 0) return <EmptyState message="No tasks" />;
```

**Keyboard test:** Tab through every page. Every interactive element must be reachable.

## Responsive Design

```tsx
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
```

Test at: 320px, 768px, 1024px, 1440px.

## Verification

- [ ] Renders without console errors
- [ ] All interactive elements keyboard accessible
- [ ] Responsive: works at 320px–1440px
- [ ] Loading, error, and empty states handled
- [ ] Follows project design system (spacing, colors, typography)
- [ ] No accessibility warnings in DevTools / axe-core

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
