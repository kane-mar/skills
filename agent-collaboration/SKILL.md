---
name: agent-collaboration
description: "Cross-functional collaboration for multi-agent teams. Use when multiple agents share a project, need to avoid serial handoffs, swarm bottlenecks, or pair on high-risk tasks. Grounded in the five Scrum values: Commitment, Focus, Openness, Respect, Courage. A continuous-flow model — no sprints, timeboxes, or scheduled ceremonies."
compatibility: "Works with any coding agent harness that supports reading/writing files and running shell commands. No special tools required."
metadata:
  version: "3.0.0"
  inspired-by: "Scrum values (Commitment, Focus, Openness, Respect, Courage) + Cross-functional teams — shared ownership, T-shaped skills, continuous feedback"
  patterns: "scrum-values, cross-functional, swarming, pair-programming, continuous-feedback"
---

# Agent Collaboration — Cross-Functional Team

This skill enables multiple AI agents to work together as a **cross-functional team**. Instead of passing work like a hot potato from agent to agent (serial handoffs), agents with different expertise collaborate **simultaneously or in tight iterative loops** on a shared objective.

> **Core shift:** "That's not my job" → "How do we get this over the finish line together?"

> **A continuous-flow model, not a ceremony-driven one.** Sprint events — Sprint Planning, Daily Scrum, Sprint Review, and Sprint Retrospective — are designed for human teams that need scheduled synchronization. AI agents work continuously and can coordinate instantly, so there are **no sprints, timeboxes, or scheduled ceremonies** here. Instead, work flows continuously: pull from the backlog whenever capacity allows, coordinate through shared artifacts (`DAILY_LOG.md`, `DECISIONS.md`), swarm on bottlenecks the moment they appear, and reflect on how well the five values are being lived *as part of the work* rather than in a scheduled retro. What survives from Scrum is the **values** and the **collaboration patterns** (swarming, pairing, guardrails) — not the calendar.

## Quick Start

If you're an agent entering a project that already has collaboration set up:

```bash
# 1. Read the context
cat .collaboration/WORKING_AGREEMENT.md
cat DEFINITION_OF_DONE.md
cat BACKLOG.md
cat .collaboration/DAILY_LOG.md
cat .collaboration/DECISIONS.md

# 2. Log your presence
echo "- $(date -Iseconds): [your-name] entered the project" >> .collaboration/DAILY_LOG.md

# 3. Check what needs doing
# - Items 'in-progress' that need help → offer to swarm
# - Items 'ready' matching your expertise → claim one
# - Items 'blocked' you can unblock
```

If `.collaboration/` does **not** exist, initialize it. Run from the project root:

```bash
# Scripts are located at <SKILL_DIR>/scripts/init-collab.sh
# Replace <SKILL_DIR> with the path to this skill directory.
<SKILL_DIR>/scripts/init-collab.sh
```

> **The backlog is separate.** This skill reads and updates the single canonical backlog (`BACKLOG.md` + `.backlog/`), which is created and owned by the [backlog-management](../backlog-management/SKILL.md) skill. Run its `init-backlog.sh` first if no backlog exists yet.

Then read the rest of this skill to understand the values, guardrails, and protocols.

---

> **Two modes of operation:** This skill works for both real-time multi-agent teams (agents running simultaneously) and sequential sessions (one agent at a time, handing off via artifacts). Protocols are the same — real-time teams swarm more aggressively; sequential sessions rely more on `DECISIONS.md` and `DAILY_LOG.md` for handoffs.

## Core Concepts

The patterns in this skill (swarming, pairing, Three Amigos, guardrails) are tools. They work **only when the five Scrum values are genuinely adopted** by every agent. Without these values, the practices become empty, robotic rituals. With them, the team creates **psychological safety** — the exact environment required for true cross-functional collaboration to happen naturally.

### Commitment — to the shared objective, each other, and quality
### Focus — on the shared objective, not distractions
### Openness — full transparency about work, progress, and challenges
### Respect — every agent is a capable professional with unique strengths
### Courage — speak up, tackle hard problems, admit uncertainty

### The Values in Action

These values interlock. When a developer realizes a feature is twice as complex as expected:

```
  [COURAGE]           [OPENNESS]            [RESPECT]             [COMMITMENT]
  Developer admits →  Team openly        →  PO Agent listens   →  Team collaborates
  they are stuck      discusses the         without blame;        to adjust scope
  and the shared      bottleneck and        values the            and swarm the
  objective is at     technical debt.       engineer's input.     goal together.
  risk.
```

> Without these values, the developer stays silent, the PO is blindsided, and the team fails in isolation. With them, the obstacle becomes a shared challenge solved through immediate collaboration.

