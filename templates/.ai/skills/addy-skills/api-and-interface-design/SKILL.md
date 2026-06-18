---
name: api-and-interface-design
description: Guides stable API and interface design. Use when designing REST/GraphQL endpoints, module boundaries, component props, or any public interface.
---

# API and Interface Design

## Core Principles

**Hyrum's Law:** Every observable behavior will be depended on by somebody. Design implications: be intentional about what you expose, don't leak implementation details, plan for deprecation at design time.

**One-Version Rule:** Extend rather than fork. Design for a world where only one version exists at a time.

**Contract First:** Define the interface before implementing. The contract is the spec.

**Consistent Error Semantics:**
```typescript
interface APIError {
  error: {
    code: string;    // "VALIDATION_ERROR"
    message: string; // "Email is required"
    details?: unknown;
  };
}
// 400 invalid data | 401 unauthenticated | 403 forbidden | 404 not found
// 409 conflict | 422 validation | 500 server error (never expose internals)
```

**Validate at Boundaries — not inside:**
```typescript
// AT route handler (user input):
const result = CreateTaskSchema.safeParse(req.body);
if (!result.success) return res.status(422).json({ error: ... });
```

**Prefer Addition Over Modification:** New fields should be additive and optional. Never change field types or remove fields.

## REST Patterns

```
GET    /api/tasks          List tasks (query params for filtering)
POST   /api/tasks          Create a task
GET    /api/tasks/:id      Get single task
PATCH  /api/tasks/:id      Partial update
DELETE /api/tasks/:id      Delete task
```

Always paginate list endpoints:
```
GET /api/tasks?page=1&pageSize=20&sortBy=createdAt&sortOrder=desc
→ { data: [...], pagination: { page, pageSize, totalItems, totalPages } }
```

## Naming Conventions

| Pattern | Convention | Example |
|---------|-----------|---------|
| REST endpoints | Plural nouns, no verbs | `GET /api/tasks` |
| Query params | camelCase | `?sortBy=createdAt` |
| Boolean fields | is/has/can prefix | `isComplete`, `hasAttachments` |
| Enum values | UPPER_SNAKE | `"IN_PROGRESS"` |

## Verification

- [ ] Every endpoint has typed input and output schemas
- [ ] Errors follow a single consistent format
- [ ] Validation at system boundaries only
- [ ] List endpoints support pagination
- [ ] New fields are additive and optional

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
