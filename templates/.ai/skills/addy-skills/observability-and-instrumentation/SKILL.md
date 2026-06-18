---
name: observability-and-instrumentation
description: Instruments code so production behavior is visible and diagnosable. Use when shipping any feature that runs in production.
---

# Observability and Instrumentation

## Overview

Instrument as you build — the same way you write tests. A feature without telemetry makes the first bug an archaeology exercise.

## Before Instrumenting: Define "Working"

Write 2-4 questions an on-call engineer will ask about this feature. Every signal must answer one of them.

## Three Signals

| Signal | Answers | Example |
|---|---|---|
| Structured log | "What happened in this specific case?" | `payment_failed` with provider error code |
| Metric | "How often / how fast, in aggregate?" | p99 latency of provider calls |
| Trace | "Where did time go across services?" | One slow checkout broken down by hop |

Metrics tell you **that** something is wrong, traces tell you **where**, logs tell you **why**.

## Structured Logging

```typescript
// BAD: unqueryable
logger.info(`Payment ${id} failed for user ${userId}`);

// GOOD: structured
logger.warn({ event: 'payment_failed', paymentId: id, provider: 'stripe',
              errorCode: err.code, attempt: n }, 'payment failed');
```

**Log levels:** `error` (someone may need to act) | `warn` (degraded but handled) | `info` (business event) | `debug` (off in prod)

**Correlation IDs are mandatory.** Attach to every log line, span, and outbound call.

**Never log secrets, tokens, passwords, or full PII.**

## Metrics: RED for services

**R**ate (req/sec) · **E**rrors (failure rate) · **D**uration (latency histogram, p95/p99 — never averages)

**Cardinality rule:** Label only from small fixed sets (route template, status class, provider name). Never user IDs, raw URLs, or error messages as labels.

## Alerting: Alert on Symptoms, Not Causes

```
SYMPTOM (page-worthy):           CAUSE (dashboard, not a page):
error rate > 1% for 5 min        CPU at 85%
p99 latency > 2s                 one pod restarted
```

Every alert must be: actionable · linked to a runbook · threshold justified by data.

## Verification

- [ ] On-call questions written down, each signal maps to one
- [ ] All logs structured with stable event names + correlation ID
- [ ] No secrets or PII in logs (spot-check actual output)
- [ ] RED metrics for every new endpoint and external dependency
- [ ] Every new alert is symptom-based and has a runbook

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
