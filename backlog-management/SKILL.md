---
name: backlog-management
description: "Manage product and sprint backlogs: writing user stories, acceptance criteria, prioritization frameworks (MoSCoW, WSJF, Eisenhower), backlog refinement, estimation, and dependency mapping. Use when maintaining a backlog, preparing for sprint planning, or triaging incoming work."
compatibility: "Works with any coding agent harness that supports reading/writing files and running shell commands."
metadata:
  version: "1.0.0"
  patterns: "backlog-refinement, prioritization, estimation, user-stories, acceptance-criteria, dependency-mapping"
---

# Backlog Management

This skill provides structured workflows for managing product and sprint backlogs with AI agents. It covers the full lifecycle: capturing ideas, writing user stories with acceptance criteria, prioritizing using established frameworks, estimating effort, refining items, and maintaining a healthy backlog.

> **Relationship to agent-collaboration:** This skill focuses on the *backlog artifact itself* — its structure, quality, and prioritization. The [agent-collaboration](../agent-collaboration/SKILL.md) skill focuses on *team ceremonies* (sprint planning, daily syncs, retros). They work well together: use backlog-management to keep your backlog healthy, and agent-collaboration to run the sprint rhythm.

---

## 🚀 Quick Start

If you're entering a project that already has backlog management set up:

```bash
# Read the current state
cat BACKLOG.md
cat .collaboration/BACKLOG.md   # if agent-collaboration is active
```

If no backlog exists, initialize one:

```bash
# Scripts are located at <SKILL_DIR>/scripts/
# Replace <SKILL_DIR> with the path to this skill directory.
<SKILL_DIR>/scripts/init-backlog.sh
```

---

## 🧠 Core Concepts

### What is a Backlog?

A backlog is a prioritized list of work items (features, bugs, tech debt, improvements) that a team maintains. It is:

- **Living** — continuously refined, never "finished"
- **Prioritized** — items at the top are more important/urgent than items at the bottom
- **Decomposable** — large items (epics) are broken down into smaller items (stories, tasks)
- **Estimable** — items should be small enough to estimate with reasonable confidence

### Backlog Types

| Type | Purpose | Horizon | Owner |
|------|---------|---------|-------|
| **Product Backlog** | All work the team might do | Weeks to months | Product Owner / PM agent |
| **Sprint Backlog** | Work committed for one sprint | 1-2 weeks | Development team |
| **Icebox** | Ideas deferred indefinitely | Unknown | Anyone |
| **Bug Backlog** | Known defects | Varies | QA / Dev agents |

---

## 📁 Shared Structure

```
project-root/
├── BACKLOG.md                   # ← READ THIS FIRST. The product backlog.
├── .backlog/
│   ├── CONFIG.md                # Prioritization framework, estimation scale, workflow rules
│   ├── ITEMS/                   # Individual backlog items (one file per item)
│   │   ├── ITEM-001--user-auth.md
│   │   ├── ITEM-002--password-reset.md
│   │   └── ...
│   ├── EPICS.md                 # Epics (large initiatives broken into items)
│   ├── DEPENDENCIES.md          # Dependency map between items
│   ├── REFINEMENT_LOG.md        # Notes from backlog refinement sessions
│   └── ICEBOX.md                # Deferred ideas
```

---

## 🛠️ Backlog Workflows

### 1. Capturing a New Item

