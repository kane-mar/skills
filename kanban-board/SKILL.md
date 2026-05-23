---
name: kanban-board
description: "Visualize and manage work using a Kanban board: columns with WIP limits, card lifecycle (add, move, block, archive), swimlanes, explicit policies, flow metrics (cycle time, lead time, throughput), and bottleneck detection. Use when tracking work in progress, limiting multitasking, or improving flow through the workflow."
compatibility: "Works with any coding agent harness that supports reading/writing files and running shell commands."
metadata:
  version: "1.0.0"
  inspired-by: "Kanban Method (David J. Anderson) — Visualize, Limit WIP, Manage Flow, Make Policies Explicit, Improve Collaboratively"
  patterns: "kanban, wip-limits, flow-management, bottleneck-detection, cycle-time"
---

# Kanban Board

This skill provides a lightweight Kanban board for AI agents to visualize and manage workflow. It is grounded in the six core Kanban practices: **visualize the workflow, limit work in progress, manage flow, make policies explicit, implement feedback loops, and improve collaboratively**.

> **Relationship to backlog-management:** The [backlog-management](../backlog-management/SKILL.md) skill manages the *product backlog* — what to build and in what priority order. This skill manages the *Kanban board* — visualizing and flowing work through the system. Together they form a complete pull-based workflow: backlog-management decides *what* to work on next; kanban-board controls *how much* is in progress and tracks flow.

---

## 🚀 Quick Start

If you're entering a project that already has a Kanban board set up:

```bash
# Read the board state and policies
cat KANBAN.md
cat .kanban/CONFIG.md
cat .kanban/BOARD.md
```

If no board exists, initialize one:

```bash
# Scripts are located at <SKILL_DIR>/scripts/
# Replace <SKILL_DIR> with the path to this skill directory.
<SKILL_DIR>/scripts/init-board.sh
```

---

## 🧠 Core Concepts

### The Six Kanban Practices

| # | Practice | What It Means for Agents |
|---|----------|--------------------------|
| 1 | **Visualize the workflow** | Make work and its status visible on the board. Hidden work cannot be managed. |
| 2 | **Limit WIP** | Cap the number of items in each column. This forces completion before starting new work. |
| 3 | **Manage flow** | Monitor how work moves through the board. Bottlenecks show up as items piling up in a column. |
| 4 | **Make policies explicit** | Define clear rules for each column (e.g., "code review required before moving to Done"). |
| 5 | **Implement feedback loops** | Review the board regularly to identify improvements. |
| 6 | **Improve collaboratively** | Use metrics and experiments to evolve the process. |

### Pull-Based System

Kanban is a **pull** system — work is pulled into the next column only when there is capacity, not pushed when someone finishes. This is the opposite of a push-based system where work is assigned and forced through.

> **Core mechanism:** An item moves from `Column A` to `Column B` only when `Column B` has room under its WIP limit. If `Column B` is full, work stays in `Column A` — even if someone has capacity. This exposes bottlenecks immediately.

### WIP Limits

Every column has a Work-in-Progress (WIP) limit — a cap on how many items can be in that column at once. WIP limits are the heart of Kanban:

- **Too high** → no pressure to finish work; items pile up
- **Too low** → team starves; not enough work flowing
- **Just right** → smooth flow, fast cycle times, early bottleneck detection

```bash
# Check current WIP state
<SKILL_DIR>/scripts/check-wip.sh
```

### Cycle Time vs Lead Time

| Metric | Definition | Starts | Ends |
|--------|------------|--------|------|
| **Cycle Time** | Time to complete an item once work starts | First column | Done column |
| **Lead Time** | Total time from request to delivery | Backlog entry | Done column |

> **Goal:** Reduce cycle time by limiting WIP and eliminating bottlenecks.

---

## 📁 Shared Structure

