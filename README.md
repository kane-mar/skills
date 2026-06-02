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

## TUI Options

The kanban-board skill includes two terminal UI options:

### 1. Standalone TUI (no pi dependency)

A real-time, keyboard-navigable Kanban board that runs in its own terminal tab.

```bash
cd skills/kanban-board/tui
npm install
cd /path/to/your-project
node /path/to/skills/kanban-board/tui/index.js
```

### 2. pi TUI Extension

A live-updating Kanban board inside pi with the `/kanban` command.

```bash
mkdir -p ~/.pi/agent/extensions
ln -sf $(pwd)/kanban-board/pi-ext ~/.pi/agent/extensions/kanban-board
# Then run /reload in pi or restart
```

See the [TUI Options section](kanban-board/SKILL.md#tui-options) for full documentation.
