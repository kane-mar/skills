---
name: definition-of-done
description: "Define, enforce, and evolve the Definition of Done (DoD): a shared checklist of quality criteria that all work must meet before it can be considered complete. Covers DoD vs Acceptance Criteria, standard criteria templates, verification workflows, DoD review, and integration with backlog-management and kanban-board skills."
compatibility: "Works with any coding agent harness that supports reading/writing files and running shell commands."
metadata:
  version: "1.0.0"
  patterns: "definition-of-done, quality-gates, acceptance-criteria, done-checklist"
---

# Definition of Done

The **Definition of Done (DoD)** is a shared, explicit checklist of quality criteria that every piece of work must meet before it can be considered complete. It protects quality by ensuring nothing is called "done" prematurely.

> **DoD is not negotiable per item.** Acceptance Criteria vary per story. The DoD applies to *everything* the team delivers. If an item doesn't meet the DoD, it's not done — regardless of whether its Acceptance Criteria are satisfied.

> **Relationship to other skills:** The [backlog-management](../backlog-management/SKILL.md) skill covers writing Acceptance Criteria for individual items. The [kanban-board](../kanban-board/SKILL.md) skill controls *when* an item moves to Done. This skill defines *what "Done" actually means* — the gate that must be passed before that move happens.

---

## 🚀 Quick Start

If you're entering a project that already has a DoD:

```bash
# Read the current Definition of Done
cat DEFINITION_OF_DONE.md
```

If no DoD exists, initialize one:

```bash
# Scripts are located at <SKILL_DIR>/scripts/
# Replace <SKILL_DIR> with the path to this skill directory.
<SKILL_DIR>/scripts/init-dod.sh
```

---

## 🧠 Core Concepts

### What is a Definition of Done?

The Definition of Done is a **shared quality checklist** that the entire team agrees to. Every backlog item — every PBI, every story, every task — must pass every item on this checklist before it can be marked as "Done."

| Aspect | DoD | Acceptance Criteria |
|--------|-----|---------------------|
| **Scope** | Applies to ALL work | Specific to ONE item |
| **Content** | Quality standards, process gates | Functional behavior, edge cases |
| **Who defines** | The whole team | The Product Owner |
| **When set** | Once, reviewed periodically | Per item, during refinement |
| **Negotiable?** | No — team agreement | Yes — can be adjusted per item |

> **Example:** A story's Acceptance Criteria say "User receives a reset link within 30 seconds." The DoD says "All unit tests pass, code reviewed, integration tests pass, documentation updated." Both must be satisfied for the item to be done.

> **Guardrail:** The DoD applies **uniformly** to every item that crosses the finish line, regardless of its unique scope. If a validation step applies only to a specific task — a particular performance benchmark, a niche security requirement, a one-time data migration check — it belongs in that task's **Acceptance Criteria**, not the global DoD. Adding item-specific rules to the DoD breaks the universal contract and forces every item to meet criteria that don't apply to it.

### Why a DoD Matters

- **Prevents technical debt** — no cutting corners on quality to meet a deadline
- **Shared understanding** — everyone agrees on what "done" means, avoiding arguments at the Sprint Review
- **Consistent quality** — every item meets the same bar, regardless of who built it
- **Transparency** — stakeholders know what "done" actually means

### DoD vs "Ready"

| Concept | Definition |
|---------|-----------|
| **Definition of Done** | Criteria that must be met for work to be considered complete |
| **Definition of Ready** | Criteria that must be met for work to be pulled into a sprint |

The DoD is about the exit door. "Ready" is about the entry door. They are complementary but different.

---

## 📁 Shared Structure

```
project-root/
├── DEFINITION_OF_DONE.md        # ← READ THIS FIRST. The team's DoD.
├── .dod/
│   ├── CONFIG.md                # DoD scope, exceptions, review cadence
│   ├── CHECKLIST.md             # The full DoD checklist (machine-readable)
│   ├── VERIFICATION_LOG.md      # Records of items verified against the DoD
│   └── REVIEW_LOG.md            # DoD review/evolution history
```

---

## 📋 Standard DoD Criteria

Below is a comprehensive set of common DoD criteria organized by category. Teams should select the criteria that apply to their context and add any team-specific ones.

### Code Quality
- [ ] **Code reviewed** — reviewed by at least one other agent (or human)
- [ ] **No known defects** — all identified bugs are fixed or explicitly deferred
- [ ] **Coding standards met** — follows the team's agreed style and conventions
- [ ] **No dead code** — no commented-out code, unused imports, or dead branches
- [ ] **Error handling complete** — all error paths are handled gracefully

### Testing
- [ ] **Unit tests pass** — all existing + new unit tests pass
- [ ] **New unit tests added** — coverage for new code (aim for ≥ 80%)
- [ ] **Integration tests pass** — end-to-end flows verified
- [ ] **Edge cases tested** — boundary conditions, empty states, error states
- [ ] **Accessibility checked** — meets WCAG standards (if applicable)

