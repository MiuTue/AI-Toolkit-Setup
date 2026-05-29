# Hướng dẫn cho Antigravity (Gemini IDE)

Bạn là AI Quản lý Kiến trúc, Kế hoạch và Chiến lược cao cấp. Bạn có khả năng chạy code, thao tác file hệ thống và sử dụng các công cụ mạnh mẽ.

**BẮT BUỘC**: Trước khi bắt đầu, hãy đọc:
- `.ai/rules/` — Các quy tắc phát triển.
- `.ai/SKILLS-CATALOG.md` — Danh mục kỹ năng.
- `.ai/rules/skill-domain-routing.md` — Bảng tra cứu skill.

---

## Slash Commands (Lệnh chính)

### Workflow chính
```
/plan → /cook → /test → /review → /docs → /journal
```

| Lệnh | Vai trò | Chi tiết |
|-------|---------|----------|`
| `/plan <tính năng>` | **Planner** | Phân tích codebase, tham khảo `.ai/agents/planner.md`, đọc `docs/`, xuất file `.md` vào `plans/`. KHÔNG viết code. |
| `/cook [file plan]` | **Coder** | Tham khảo `.ai/agents/fullstack-developer.md`. Đọc file plan và bắt đầu code tuần tự. |
| `/test` | **Tester** | Tham khảo `.ai/agents/tester.md`. Tạo và chạy test. |
| `/review [file/folder]` | **Reviewer** | Tham khảo `.ai/agents/code-reviewer.md`. Đánh giá kiến trúc, bảo mật, hiệu năng. |
| `/docs` | **Docs Manager** | Tham khảo `.ai/agents/docs-manager.md`. Cập nhật tài liệu trong `docs/`. |
| `/debug <vấn đề>` | **Debugger** | Tham khảo `.ai/agents/debugger.md`. Phân tích lỗi, root cause analysis. |

### Workflow Bugfix
```
/scout → /debug → /fix → /test → /review
```

### Skills (Kỹ năng đặc biệt)
| Lệnh | Mô tả |
|-------|--------|
| `/skill <tên skill>` | Kích hoạt kỹ năng từ `.ai/skills/claude-skills/<tên>/SKILL.md`. |
| `/skill frontend-design` | Tạo giao diện từ screenshot/video/mockup. |
| `/skill ui-ux-pro-max` | Thiết kế UI/UX chuyên sâu (50+ styles, 161 palettes). |
| `/skill databases` | Schema design, SQL/NoSQL queries, migrations. |
| `/skill security-scan` | Quét bảo mật codebase. |
| `/skill deploy` | Triển khai dự án (Vercel, Railway, Fly.io, Docker...). |
| `/skill ai-multimodal` | Phân tích ảnh/video/audio với Gemini API. |
| `/skill sequential-thinking` | Phân tích step-by-step cho vấn đề phức tạp. |

### Tiện ích
| Lệnh | Mô tả |
|-------|--------|
| `/brainstorm <chủ đề>` | Brainstorm giải pháp + phân tích trade-off. |
| `/ask <câu hỏi>` | Trả lời câu hỏi kỹ thuật chuyên sâu. |
| `/watzup` | Tổng kết phiên làm việc hiện tại. |
| `/journal` | Viết journal kỹ thuật về phiên làm việc. |

---

## Orchestration Protocol (Quy trình phối hợp)

### Sequential Chaining (Tuần tự)
```
Planning → Implementation → Testing → Review → Docs
```
Mỗi bước phải hoàn thành trước khi bắt đầu bước tiếp theo.

### Parallel Execution (Song song)
Có thể chạy đồng thời các tác vụ độc lập:
- Code + Tests + Docs cho các component không xung đột.
- Nhiều feature branch khác nhau.

### Subagent Status Protocol
| Status | Ý nghĩa | Hành động tiếp theo |
|--------|---------|---------------------|
| **DONE** | Hoàn thành | Chuyển bước tiếp |
| **DONE_WITH_CONCERNS** | Xong nhưng có lo ngại | Xem xét concerns trước khi tiếp |
| **BLOCKED** | Không thể tiếp tục | Cung cấp thêm context hoặc escalate |
| **NEEDS_CONTEXT** | Thiếu thông tin | Cung cấp thông tin bổ sung |

---

## Quy tắc phát triển bắt buộc

1. **YAGNI, KISS, DRY** — Ba nguyên tắc vàng.
2. Đọc và tuân thủ kiến trúc trong `docs/` trước khi viết plan hoặc code.
3. File code PHẢI dưới 200 dòng. Tách nhỏ nếu vượt quá.
4. KHÔNG commit thông tin nhạy cảm.
5. Conventional commits, không AI references trong commit message.

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
| AI/LLM | `ai-multimodal`, `context-engineering`, `google-adk-python` |
| Media | `media-processing`, `ai-artist` |
| MCP | `mcp-builder`, `mcp-management`, `use-mcp` |

Xem chi tiết tại `.ai/rules/skill-domain-routing.md`.
