#!/bin/bash
# ================================================================
# AI Setup Toolkit — All-in-One
#
# SUBCOMMANDS:
#   ./setup.sh                           Setup dự án (KHÔNG tự cài skills)
#   ./setup.sh skill [arg] [--target X]  Cài Addy Osmani skills
#   ./setup.sh commands [arg]            Cài Addy slash commands (/spec /plan /build...)
#   ./setup.sh help                      Trợ giúp đầy đủ
#
# SKILL ARGS:
#   (trống)                Menu tương tác
#   <tên-skill>            Cài 1 skill
#   all                    Cài cả 24 skills
#   bundle:<tên>           Cài theo nhóm
#   --list                 Liệt kê 24 skills
#
# COMMANDS ARGS:
#   (trống)                Cài tất cả 7 slash commands
#   --list                 Liệt kê 7 commands
#   <tên>                  Cài 1 command: spec|plan|build|test|review|ship|code-simplify
#
# --target (dùng kèm skill hoặc commands):
#   kiro      → ~/.kiro/skills/         (Kiro IDE, global)
#   claude    → ~/.claude/skills/       (Claude Code, global)
#   project   → ./.claude/skills/      (Claude Code, chỉ dự án này)
#   both      → claude + kiro cùng lúc
#   auto      → tự phát hiện (mặc định)
#
# BUNDLES:
#   essential | define | plan | build | verify | review | ship
# ================================================================

# ── Colors ─────────────────────────────────────────────────────
GREEN='\033[0;32m';  BLUE='\033[0;34m';  YELLOW='\033[1;33m'
RED='\033[0;31m';    CYAN='\033[0;36m';  MAGENTA='\033[0;35m'
BOLD='\033[1m';      DIM='\033[2m';      NC='\033[0m'

# ── Paths ───────────────────────────────────────────────────────
TOOLKIT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="${TOOLKIT_DIR}/templates"
PROJECT_DIR="$(pwd)"
ADDY_CACHE="${TOOLKIT_DIR}/templates/.ai/skills/addy-skills"
CMD_CACHE="${TOOLKIT_DIR}/templates/addy-commands"
REMOTE_BASE="https://raw.githubusercontent.com/addyosmani/agent-skills/main"

# ── Skills Registry ─────────────────────────────────────────────
# Format: "name|phase|mô tả"
SKILLS=(
  "using-agent-skills|Meta|Maps incoming work to the right skill — meta-skill điều phối tất cả"
  "interview-me|Define|Phỏng vấn 1 câu/lần để khai thác đúng nhu cầu thực"
  "idea-refine|Define|Tư duy phân kỳ/hội tụ biến ý tưởng mơ hồ thành đề xuất cụ thể"
  "spec-driven-development|Define|Viết PRD đầy đủ TRƯỚC khi code"
  "planning-and-task-breakdown|Plan|Phân rã spec thành tasks nhỏ, đúng thứ tự phụ thuộc"
  "incremental-implementation|Build|Thin vertical slices — implement→test→verify→commit"
  "test-driven-development|Build|Red-Green-Refactor, test pyramid 80/15/5, DAMP over DRY"
  "context-engineering|Build|Đưa đúng thông tin vào đúng thời điểm — rules files, MCP"
  "source-driven-development|Build|Mọi quyết định dựa trên docs chính thức"
  "doubt-driven-development|Build|Review adversarial fresh-context mọi quyết định quan trọng"
  "frontend-ui-engineering|Build|Component architecture, WCAG 2.1 AA, state management"
  "api-and-interface-design|Build|Contract-first, Hyrum's Law, error semantics"
  "browser-testing-with-devtools|Verify|Chrome DevTools MCP — DOM, console, network"
  "debugging-and-error-recovery|Verify|5 bước: reproduce→localize→reduce→fix→guard"
  "code-review-and-quality|Review|Five-axis review, ~100 lines sizing, severity labels"
  "code-simplification|Review|Chesterton's Fence, Rule of 500 — giảm complexity"
  "security-and-hardening|Review|OWASP Top 10 + LLM Top 10, threat model, SSRF"
  "performance-optimization|Review|Measure-first, Core Web Vitals, N+1 queries"
  "git-workflow-and-versioning|Ship|Trunk-based dev, atomic commits, save-point pattern"
  "ci-cd-and-automation|Ship|Shift Left, feature flags, quality gate pipelines"
  "deprecation-and-migration|Ship|Code-as-liability, migration patterns, zombie code"
  "documentation-and-adrs|Ship|Architecture Decision Records — document WHY"
  "observability-and-instrumentation|Ship|Structured logging, RED metrics, OpenTelemetry"
  "shipping-and-launch|Ship|Pre-launch checklists, staged rollouts, rollback procedures"
)

# ── Slash Commands Registry ──────────────────────────────────────
# Format: "name|mô tả|skills kích hoạt"
COMMANDS=(
  "spec|Spec-driven development — viết PRD trước khi code|spec-driven-development"
  "plan|Phân rã spec thành tasks nhỏ, verifiable|planning-and-task-breakdown"
  "build|Implement từng slice: RED→GREEN→commit. Thêm 'auto' để chạy toàn plan|incremental-implementation + test-driven-development"
  "test|TDD workflow + Prove-It pattern cho bug fixes|test-driven-development"
  "review|Five-axis code review: correctness, readability, arch, security, perf|code-review-and-quality"
  "code-simplify|Giảm complexity giữ nguyên behavior|code-simplification"
  "ship|Fan-out đến 3 personas song song: code-reviewer + security-auditor + test-engineer → GO/NO-GO|shipping-and-launch"
)

