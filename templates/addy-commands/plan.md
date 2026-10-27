---
description: Phân rã spec thành tasks nhỏ, verifiable với acceptance criteria và thứ tự phụ thuộc
---

Invoke the agent-skills:planning-and-task-breakdown skill.

Đọc spec hiện có (SPEC.md hoặc tương đương) và các phần codebase liên quan. Sau đó:

1. Vào plan mode — chỉ đọc, không thay đổi code
2. Xác định dependency graph giữa các components
3. Slice theo chiều dọc (một complete path mỗi task, không phải horizontal layers)
4. Viết tasks với acceptance criteria và verification steps
5. Thêm checkpoints giữa các phases
6. Present plan để human review

Lưu plan vào tasks/plan.md và task list vào tasks/todo.md.
