# Skills

[![skills.sh](https://skills.sh/b/kane-mar/skills)](https://skills.sh/kane-mar/skills)

A collection of AI agent skills.

## Skills

| Skill | Description |
|-------|-------------|
| [agent-collaboration](agent-collaboration/SKILL.md) | Scrum-based collaboration for multi-agent teams. Use when multiple agents share a project, need to avoid serial handoffs, swarm bottlenecks, or pair on high-risk tasks. Grounded in the five Scrum values: Commitment, Focus, Openness, Respect, Courage. |
| [backlog-management](backlog-management/SKILL.md) | Manage product and sprint backlogs: writing user stories, acceptance criteria, backlog refinement, and progressive granularity (small work at top, large at bottom — break down only as items rise in priority). |
| [kanban-board](kanban-board/SKILL.md) | Visualize and manage work using a Kanban board: columns with WIP limits, card lifecycle, explicit policies, and flow metrics. Includes a pi TUI extension for interactive board visualization with `/kanban`. |
| [definition-of-done](definition-of-done/SKILL.md) | Define, enforce, and evolve the Definition of Done (DoD): shared quality checklist, DoD vs Acceptance Criteria, verification workflows, and periodic review. |

## Install

### Install all skills

```bash
npx skills add kane-mar/skills
```

### Install a specific skill

```bash
npx skills add kane-mar/skills --skill agent-collaboration
```

```bash
npx skills add kane-mar/skills --skill backlog-management
```

```bash
npx skills add kane-mar/skills --skill kanban-board
```

```bash
npx skills add kane-mar/skills --skill definition-of-done
```

### List available skills

```bash
npx skills add kane-mar/skills --list
```

## TUI Extensions

The kanban-board skill includes a [pi TUI extension](kanban-board/pi-ext/) for a live-updating, keyboard-navigable Kanban board. See the [TUI Extension section](kanban-board/SKILL.md#-tui-extension) in the skill for install and usage instructions.

```bash
# Quick install (from the skills repo root):
mkdir -p ~/.pi/agent/extensions
ln -sf $(pwd)/kanban-board/pi-ext ~/.pi/agent/extensions/kanban-board
# Then run /reload in pi or restart
```
