# 🗺️ Hướng dẫn chọn Skill theo tình huống thực tế

Bộ toolkit có **1450+ community skills** + **82+ claude-skills chính thức**. Tài liệu này giúp bạn nhanh chóng tìm đúng skill cần dùng.

---

## Nguyên tắc vàng

> Bạn KHÔNG cần nhớ hết 1500 skills. Chỉ cần nói cho AI biết **bạn muốn làm gì**, AI sẽ tự tìm skill phù hợp từ danh mục.
> 
> Ví dụ: Gõ `/skill find-skills` rồi mô tả nhu cầu → AI sẽ tìm và đề xuất skill cho bạn.

---

## 📋 Bảng tra cứu nhanh theo tình huống

### 🏗️ "Tôi muốn bắt đầu một dự án mới"

| Bước | Lệnh/Skill | Mô tả |
|------|------------|-------|
| 1 | `/plan Mô tả dự án` | AI lên kế hoạch kiến trúc |
| 2 | `/skill bootstrap` | Khởi tạo dự án (tech stack, cấu trúc thư mục) |
| 3 | `/cook plans/xxx.md` | Bắt đầu code theo kế hoạch |

---

### 🎨 "Tôi có bản thiết kế UI, muốn biến thành code"

| Tình huống | Skill | Gõ lệnh |
|-----------|-------|---------|
| Có ảnh mockup/screenshot | `frontend-design` | `/skill frontend-design` + kèm ảnh |
| Định hình màu sắc, layout, UX | `ui-ux-pro-max` | `/skill ui-ux-pro-max` |
| Dùng Tailwind + shadcn/ui | `ui-styling` | `/skill ui-styling` |
| Thiết kế 3D / WebGL cơ bản | `threejs` | `/skill threejs` |
| Làm Animation / Motion | `animejs-animation` | `/skill animejs-animation` |
| Cần audit giao diện cũ | `web-design-guidelines` | `/skill web-design-guidelines` |

**Community skills bổ sung cực mạnh cho Frontend & UI:**
- **Three.js chuyên sâu:** `threejs-fundamentals`, `threejs-geometry`, `threejs-lighting`, `threejs-materials`, `threejs-shaders`, `threejs-animation`, v.v.
- **Phong cách thiết kế:** `high-end-visual-design`, `industrial-brutalist-ui`, `minimalist-ui`, `baseline-ui`
- **UI Components & CSS:** `radix-ui-design-system`, `tailwind-design-system`, `tailwind-patterns`, `magic-ui-generator`
- **Nâng cấp "taste" (Gout thẩm mỹ):** `design-taste-frontend`, `stitch-design-taste`, `stitch-ui-design`
- **Hoạt ảnh (Animation):** `animejs-animation`, `makepad-animation`

---

### ⚛️ "Tôi đang code React / Next.js / Frontend Framework"

| Tình huống | Skill |
|-----------|-------|
| Patterns React chuẩn | `react-best-practices` (hoặc `react-patterns`) |
| Tối ưu hiệu năng Component | `react-component-performance` |
| Refactor/Nâng cấp code cũ | `react-modernization` |
| Next.js App Router, SSR | `web-frameworks` (hoặc `react-nextjs-development`) |
| State management | `react-state-management` |
| SvelteKit | `sveltekit` |
| Dùng Functional Programming | `fp-react` |

---

### 🔧 "Tôi cần build Backend / API"

| Tình huống | Skill |
|-----------|-------|
| REST/GraphQL API (NestJS, FastAPI, Django) | `backend-development` |
| Authentication (OAuth, JWT, passkeys) | `better-auth` |
| Tích hợp thanh toán (Stripe, Polar) | `payment-integration` |
| Database design, queries | `databases` |

**Community skills bổ sung:**
- `fastapi-pro` — FastAPI chuyên sâu
- `django-pro` — Django chuyên sâu
- `nestjs-expert` — NestJS patterns
- `prisma-expert` — Prisma ORM
- `graphql-architect` — Thiết kế GraphQL
- `nodejs-best-practices` — Node.js chuẩn
- `postgresql-optimization` — Tối ưu PostgreSQL

---

### 🐛 "Code bị lỗi, tôi cần debug"

| Bước | Lệnh | Mô tả |
|------|-------|-------|
| 1 | `/debug Mô tả lỗi` | AI phân tích root cause |
| 2 | `/fix` | AI sửa lỗi |
| 3 | `/test` | Chạy lại test |

**Skills hỗ trợ:**
- `sequential-thinking` — Phân tích step-by-step cho vấn đề phức tạp
- `debugger` (community) — Chiến lược debug nâng cao
- `error-detective` (community) — Truy tìm lỗi ẩn

