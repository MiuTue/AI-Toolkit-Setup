---
name: shipping-and-launch
description: Prepares production launches. Use when deploying to production, setting up monitoring, planning staged rollouts, or building a rollback strategy.
---

# Shipping and Launch

## Pre-Launch Checklist

**Code:** All tests pass · build succeeds · lint & types pass · reviewed · no debug console.logs

**Security:** No secrets in code · `npm audit` clean · input validation · auth checks · security headers · rate limiting on auth · CORS not wildcard

**Performance:** Core Web Vitals in "Good" · no N+1 · images optimized · bundle in budget · DB indexes

**Accessibility:** Keyboard navigation · screen reader works · WCAG 2.1 AA contrast · focus management

**Infrastructure:** Env vars set · DB migrations applied · health check endpoint · logging configured

## Feature Flag Lifecycle

```
1. DEPLOY with flag OFF       → Code in production but inactive
2. ENABLE for team/beta       → Internal testing in prod
3. GRADUAL ROLLOUT            → 5% → 25% → 50% → 100%
4. MONITOR at each stage      → Watch errors, latency, business metrics
5. CLEAN UP within 2 weeks    → Remove flag and dead code
```

## Rollout Decision Thresholds

| Metric | Advance ✅ | Hold ⚠️ | Roll back 🔴 |
|--------|------------|---------|-------------|
| Error rate | Within 10% of baseline | 10–100% above | >2x baseline |
| P95 latency | Within 20% of baseline | 20–50% above | >50% above |
| Business metrics | Neutral or positive | Decline <5% | Decline >5% |

## Rollback Plan Template

```markdown
## Rollback Plan for [Feature]

### Trigger Conditions
- Error rate > 2x baseline OR P95 latency > [X]ms

### Rollback Steps
1. Disable feature flag (< 1 min)  OR
1. Deploy previous version (< 5 min)
2. Verify: health check + error monitoring
3. Notify team

### Time to Rollback
- Feature flag: < 1 minute
- Redeploy: < 5 minutes
- DB rollback: < 15 minutes
```

## Post-Launch (first hour)

- [ ] Health endpoint returns 200
- [ ] Error rate normal
- [ ] Latency normal  
- [ ] Critical user flow works manually
- [ ] Logs flowing and readable

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
