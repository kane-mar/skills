# DoD vs Acceptance Criteria — Deep Dive

A common source of confusion is the difference between the **Definition of Done (DoD)** and **Acceptance Criteria (AC)**. They serve different purposes and both must be satisfied before work is complete.

---

## The Fundamental Difference

| | Definition of Done | Acceptance Criteria |
|---|---|---|
| **Answers** | "Is this work complete to the team's quality standard?" | "Does this work behave correctly?" |
| **Scope** | Global — applies to every item | Local — specific to one story |
| **Focus** | Quality, process, completeness | Behavior, functionality, edge cases |
| **Changes** | Rare — reviewed quarterly | Often — refined per sprint |
| **Who owns it** | The whole team | The Product Owner |

## Examples

### Scenario: User Password Reset

**Acceptance Criteria** (specific to this story):
1. User enters email → reset link sent within 30s
2. Link expires after 15 minutes
3. Invalid link shows error message
4. Rate limit: max 3 requests per hour per email

**Definition of Done** (applies to ALL work):
- Code reviewed by another agent
- Unit tests pass (existing + new)
- Integration tests pass
- Edge cases tested
- Code documented
- Decision rationale logged
- No regressions
- Peer verified

Both must be satisfied. If the acceptance criteria are all met but the code wasn't reviewed, **it's not done**.

---

## Common Mistakes

### Mistake 1: Putting DoD items into Acceptance Criteria

**Bad:** Acceptance Criteria include "Code must be reviewed" for every story.

**Why it's bad:** This duplicates the DoD on every item. If the DoD changes, you must update every story. Keep the DoD in one place.

### Mistake 2: Skipping the DoD to "save time"

**Bad:** "We know the code works, let's just mark it done without reviewing."

**Why it's bad:** The DoD exists to catch exactly this kind of shortcut. Skipping it creates technical debt and erodes quality standards. If the DoD is too onerous, review the DoD — don't ignore it.

### Mistake 3: Confusing DoD with "Ready"

**Bad:** Using the DoD as a checklist before starting work.

**Why it's bad:** The DoD is about completion, not readiness. A separate "Definition of Ready" covers what's needed to start work (e.g., acceptance criteria defined, estimated, dependencies clear).

---

## When Each Applies

```
Item created → refined → Acceptance Criteria written
                              ↓
                      Sprint Planning: item pulled in
                              ↓
                      Work begins (In Progress)
                              ↓
                      Acceptance Criteria verified
                              ↓
                      DoD checklist verified ← YOU ARE HERE
                              ↓
                      Item moves to Done
```

The DoD is the **final gate** — the last check before work leaves the active board.
