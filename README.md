# Skills

[![skills.sh](https://skills.sh/b/kane-mar/skills)](https://skills.sh/kane-mar/skills)

A collection of AI agent skills.

## Skills

| Skill | Description |
|-------|-------------|
| [agent-collaboration](agent-collaboration/SKILL.md) | Scrum-based collaboration for multi-agent teams. Use when multiple agents share a project, need to avoid serial handoffs, swarm bottlenecks, or pair on high-risk tasks. Grounded in the five Scrum values: Commitment, Focus, Openness, Respect, Courage. |
| [backlog-management](backlog-management/SKILL.md) | Manage the product backlog: writing user stories, acceptance criteria, backlog refinement, and progressive granularity (small work at top, large at bottom — break down only as items rise in priority). The backlog is one flat ranked table with no grouped sections; close incomplete work before starting new work, and delivered rows keep their rank. |
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
npx skills add kane-mar/skills --skill definition-of-done
```

### List available skills

```bash
npx skills add kane-mar/skills --list
```
