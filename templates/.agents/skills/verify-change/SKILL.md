---
name: verify-change
description: Selects and runs proportionate validation for a code change. Use before declaring a task complete, merging a change, or shipping a release candidate.
---

# Verify Change

1. Inspect the diff and project configuration to select the narrowest commands that cover changed behavior.
2. Run formatting, linting, type checks, tests, builds, or manual verification only when relevant.
3. Capture failures without masking or weakening tests merely to pass validation.
4. Summarize commands, outcomes, coverage gaps, and follow-up work.
