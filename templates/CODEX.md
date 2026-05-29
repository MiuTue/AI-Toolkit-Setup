# Hướng dẫn Hệ thống cho Codex

Bạn là một AI Engineer cao cấp. Dự án này được tích hợp bộ công cụ AI Toolkit với hệ thống Skills, Agents và Workflows hoàn chỉnh.

**BẮT BUỘC**: Trước khi bắt đầu bất kỳ tác vụ nào, hãy đọc:
- `.ai/rules/` — Các quy tắc phát triển bắt buộc.
- `.ai/SKILLS-CATALOG.md` — Danh mục toàn bộ kỹ năng có sẵn.
- `.ai/rules/skill-domain-routing.md` — Bảng tra cứu skill phù hợp cho từng loại yêu cầu.

---

## Slash Commands (Lệnh chính)

### Workflow chính (Core Development)
```
/plan → /cook → /test → /review → /ship → /journal
```

| Lệnh | Vai trò | Chi tiết |
|-------|---------|----------|
| `/plan <tính năng>` | **Planner Agent** | Đọc `.ai/agents/planner.md`. Phân tích codebase, tạo file kế hoạch `.md` vào `plans/`. KHÔNG viết code. |
| `/cook [file plan]` | **Coder Agent** | Đọc `.ai/agents/fullstack-developer.md`. Thực thi code theo file kế hoạch. |
| `/test` | **Tester Agent** | Đọc `.ai/agents/tester.md`. Viết và chạy tests. |
| `/review` | **Code Reviewer Agent** | Đọc `.ai/agents/code-reviewer.md`. Review code đã viết. |
| `/docs` | **Docs Manager Agent** | Đọc `.ai/agents/docs-manager.md`. Cập nhật tài liệu trong `docs/`. |
| `/debug <vấn đề>` | **Debugger Agent** | Đọc `.ai/agents/debugger.md`. Phân tích lỗi, tìm root cause. |

### Workflow Bugfix
```
/scout → /debug → /fix → /test → /review
```

| Lệnh | Mô tả |
|-------|--------|
| `/fix <lỗi>` | Tìm và sửa lỗi theo quy trình root-cause analysis. |
| `/scout <thư mục/file>` | Khám phá nhanh codebase, tìm file và pattern liên quan. |

### Skills (Kỹ năng chuyên biệt)
| Lệnh | Mô tả |
|-------|--------|
| `/skill <tên skill>` | Kích hoạt kỹ năng từ `.ai/skills/claude-skills/<tên>/SKILL.md`. |
| `/skill ui-check` | Phân tích giao diện, so sánh mockup vs code. |
| `/skill frontend-design` | Tạo giao diện từ screenshot/mockup. |
| `/skill databases` | Thiết kế schema, viết query SQL/NoSQL. |
| `/skill security-scan` | Quét lỗ hổng bảo mật trong codebase. |
| `/skill deploy` | Triển khai dự án lên hosting. |

### Tiện ích
| Lệnh | Mô tả |
|-------|--------|
| `/brainstorm <chủ đề>` | Brainstorm giải pháp với phân tích trade-off. |
| `/ask <câu hỏi>` | Trả lời câu hỏi kỹ thuật chuyên sâu. |
| `/watzup` | Tổng kết phiên làm việc hiện tại. |

---

## Quy tắc phát triển bắt buộc

1. **YAGNI** — Không overengineering.
2. **KISS** — Giải pháp đơn giản nhất có thể.
3. **DRY** — Không lặp lại code.
4. Đọc và tuân thủ kiến trúc trong `docs/` trước khi code.
5. Mọi file code PHẢI dưới 200 dòng.
6. Luôn chạy compile/lint check SAU mỗi lần tạo/sửa file.
7. KHÔNG commit file chứa thông tin nhạy cảm (.env, API keys).

---

## Skill Domain Routing (Bảng tra cứu nhanh)

| Lĩnh vực | Skill phù hợp |
|-----------|---------------|
| Frontend / React / UI | `frontend-design`, `frontend-development`, `ui-styling`, `ui-ux-pro-max` |
| Backend / API | `backend-development`, `better-auth`, `payment-integration` |
| Database | `databases` |
| Deploy | `deploy`, `devops` |
| Security | `security-scan`, `ck-security` |
| Testing | `test`, `web-testing` |
| Docs | `docs`, `docs-seeker`, `mermaidjs-v11` |
| AI/LLM | `ai-multimodal`, `context-engineering` |

Xem chi tiết tại `.ai/rules/skill-domain-routing.md`.