# ── Bundles ──────────────────────────────────────────────────────
BUNDLE_ESSENTIAL=("using-agent-skills" "spec-driven-development" "planning-and-task-breakdown"
  "incremental-implementation" "test-driven-development" "debugging-and-error-recovery"
  "code-review-and-quality" "git-workflow-and-versioning")
BUNDLE_DEFINE=("using-agent-skills" "interview-me" "idea-refine" "spec-driven-development")
BUNDLE_PLAN=("planning-and-task-breakdown")
BUNDLE_BUILD=("incremental-implementation" "test-driven-development" "context-engineering"
  "source-driven-development" "doubt-driven-development" "frontend-ui-engineering" "api-and-interface-design")
BUNDLE_VERIFY=("browser-testing-with-devtools" "debugging-and-error-recovery")
BUNDLE_REVIEW=("code-review-and-quality" "code-simplification" "security-and-hardening" "performance-optimization")
BUNDLE_SHIP=("git-workflow-and-versioning" "ci-cd-and-automation" "deprecation-and-migration"
  "documentation-and-adrs" "observability-and-instrumentation" "shipping-and-launch")

# ================================================================
# HELPERS
# ================================================================

_fetch() {
  local url="$1" out="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$out" 2>/dev/null
  elif command -v wget &>/dev/null; then
    wget -qO "$out" "$url" 2>/dev/null
  else
    echo -e "  ${RED}✗${NC}  Cần cài curl hoặc wget." >&2; return 1
  fi
}

# Resolve target dir(s) từ flag --target
# Output: một hoặc nhiều dòng, mỗi dòng là 1 đường dẫn
_resolve_targets() {
  local mode="${1:-auto}"
  case "$mode" in
    kiro)    echo "${HOME}/.kiro/skills" ;;
    claude)  echo "${HOME}/.claude/skills" ;;
    project) echo "${PROJECT_DIR}/.claude/skills" ;;
    both)
      echo "${HOME}/.kiro/skills"
      echo "${HOME}/.claude/skills"
      ;;
    auto)
      # Ưu tiên: nếu có Kiro → kiro; nếu có .claude global → claude; fallback kiro
      if [[ -d "${HOME}/.kiro" ]]; then
        echo "${HOME}/.kiro/skills"
      elif [[ -d "${HOME}/.claude" ]]; then
        echo "${HOME}/.claude/skills"
      else
        echo "${HOME}/.kiro/skills"
      fi
      ;;
    *)
      echo -e "  ${RED}✗${NC}  --target không hợp lệ: '$mode'. Dùng: kiro|claude|project|both|auto" >&2
      return 1
      ;;
  esac
}

# Resolve target dir cho commands (.claude/commands/)
_resolve_cmd_target() {
  local mode="${1:-auto}"
  case "$mode" in
    project) echo "${PROJECT_DIR}/.claude/commands" ;;
    claude|both|auto) echo "${HOME}/.claude/commands" ;;
    kiro)
      echo -e "  ${YELLOW}⚠${NC}  Kiro không dùng .claude/commands — cài vào ~/.claude/commands thay thế" >&2
      echo "${HOME}/.claude/commands"
      ;;
    *)
      echo -e "  ${RED}✗${NC}  --target không hợp lệ: '$mode'" >&2
      return 1
      ;;
  esac
}

# Badge kiểm tra skill đã cài chưa
_skill_badge() {
  local name="$1"
  local badge=""
  [[ -f "${HOME}/.kiro/skills/${name}/SKILL.md" ]]     && badge+=" ${GREEN}[kiro]${NC}"
  [[ -f "${HOME}/.claude/skills/${name}/SKILL.md" ]]   && badge+=" ${CYAN}[claude]${NC}"
  [[ -f "${PROJECT_DIR}/.claude/skills/${name}/SKILL.md" ]] && badge+=" ${BLUE}[project]${NC}"
  [[ -f "${ADDY_CACHE}/${name}/SKILL.md" ]]            && badge+=" ${DIM}[cached]${NC}"
  echo "$badge"
}

# Badge kiểm tra command đã cài chưa
_cmd_badge() {
  local name="$1"
  local badge=""
  [[ -f "${HOME}/.claude/commands/${name}.md" ]]               && badge+=" ${CYAN}[claude]${NC}"
  [[ -f "${PROJECT_DIR}/.claude/commands/${name}.md" ]]        && badge+=" ${BLUE}[project]${NC}"
  [[ -f "${CMD_CACHE}/${name}.md" ]]                           && badge+=" ${DIM}[cached]${NC}"
  echo "$badge"
}

