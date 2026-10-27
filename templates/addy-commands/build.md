---
description: Implement tasks theo từng slice — build, test, verify, commit. Thêm "auto" để chạy toàn plan trong một lần approved.
---

Invoke the agent-skills:incremental-implementation skill cùng agent-skills:test-driven-development.

## Modes

- **`/build`** — implement *task tiếp theo* đang pending, rồi dừng (cẩn thận, từng slice một).
- **`/build auto`** — tạo plan nếu cần, lấy một lần approval, rồi implement *mọi task* mà không dừng giữa chừng.

`$ARGUMENTS` chọn mode. Treat `auto` hoặc `all` là autonomous mode; còn lại là single-task mode.

## Default: một task

Chọn task pending tiếp theo từ plan. Sau đó:

1. Đọc acceptance criteria của task
2. Load context liên quan (code hiện có, patterns, types)
3. Viết failing test cho behavior mong đợi (RED)
4. Implement code tối thiểu để pass test (GREEN)
5. Chạy toàn bộ test suite để kiểm tra regressions
6. Chạy build để verify compilation
7. Commit với message mô tả
8. Đánh dấu task complete và dừng

## Autonomous: toàn bộ plan (`/build auto`)

1. **Yêu cầu spec.** Tìm SPEC.md ở root, docs/SPEC.md, hoặc file trong spec/. Nếu không có, dừng và yêu cầu chạy /spec trước.
2. **Baseline sạch.** Chạy `git status --porcelain`. Nếu có uncommitted changes không liên quan, hỏi cách xử lý.
3. **Plan nếu cần.** Nếu không có tasks/plan.md, invoke planning-and-task-breakdown.
4. **Single checkpoint.** Present full plan và chờ affirmative rõ ràng. Đây là gate duy nhất.
5. **Execute mọi task theo thứ tự dependency.** Mỗi task: RED→GREEN→regression→build→commit→mark complete.
6. **Dừng và hỏi** khi: test không pass, build bị break, spec mơ hồ, hoặc task high-risk/irreversible.
