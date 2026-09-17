---
name: security-and-hardening
description: Hardens code against vulnerabilities. Use when handling user input, authentication, data storage, or external integrations.
---

# Security and Hardening

## Overview

Security-first development. Treat every external input as hostile, every secret as sacred, every authorization check as mandatory.

## Threat Model First (5 minutes)

1. Map trust boundaries (HTTP, forms, files, webhooks, LLM output)
2. Name the assets (credentials, PII, payment data)
3. Run STRIDE: Spoofing / Tampering / Repudiation / Info Disclosure / DoS / Elevation

## Three-Tier Boundary System

**Always Do:**
- Validate all external input at system boundary
- Parameterize all database queries — never concatenate user input into SQL
- Encode output to prevent XSS
- Use HTTPS, hash passwords (bcrypt/argon2), set security headers
- `npm audit` before every release

**Ask First:**
- New auth flows, storing new PII categories, new external integrations
- CORS changes, file upload handlers, permission/role changes

**Never:**
- Commit secrets to version control
- Log sensitive data (passwords, tokens)
- Trust client-side validation as a security boundary
- Use `eval()` or `innerHTML` with user data
- Store sessions in localStorage

## Key Patterns

```typescript
// SQL: always parameterized
await db.query('SELECT * FROM users WHERE id = $1', [userId]);

// Password: bcrypt with 12+ rounds
const hash = await bcrypt.hash(password, 12);

// Input: schema validation at boundary
const result = CreateTaskSchema.safeParse(req.body);
if (!result.success) return res.status(422).json({ error: result.error.flatten() });

// Auth: always check ownership
if (task.ownerId !== req.user.id) return res.status(403).json({ error: 'FORBIDDEN' });

// SSRF: allowlist before fetching user-supplied URLs
if (!ALLOWED_HOSTS.has(url.hostname)) throw new Error('host not allowed');
```

## LLM / AI Features

- Treat all model output as untrusted input — never pass into `eval`, SQL, shell, `innerHTML`
- Assume prompts can be hijacked (prompt injection) — enforce permissions in code, not in prompts
- Keep secrets and other users' data out of prompts
- Constrain tool permissions, require confirmation for destructive actions

## Verification

- [ ] `npm audit` — no critical/high vulnerabilities
- [ ] No secrets in source or git history
- [ ] All input validated at boundaries
- [ ] Auth/authz checked on every protected endpoint
- [ ] Security headers present (check DevTools)
- [ ] Rate limiting on auth endpoints

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