# ================================================================
# CMD_SETUP — setup dự án (KHÔNG cài skills)
# ================================================================
cmd_setup() {
  echo ""
  echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}${BOLD}║   🚀 AI Setup Toolkit — Codex / Claude / Kiro / Cursor  ║${NC}"
  echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${BLUE}📂 Toolkit:${NC} ${TOOLKIT_DIR}"
  echo -e "${BLUE}📁 Dự án:  ${NC} ${PROJECT_DIR}"
  echo ""

  if [[ "$TOOLKIT_DIR" == "$PROJECT_DIR" ]]; then
    echo -e "${RED}❌ Đang chạy TRONG thư mục toolkit — hãy cd vào dự án rồi chạy lại.${NC}"
    exit 1
  fi
  if [[ ! -d "$TEMPLATE_DIR" ]]; then
    echo -e "${RED}❌ Không tìm thấy templates tại ${TEMPLATE_DIR}${NC}"
    exit 1
  fi

  echo -e "${BLUE}[1/5]${NC} 📦 Cài .ai/ (agents, skills, rules)..."
  if [[ -d "${TEMPLATE_DIR}/.ai" ]]; then
    cp -R "${TEMPLATE_DIR}/.ai" "${PROJECT_DIR}/"
    echo -e "  ${GREEN}✓${NC} .ai/agents/            — 14 Agents chuyên biệt"
    echo -e "  ${GREEN}✓${NC} .ai/skills/claude-skills/    — 82+ Skills chính thức"
    echo -e "  ${GREEN}✓${NC} .ai/skills/community-skills/ — 1450+ Community skills"
    echo -e "  ${GREEN}✓${NC} .ai/rules/             — 7 bộ Rules workflow"
    echo -e "  ${GREEN}✓${NC} .ai/SKILLS-CATALOG.md  — Danh mục tra cứu"
    echo -e "  ${GREEN}✓${NC} .ai/SKILLS-GUIDE.md    — Hướng dẫn chọn skill"
  fi

  echo -e "${BLUE}[2/5]${NC} 📝 File cấu hình AI..."
  [[ -f "${TEMPLATE_DIR}/CODEX.md" ]]     && cp "${TEMPLATE_DIR}/CODEX.md" "${PROJECT_DIR}/CODEX.md"       && echo -e "  ${GREEN}✓${NC} CODEX.md"
  [[ -f "${TEMPLATE_DIR}/GEMINI.md" ]]    && cp "${TEMPLATE_DIR}/GEMINI.md" "${PROJECT_DIR}/GEMINI.md"     && echo -e "  ${GREEN}✓${NC} GEMINI.md"
  [[ -f "${TEMPLATE_DIR}/.cursorrules" ]] && cp "${TEMPLATE_DIR}/.cursorrules" "${PROJECT_DIR}/.cursorrules" && echo -e "  ${GREEN}✓${NC} .cursorrules"

  echo -e "${BLUE}[3/5]${NC} 📚 docs/..."
  mkdir -p "${PROJECT_DIR}/docs"
  [[ -d "${TEMPLATE_DIR}/docs" ]] && cp -R "${TEMPLATE_DIR}/docs/"* "${PROJECT_DIR}/docs/" 2>/dev/null || true
  echo -e "  ${GREEN}✓${NC} docs/"

  echo -e "${BLUE}[4/5]${NC} 📋 plans/..."
  mkdir -p "${PROJECT_DIR}/plans/templates"
  [[ -d "${TEMPLATE_DIR}/plans" ]] && cp -R "${TEMPLATE_DIR}/plans/"* "${PROJECT_DIR}/plans/" 2>/dev/null || true
  echo -e "  ${GREEN}✓${NC} plans/templates/ — feature, bug-fix, refactor templates"

  echo -e "${BLUE}[5/5]${NC} 🔒 .gitignore..."
  if [[ -f "${PROJECT_DIR}/.gitignore" ]]; then
    if ! grep -q "claude-skills/_shared" "${PROJECT_DIR}/.gitignore" 2>/dev/null; then
      printf '\n# AI Toolkit\n.ai/skills/claude-skills/.env\n.ai/skills/claude-skills/.env.*\n' >> "${PROJECT_DIR}/.gitignore"
      echo -e "  ${GREEN}✓${NC} Đã thêm entries"
    else
      echo -e "  ${GREEN}✓${NC} Đã có sẵn"
    fi
  else
    printf '# AI Toolkit\n.ai/skills/claude-skills/.env\n.ai/skills/claude-skills/.env.*\n' > "${PROJECT_DIR}/.gitignore"
    echo -e "  ${GREEN}✓${NC} Tạo mới"
  fi

  echo ""
  echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}${BOLD}  ✅ Setup xong! Skills chưa được cài — dùng lệnh bên dưới.${NC}"
  echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
  echo ""
  echo -e "${BOLD}⚡ Bước tiếp theo — thêm Addy Osmani skills & commands:${NC}"
  echo ""
  echo -e "  ${CYAN}$(basename "$0") commands${NC}               — Cài 7 slash commands (/spec /plan /build...)"
  echo -e "  ${CYAN}$(basename "$0") skill bundle:essential${NC}  — 8 production-grade skills thiết yếu"
  echo -e "  ${CYAN}$(basename "$0") skill all${NC}               — Tất cả 24 skills"
  echo -e "  ${CYAN}$(basename "$0") skill --list${NC}            — Xem danh sách 24 skills"
  echo ""
  echo -e "${DIM}Hoặc cài trực tiếp trong Claude Code:${NC}"
  echo -e "  ${DIM}/plugin marketplace add addyosmani/agent-skills${NC}"
  echo -e "  ${DIM}/plugin install agent-skills@addy-agent-skills${NC}"
  echo ""
}

# ================================================================
# CMD_SKILL — quản lý Addy Osmani skills
# ================================================================

