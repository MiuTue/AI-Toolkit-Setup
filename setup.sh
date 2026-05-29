#!/bin/bash

# ============================================================
# AI Setup Toolkit — Codex / Antigravity / Cursor
# Tự động thiết lập toàn bộ hệ sinh thái Skills, Agents,
# Rules, Workflow và Plan Templates cho dự án bất kỳ.
# ============================================================

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║   🚀 AI Setup Toolkit — Codex / Antigravity / Cursor  ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# Get the directory where setup.sh is located
TOOLKIT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="${TOOLKIT_DIR}/templates"
PROJECT_DIR="$(pwd)"

echo -e "${BLUE}📂 Toolkit:  ${NC}${TOOLKIT_DIR}"
echo -e "${BLUE}📁 Dự án:    ${NC}${PROJECT_DIR}"
echo ""

# Safety check
if [ "$TOOLKIT_DIR" == "$PROJECT_DIR" ]; then
    echo -e "${RED}❌ Lỗi: Bạn đang chạy setup TRONG chính thư mục toolkit.${NC}"
    echo -e "${YELLOW}   Hãy cd vào thư mục dự án cần cài đặt rồi chạy lại lệnh này.${NC}"
    exit 1
fi

# Check template directory
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo -e "${RED}❌ Lỗi: Không tìm thấy thư mục templates tại ${TEMPLATE_DIR}${NC}"
    exit 1
fi

# ---- STEP 1: Copy hệ thống .ai/ (Agents, Skills, Rules) ----
echo -e "${BLUE}[1/5]${NC} 📦 Cài đặt hệ thống AI (.ai/agents, .ai/skills, .ai/rules)..."
if [ -d "${TEMPLATE_DIR}/.ai" ]; then
    cp -R "${TEMPLATE_DIR}/.ai" "${PROJECT_DIR}/"
    echo -e "  ${GREEN}✓${NC} .ai/agents/  — 14 Agent chuyên biệt (Planner, Coder, Reviewer, Tester...)"
    echo -e "  ${GREEN}✓${NC} .ai/skills/claude-skills/   — 82+ Skills chính thức (frontend-design, databases, deploy...)"
    echo -e "  ${GREEN}✓${NC} .ai/skills/community-skills/ — 1450+ Skills cộng đồng (react, fastapi, docker, prompt-engineering...)"
    echo -e "  ${GREEN}✓${NC} .ai/rules/   — 7 bộ Rules (workflow, orchestration, development...)"
    echo -e "  ${GREEN}✓${NC} .ai/SKILLS-CATALOG.md — Danh mục tra cứu Skills chính thức"
    echo -e "  ${GREEN}✓${NC} .ai/SKILLS-GUIDE.md  — Hướng dẫn chọn skill theo tình huống thực tế"
fi

# ---- STEP 2: Copy file cấu hình từng AI ----
echo -e "${BLUE}[2/5]${NC} 📝 Tạo file cấu hình cho từng AI..."

if [ -f "${TEMPLATE_DIR}/CODEX.md" ]; then
    cp "${TEMPLATE_DIR}/CODEX.md" "${PROJECT_DIR}/CODEX.md"
    echo -e "  ${GREEN}✓${NC} CODEX.md     — System Prompt cho Codex (Slash Commands + Skills)"
fi

if [ -f "${TEMPLATE_DIR}/GEMINI.md" ]; then
    cp "${TEMPLATE_DIR}/GEMINI.md" "${PROJECT_DIR}/GEMINI.md"
    echo -e "  ${GREEN}✓${NC} GEMINI.md    — System Prompt cho Antigravity (Orchestration + Skills)"
fi

if [ -f "${TEMPLATE_DIR}/.cursorrules" ]; then
    cp "${TEMPLATE_DIR}/.cursorrules" "${PROJECT_DIR}/.cursorrules"
    echo -e "  ${GREEN}✓${NC} .cursorrules — Rules cho Cursor IDE (Cook + Test + Fix)"
fi

# ---- STEP 3: Tạo thư mục docs/ ----
echo -e "${BLUE}[3/5]${NC} 📚 Tạo thư mục tài liệu (docs/)..."
mkdir -p "${PROJECT_DIR}/docs"
if [ -d "${TEMPLATE_DIR}/docs" ]; then
    cp -R "${TEMPLATE_DIR}/docs/"* "${PROJECT_DIR}/docs/" 2>/dev/null || true
