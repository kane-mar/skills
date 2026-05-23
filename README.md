# Skills

[![skills.sh](https://skills.sh/b/kane-mar/skills)](https://skills.sh/kane-mar/skills)

A collection of AI agent skills.

## Skills

| Skill | Description |
|-------|-------------|
| [agent-collaboration](agent-collaboration/SKILL.md) | Scrum-based collaboration for multi-agent teams. Use when multiple agents share a project, need to avoid serial handoffs, swarm bottlenecks, pair on high-risk tasks, or run sprint cycles with planning/syncs/reviews/retros. |
| [backlog-management](backlog-management/SKILL.md) | Manage product and sprint backlogs: writing user stories, acceptance criteria, prioritization frameworks (MoSCoW, WSJF, Eisenhower), backlog refinement, estimation, and dependency mapping. |
| [kanban-board](kanban-board/SKILL.md) | Visualize and manage work using a Kanban board: columns with WIP limits, card lifecycle, swimlanes, explicit policies, and flow metrics. Includes a pi TUI extension for interactive board visualization with `/kanban`. |

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