_skill_list() {
  echo ""
  echo -e "${BOLD}📋 24 Production-Grade Skills — addyosmani/agent-skills${NC}"
  echo -e "${DIM}   https://github.com/addyosmani/agent-skills${NC}"
  echo ""

  local cur_phase=""
  for entry in "${SKILLS[@]}"; do
    IFS='|' read -r name phase desc <<< "$entry"
    if [[ "$phase" != "$cur_phase" ]]; then
      cur_phase="$phase"
      case "$phase" in
        Meta)   echo -e "\n  ${MAGENTA}${BOLD}◆ Meta${NC}" ;;
        Define) echo -e "\n  ${BLUE}${BOLD}◆ Define  — Clarify what to build${NC}" ;;
        Plan)   echo -e "\n  ${GREEN}${BOLD}◆ Plan    — Break it down${NC}" ;;
        Build)  echo -e "\n  ${YELLOW}${BOLD}◆ Build   — Write the code${NC}" ;;
        Verify) echo -e "\n  ${CYAN}${BOLD}◆ Verify  — Prove it works${NC}" ;;
        Review) echo -e "\n  ${MAGENTA}${BOLD}◆ Review  — Quality gates${NC}" ;;
        Ship)   echo -e "\n  ${RED}${BOLD}◆ Ship    — Deploy with confidence${NC}" ;;
      esac
    fi
    local badge
    badge="$(_skill_badge "$name")"
    echo -e "    ${YELLOW}${name}${NC}${badge}"
    echo -e "    ${DIM}${desc}${NC}"
  done

  echo ""
  echo -e "${BOLD}📦 Bundles:${NC}"
  echo -e "  ${CYAN}bundle:essential${NC}  — 8 skills thiết yếu ${DIM}(mọi dự án nên có)${NC}"
  echo -e "  ${CYAN}bundle:define${NC}     — Define  (4)  ${CYAN}bundle:plan${NC}    — Plan    (1)"
  echo -e "  ${CYAN}bundle:build${NC}      — Build   (7)  ${CYAN}bundle:verify${NC}  — Verify  (2)"
  echo -e "  ${CYAN}bundle:review${NC}     — Review  (4)  ${CYAN}bundle:ship${NC}    — Ship    (6)"
  echo -e "  ${CYAN}all${NC}               — Tất cả 24 skills"
  echo ""
  echo -e "${DIM}--target: kiro(mặc định) | claude | project | both${NC}"
  echo ""
}

_install_one_skill() {
  local skill="$1" dest="$2"
  local out_file="${dest}/${skill}/SKILL.md"

  # validate
  local valid=false
  for entry in "${SKILLS[@]}"; do
    [[ "${entry%%|*}" == "$skill" ]] && { valid=true; break; }
  done
  if [[ "$valid" == false ]]; then
    echo -e "  ${RED}✗${NC}  '${skill}' không có trong danh sách — dùng --list"
    return 1
  fi

  if [[ -f "$out_file" ]]; then
    echo -e "  ${DIM}↷  ${skill} (đã có tại ${dest##*/}, bỏ qua)${NC}"
    return 0
    return 0
  fi

  echo -ne "  ${CYAN}⟳${NC}  ${YELLOW}${skill}${NC}..."
  mkdir -p "${dest}/${skill}"

  # local cache → GitHub
  local cache="${ADDY_CACHE}/${skill}/SKILL.md"
  if [[ -f "$cache" ]]; then
    cp "$cache" "$out_file"
    echo -e "\r  ${GREEN}✓${NC}  ${YELLOW}${skill}${NC} ${DIM}(cache)${NC}              "
    return 0
  elif _fetch "${REMOTE_BASE}/skills/${skill}/SKILL.md" "$out_file"; then
    # Save to local cache (best-effort, không ảnh hưởng exit code)
    mkdir -p "${ADDY_CACHE}/${skill}" 2>/dev/null
    cp "$out_file" "${ADDY_CACHE}/${skill}/SKILL.md" 2>/dev/null || true
    echo -e "\r  ${GREEN}✓${NC}  ${YELLOW}${skill}${NC} ${DIM}(github)${NC}             "
    return 0
  else
    rm -f "$out_file"
    echo -e "\r  ${RED}✗${NC}  ${skill} — tải thất bại           "
    return 1
  fi
}

_install_bundle() {
  local label="$1"; shift
  local dests=("$@")          # last arg is list of dests? No — dests passed separately
  # Usage: _install_bundle label dest1 [dest2] skill1 skill2...
  # Actually: call per dest
  :
}

_install_skills_list() {
  # $1 = label, $2..= skill names, targets stored in TARGET_DIRS array
  local label="$1"; shift
  local skills=("$@")
  local ok=0 fail=0

  echo -e "${BLUE}📦 Bundle: ${BOLD}${label}${NC} (${#skills[@]} skills)"
  echo -e "${DIM}   → ${TARGET_DIRS[*]}${NC}"
  echo ""
  for skill in "${skills[@]}"; do
    for dest in "${TARGET_DIRS[@]}"; do
      if _install_one_skill "$skill" "$dest"; then
        ok=$((ok + 1))
      else
        fail=$((fail + 1))
      fi
    done
  done
  echo ""
  echo -e "  ${GREEN}${BOLD}✓ ${ok} cài thành công${NC}$([ $fail -gt 0 ] && echo " | ${RED}✗ ${fail} lỗi${NC}")"
}