```
project-root/
├── KANBAN.md                   # ← READ THIS FIRST. Board overview and active cards.
├── .kanban/
│   ├── CONFIG.md               # Column definitions, WIP limits, policies
│   ├── BOARD.md                # Current board state (card positions)
│   ├── CARDS/                  # Individual card files
│   │   ├── CARD-001--user-auth.md
│   │   ├── CARD-002--password-reset.md
│   │   └── ...
│   ├── POLICIES.md             # Explicit column policies
│   ├── METRICS.md              # Cycle time, lead time, throughput tracking
│   └── BLOCKERS.md             # Blocked items and their impediments
```

---

## 📋 Operating Rules

### Rule 1 — Respect WIP Limits

Never exceed a column's WIP limit. Before moving a card into a column, count how many cards are already there. If at the limit, the card stays where it is.

### Rule 2 — Pull, Don't Push

Work is pulled by the next column when it has capacity. Do not push work into a column that is full. If the next column is at WIP capacity, focus on finishing work in the current column to create space.

### Rule 3 — Visualize Blockers

When a card is blocked, mark it immediately on the board. Log the blocker in BLOCKERS.md. Do not hide blocked work — it must remain visible.

### Rule 4 — Finish Before Starting

When WIP limits are reached, do not start new work. Help finish what's already in progress first. This is the same principle as [Rule 3 in backlog-management](../backlog-management/SKILL.md#rule-3--help-others-before-pulling-new-work).

### Rule 5 — Measure and Improve

Log cycle time for each completed card in METRICS.md. Review metrics regularly to identify improvement opportunities.

---

## 🛠️ Kanban Workflows

### 0. Drawing the Board

When asked to show the current board state, generate a text-based visualization using the format described in [references/board-visualization.md](references/board-visualization.md).

```
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
| Product Backlog Item (PBI)         | Work Not Started                         | Work in Progress (WIP)             | Done                               |
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
| Secure Customer Portal Access      | - Draft identity verification reqs       | - Establish secure login protocol  | - System baseline security review  |
|                                    | - Map password recovery journey          |                                    |                                    |
...
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
```

Each row is one PBI. Columns go in this order: PBI name → Work Not Started → Work in Progress → Done.

---

### 1. Initializing the Board

```bash
<SKILL_DIR>/scripts/init-board.sh
```

This creates the default board with standard columns:
- **Backlog** (no WIP limit) — work waiting to be started
- **Ready** (WIP: 3) — work that's ready to pull
- **In Progress** (WIP: 3) — actively being worked on
- **Review** (WIP: 2) — awaiting review
- **Done** (no WIP limit) — completed work

Customize columns and WIP limits in `.kanban/CONFIG.md`.

### 2. Adding a Card

```bash
<SKILL_DIR>/scripts/add-card.sh "Implement password reset" "feature" "high"
```

Cards should be small enough to complete quickly. If a card is too large, it should be split.

**Card template:**

```markdown
---
id: CARD-003
title: "Implement password reset"
type: feature
priority: high
status: backlog
created: 2026-05-23T10:00:00
---

## Description
Users can reset their password via email.

## Acceptance Criteria
- [ ] Reset link sent within 30s
- [ ] Link expires after 15 minutes
- [ ] Invalid link shows error message

## Blockers
(none)

## Cycle Time
started: —
completed: —
```

### 3. Moving a Card

Cards move through columns by being **pulled** by the next stage, not pushed.

```bash
# Move a card to the next column (only if WIP allows)
<SKILL_DIR>/scripts/move-card.sh CARD-003 "In Progress"

# Move a card to a specific column
<SKILL_DIR>/scripts/move-card.sh CARD-003 "Done"

# Block a card
<SKILL_DIR>/scripts/block-card.sh CARD-003 "Waiting for email service API key"
```

**Rule:** Before moving, the script checks whether the target column has capacity under its WIP limit. If the column is full, the card stays where it is and the bottleneck is reported.

### 4. Checking WIP Status

```bash
<SKILL_DIR>/scripts/check-wip.sh
```

