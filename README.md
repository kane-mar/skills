# Skills

[![skills.sh](https://skills.sh/b/kane-mar/skills)](https://skills.sh/kane-mar/skills)

A collection of AI agent skills.

## Skills

| Skill | Description |
|-------|-------------|
| [product-discovery](product-discovery/SKILL.md) | Autonomous, evidence-driven product discovery. Decide what is worth building using real evidence from Hacker News, Stack Exchange, the App Store, and Reddit. Produces a Build / Don't Build / Investigate Further decision, then hands off to backlog-management. Delegates deep market sizing / channels / monetization / North Star to product-research, and personas / interview guides / simulated interviews to user-communication. |
| [product-research](product-research/SKILL.md) | Evidence-driven market research. Sizes the market (TAM/SAM/SOM), maps distribution channels, analyzes monetization/pricing, and defines the North Star metric — every figure tagged Fact / Inference / Assumption / Gap and tied to a source. Supplies the economic layer a discovery decision rests on. |
| [user-communication](user-communication/SKILL.md) | Understand and talk to users: evidence-grounded personas, behavior-not-opinion interview guides, and simulated user interviews that stay inside their evidence block. Supplies the human layer (who the customer is, what to ask, what they'd say) feeding discovery and product-research. |
| [agent-collaboration](agent-collaboration/SKILL.md) | Scrum-based collaboration for multi-agent teams. Use when multiple agents share a project, need to avoid serial handoffs, swarm bottlenecks, or pair on high-risk tasks. Grounded in the five Scrum values: Commitment, Focus, Openness, Respect, Courage. |
| [backlog-management](backlog-management/SKILL.md) | Manage the product backlog: writing user stories, acceptance criteria, backlog refinement, and progressive granularity (small work at top, large at bottom — break down only as items rise in priority). The backlog is one flat ranked table with no grouped sections; close incomplete work before starting new work, and delivered rows keep their rank. Seeds the backlog from product-discovery outcomes. |
| [definition-of-done](definition-of-done/SKILL.md) | Define, enforce, and evolve the Definition of Done (DoD): shared quality checklist, DoD vs Acceptance Criteria, verification workflows, and periodic review. |

## The Product Flow: Discovery → Backlog → Well-Built Product

The skills form one end-to-end pipeline that takes a fuzzy idea and turns it into a shipped, quality-gated product. Each skill owns one stage and hands off to the next. **Together they close the loop — but each is independently usable** if you only need one stage. Two skills deepen the discovery stage — [product-research](product-research/SKILL.md) for the market/economic layer and [user-communication](user-communication/SKILL.md) for the human layer — while four carry the build through to done.

```
┌──────────────────┐   ┌───────────────────┐   ┌──────────────────────┐   ┌──────────────────────┐
│ product-discovery │ → │  backlog-management │ → │  agent-collaboration │ → │   definition-of-done  │
│  WHAT to build     │   │  ORDER the work     │   │  DO the work          │   │  GATE "done"           │
└──────────────────┘   └───────────────────┘   └──────────────────────┘   └──────────────────────┘
     evidence              ranked list              pull & swarm            quality checklist
     → Build/No/Maybe      → stories + AC          → WIP limits, pairing    → nothing ships early
```

### 1. product-discovery — decide *what* is worth building

Before any work is queued, [product-discovery](product-discovery/SKILL.md) answers the question **"should we build this at all?"** using *real, live evidence* (Hacker News, Stack Exchange, App Store, Reddit), not opinion. It runs a seven-stage loop and produces a **Discovery Report** with a verdict:

- **Build** — commit; seed the MVP into the backlog.
- **Investigate Further** — the evidence is directional but not enough; seed *validation* work, not build work.
- **Don't Build** — stop; nothing enters the backlog.

> **Key discipline:** every claim is tagged Fact / Inference / Assumption / Gap and rated Weak / Medium / Strong. Weak evidence never becomes committed build work — it becomes a validation item. This evidence ladder is the input to the next stage.

**Output →** a Discovery Report (`PRODUCT_DISCOVERY.md`) with a decision.

### 2. backlog-management — turn the decision into an *ordered* list

[backlog-management](backlog-management/SKILL.md) takes the Discovery Report's verdict and converts it into a **single-ranked, ordered backlog** (`BACKLOG.md` + `.backlog/`) grounded in Scrum's definition. It:

- Sets the **product goal** from the discovery's opportunity summary.
- Seeds MVP slices as `feature` items and validation questions as `improvement` items — **never as build work when the evidence is weak**.
- Writes **user stories + acceptance criteria** on the top items, pulling the *real* customer problems from the discovery report into the AC.
- Maintains **progressive granularity**: small work at the top, large work at the bottom, broken down only as it rises.

> **Key discipline:** the backlog is **one flat, single-ranked list** — no grouped sections. Rank *is* priority; there is exactly one "what do I do next?" answer.

**Output →** a ranked `BACKLOG.md` with the top items ready to pull.

### 3. agent-collaboration — *do* the work, together

[agent-collaboration](agent-collaboration/SKILL.md) governs how a team of agents actually executes the ranked backlog. It is a **continuous-flow model** (no sprints, timeboxes, or ceremonies). Agents:

- **Pull from the top** of the backlog, always in priority order.
- **Swarm** on bottlenecks the moment they appear, rather than waiting.
- Enforce **WIP limits** (2–3 active items for a 3–5 agent team) to guarantee finished work over started work.
- Pair on high-risk items and coordinate through shared artifacts (`DAILY_LOG.md`, `DECISIONS.md`).

> **Key discipline:** close incomplete work before starting new work. The five Scrum values (Commitment, Focus, Openness, Respect, Courage) make the patterns real rather than robotic.

**Output →** the work gets *built*, in priority order, with bottlenecks cleared.

### 4. definition-of-done — gate what counts as "done"

[definition-of-done](definition-of-done/SKILL.md) provides the **quality gate** every item must pass before it's marked complete. The **Definition of Done (DoD)** is a shared, non-negotiable checklist (tests pass, reviewed, documented, etc.) that applies uniformly to *all* work — distinct from per-item **Acceptance Criteria**.

> **Key discipline:** nothing is "done" until it meets the DoD, regardless of whether its Acceptance Criteria are satisfied. The DoD lives in one authoritative `DEFINITION_OF_DONE.md`, referenced (not duplicated) by everything else.

**Output →** shipped work that genuinely meets the quality bar, not just "code written."

### The loop closes

When work is marked done, the team's learning feeds back to the top: new customer signals, unmet needs, and validation results found *while building* become fresh input for another discovery cycle. The pipeline is circular, not linear:

```
   discovery → backlog → collaboration → done
        ▲                              │
        └────── new evidence found ────┘
```

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
npx skills add kane-mar/skills --skill product-discovery
```

```bash
npx skills add kane-mar/skills --skill product-research
```

```bash
npx skills add kane-mar/skills --skill user-communication
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