_skill_menu() {
  echo -e "${BOLD}Chọn skills muốn cài:${NC}"
  echo ""
  echo -e "  ${CYAN}1${NC}  bundle:essential  — 8 skills thiết yếu ${DIM}(khuyến nghị)${NC}"
  echo -e "  ${CYAN}2${NC}  all               — Tất cả 24 skills"
  echo -e "  ${CYAN}3${NC}  bundle:define     — Define phase"
  echo -e "  ${CYAN}4${NC}  bundle:build      — Build phase"
  echo -e "  ${CYAN}5${NC}  bundle:review     — Review phase"
  echo -e "  ${CYAN}6${NC}  bundle:ship       — Ship phase"
  echo -e "  ${CYAN}7${NC}  Nhập thủ công     — Xem danh sách rồi nhập tên"
  echo -e "  ${CYAN}q${NC}  Thoát"
  echo ""
  read -r -p "$(echo -e "${YELLOW}Lựa chọn: ${NC}")" choice
  case "$choice" in
    1) _install_skills_list "essential" "${BUNDLE_ESSENTIAL[@]}" ;;
    2)
      echo -e "${BLUE}📦 Cài tất cả 24 skills...${NC}"; echo ""
      local ok=0 fail=0
      for entry in "${SKILLS[@]}"; do
        IFS='|' read -r name _ _ <<< "$entry"
        for dest in "${TARGET_DIRS[@]}"; do
          if _install_one_skill "$name" "$dest"; then ok=$((ok+1)); else fail=$((fail+1)); fi
        done
      done
      echo ""; echo -e "  ${GREEN}${BOLD}✓ ${ok}/24 cài thành công${NC}$([ $fail -gt 0 ] && echo " | ${RED}${fail} lỗi${NC}")"
      ;;
    3) _install_skills_list "define"  "${BUNDLE_DEFINE[@]}" ;;
    4) _install_skills_list "build"   "${BUNDLE_BUILD[@]}" ;;
    5) _install_skills_list "review"  "${BUNDLE_REVIEW[@]}" ;;
    6) _install_skills_list "ship"    "${BUNDLE_SHIP[@]}" ;;
    7)
      _skill_list
      read -r -p "$(echo -e "${YELLOW}Nhập tên skills (cách nhau dấu cách): ${NC}")" inp
      for s in $inp; do
        for dest in "${TARGET_DIRS[@]}"; do _install_one_skill "$s" "$dest"; done
      done
      ;;
    q|Q) echo "Đã thoát."; return 0 ;;
    *) echo -e "${RED}Lựa chọn không hợp lệ${NC}" ;;
  esac
}

cmd_skill() {
  # Parse args: tách --target ra khỏi skill arg
  local arg="" target="auto"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --target|-t) target="${2:-auto}"; shift 2 ;;
      *) arg="$1"; shift ;;
    esac
  done

  # Build TARGET_DIRS array từ target mode (compatible bash 3/4)
  local resolved
  resolved="$(_resolve_targets "$target")" || exit 1
  IFS=$'\n' read -r -d '' -a TARGET_DIRS <<< "$resolved" 2>/dev/null || true
  # fallback nếu read bị lỗi
  [[ ${#TARGET_DIRS[@]} -eq 0 ]] && TARGET_DIRS=($resolved)
  for d in "${TARGET_DIRS[@]}"; do mkdir -p "$d"; done

  echo ""
  echo -e "${CYAN}${BOLD}╔═══════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}${BOLD}║   🎯 Addy Osmani Agent Skills — Production Grade       ║${NC}"
  echo -e "${CYAN}${BOLD}╚═══════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${BLUE}📂 Target:${NC} ${TARGET_DIRS[*]}"
  echo ""

  case "$arg" in
    ""|menu)        _skill_menu ;;
    --list|-l)      _skill_list; return 0 ;;
    all)
      echo -e "${BLUE}📦 Cài tất cả 24 skills...${NC}"; echo ""
      local ok=0 fail=0
      for entry in "${SKILLS[@]}"; do
        IFS='|' read -r name _ _ <<< "$entry"
        for dest in "${TARGET_DIRS[@]}"; do
          if _install_one_skill "$name" "$dest"; then ok=$((ok+1)); else fail=$((fail+1)); fi
        done
      done
      echo ""; echo -e "  ${GREEN}${BOLD}✓ ${ok}/24${NC}$([ $fail -gt 0 ] && echo " | ${RED}${fail} lỗi${NC}")"
      ;;
    bundle:essential) _install_skills_list "essential" "${BUNDLE_ESSENTIAL[@]}" ;;
    bundle:define)    _install_skills_list "define"    "${BUNDLE_DEFINE[@]}" ;;
    bundle:plan)      _install_skills_list "plan"      "${BUNDLE_PLAN[@]}" ;;
    bundle:build)     _install_skills_list "build"     "${BUNDLE_BUILD[@]}" ;;
    bundle:verify)    _install_skills_list "verify"    "${BUNDLE_VERIFY[@]}" ;;
    bundle:review)    _install_skills_list "review"    "${BUNDLE_REVIEW[@]}" ;;
    bundle:ship)      _install_skills_list "ship"      "${BUNDLE_SHIP[@]}" ;;
    *)
      for dest in "${TARGET_DIRS[@]}"; do _install_one_skill "$arg" "$dest"; done
      ;;
  esac

  echo ""
  echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}${BOLD}  ✅ Xong! Dùng trong Claude Code / Kiro:${NC}"
  echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
  echo ""
  echo -e "  ${YELLOW}/skill spec-driven-development${NC}     — Spec trước khi code"
  echo -e "  ${YELLOW}/skill test-driven-development${NC}     — Red-Green-Refactor"
  echo -e "  ${YELLOW}/skill security-and-hardening${NC}      — OWASP + LLM audit"
  echo -e "  ${YELLOW}/skill code-review-and-quality${NC}     — Five-axis review"
  echo ""
  echo -e "${DIM}Cũng có thể cài slash commands: $(basename "$0") commands${NC}"
  echo ""
}