### Documentation
- [ ] **Code documented** — public APIs, complex logic, and configuration explained
- [ ] **README updated** — if the item changes setup, usage, or architecture
- [ ] **Decision rationale logged** — architectural or design decisions recorded

### Operations
- [ ] **No regressions** — existing functionality still works
- [ ] **Performance verified** — no degradation beyond accepted thresholds
- [ ] **Security reviewed** — no new vulnerabilities introduced
- [ ] **Logging added** — sufficient observability for production

### Collaboration
- [ ] **Peer verified** — another agent or human confirms the work meets Acceptance Criteria
- [ ] **Stakeholder sign-off** — PO or end user accepts the work

> **Not all criteria apply to all teams.** Customize the checklist in `.dod/CHECKLIST.md` to match your team's context. A small team building a prototype may have a lightweight DoD. A regulated industry team may have an extensive one.

---

## 🛠️ DoD Workflows

### 1. Initializing the DoD

```bash
<SKILL_DIR>/scripts/init-dod.sh
```

This creates `DEFINITION_OF_DONE.md` with a starter DoD and `.dod/CHECKLIST.md` with the full machine-readable checklist.

Customize the checklist by editing `.dod/CHECKLIST.md` — enable or disable items based on your team's needs.

### 2. Checking an Item Against the DoD

Before marking any work as Done, verify it against every active criterion in the DoD:

```bash
<SKILL_DIR>/scripts/verify-dod.sh CARD-003
```

The script reads the checklist from `.dod/CHECKLIST.md` and walks through each criterion:

```
🔍 Verifying CARD-003 against Definition of Done...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Code reviewed
✅ Unit tests pass
✅ New unit tests added
❌ Integration tests pass  ← NOT MET
✅ Edge cases tested
✅ Code documented
✅ No regressions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Result: ❌ NOT DONE — 1 criterion not met
```

If any criterion is not met, the item cannot be moved to Done. Log the verification result in `.dod/VERIFICATION_LOG.md`.

### 3. Overriding a DoD Item (Rare)

In exceptional cases, the team may agree to waive a specific DoD criterion for a specific item. This must be:

1. **Explicit** — logged in VERIFICATION_LOG.md with the reason
2. **Rare** — frequent overrides mean the DoD needs updating
3. **Team decision** — not a single agent's choice

```bash
<SKILL_DIR>/scripts/verify-dod.sh CARD-003 --override "Integration tests waived — test environment down, will add in next sprint"
```

### 4. Reviewing the DoD

The DoD should be reviewed periodically (e.g., every quarter or after a major retrospective). Update it based on what the team has learned.

```bash
<SKILL_DIR>/scripts/review-dod.sh "Added security review criterion. Removed outdated browser test requirement."
```

Review history is logged in `.dod/REVIEW_LOG.md`.

---

## 📋 Quick Reference Cards

### Before Marking an Item as Done
- [ ] Run `verify-dod.sh <item-id>` to check every DoD criterion
- [ ] Every criterion must be met — no exceptions without a logged override
- [ ] Acceptance Criteria are NOT a substitute for the DoD — both must be satisfied
- [ ] Log the verification result in VERIFICATION_LOG.md

### When Defining the DoD
- [ ] Involve the whole team — DoD is a team agreement, not a mandate
- [ ] Start simple — a 5-item DoD that's enforced is better than a 20-item DoD that's ignored
- [ ] Include criteria from: Code Quality, Testing, Documentation, Operations, Collaboration
- [ ] Write each criterion as a clear yes/no check — no ambiguity

### During DoD Review
- [ ] Review the DoD every quarter or after major retros
- [ ] Ask: "Did we skip any DoD items this sprint?" — that's a signal the DoD is wrong
- [ ] Ask: "Are there new quality concerns not covered?" — add them
- [ ] Ask: "Are any criteria obsolete?" — remove them
- [ ] Log changes in REVIEW_LOG.md

### DoD vs Acceptance Criteria Quick Check

| Question | DoD | AC |
|----------|-----|----|
| Does this apply to every item? | ✅ Yes | ❌ Per item |
| Can an agent decide to skip it? | ❌ No | ✅ With PO |
| Is it about quality or behavior? | Quality | Behavior |
| Who defines it? | Team | Product Owner |

---

## 📚 References

- [DoD vs Acceptance Criteria Deep Dive](references/dod-vs-ac.md) — Detailed explanation with examples of when each applies.

---

## 🔧 Helper Scripts

| Script | Purpose |
|--------|---------|
| `init-dod.sh` | Initialize the Definition of Done structure |
| `verify-dod.sh` | Check an item against every DoD criterion |
| `review-dod.sh` | Log a DoD review or update |

See [scripts/](scripts/) for implementation.
