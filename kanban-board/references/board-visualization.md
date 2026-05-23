# Kanban Board Visualization

When asked to draw the current Kanban board, generate a text-based board using the format below.

---

## Board Template

```
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
| Product Backlog Item (PBI)         | Work Not Started                         | Work in Progress (WIP)             | Done                               |
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
| Secure Customer Portal Access      | - Draft identity verification reqs       | - Establish secure login protocol  | - System baseline security review  |
|                                    | - Map password recovery journey          |                                    |                                    |
|                                    | - Review compliance/privacy guidelines   |                                    |                                    |
|                                    | - Define session timeout policies        |                                    |                                    |
|                                    | - Design administrative lockout workflow |                                    |                                    |
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
| Executive Performance Dashboard    | - Define core business metrics & KPIs    |                                    |                                    |
|                                    | - Map source data systems for revenue    |                                    |                                    |
|                                    | - Draft executive layout wireframes      |                                    |                                    |
|                                    | - Establish data refresh schedules       |                                    |                                    |
|                                    | - Define financial data access levels    |                                    |                                    |
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
| Real-Time Data Sync                | - Define maximum data latency limits     |                                    |                                    |
|                                    | - Identify critical sync business events |                                    |                                    |
|                                    | - Draft data reconciliation procedures   |                                    |                                    |
|                                    | - Establish peak hour performance limits |                                    |                                    |
|                                    | - Map fallback offline workflows         |                                    |                                    |
+------------------------------------+------------------------------------------+------------------------------------+------------------------------------+
```

---

## Rules for Generating the Board

### Column Order

Always use these four columns, in this order:

1. **Product Backlog Item (PBI)** — The name of the work item / epic / story
2. **Work Not Started** — Tasks that are defined but not yet begun
3. **Work in Progress (WIP)** — Tasks currently being worked on
4. **Done** — Completed tasks

### Row Structure

- Each row represents one PBI (a user story, feature, or epic)
- The PBI name goes in the first column, spanning the full row
- Bullet points under each column show individual tasks within that PBI
- An empty column means no tasks are in that stage for that PBI

### WIP Priority

Within the **Work in Progress (WIP)** column, tasks should be listed in priority order — the most important active task first.

### Layout Rules

- Use `+--+--+--+--+` separators between rows
- Use `|` for vertical separators
- Align text columns for readability (columns need not be exactly equal width, but should be consistent)
- The full board width should fit in standard terminal width (~120 chars recommended)

### Column Widths

Suggested proportional widths for the four columns:

| Column | Width (chars) | Purpose |
|--------|--------------|---------|
| PBI | 36 | Item name — keep names concise |
| Work Not Started | 42 | Task descriptions |
| WIP | 36 | Active task descriptions |
| Done | 36 | Completed task descriptions |

Adjust widths as needed based on content, but keep the layout readable.