# ================================================================
# CMD_COMMANDS — cài 7 Addy slash commands vào .claude/commands/
# ================================================================

# Nội dung inline của 7 commands (không cần mạng khi đã cache)
_write_cmd_spec() { cat > "$1" << 'CMDEOF'
---
description: Start spec-driven development — viết PRD có cấu trúc trước khi code bất kỳ dòng nào
---

Invoke the agent-skills:spec-driven-development skill.

Bắt đầu bằng cách hiểu người dùng muốn xây dựng gì. Hỏi làm rõ về:
1. Mục tiêu và người dùng mục tiêu
2. Tính năng cốt lõi và acceptance criteria
3. Ưu tiên tech stack và constraints
4. Boundaries đã biết (luôn làm, cần hỏi trước, không bao giờ làm)

Sau đó tạo spec có cấu trúc gồm 6 phần: objective, commands, project structure,
code style, testing strategy, và boundaries.

Lưu spec vào SPEC.md ở root dự án và xác nhận với người dùng trước khi tiếp tục.
CMDEOF
}

_write_cmd_plan() { cat > "$1" << 'CMDEOF'
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
CMDEOF
}

_write_cmd_build() { cat > "$1" << 'CMDEOF'
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
CMDEOF
}

_write_cmd_test() { cat > "$1" << 'CMDEOF'
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
CMDEOF
}

_write_cmd_review() { cat > "$1" << 'CMDEOF'
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
CMDEOF
}

_write_cmd_code_simplify() { cat > "$1" << 'CMDEOF'
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
CMDEOF
}

_write_cmd_ship() { cat > "$1" << 'CMDEOF'
---
description: Pre-launch checklist với parallel fan-out đến 3 personas → quyết định GO/NO-GO
---

Invoke the agent-skills:shipping-and-launch skill.

`/ship` là **fan-out orchestrator**. Chạy 3 specialist personas song song, sau đó merge reports thành quyết định GO/NO-GO duy nhất kèm rollback plan.

## Phase A — Parallel fan-out

Spawn 3 subagents đồng thời (issue cả 3 calls trong một turn):

1. **`code-reviewer`** — Five-axis review (correctness, readability, architecture, security, performance) trên staged changes hoặc recent commits.
2. **`security-auditor`** — Vulnerability và threat-model pass. OWASP Top 10, secrets, auth/authz, CVEs.
3. **`test-engineer`** — Phân tích test coverage. Gaps trong happy path, edge cases, error paths.

## Phase B — Merge

Tổng hợp findings từ 3 personas thành:
- Code Quality, Security, Performance, Accessibility, Infrastructure, Documentation

## Phase C — Quyết định

```markdown
## Ship Decision: GO | NO-GO

### Blockers (phải fix trước khi ship)
### Recommended fixes (nên fix)
### Acknowledged risks (ship mà biết risk)
### Rollback plan
- Trigger conditions: [signals nào kích hoạt rollback]
- Rollback steps: [các bước cụ thể]
```

**Rule:** Nếu bất kỳ persona nào return Critical finding → default NO-GO trừ khi user chấp nhận risk.
CMDEOF
}


_commands_list() {
  echo ""
  echo -e "${BOLD}⚡ 7 Slash Commands — addyosmani/agent-skills${NC}"
  echo -e "${DIM}   Cài vào .claude/commands/ để dùng trong Claude Code${NC}"
  echo ""
  echo -e "  ${BOLD}Command          Kích hoạt skill                    Mô tả${NC}"
  echo -e "  ${DIM}─────────────────────────────────────────────────────────────────${NC}"

  local names=("spec" "plan" "build" "test" "review" "code-simplify" "ship")
  local descs=(
    "spec-driven-development       Viết PRD trước khi code"
    "planning-and-task-breakdown   Phân rã spec → tasks nhỏ"
    "incremental-impl + TDD        /build auto = chạy toàn plan"
    "test-driven-development       TDD + Prove-It bug fix pattern"
    "code-review-and-quality       Five-axis review"
    "code-simplification           Giảm complexity, giữ behavior"
    "shipping-and-launch           3 personas song song → GO/NO-GO"
  )

  for i in "${!names[@]}"; do
    local name="${names[$i]}"
    local badge
    badge="$(_cmd_badge "$name")"
    printf "  ${YELLOW}/%-16s${NC}${badge}\n" "$name"
    echo -e "    ${DIM}${descs[$i]}${NC}"
  done

  echo ""
  echo -e "${DIM}Target: ~/.claude/commands/ (global) hoặc ./.claude/commands/ (project)${NC}"
  echo -e "${DIM}Dùng: $(basename "$0") commands [--target project]${NC}"
  echo ""
}

