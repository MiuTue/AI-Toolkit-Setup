---
name: documentation-and-adrs
description: Records decisions and documentation. Use when making architectural decisions, changing public APIs, or shipping features that need context documented for future engineers and agents.
---

# Documentation and ADRs

## Architecture Decision Records (ADRs)

Document the WHY, not just the what. ADRs capture context, constraints, and trade-offs that code cannot.

**When to write an ADR:** Choosing a framework, data model, auth strategy, API architecture, infrastructure. Any decision expensive to reverse.

**ADR Template** (store in `docs/decisions/ADR-NNN-title.md`):

```markdown
# ADR-001: Use PostgreSQL for primary database

## Status
Accepted

## Date
2025-01-15

## Context
[What situation led to needing a decision. What requirements/constraints exist.]

## Decision
[What was decided and why.]

## Alternatives Considered

### [Alternative 1]
- Pros: ...
- Cons: ...
- Rejected: [reason]

## Consequences
[What changes, what risks are accepted, what team needs to know.]
```

**Don't delete old ADRs.** When a decision changes, write a new ADR that supersedes the old one.

## Inline Documentation

**Comment the WHY, not the WHAT:**
```typescript
// BAD: restates code
// increment counter by 1
counter += 1;

// GOOD: explains non-obvious intent
// Uses sliding window (not fixed schedule) to prevent burst attacks at window edges
if (now - windowStart > WINDOW_SIZE_MS) { counter = 0; windowStart = now; }
```

**Never keep:** commented-out code, TODO comments >1 day old, comments restating the code.

**Always keep:** gotchas, non-obvious constraints, references to ADRs.

## README Must Cover

```markdown
# Project Name
[One-paragraph description]

## Quick Start
[clone, install, env setup, run dev]

## Commands
| Command | Description |
|---------|-------------|
| `npm run dev` | Start dev server |
| `npm test` | Run tests |

## Architecture
[Key decisions — link to ADRs]
```

## Verification

- [ ] ADRs exist for all significant architectural decisions
- [ ] README covers quick start, commands, architecture
- [ ] No commented-out code
- [ ] Rules files (CLAUDE.md etc.) are current and accurate

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
