---
name: ci-cd-and-automation
description: Automates CI/CD pipeline setup. Use when setting up or modifying build/deployment pipelines, quality gates, or deployment strategies.
---

# CI/CD and Automation

## The Quality Gate Pipeline

Every PR goes through:
```
Lint → Type Check → Unit Tests → Build → Integration → Security Audit → Bundle Size
```
No gate can be skipped. Fix the issue — don't disable the check.

## GitHub Actions: Basic CI

```yaml
name: CI
on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '22', cache: 'npm' }
      - run: npm ci
      - run: npm run lint
      - run: npx tsc --noEmit
      - run: npm test -- --coverage
      - run: npm run build
      - run: npm audit --audit-level=high
```

## Feature Flags

Decouple deployment from release. Deploy behind a flag, enable when ready, roll back by disabling:
```typescript
if (featureFlags.isEnabled('new-feature', { userId })) {
  return <NewFeature />;
}
return <LegacyFeature />;
```
**Flag lifecycle:** Create → Enable for team → Canary → Full rollout → **Remove within 2 weeks**

## Deployment Strategy

```
PR merged → Staging (auto) → Manual verification → Production (manual/auto)
                                                  → Monitor 15 min window
                                                  → Errors? Rollback
```

## CI Optimization (if pipeline > 10 min)

1. Cache dependencies (`actions/cache`)
2. Parallel jobs (split lint/typecheck/test/build)
3. Path filters (skip e2e for docs-only PRs)
4. Shard test suites across runners

## Verification

- [ ] All quality gates present (lint, types, tests, build, audit)
- [ ] Pipeline runs on every PR and push to main
- [ ] Failures block merge (branch protection)
- [ ] Secrets in secrets manager, not in code
- [ ] Deployment has a rollback mechanism

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
