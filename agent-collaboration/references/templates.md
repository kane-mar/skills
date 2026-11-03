# Collaboration Templates — Cross-Functional Team

Ready-to-use templates for cross-functional collaboration artifacts. Copy and fill as needed.

## Team Working Agreement (WORKING_AGREEMENT.md)

```markdown
# Team Working Agreement

> A living document. Review and update continuously as you learn.

## WIP Limits
- Maximum active items (Status = in-progress) in BACKLOG.md at any time: 3
- If at limit, swarm before pulling new work.

## Definition of Done
- The authoritative DoD is in `DEFINITION_OF_DONE.md` (owned by the definition-of-done skill).
- No duplicate here — read and enforce `DEFINITION_OF_DONE.md`.

## Three Amigos
- Every story requires a Three Amigos review before moving to "In Progress"
- Log the session in DAILY_LOG.md

## 15-Minute Rule
- If stuck for 15+ minutes on a problem, ask a teammate for help
- Log what you tried

## Communication
- Design feedback: in shared documents / comments
- Architectural decisions: in DECISIONS.md
- Status: in BACKLOG.md
- Blockers & activity: in DAILY_LOG.md

## Code Reviews
- All pull requests must be reviewed within 4 hours of submission
- Reviews require sign-off from a different discipline
```

## Three Amigos Session Log (for DAILY_LOG.md)

```markdown
## Three Amigos — Story: [story name] (2026-05-23)

**PO:** "[what the user needs]"
**Developer:** "[technical constraints / approach]"
**QA:** "[edge cases / testability concerns]"
**Resolution:** [what changed — scope, design, or acceptance criteria]
```

## 15-Minute Attempt Log (for DAILY_LOG.md)

```markdown
## 15-min attempt — 2026-05-23T10:00:00

**Problem:** [what's stuck]
**Tried:**
  - [what you attempted]
  - [what you attempted]
**Still stuck after 15min → asking [agent-name] for help**
```

## Backlog Entry

The canonical backlog table uses the columns defined by the [backlog-management](../backlog-management/SKILL.md) skill. When collaborating with multiple agents, add an **`Owner`** column to record who is working on each `in-progress` item:

```markdown
| Rank | ID | Title | Type | Status | Notes | Owner |
|------|----|-------|------|--------|-------|-------|
| 1 | ITEM-001 | User password reset | feature | in-progress | Waiting on email service config | agent-alpha |
```

## Activity Log Entry (for DAILY_LOG.md)

```markdown
## 2026-05-23

**agent-name:** What I did, any swarming/pairing activity.
  - Blockers: What's blocking me (or "none")
  - Next: What I'll do next
```

## Swarm Event Log

```markdown
## Swarm Event — 2026-05-23T10:00:00

**Bottleneck:** Description of the bottleneck
**Agents involved:** agent-alpha, agent-beta
**Plan:** How we'll break it down and resolve it
```

## Pair Programming Session

```markdown
---
id: PAIR-001
date: 2026-05-23T10:00:00
driver: agent-alpha
navigator: agent-beta
task: "Implement password reset security module"
status: in-progress
---

### Goals
- Implement rate-limited password reset endpoint
- Add email verification step
- Pass all security scans

### Notes
- Discovered email service has a 10 req/min rate limit
- Decided to add client-side cooldown UX (delegated to beta's next solo task)

### Knowledge Transfer
- agent-beta now understands the email service integration
- agent-alpha learned the frontend cooldown pattern for future reference

### Outcome
- Security module implemented and passing scans
- Rate limiting handled correctly
```

## Decision Log Entry

```markdown
## 2026-05-23: Email service rate limiting

- **Decision:** Use client-side cooldown + server-side rate limiting for password reset emails
- **Rationale:** Email provider limits to 10 req/min. Client cooldown prevents most exceeded limits; server-side catch handles edge cases.
- **Alternatives considered:** Switch email provider, queue-based sending (overengineering for current volume)
- **Values reflected:** Openness (agent-alpha surfaced the limit early), Courage (agent-beta admitted the UI cooldown adds complexity)
- **Logged by:** agent-alpha
```

## Values Reflection

A lightweight, in-the-flow alternative to a scheduled retrospective. Use it when something goes wrong or feels off — or just periodically — and log the result in DECISIONS.md.

```markdown
## Values Reflection — 2026-05-23

| Value | Reflection |
|-------|------------|
| **Commitment** | Did everyone stay engaged after their individual task was done? |
| **Focus** | Did we stay on the shared objective, or get pulled elsewhere? |
| **Openness** | Did we surface bad news early enough? |
| **Respect** | Did we truly listen to each other's expertise? |
| **Courage** | Did anyone speak up about an uncomfortable truth? |

_Which value was weakest? What one thing can we do to strengthen it?_

## Action Items
- [ ]
- [ ]
```

## Swarming Invitation (for DAILY_LOG.md)

```markdown
**Swarm needed:** [description of bottleneck]
  - Who can help? [agent names]
  - What's needed: [specific help request]
```

## Pairing Invitation (for DAILY_LOG.md)

```markdown
**Pairing request:** [task description]
  - Why: [high-risk / knowledge transfer / complex]
  - Looking for: [driver / navigator / specific expertise]
```
