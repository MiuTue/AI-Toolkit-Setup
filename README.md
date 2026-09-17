# AI Setup Toolkit

Thiết lập agent hiện đại cho dự án: một `AGENTS.md` chung, skills theo chuẩn mở trong `.agents/skills`, và cấu hình subagent riêng khi Codex hoặc Antigravity cần.

Hỗ trợ chính: **Codex**, **Google Antigravity**, **Cursor**. Claude Code vẫn có thể nhận skills qua `--target claude`.

## Mô hình cài đặt

```text
my-project/
├── AGENTS.md                  # Chỉ dẫn chung cho agent
├── .agents/
│   ├── skills/                 # Workflow skills: SKILL.md + assets tùy chọn
│   └── agents/                 # Subagent Markdown cho Antigravity
├── .codex/
│   └── agents/                 # Subagent TOML cho Codex
└── plans/                      # Plan dài hạn, nếu dự án cần
```

`AGENTS.md` là lớp hướng dẫn chung, không phải nơi nhét toàn bộ workflow. Skills được agent tự nhận diện theo `description`, hoặc gọi rõ ràng bằng `$skill-name` trong Codex và `/skill-name` trong Antigravity.

## Cài đặt toolkit

```bash
git clone https://github.com/YOUR_USERNAME/ai-setup-toolkit.git ~/ai-setup-toolkit
cd ~/ai-setup-toolkit
chmod +x setup.sh
echo "alias ai-setup='$PWD/setup.sh'" >> ~/.zshrc
source ~/.zshrc
```

## Dùng trong một dự án

```bash
cd /path/to/my-project
ai-setup
```

Lệnh này không ghi đè `AGENTS.md`, `.agents/`, hoặc `.codex/` đã tồn tại. Bản cài mặc định gồm 6 workflow skills (`plan-feature`, `implement-plan`, `fix-bug`, `review-change`, `verify-change`, `update-docs`), 24 skills Addy Osmani đã cache, cùng profile `reviewer` và `researcher` cho Codex/Antigravity.

## Thêm skills theo nhu cầu

```bash
# Cài vào .agents/skills của dự án hiện tại — mặc định
ai-setup skill bundle:essential

# Cài một skill cụ thể
ai-setup skill security-and-hardening

# Xem danh sách skills
ai-setup skill --list

# Chỉ cài cho Claude Code ở user scope
ai-setup skill code-review-and-quality --target claude
```

Không cài toàn bộ catalog community vào mọi dự án: số lượng skills lớn làm danh sách discovery bị cắt ngắn và gây nhiễu context. Chỉ cài skill cần cho stack, domain và workflow thực tế.

## Workflow khuyến nghị

```text
plan-feature → implement-plan → verify-change → review-change → update-docs
                         └── fix-bug khi có lỗi
```

Skills thay cho workflow Markdown cũ. Antigravity đang chuyển Workflows sang Agent Skills; skill vẫn có thể được gọi như slash command.

## Khi nào dùng plugin

Đặt skill riêng của repository trong `.agents/skills/`. Chỉ đóng gói plugin khi cần chia sẻ workflow ổn định cho team, gom nhiều skills, hoặc kèm MCP/connector. Với Codex, dùng `$plugin-creator`; không cần plugin chỉ để cài một skill nội bộ.

## Ghi chú cho từng công cụ

- **Codex:** đọc `AGENTS.md`, quét `.agents/skills`, và nhận custom subagent từ `.codex/agents/*.toml`.
- **Antigravity:** đọc `AGENTS.md`, quét `.agents/skills`; custom subagent đặt tại `.agents/agents/`.
- **Cursor:** dùng `AGENTS.md` cho quy tắc chung; chỉ tạo `.cursor/rules/` khi cần scope theo thư mục hoặc glob. Không tạo `.cursorrules` mới.
- **Claude Code:** dùng `CLAUDE.md` và `.claude/skills/`; target `claude` giữ tương thích cho trường hợp này.

## Tài liệu chính thức

- [Codex: AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
- [Codex: Skills](https://learn.chatgpt.com/docs/build-skills)
- [Antigravity: Skills](https://antigravity.google/docs/skills)
- [Antigravity: Workflows to Skills](https://antigravity.google/docs/migration/workflows-to-skills)