When a new idea, feature request, or bug is identified, capture it as a backlog item with minimal structure first (don't let perfect be the enemy of captured):

```bash
# Quick capture
<SKILL_DIR>/scripts/capture-item.sh "User can reset password via email" "feature" "high"
```

**Minimum viable capture** (log directly to BACKLOG.md or ICEBOX.md):

```markdown
| Item | Type | Priority | Notes |
|------|------|----------|-------|
| User password reset | feature | high | Need email service integration |
```

### 2. Writing a User Story

When an item is refined for sprint planning, write it as a full user story:

```
**As a** [type of user]
**I want** [action or capability]
**So that** [benefit or value]

**Acceptance Criteria:**
1. [Scenario 1 — happy path]
2. [Scenario 2 — edge case]
3. [Scenario 3 — error case]

**Technical Notes:**
- [constraints, dependencies, implementation hints]
```

**Example:**

```markdown
## ITEM-003: Password Reset

**As a** registered user who has forgotten their password
**I want** to reset my password via email
**So that** I can regain access to my account

**Acceptance Criteria:**
1. User enters email on "Forgot Password" page → receives reset link within 30s
2. Reset link expires after 15 minutes
3. Using an expired link shows "Link expired — request a new one"
4. Using an invalid link shows "Invalid reset link"

**Technical Notes:**
- Email service has 10 req/min rate limit → needs client cooldown + server queue
- Reset tokens stored hashed in DB
- Rate limit: max 3 reset requests per email per hour

**Estimate:** 5 story points
```

### 3. Prioritization Frameworks

The CONFIG.md defines which framework the team uses. Supported frameworks:

#### MoSCoW (Simple, common)

| Category | Meaning | Backlog Action |
|----------|---------|---------------|
| **M**ust have | Non-negotiable for launch | Top of backlog |
| **S**hould have | Important but not critical | High priority |
| **C**ould have | Nice to have | Medium priority |
| **W**on't have | Explicitly out of scope | Icebox or next release |

```bash
# Prioritize using MoSCoW
<SKILL_DIR>/scripts/prioritize.sh --method moscow --item ITEM-003 --category M
```

#### WSJF (Weighted Shortest Job First — SAFe)

Formula: `WSJF = (Business Value + Time Criticality + Risk Reduction) / Job Size`

```bash
# Score an item using WSJF
<SKILL_DIR>/scripts/prioritize.sh --method wsjf --item ITEM-003 --value 8 --criticality 5 --risk 3 --size 5
```

#### Eisenhower Matrix (For triaging incoming work)

| | Urgent | Not Urgent |
|---|--------|------------|
| **Important** | Do first (Sprint) | Schedule (Backlog) |
| **Not Important** | Delegate | Delete / Icebox |

### 4. Estimation

Estimate items using a consistent scale defined in CONFIG.md:

```bash
<SKILL_DIR>/scripts/estimate.sh ITEM-003 5
```

**Common estimation scales:**

| Scale | Values | Best For |
|-------|--------|----------|
| **Story Points (Fibonacci)** | 1, 2, 3, 5, 8, 13, 21 | Scrum teams |
| **T-Shirt Sizes** | XS, S, M, L, XL, XXL | Quick, rough estimates |
| **Time (hours/days)** | 1h, 4h, 1d, 2d, 3d, 5d+ | Teams new to agile |
| **Complexity (1-5)** | 1=trivial, 5=very complex | Technical teams |

**Estimation guidelines:**
- Items > 13 story points (or XL) should be **split** into smaller items
- Items < 1 story point (or XS) are often chores, not stories
- If two estimators disagree by > 2x, discuss assumptions before averaging

### 5. Backlog Refinement (Grooming)

Regular refinement keeps the backlog healthy. Run every 2-3 days or between sprints.

**Refinement checklist:**

- [ ] **Top 20%** of backlog items have user stories and acceptance criteria
- [ ] **No zombies** — items older than 3 months without activity → move to ICEBOX.md or delete
- [ ] **Dependencies mapped** — items that block each other are linked in DEPENDENCIES.md
- [ ] **Estimates current** — re-estimate items if context has changed significantly
- [ ] **Splitting done** — items > 13 points are broken down
- [ ] **Duplicates merged** — search for overlapping items
- [ ] **Priorities updated** — re-prioritize based on latest context

```bash
# Log a refinement session
<SKILL_DIR>/scripts/refine.sh "Refined top 10 items, moved 3 stale items to icebox, split ITEM-005 into 3 stories"
```

### 6. Sprint Backlog Preparation

When preparing for sprint planning, pull the top N items from the backlog that fit in the sprint:

```bash
# Select items for the sprint (capacity-based)
<SKILL_DIR>/scripts/select-for-sprint.sh 3 "Items for Sprint 4"
```

**Selection rules:**
1. Take items from the top of the prioritized backlog
2. Stop when total estimated effort reaches team capacity
3. Ensure no hard dependency is missing (check DEPENDENCIES.md)
4. Include at least one bug fix if bugs exist in the backlog

### 7. Dependency Mapping

Items often depend on each other. Track these in `.backlog/DEPENDENCIES.md`:

```markdown
## Dependency Map

| Item | Depends On | Blocks | Notes |
|------|-----------|--------|-------|
| ITEM-003: Password Reset | ITEM-001: User Auth | — | Needs auth system first |
| ITEM-007: Email Template | — | ITEM-003 | Must be done before password reset emails |
```

```bash
# Add a dependency
<SKILL_DIR>/scripts/add-dependency.sh ITEM-003 "depends-on" ITEM-001
```

---

## 📋 Quick Reference Cards

### When Capturing a New Item
- [ ] Give it a unique ID (ITEM-NNN)
- [ ] Record: description, type (feature/bug/tech-debt/improvement), source
- [ ] Assign a rough priority now; refine later
- [ ] If unclear → put in ICEBOX.md, not the main backlog

### When Refining an Item
- [ ] Write a user story (As a... I want... So that...)
- [ ] Define acceptance criteria (happy path + edge cases + error cases)
- [ ] Estimate effort
- [ ] Map dependencies
- [ ] Check for duplicates

### Before Sprint Planning
- [ ] Top items have stories + AC + estimates
- [ ] Dependencies are clear
- [ ] Stale items are moved to ICEBOX.md
- [ ] Team capacity is known
- [ ] CONFIG.md reflects current prioritization framework

### When Prioritizing
- [ ] Choose a framework (MoSCoW / WSJF / Eisenhower) and be consistent
- [ ] Prioritize by value delivered, not effort required (unless using WSJF)
- [ ] Re-prioritize when new information arrives
- [ ] Log priority decisions in REFINEMENT_LOG.md

---

## 🔧 Helper Scripts

| Script | Purpose |
|--------|---------|
| `init-backlog.sh` | Initialize the backlog directory structure |
| `capture-item.sh` | Quick-capture a new backlog item |
| `prioritize.sh` | Score/re-prioritize an item using a framework |
| `estimate.sh` | Assign/update an estimate to an item |
| `refine.sh` | Log a refinement session |
| `select-for-sprint.sh` | Pull items from backlog into sprint scope |
| `add-dependency.sh` | Add a dependency link between items |

See [scripts/](scripts/) for implementation.