---

### 🚀 "Tôi muốn deploy dự án"

| Tình huống | Skill |
|-----------|-------|
| Deploy tổng quát (tự nhận diện platform) | `deploy` |
| Docker, Kubernetes, CI/CD | `devops` |
| Vercel, Netlify | `deploy` |

**Community skills bổ sung:**
- `docker-expert` — Docker chuyên sâu
- `kubernetes-architect` — K8s kiến trúc
- `aws-serverless` — AWS Lambda
- `gcp-cloud-run` — Google Cloud Run
- `cloudflare-workers-expert` — Cloudflare Workers

---

### 🔒 "Tôi muốn kiểm tra bảo mật"

| Tình huống | Skill |
|-----------|-------|
| Quét lỗ hổng tổng thể (STRIDE/OWASP) | `ck-security` |
| Quét secrets, hardcoded keys | `security-scan` |

**Community skills bổ sung:**
- `pentest-checklist` — Checklist pentest
- `api-security-best-practices` — Bảo mật API
- `red-team-tactics` — Kỹ thuật Red Team

---

### 📱 "Tôi đang làm Mobile App"

| Tình huống | Skill |
|-----------|-------|
| React Native / Flutter / SwiftUI | `mobile-development` |

**Community skills bổ sung:**
- `flutter-expert` — Flutter chuyên sâu
- `react-native-architecture` — Kiến trúc RN
- `ios-developer` — iOS native
- `android-jetpack-compose-expert` — Android Jetpack

---

### 📝 "Tôi cần cập nhật tài liệu"

| Tình huống | Skill |
|-----------|-------|
| Cập nhật docs dự án | `docs` |
| Tìm docs thư viện/framework | `docs-seeker` |
| Vẽ diagram (Mermaid) | `mermaidjs-v11` |
| Vẽ diagram (Excalidraw) | `excalidraw` |

---

### 🤖 "Tôi muốn xây dựng AI Agent"

| Tình huống | Skill |
|-----------|-------|
| Phân tích ảnh/video/audio | `ai-multimodal` |
| Tối ưu context window | `context-engineering` |
| Build MCP server | `mcp-builder` |
| Google ADK Python | `google-adk-python` |

**Community skills bổ sung:**
- `multi-agent-architect` — Thiết kế multi-agent
- `langgraph` — LangGraph patterns
- `langchain-architecture` — LangChain
- `crewai` — CrewAI framework
- `prompt-engineering` — Kỹ thuật prompt
- `rag-implementation` — RAG patterns

---

### 💼 "Tôi cần viết nội dung / marketing"

| Tình huống | Skill |
|-----------|-------|
| Landing page, email, headline | `copywriting` |
| Brand identity, logo | `design` |

**Community skills bổ sung:**
- `content-marketer` — Content marketing
- `cold-email` — Email outreach
- `linkedin-profile-optimizer` — LinkedIn
- `seo` (`ai-seo`) — SEO tối ưu
- `landing-page-generator` — Tạo landing page

---

## 💡 Mẹo sử dụng hàng ngày

### 1. Không biết dùng skill gì? → Gõ `/skill find-skills`
```
/skill find-skills Tôi cần tối ưu hiệu suất React app
→ AI sẽ đề xuất: react-best-practices, react-component-performance, performance-optimizer
```

### 2. Muốn brainstorm trước khi quyết định? → Gõ `/brainstorm`
```
/brainstorm Nên dùng PostgreSQL hay MongoDB cho dự án e-commerce?
→ AI phân tích trade-off chi tiết
```

### 3. Muốn AI tự chọn skill? → Chỉ cần mô tả bình thường
AI đã được cấu hình để tự động đọc bảng `skill-domain-routing` và chọn skill phù hợp. Bạn không cần phải nhớ tên skill, chỉ cần nói bạn muốn làm gì.

---

## 📂 Cấu trúc Skills trong dự án

```
.ai/skills/
├── claude-skills/      ← 82+ skills chính thức (từ ClaudeKit)
│   ├── ck-plan/        ← Lập kế hoạch
│   ├── cook/           ← Triển khai code
│   ├── test/           ← Testing
│   ├── frontend-design/← UI từ mockup
│   ├── databases/      ← Database design
│   ├── deploy/         ← Triển khai
│   └── ...
└── community-skills/   ← 1450+ skills cộng đồng
    ├── react-best-practices/
    ├── fastapi-pro/
    ├── docker-expert/
    ├── prompt-engineering/
    └── ...
```