_install_one_command() {
  local name="$1" dest_dir="$2"
  local out_file="${dest_dir}/${name}.md"

  local valid=false
  for entry in "${COMMANDS[@]}"; do
    [[ "${entry%%|*}" == "$name" ]] && { valid=true; break; }
  done
  if [[ "$valid" == false ]]; then
    echo -e "  ${RED}✗${NC}  '${name}' không tồn tại — dùng --list"
    return 1
  fi

  if [[ -f "$out_file" ]]; then
    echo -e "  ${DIM}↷  /${name} (đã có tại ${dest_dir##*/}, bỏ qua)${NC}"
    return 0
    return 0
  fi

  echo -ne "  ${CYAN}⟳${NC}  Đang cài ${YELLOW}/${name}${NC}..."
  mkdir -p "$dest_dir"

  # Dùng local cache nếu có
  local cache="${CMD_CACHE}/${name}.md"
  if [[ -f "$cache" ]]; then
    cp "$cache" "$out_file"
    echo -e "\r  ${GREEN}✓${NC}  ${YELLOW}/${name}${NC} ${DIM}(cache)${NC}              "
    return 0
  fi

  # Tạo từ inline content (không cần mạng)
  case "$name" in
    spec)          _write_cmd_spec         "$out_file" ;;
    plan)          _write_cmd_plan         "$out_file" ;;
    build)         _write_cmd_build        "$out_file" ;;
    test)          _write_cmd_test         "$out_file" ;;
    review)        _write_cmd_review       "$out_file" ;;
    code-simplify) _write_cmd_code_simplify "$out_file" ;;
    ship)          _write_cmd_ship         "$out_file" ;;
    *)
      # Fallback: fetch từ GitHub
      if _fetch "${REMOTE_BASE}/.claude/commands/${name}.md" "$out_file"; then
        mkdir -p "$CMD_CACHE" && cp "$out_file" "${CMD_CACHE}/${name}.md"
        echo -e "\r  ${GREEN}✓${NC}  ${YELLOW}/${name}${NC} ${DIM}(github)${NC}             "
        return 0
      else
        rm -f "$out_file"
        echo -e "\r  ${RED}✗${NC}  /${name} — tải thất bại          "
        return 1
      fi
      ;;
  esac

  # Cache inline result
  mkdir -p "$CMD_CACHE" && cp "$out_file" "${CMD_CACHE}/${name}.md"
  echo -e "\r  ${GREEN}✓${NC}  ${YELLOW}/${name}${NC} ${DIM}(inline)${NC}             "
}

cmd_commands() {
  local arg="" target="auto"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --target|-t) target="${2:-auto}"; shift 2 ;;
      *) arg="$1"; shift ;;
    esac
  done

  local dest_dir
  dest_dir="$(_resolve_cmd_target "$target")" || exit 1
  mkdir -p "$dest_dir"

  echo ""
  echo -e "${CYAN}${BOLD}╔═══════════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}${BOLD}║   ⚡ Addy Osmani Slash Commands — Claude Code           ║${NC}"
  echo -e "${CYAN}${BOLD}╚═══════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "${BLUE}📂 Cài vào:${NC} ${dest_dir}"
  echo ""

  case "$arg" in
    --list|-l)
      _commands_list; return 0 ;;
    "")
      # Cài tất cả 7
      echo -e "${BOLD}Cài tất cả 7 slash commands...${NC}"
      echo ""
      local names=("spec" "plan" "build" "test" "review" "code-simplify" "ship")
      local ok=0 fail=0
      for name in "${names[@]}"; do
        if _install_one_command "$name" "$dest_dir"; then ok=$((ok+1)); else fail=$((fail+1)); fi
      done
      echo ""
      echo -e "  ${GREEN}${BOLD}✓ ${ok}/7 commands đã cài${NC}$([ $fail -gt 0 ] && echo " | ${RED}✗ ${fail} lỗi${NC}")"
      ;;
    *)
      _install_one_command "$arg" "$dest_dir"
      ;;
  esac

  echo ""
  echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}${BOLD}  ✅ Xong! Gõ các lệnh này trong Claude Code:${NC}"
  echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════${NC}"
  echo ""
  echo -e "  ${YELLOW}/spec${NC}          — Viết PRD trước khi code"
  echo -e "  ${YELLOW}/plan${NC}          — Phân rã spec thành tasks"
  echo -e "  ${YELLOW}/build${NC}         — Implement slice tiếp theo"
  echo -e "  ${YELLOW}/build auto${NC}    — Chạy toàn bộ plan tự động"
  echo -e "  ${YELLOW}/test${NC}          — TDD + Prove-It bug fix"
  echo -e "  ${YELLOW}/review${NC}        — Five-axis code review"
  echo -e "  ${YELLOW}/code-simplify${NC} — Giảm complexity"
  echo -e "  ${YELLOW}/ship${NC}          — GO/NO-GO với 3 personas song song"
  echo ""
  echo -e "${DIM}Lưu ý: Commands hoạt động tốt nhất khi đã cài skills tương ứng.${NC}"
  echo -e "${DIM}Dùng: $(basename "$0") skill bundle:essential${NC}"
  echo ""
}

