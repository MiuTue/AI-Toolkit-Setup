---
name: git-workflow-and-versioning
description: Structures git workflow. Use when making any code change — committing, branching, or organizing work.
---

# Git Workflow and Versioning

## Overview

Git is your safety net. Treat commits as save points, branches as sandboxes, history as documentation. Disciplined version control keeps AI-generated changes manageable, reviewable, and reversible.

## Core Principles

**Trunk-Based Development:** Keep `main` always deployable. Short-lived feature branches (1-3 days). Long-lived branches are hidden costs.

**Commit Early, Commit Often:** Each successful increment gets its own commit. Commits are save points.

**Atomic Commits:** Each commit does one logical thing. Don't mix formatting with behavior, or refactoring with features.

**Descriptive Messages:**
```
feat: add email validation to registration endpoint

Prevents invalid formats from reaching the database.
Uses Zod at route handler level, consistent with auth.ts patterns.
```

## Branch Naming

```
feature/<description>   fix/<description>
refactor/<description>  chore/<description>
```

## The Save Point Pattern

```
Make change → Test passes? → Commit → Continue
                          ↘ Fails?  → git reset --hard HEAD → Investigate
```

## Pre-Commit Checklist

```bash
git diff --staged                                          # review what you're committing
git diff --staged | grep -i "password\|secret\|api_key"   # no secrets
npm test && npm run lint && npx tsc --noEmit               # all checks pass
```

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'll commit when the feature is done" | Giant commits are impossible to review, debug, or revert. |
| "The message doesn't matter" | Messages are documentation. Future agents will need them. |

## Verification

- [ ] Commit does one logical thing
- [ ] Message explains the why, follows type conventions
- [ ] Tests pass before committing
- [ ] No secrets in the diff
- [ ] `.gitignore` covers `node_modules/`, `.env`, `dist/`

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
