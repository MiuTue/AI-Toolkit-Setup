---
name: context-engineering
description: Optimizes agent context setup. Use when starting a new session, when agent output quality degrades, or when switching between tasks.
---

# Context Engineering

## Overview

Feed agents the right information at the right time. Too little = hallucination. Too much = lost focus. Context is the single biggest lever for agent output quality.

## Context Hierarchy (most → least persistent)

```
1. Rules Files (CLAUDE.md)     ← Always loaded, project-wide
2. Spec / Architecture Docs    ← Loaded per feature/session
3. Relevant Source Files       ← Loaded per task
4. Error Output / Test Results ← Loaded per iteration
5. Conversation History        ← Accumulates, compacts
```

## Level 1: Rules File (Highest Leverage)

Create `CLAUDE.md` (or `.cursorrules`, `AGENTS.md`) covering:
- Tech stack with exact versions
- Full build/test/lint/dev commands
- Code conventions with one real example
- Boundaries: Never / Ask first / Always

## Context Packing Strategies

**Brain Dump** — at session start, structured block:
```
PROJECT CONTEXT:
- Building [X] using [tech stack]
- Relevant spec: [excerpt]
- Files involved: [list]
- Known gotchas: [list]
```

**Selective Include** — only what's relevant to the current task. Aim for <2,000 lines of focused context per task.

## Anti-Patterns

| Anti-Pattern | Fix |
|---|---|
| Context starvation | Load rules file + relevant source files before each task |
| Context flooding (>5,000 lines) | Include only task-relevant content |
| Stale context | Start fresh sessions when switching major features |
| Missing examples | Include one example of the pattern to follow |

## Verification

- [ ] Rules file exists covering tech stack, commands, conventions, boundaries
- [ ] Agent output follows patterns in the rules file
- [ ] No hallucinated APIs or imports
- [ ] Context refreshed when switching major tasks

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
