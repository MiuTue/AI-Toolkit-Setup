---
name: interview-me
description: Extracts what the user actually wants instead of what they think they should want. One-question-at-a-time interview until ~95% confidence. Use when an ask is underspecified ("build me X" without "for whom" or "why now").
---

# Interview Me

## Overview

What people ask for and what they actually want are different things. This skill closes the gap before it costs anything by asking one question at a time, with your best guess attached, until you can predict what the user will say.

## The Process

**Step 1: Hypothesize with confidence number**
```
HYPOTHESIS: You want a way to answer "how are we doing?" in standup.
CONFIDENCE: ~30% — missing: who it's for, what "metrics" means, success criteria
```

**Step 2: Ask one question at a time, each with a guess**
```
Q: Is this for you alone, the team in standup, or execs?
GUESS: Engineering team in standup — "we" usually scopes that way.
```
Wait for reaction before next question.

**Step 3: Listen for "want vs. should want"** — Watch for buzzwords ("scalable", "modern") without specifics. Ask: *"If you didn't have to justify this to anyone, what would you actually want?"*

**Step 4: Restate intent**
```
Here's what I now think you want:
- Outcome:      [one line]
- User:         [who benefits]
- Why now:      [what changed]
- Success:      [how we know it worked]
- Constraint:   [the binding limit]
- Out of scope: [explicitly not doing]
Yes / no / refine?
```

**Step 5: Confirm** — Only explicit "yes" counts. "Sounds good" or "whatever you think" are not confirmation.

**Stop condition:** Can you predict the user's reaction to the next 3 questions? If yes, stop interviewing.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The ask is clear enough" | If you can't write the outcome in one sentence right now, it isn't. |
| "Asking too many questions wastes time" | Building the wrong thing wastes far more. |
| "They said 'whatever you think'" | That's delegation, not decision. Re-ask with two concrete options. |

---
*Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) — MIT License*
