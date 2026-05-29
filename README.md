# AI Setup Toolkit

Bộ công cụ tự động thiết lập môi trường AI Engineer cho mọi dự án.  
Hỗ trợ: **Codex** | **Antigravity** | **Cursor IDE**

## ✨ Tính năng

- **82+ Skills** tích hợp sẵn (frontend-design, databases, deploy, security-scan, ai-multimodal...)
- **14 Agents** chuyên biệt (Planner, Fullstack Developer, Tester, Debugger, Code Reviewer, Docs Manager...)
- **7 bộ Rules** điều khiển workflow (primary-workflow, orchestration-protocol, skill-domain-routing...)
- **3 Plan Templates** chuẩn (Feature, Bug Fix, Refactor)
- **Slash Commands** (`/plan`, `/cook`, `/test`, `/review`, `/skill`, `/debug`, `/fix`, `/brainstorm`...)
- Một lệnh setup duy nhất, dùng được ngay trên cả 3 công cụ AI

## 🚀 Cài đặt (1 lần duy nhất)

### Cách 1: Alias (Khuyến nghị)

```bash
# Clone repo về máy (bạn có thể clone vào bất kỳ đâu, ví dụ ~/ai-setup-toolkit)
git clone https://github.com/YOUR_USERNAME/ai-setup-toolkit.git ~/ai-setup-toolkit

# Di chuyển vào thư mục vừa clone
cd ~/ai-setup-toolkit

# Thêm alias vào shell config bằng đường dẫn tuyệt đối của thư mục hiện tại (hỗ trợ đường dẫn có dấu cách)
echo "alias ai-setup=\"'$PWD/setup.sh'\"" >> ~/.zshrc

# Reload shell
source ~/.zshrc
```

### Cách 2: Chạy trực tiếp

```bash
git clone https://github.com/YOUR_USERNAME/ai-setup-toolkit.git ~/ai-setup-toolkit
chmod +x ~/ai-setup-toolkit/setup.sh
```

## 📦 Sử dụng trên dự án

```bash
cd /path/to/my-project
ai-setup
# Hoặc: ~/ai-setup-toolkit/setup.sh
```

Lệnh trên sẽ tự động tạo:

```
my-project/
├── .ai/                          # Hệ sinh thái AI dùng chung
│   ├── agents/                   # 14 agent (planner.md, fullstack-developer.md, tester.md...)
│   ├── skills/claude-skills/     # 82+ skills (frontend-design, databases, deploy...)
│   ├── rules/                    # 7 bộ rules (workflow, orchestration, development...)
│   └── SKILLS-CATALOG.md         # Danh mục tra cứu nhanh
├── docs/                         # Tài liệu kiến trúc dự án
├── plans/                        # Nơi lưu file kế hoạch
│   └── templates/                # 3 plan templates (feature, bug-fix, refactor)
├── CODEX.md                      # System prompt cho Codex
├── GEMINI.md                     # System prompt cho Antigravity
└── .cursorrules                  # Rules cho Cursor IDE
```

## 🎯 Slash Commands Reference

### Core Workflow
```
/plan → /cook → /test → /review → /docs
```

| Lệnh | Mô tả | Dùng trên |
|-------|--------|-----------|
| `/plan <tính năng>` | Lên kế hoạch chi tiết | Codex, Antigravity |
| `/cook [file plan]` | Viết code theo plan | Codex, Cursor, Antigravity |
| `/test` | Viết & chạy test | Codex, Cursor |
| `/review` | Review code quality | Codex, Cursor, Antigravity |
| `/fix <lỗi>` | Sửa lỗi nhanh | Codex, Cursor |
| `/debug <vấn đề>` | Phân tích root cause | Codex, Antigravity |
| `/docs` | Cập nhật tài liệu | Codex, Antigravity |

### Skills
| Lệnh | Mô tả |
|-------|--------|
| `/skill frontend-design` | Tạo UI từ mockup/screenshot |
| `/skill ui-ux-pro-max` | Thiết kế UI/UX chuyên sâu |
| `/skill databases` | Schema, queries, migrations |
| `/skill deploy` | Deploy lên hosting |
| `/skill security-scan` | Quét lỗ hổng bảo mật |
| `/skill ai-multimodal` | Phân tích ảnh/video/audio |

### Tiện ích
| Lệnh | Mô tả |
|-------|--------|
| `/brainstorm <chủ đề>` | Brainstorm + trade-off |
| `/ask <câu hỏi>` | Hỏi kỹ thuật chuyên sâu |
| `/watzup` | Tổng kết phiên làm việc |
| `/journal` | Viết journal kỹ thuật |

## 📋 Ví dụ sử dụng thực tế

### Thêm tính năng mới
```
1. Mở Antigravity/Codex → /plan Thêm hệ thống thanh toán Stripe
2. AI tạo file plans/20260529-stripe-payment.md
3. Mở Cursor → mở file plan → /cook
4. Cursor tự động code theo từng bước trong plan
5. Gõ /test → AI viết test
6. Gõ /review → AI review code
```

### Sửa lỗi
```
1. Mở Codex → /debug Lỗi không login được trên mobile
2. AI phân tích root cause
3. /fix → AI đề xuất và sửa lỗi
4. /test → Chạy lại test suite
```

### Gọi Skill đặc biệt
```
1. Mở Antigravity → /skill frontend-design [kèm ảnh mockup]
2. AI phân tích mockup và tạo component React
3. /skill databases → AI thiết kế schema cho tính năng
```

## 📄 License

MIT License
