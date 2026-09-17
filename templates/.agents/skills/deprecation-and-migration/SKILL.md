---
name: deprecation-and-migration
description: Manages deprecation and migration. Use when removing old systems, APIs, or features, or migrating users from one implementation to another.
---

# Deprecation and Migration

## Core Principle

**Code is a liability, not an asset.** Every line has ongoing maintenance cost. Deprecation is the discipline of removing code that no longer earns its keep.

## The Deprecation Decision

Before deprecating, answer:
1. Does this system still provide unique value?
2. How many consumers depend on it? (quantify scope)
3. Does a replacement exist? (build first, then deprecate)
4. What's the migration cost vs ongoing maintenance cost?

## Advisory vs Compulsory

| Type | When | Mechanism |
|------|------|-----------|
| **Advisory** | Old system is stable | Warnings, docs. Users migrate on their own timeline. |
| **Compulsory** | Security risk, blocking progress | Hard deadline. Must provide migration tooling. |

Default to advisory. Use compulsory only when maintenance cost justifies forcing migration.

## Migration Process

**Step 1: Build the replacement first** — proven in production, covers all critical use cases.

**Step 2: Announce and document:**
```markdown
## Deprecation Notice: OldService
Status: Deprecated as of 2025-03-01
Replacement: NewService (see migration guide below)
Reason: [specific reason]

### Migration Guide
1. Replace import...
2. Update config...
3. Run verification: `npx migrate-check`
```

**Step 3: Migrate incrementally** — one consumer at a time, verify each, remove old references.

**Step 4: Remove** — Only after zero active usage verified by metrics/logs.

## Migration Patterns

**Strangler:** Run old and new in parallel. Route traffic incrementally (0% → 10% → 50% → 100%). Remove old when 0%.

**Adapter:** Wrap new implementation behind old interface so consumers don't need to change immediately.

**Zombie Code Rule:** Code no one owns but people depend on must either get an owner or get removed. It cannot stay in limbo.

## Verification

- [ ] Replacement is production-proven
- [ ] Migration guide with concrete steps exists
- [ ] All active consumers migrated (verified by metrics/logs)
- [ ] Old code, tests, docs fully removed
- [ ] No references to deprecated system remain

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