fi
echo -e "  ${GREEN}✓${NC} docs/ — Thư mục tài liệu kiến trúc dự án"

# ---- STEP 4: Tạo thư mục plans/ + templates ----
echo -e "${BLUE}[4/5]${NC} 📋 Tạo thư mục kế hoạch (plans/) và Plan Templates..."
mkdir -p "${PROJECT_DIR}/plans/templates"
if [ -d "${TEMPLATE_DIR}/plans" ]; then
    cp -R "${TEMPLATE_DIR}/plans/"* "${PROJECT_DIR}/plans/" 2>/dev/null || true
fi
echo -e "  ${GREEN}✓${NC} plans/templates/feature-implementation-template.md"
echo -e "  ${GREEN}✓${NC} plans/templates/bug-fix-template.md"
echo -e "  ${GREEN}✓${NC} plans/templates/refactor-template.md"
echo -e "  ${GREEN}✓${NC} plans/templates/template-usage-guide.md"

# ---- STEP 5: Thêm vào .gitignore (nếu cần) ----
echo -e "${BLUE}[5/5]${NC} 🔒 Kiểm tra .gitignore..."
if [ -f "${PROJECT_DIR}/.gitignore" ]; then
    if ! grep -q ".ai/skills/claude-skills/_shared" "${PROJECT_DIR}/.gitignore" 2>/dev/null; then
        echo "" >> "${PROJECT_DIR}/.gitignore"
        echo "# AI Toolkit - sensitive files" >> "${PROJECT_DIR}/.gitignore"
        echo ".ai/skills/claude-skills/.env" >> "${PROJECT_DIR}/.gitignore"
        echo ".ai/skills/claude-skills/.env.*" >> "${PROJECT_DIR}/.gitignore"
        echo -e "  ${GREEN}✓${NC} Đã thêm entries vào .gitignore"
    else
        echo -e "  ${GREEN}✓${NC} .gitignore đã có sẵn entries"
    fi
else
    echo "# AI Toolkit - sensitive files" > "${PROJECT_DIR}/.gitignore"
    echo ".ai/skills/claude-skills/.env" >> "${PROJECT_DIR}/.gitignore"
    echo ".ai/skills/claude-skills/.env.*" >> "${PROJECT_DIR}/.gitignore"
    echo -e "  ${GREEN}✓${NC} Tạo .gitignore mới"
fi

# ---- DONE ----
echo ""
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}${BOLD}  ✅ Setup thành công! Hệ thống AI đã sẵn sàng.${NC}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${BOLD}Slash Commands có sẵn:${NC}"
echo -e "  ${YELLOW}/plan${NC}  <tính năng>     — Lên kế hoạch (AI → Planner)"
echo -e "  ${YELLOW}/cook${NC}  [file plan]     — Bắt đầu code (AI → Coder)"
echo -e "  ${YELLOW}/test${NC}                  — Viết & chạy test (AI → Tester)"
echo -e "  ${YELLOW}/review${NC}               — Review code (AI → Reviewer)"
echo -e "  ${YELLOW}/debug${NC} <vấn đề>       — Phân tích lỗi (AI → Debugger)"
echo -e "  ${YELLOW}/fix${NC}   <lỗi>          — Sửa lỗi nhanh"
echo -e "  ${YELLOW}/docs${NC}                 — Cập nhật tài liệu"
echo -e "  ${YELLOW}/skill${NC} <tên>          — Gọi kỹ năng chuyên biệt (82+ skills)"
echo -e "  ${YELLOW}/brainstorm${NC} <chủ đề>  — Brainstorm giải pháp"
echo -e "  ${YELLOW}/watzup${NC}               — Tổng kết phiên làm việc"
echo ""
echo -e "${BOLD}Bắt đầu sử dụng:${NC}"
echo -e "  1. Mở dự án trong ${CYAN}Cursor${NC} → Chat (Cmd+L) → gõ ${YELLOW}/cook${NC}"
echo -e "  2. Mở ${CYAN}Codex${NC}  → gõ ${YELLOW}/plan Thêm tính năng đăng nhập${NC}"
echo -e "  3. Mở ${CYAN}Antigravity${NC} → gõ ${YELLOW}/plan Thiết kế API cho module thanh toán${NC}"
echo ""
