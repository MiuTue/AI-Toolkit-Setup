---
description: TDD workflow — viết failing tests trước, implement, verify. Với bugs dùng Prove-It pattern.
---

Invoke the agent-skills:test-driven-development skill.

Với tính năng mới:
1. Viết tests mô tả behavior mong đợi (phải FAIL)
2. Implement code để pass chúng
3. Refactor trong khi giữ tests green

Với bug fixes (Prove-It pattern):
1. Viết test reproduce lại bug (phải FAIL)
2. Xác nhận test fail
3. Implement fix
4. Xác nhận test pass
5. Chạy full test suite để kiểm tra regressions

Với browser-related issues, cũng invoke agent-skills:browser-testing-with-devtools
để verify với Chrome DevTools MCP.