**For detailed exploration of each value** (what it looks like, what it doesn't mean, signs of weakness) see [references/patterns-deep-dive.md](references/patterns-deep-dive.md#1-the-five-scrum-values--deep-dive).

## Operating Rules

Values shape *intentions*. These operating rules shape *behavior* — they make collaboration the path of least resistance rather than an afterthought. High-performing teams formalize these into a **Team Working Agreement** (see `.collaboration/WORKING_AGREEMENT.md`).

### Rule 1 — WIP Limits (Swarming Enforcer)

**The rule:** Set a hard Work-in-Progress (WIP) limit on the backlog. For a team of 3-5 agents, limit active items to 2-3 total. An active item is a row in `BACKLOG.md` whose `Status` is `in-progress`.

**How it forces collaboration:** If the WIP limit is reached, an agent cannot pull a new item into `in-progress`. They *must* look at the `in-progress` or `blocked` rows and ask teammates: *"How can I help you get this story to Done?"* This shifts the metric from *resource utilization* (keeping everyone busy) to *throughput* (getting value out of the pipeline).

```bash
# Count items in BACKLOG.md with Status = in-progress. If at the WIP limit, swarm instead.
```

### Rule 2 — Shared Definition of Done (Cross-Functional Binding)

**The rule:** An item is not "Done" until *all* criteria are met — no agent can declare victory unilaterally. Include cross-functional gates:
- *"Requires peer review from another discipline"* (backend reviews frontend, QA signs off on backend, etc.)
- *"Acceptance criteria verified by PO before marking 'Done'"*

**The Definition of Done lives in `DEFINITION_OF_DONE.md`** — the single authoritative reference, owned by the [definition-of-done](../definition-of-done/SKILL.md) skill. Do **not** keep a duplicate DoD in `WORKING_AGREEMENT.md`; reference it instead.

### Rule 3 — Three Amigos (Design Before Code)

**The rule:** Before coding a story, hold a mini-kickoff with three perspectives:
- **Business** (PO agent) — explains the *what*
- **Technical** (Developer agent) — explains the *how*
- **Testing** (QA agent) — raises the *what ifs*

**Log to DAILY_LOG.md:**
```markdown
## Three Amigos — Story: Password Reset
**PO:** "Users locked out must receive a reset link within 30 seconds"
**Developer:** "Email service has 10 req/min rate limit — we need a queue"
**QA:** "How do we test rate limiting? What if email service is down?"
**Resolution:** Added client cooldown + server queue + error UI. AC updated.
```

### Rule 4 — The 15-Minute Rule (Normalizing Help-Seeking)

**The rule:** If stuck on a problem, spend **15 minutes** trying to solve it (documenting attempts). If still stuck, **must** ask a teammate for help.

**Log to DAILY_LOG.md:**
```markdown
## 15-min attempt — 2026-05-23T10:00:00
**Problem:** WebSocket drops after 60s idle
**Tried:** checked heartbeat (30s), bypassed proxy, added reconnect (state lost)
**Still stuck → asking agent-beta for help**
```

> **See also:** [Pair Programming](#4-pair-programming) for when a teammate responds and you pair on the solution.

### Rule 5 — Guilds (Cross-Team Alignment)

**The rule:** Establish cross-cutting groups from different sub-teams who share a discipline (e.g., Frontend Guild, Security Guild) to align on global standards.

**Log to DECISIONS.md:**
```markdown
## Guild: Frontend Architecture
**Members:** agent-beta (Team A), agent-delta (Team B)
**Decision:** All new components use shared design system. No component-specific CSS outside `src/shared/`.
```

### Rule 6 — Team Working Agreement

Formalize all guardrails into **`.collaboration/WORKING_AGREEMENT.md`**:

| Focus Area | Example Agreement |
|------------|-------------------|
| **WIP Limits** | Max 3 active stories. At limit, swarm before pulling new work. |
| **Code Reviews** | Review within 4h. Sign-off from a different discipline required. |
| **Definition of Done** | Defined in DEFINITION_OF_DONE.md — see the definition-of-done skill. |
| **Three Amigos** | Every story needs Three Amigos before moving to "In Progress". |
| **15-Minute Rule** | Stuck for 15+ min? Ask for help. No exceptions. |
| **Communication** | Design → shared docs. Decisions → DECISIONS.md. Status → BACKLOG.md. |

### Rule 7 — Reflect Continuously on the Values

Don't wait for a scheduled retrospective. As work flows, periodically ask — especially when something goes wrong or feels off:

- **Commitment** — Did everyone stay engaged after their individual task was done?
- **Focus** — Did we stay on the shared objective, or get pulled elsewhere?
- **Openness** — Did we surface bad news early enough?
- **Respect** — Did we truly listen to each other's expertise?
- **Courage** — Did anyone speak up about an uncomfortable truth?

Log the reflection and any action item in `DECISIONS.md` or `DAILY_LOG.md`. This keeps the values alive without a ceremony.

---

## When to Activate This Skill

| Trigger | Action |
|---------|--------|
| Multiple agents share a project | Initialize collaboration structure |
| Work is being passed serially (A → B → C) | Break the chain — use swarming + Three Amigos instead |
| A bottleneck is forming | Check WIP limits → swarm (see below) |
| High-risk or security-sensitive task | Pair program (see below) |
| An agent is stuck for 15+ minutes | Invoke the 15-minute rule → ask for help → micro-pair |
| Teams need technical alignment | Form a Guild (see [Rule 5](#rule-5--guilds-cross-team-alignment)) |
| A value feels weak | Reflect on the values and log an action (see [Rule 7](#rule-7--reflect-continuously-on-the-values)) |

## Shared Structure

```
project-root/
 BACKLOG.md                   # The single canonical backlog (owned by backlog-management)
 .backlog/                    # Backlog item files, archive, config (owned by backlog-management)
 .collaboration/
    WORKING_AGREEMENT.md      # WIP limits, Three Amigos, 15-min rule, etc. (references DEFINITION_OF_DONE.md)
    DAILY_LOG.md              # Activity log: entries, Three Amigos, 15-min attempts
    DECISIONS.md              # Key decisions + Guild alignment log
    PAIRS/                    # Pair session notes
```

## Collaboration Workflows

### 0. Ground Rules (Every Agent Must Follow)

These ground rules are direct expressions of the five Scrum values. Follow them to create psychological safety.

**Read the Working Agreement and the backlog first.** Know the shared objective and the guardrails before doing anything.
**Update shared artifacts after every action.** Log decisions, blockers, and uncertainty — especially bad news.
**Swarm before you wait.** Finished early? Go help a teammate. See a bottleneck? Converge on it.
**Be explicit, not implicit.** Document rationale and trade-offs in DECISIONS.md. Don't assume.

### 1. Setup

Run `./scripts/init-collab.sh` to initialize the collaboration structure. This creates:
- `.collaboration/WORKING_AGREEMENT.md` — Team Working Agreement with defaults
- `.collaboration/DAILY_LOG.md` — Activity log
- `.collaboration/DECISIONS.md` — Key decisions log
- `.collaboration/PAIRS/` — Pair session notes directory

```bash
./scripts/init-collab.sh
```

Then customize the defaults:
- Edit `WORKING_AGREEMENT.md` — tune WIP limits, Three Amigos rules (DoD lives in DEFINITION_OF_DONE.md)

### 2. Pull Work from the Backlog

There is no planning ceremony. Work flows continuously from the single ranked backlog:

1. **Read the backlog** — `BACKLOG.md` and `.backlog/`
2. **Pull the highest-priority ready item** (respect WIP limits — swarm instead if at limit)
3. **Three Amigos before coding** any story
4. **Assign an owner** (set the `Owner` value and move `Status` to `in-progress`)

### 3. Swarming (Bottleneck Protocol)

When a bottleneck appears — a task piling up, a tester overwhelmed, a complex problem blocking progress — the team **swarms** it instead of waiting.

**Trigger conditions:**
- An item in BACKLOG.md has been `in-progress` for too long
- One agent is blocked waiting for another
- Test failures are piling up faster than they're being fixed
- A complex issue needs multiple perspectives

**Protocol:**

1. **Recognize the bottleneck** — Flag it in DAILY_LOG.md
2. **Offer help** — Agents with available capacity ask "How can I help?" or "Let me take X off your plate"
3. **Converge** — Multiple agents work on the same problem simultaneously
4. **Resolve** — Clear the bottleneck together
5. **Log it** — Document what happened and how it was resolved in DECISIONS.md

**Example scenario:** Five user stories are coded but sitting in "Ready for QA." The QA agent is overwhelmed.

```
Instead of: QA agent works through them one-by-one while other agents move on to new coding tasks.

Do this: Two developers "swarm" the QA column. One helps automate tedious regression tests.
The other handles manual edge-case testing under the QA agent's guidance. The team clears
the bottleneck together.
```

### 4. Pair Programming

When a high-risk, complex, or knowledge-critical task appears, two agents pair up.

**When to pair:**
- A critical framework upgrade that only one agent understands (bus factor)
- A security-sensitive component
- A complex algorithm that benefits from real-time review
- Onboarding an agent to an unfamiliar area of the codebase

**Protocol:**

1. **Announce the pair session** — Create a pair note:
   ```
   .collaboration/PAIRS/PAIR-001--backend-alpha--frontend-beta.md
   ```
2. **Define roles**:
   - **Driver** — Writes the code, focuses on the tactical "how"
   - **Navigator** — Reviews each line as it's written, thinks about strategy, edge cases, and testing
3. **Switch roles** periodically (every 15-30 min of agent turns)
4. **Document output** — Log the outcome, key decisions, and knowledge transferred

**Example:** A senior backend agent pairs with a frontend agent on a security architecture upgrade.
The senior drives the architectural logic; the frontend agent provides immediate code review,
asks clarifying questions, and writes unit tests. The task is completed with higher quality,
and the frontend agent now understands the backend security setup — spreading capability.

### 5. Recognizing Completion

When work is delivered, the team reflects on what was accomplished and updates the backlog:

1. **Verify the DoD** — Each completed item must pass the Definition of Done (see [definition-of-done](../definition-of-done/SKILL.md))
2. **Update BACKLOG.md** — Mark done (keep rank), archive the item file, and add any new items discovered along the way
3. **Log outcomes** in DECISIONS.md

---

## Quick Reference Cards

### Before Any Action
- [ ] **Values check:** Am I acting with Commitment, Focus, Openness, Respect, Courage?
- [ ] **Guardrails check:** Is WIP at the limit? (If yes → swarm, don't pull new work)
- [ ] **Guardrails check:** Is this story Three Amigos-ready? (If not → flag it before coding)
- [ ] Read WORKING_AGREEMENT.md (team's explicit rules)
- [ ] Read DAILY_LOG.md (recent activity, blockers, Three Amigos sessions)
- [ ] Check BACKLOG.md (what's my next priority? WIP limit enforced on `in-progress` items)
- [ ] Check DECISIONS.md (any decisions that affect my work?)

### After Any Action
- [ ] **Values check:** Did I live the values? (Commitment → helped others? Openness → shared bad news? Courage → spoke up about problems?)
- [ ] **Guardrails check:** Did I respect the WIP limit? Did I follow the DoD? If I was stuck, did I ask for help within 15 min?
- [ ] Update BACKLOG.md item status
- [ ] Log blockers, Three Amigos sessions, and 15-min attempts in DAILY_LOG.md
- [ ] Log key decisions and Guild alignment in DECISIONS.md
- [ ] Note pair sessions or swarming events in DAILY_LOG.md

### WIP Limit Reached?
→ **Swarm.** Don't pull new work. Ask "How can I help finish what's already started?" This enforces **Commitment** and **Focus**.

### Starting a New Story?
→ **Three Amigos first.** PO + Developer + QA perspectives before a line of code. Log it. This enforces **Openness** and **Respect**.

### Stuck for 15 Minutes?
→ **Ask for help.** Log what you tried. This enforces **Courage** and **Openness**.

### Spot a High-Risk Task?
→ **Pair.** Two agents, one task. Driver + Navigator roles, switch regularly. This is **Respect** (sharing knowledge) and **Commitment** (quality).

### When Completing Work
- [ ] Verify each item against the DoD
- [ ] Mark done in BACKLOG.md (keep rank) and archive the item file
- [ ] Add any new items discovered to the backlog
- [ ] Review and update WORKING_AGREEMENT.md (living document — improve it as you learn)
- [ ] Reflect on the values and log any action items

## References

- [Patterns Deep Dive](references/patterns-deep-dive.md) — Detailed exploration of the five Scrum values, swarming, pair programming, and T-shaped skill development.
- [Templates](references/templates.md) — Ready-to-use templates for collaboration artifacts: Working Agreement, Three Amigos, 15-minute rule, activity log, swarm events, pair programming, and decision log.
- [backlog-management](../backlog-management/SKILL.md) — Managing the product backlog: user stories, acceptance criteria, rank-ordering, refinement.
- [definition-of-done](../definition-of-done/SKILL.md) — Defining and enforcing the Definition of Done: the quality gate everything must pass.

---

## Helper Scripts

| Script | Purpose |
|--------|---------|
| `init-collab.sh` | Initialize the collaboration structure |
| `three-amigos.sh` | Log a Three Amigos session (PO + Developer + QA) |
| `stuck-15.sh` | Log a 15-minute rule attempt (stuck on a problem, asking for help) |
| `swarm.sh` | Log a swarming event — multiple agents converging on a bottleneck |
| `pair-session.sh` | Initialize a pair programming session log |
| `decision.sh` | Log a key decision to DECISIONS.md |

See [scripts/](scripts/) for implementation.
