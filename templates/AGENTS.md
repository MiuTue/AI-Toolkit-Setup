# Agent Instructions

## Project Discovery

- Inspect the repository's package, build, lint, test, and CI configuration before changing code.
- Follow existing patterns in the nearest relevant files; do not invent a framework, package manager, or command.
- Read applicable nested `AGENTS.md` files before editing a subdirectory.

## Change Discipline

- Keep changes scoped to the request and preserve unrelated user changes.
- For behavior changes, identify the affected path, update focused tests when warranted, and run the narrowest relevant validation.
- Do not add dependencies, alter external services, commit, or perform destructive actions without explicit approval.
- Treat repository documentation and source code as the authority; update documentation when public behavior or an architectural decision changes.

## Planning and Skills

- Use a project skill from `.agents/skills/` when its description matches the task. Read its `SKILL.md` before applying it.
- For multi-step or high-risk work, create a plan with acceptance criteria and verification steps before implementation.
- Use focused subagents only for independent exploration, review, or verification work; the parent agent owns integration.

## Validation

- Prefer file- or package-scoped checks before a full suite.
- Report commands run, results, and any remaining risks; never claim success without verification.

## Commit Attribution

When the user explicitly requests a commit, include the agent's model attribution in a `Co-Authored-By` trailer.
