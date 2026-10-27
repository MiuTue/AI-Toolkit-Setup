---
description: Đơn giản hóa code để clarity và maintainability — giảm complexity mà không thay đổi behavior
---

Invoke the agent-skills:code-simplification skill.

Đơn giản hóa code đã thay đổi gần đây (hoặc scope được chỉ định) trong khi giữ nguyên exact behavior:

1. Đọc CLAUDE.md và study project conventions
2. Xác định target code — recent changes trừ khi scope rộng hơn được chỉ định
3. Hiểu purpose, callers, edge cases, và test coverage trước khi chỉnh
4. Scan cơ hội đơn giản hóa:
   - Deep nesting → guard clauses hoặc extracted helpers
   - Long functions → split theo responsibility
   - Nested ternaries → if/else hoặc switch
   - Generic names → tên mô tả
   - Duplicated logic → shared functions
   - Dead code → xóa sau khi xác nhận
5. Apply từng simplification incrementally — chạy tests sau mỗi thay đổi
6. Verify tất cả tests pass, build thành công, và diff sạch
