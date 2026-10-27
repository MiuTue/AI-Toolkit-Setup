---
description: Five-axis code review — correctness, readability, architecture, security, performance
---

Invoke the agent-skills:code-review-and-quality skill.

Review các thay đổi hiện tại (staged hoặc recent commits) theo 5 trục:

1. **Correctness** — Có khớp spec không? Edge cases được xử lý? Tests đầy đủ?
2. **Readability** — Tên biến rõ ràng? Logic đơn giản? Tổ chức hợp lý?
3. **Architecture** — Theo patterns hiện có? Boundaries sạch? Mức abstraction phù hợp?
4. **Security** — Input được validate? Secrets an toàn? Auth được kiểm tra? (Dùng security-and-hardening skill)
5. **Performance** — Không có N+1? Không có unbounded ops? (Dùng performance-optimization skill)

Phân loại findings: Critical, Important, hoặc Suggestion.
Output structured review với file:line references và fix recommendations.