# ================================================================
# CMD_HELP
# ================================================================
cmd_help() {
  echo ""
  echo -e "${CYAN}${BOLD}AI Setup Toolkit — All-in-One${NC}"
  echo -e "${DIM}Addy Osmani agent-skills + production-grade workflow${NC}"
  echo ""
  echo -e "${BOLD}SUBCOMMANDS:${NC}"
  echo -e "  ${CYAN}setup${NC}              Setup dự án (.ai/, CODEX.md, plans/) — KHÔNG cài skills"
  echo -e "  ${CYAN}skill${NC} [arg]        Cài Addy Osmani production skills"
  echo -e "  ${CYAN}commands${NC} [arg]     Cài 7 slash commands (/spec /plan /build...)"
  echo -e "  ${CYAN}help${NC}               Trợ giúp này"
  echo ""
  echo -e "${BOLD}SKILL ARGS:${NC}"
  echo -e "  (trống)            Menu tương tác"
  echo -e "  --list             Xem 24 skills với trạng thái cài đặt"
  echo -e "  <tên>              Cài 1 skill cụ thể"
  echo -e "  all                Cài tất cả 24 skills"
  echo -e "  bundle:essential   8 skills thiết yếu ${DIM}(khuyến nghị)${NC}"
  echo -e "  bundle:define      Define phase   (4 skills)"
  echo -e "  bundle:plan        Plan phase     (1 skill)"
  echo -e "  bundle:build       Build phase    (7 skills)"
  echo -e "  bundle:verify      Verify phase   (2 skills)"
  echo -e "  bundle:review      Review phase   (4 skills)"
  echo -e "  bundle:ship        Ship phase     (6 skills)"
  echo ""
  echo -e "${BOLD}COMMANDS ARGS:${NC}"
  echo -e "  (trống)            Cài tất cả 7 commands"
  echo -e "  --list             Xem danh sách commands"
  echo -e "  spec|plan|build|test|review|code-simplify|ship"
  echo ""
  echo -e "${BOLD}--target (dùng với skill hoặc commands):${NC}"
  echo -e "  kiro               ~/.kiro/skills/         ${DIM}(Kiro IDE)${NC}"
  echo -e "  claude             ~/.claude/skills/       ${DIM}(Claude Code, global)${NC}"
  echo -e "  project            ./.claude/skills/       ${DIM}(Claude Code, dự án này)${NC}"
  echo -e "  both               kiro + claude cùng lúc"
  echo -e "  auto               Tự phát hiện ${DIM}(mặc định)${NC}"
  echo ""
  echo -e "${BOLD}EXAMPLES:${NC}"
  echo -e "  ${DIM}# Setup dự án mới (không cài skills):${NC}"
  echo -e "  $(basename "$0")"
  echo ""
  echo -e "  ${DIM}# Sau setup — cài slash commands cho Claude Code:${NC}"
  echo -e "  $(basename "$0") commands"
  echo -e "  $(basename "$0") commands --target project   ${DIM}# chỉ dự án này${NC}"
  echo ""
  echo -e "  ${DIM}# Cài skills thiết yếu vào Kiro:${NC}"
  echo -e "  $(basename "$0") skill bundle:essential"
  echo ""
  echo -e "  ${DIM}# Cài vào cả Kiro lẫn Claude Code:${NC}"
  echo -e "  $(basename "$0") skill bundle:essential --target both"
  echo ""
  echo -e "  ${DIM}# Cài 1 skill cụ thể vào Claude Code (global):${NC}"
  echo -e "  $(basename "$0") skill security-and-hardening --target claude"
  echo ""
  echo -e "  ${DIM}# Hoặc cài trực tiếp trong Claude Code (không cần script):${NC}"
  echo -e "  ${DIM}/plugin marketplace add addyosmani/agent-skills${NC}"
  echo -e "  ${DIM}/plugin install agent-skills@addy-agent-skills${NC}"
  echo ""
  echo -e "${DIM}Source: https://github.com/addyosmani/agent-skills (MIT)${NC}"
  echo ""
}

# ================================================================
# ENTRY POINT
# ================================================================
SUBCMD="${1:-setup}"
shift 2>/dev/null || true

case "$SUBCMD" in
  setup|"")     cmd_setup ;;
  skill)        cmd_skill "$@" ;;
  commands|cmd) cmd_commands "$@" ;;
  help|--help|-h) cmd_help ;;
  *)
    # Gợi ý nếu user nhập thẳng tên skill/bundle
    if [[ "$SUBCMD" == bundle:* ]] || grep -q "^${SUBCMD}|" <<< "$(printf '%s\n' "${SKILLS[@]}")"; then
      echo -e "${YELLOW}Gợi ý: $(basename "$0") skill ${SUBCMD} $*${NC}"
      cmd_skill "$SUBCMD" "$@"
    elif [[ "$SUBCMD" == "spec" || "$SUBCMD" == "plan" || "$SUBCMD" == "build" ||
            "$SUBCMD" == "test" || "$SUBCMD" == "review" || "$SUBCMD" == "ship" ||
            "$SUBCMD" == "code-simplify" ]]; then
      echo -e "${YELLOW}Gợi ý: $(basename "$0") commands ${SUBCMD} $*${NC}"
      cmd_commands "$SUBCMD" "$@"
    else
      echo -e "${RED}Lệnh không hợp lệ: '${SUBCMD}'${NC}"
      echo -e "Dùng: $(basename "$0") help"
      exit 1
    fi
    ;;
esac