Output example:
```
📊 WIP Status
━━━━━━━━━━━━━━━
Backlog      —  12 cards  (limit: ∞)
Ready        —   3 cards  (limit:  3) ⚠️ AT LIMIT
In Progress  —   2 cards  (limit:  3) ✅
Review       —   2 cards  (limit:  2) ⚠️ AT LIMIT
Done         —   8 cards  (limit: ∞)
━━━━━━━━━━━━━━━
🔴 Bottleneck detected: Review column is at WIP limit.
   → 1 card waiting in In Progress to enter Review.
```

### 5. Blocking and Unblocking

When work is blocked, it stays visible on the board but is flagged:

```bash
<SKILL_DIR>/scripts/block-card.sh CARD-003 "Waiting for email service API key from DevOps"
```

When the blocker is resolved:

```bash
<SKILL_DIR>/scripts/unblock-card.sh CARD-003
```

**Blockers are not hidden.** A blocked card remains on the board so the team can see the bottleneck. This is the practice of *visualizing the workflow* — hiding blocked work is anti-Kanban.

### 6. Archiving Completed Cards

When a card reaches Done, archive it to keep the board clean:

```bash
<SKILL_DIR>/scripts/archive-card.sh CARD-003
```

Archiving moves the card to `.kanban/ARCHIVED/` and logs the cycle time.

### 7. Logging Cycle Time

When a card is archived, the script records its cycle time in METRICS.md:

```markdown
## Cycle Time Log

| Card | Started | Completed | Cycle Time |
|------|---------|-----------|------------|
| CARD-003: Password Reset | 2026-05-20 | 2026-05-23 | 3 days |
```

### 8. Swimlanes (Optional)

For teams handling multiple work streams, cards can be organized into **swimlanes** — horizontal rows on the board that separate different types of work:

| Swimlane | Purpose |
|----------|---------|
| **Features** | New feature development |
| **Bugs** | Defect fixes |
| **Tech Debt** | Refactoring, infrastructure |
| **Chores** | Maintenance, minor tasks |

Swimlanes are defined in `.kanban/CONFIG.md`. Each swimlane has its own set of columns with optional per-swimlane WIP limits.

---

## 📋 Quick Reference Cards

### Before Any Action
- [ ] **Read the board** — read KANBAN.md, BOARD.md, and CONFIG.md to understand current state and policies
- [ ] **Check WIP limits** — run `check-wip.sh` to see where there is capacity
- [ ] **Check for blockers** — review BLOCKERS.md before starting work

### When Adding a Card
- [ ] Give it a unique ID (CARD-NNN)
- [ ] Add to the Backlog column initially
- [ ] Record type, priority, and description
- [ ] If unclear → add minimal info; refine later

### When Moving a Card
- [ ] Verify target column is under its WIP limit
- [ ] Record the move in BOARD.md
- [ ] If blocked in the target → flag in BLOCKERS.md
- [ ] If moving to Done → log cycle time in METRICS.md

### When a Card Is Blocked
- [ ] Flag it on the board — do not hide it
- [ ] Log the blocker in BLOCKERS.md with the reason
- [ ] Unblock as soon as the impediment is resolved
- [ ] If blocked for too long → escalate or split the card

### When Reviewing Flow
- [ ] Check which columns are at WIP limit
- [ ] Look for items piling up in one column (bottleneck)
- [ ] Review cycle times in METRICS.md — are they trending up or down?
- [ ] Make one process change based on the data

---

## 📚 References

- [Kanban Board Visualization](references/board-visualization.md) — Text-based board format. When asked to draw the current board, generate output matching this template.
- [Kanban Method Overview](references/kanban-overview.md) — The six core Kanban practices explained for AI agents.

---

## 🔧 Helper Scripts

| Script | Purpose |
|--------|---------|
| `init-board.sh` | Initialize the Kanban board structure |
| `add-card.sh` | Add a new card to the backlog |
| `move-card.sh` | Move a card between columns (respects WIP) |
| `block-card.sh` | Mark a card as blocked |
| `unblock-card.sh` | Unblock a previously blocked card |
| `check-wip.sh` | Display WIP status across all columns |
| `archive-card.sh` | Archive a completed card and log cycle time |

See [scripts/](scripts/) for implementation.
