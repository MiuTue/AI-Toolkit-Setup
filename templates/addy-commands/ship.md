---
description: Pre-launch checklist với parallel fan-out đến 3 personas → quyết định GO/NO-GO
---

Invoke the agent-skills:shipping-and-launch skill.

`/ship` là **fan-out orchestrator**. Chạy 3 specialist personas song song, sau đó merge reports thành quyết định GO/NO-GO duy nhất kèm rollback plan.

## Phase A — Parallel fan-out

Spawn 3 subagents đồng thời (issue cả 3 calls trong một turn):

1. **`code-reviewer`** — Five-axis review (correctness, readability, architecture, security, performance) trên staged changes hoặc recent commits.
2. **`security-auditor`** — Vulnerability và threat-model pass. OWASP Top 10, secrets, auth/authz, CVEs.
3. **`test-engineer`** — Phân tích test coverage. Gaps trong happy path, edge cases, error paths.

## Phase B — Merge

Tổng hợp findings từ 3 personas thành:
- Code Quality, Security, Performance, Accessibility, Infrastructure, Documentation

## Phase C — Quyết định

```markdown
## Ship Decision: GO | NO-GO

### Blockers (phải fix trước khi ship)
### Recommended fixes (nên fix)
### Acknowledged risks (ship mà biết risk)
### Rollback plan
- Trigger conditions: [signals nào kích hoạt rollback]
- Rollback steps: [các bước cụ thể]
```

**Rule:** Nếu bất kỳ persona nào return Critical finding → default NO-GO trừ khi user chấp nhận risk.
