---
name: user-communication
description: Understand and talk to users — build personas, write interview guides, and run simulated user interviews. Use when you need to know who the customer is, what to ask them, or what they'd actually say before you've found real users to talk to. Produces research-backed personas, evidence-anchored interview guides, and transcribed simulated interviews whose answers stay grounded in the evidence (never pasted-in bias). Complements product-discovery (which finds the problem) and product-research (which sizes the market) by supplying the human layer.
license: MIT
metadata:
  version: "0.1.0"
  patterns: "personas, user-interviews, interview-guide, customer-discovery, jobs-to-be-done, simulated-interviews"
---

# User Communication

Understand who the customer is, what to ask them, and what they'd say — before (or instead of) talking to real users. This skill turns evidence into **personas**, turns personas into **interview guides**, and produces **simulated interviews** whose answers stay anchored to real evidence rather than drifting into what the interviewer *wants* to hear.

> **Where this fits:** this is the **human layer** that feeds [product-discovery](../product-discovery/SKILL.md) (customer problems, jobs-to-be-done) and [product-research](../product-research/SKILL.md) (who pays, at what price). Discovery *mines* problems from HN/Reddit/Stack Exchange; this skill *names and converses with* the people behind those problems.

> **Core shift:** a persona is not a marketing stereotype. It is a **synthesis of sourced evidence** about a segment. A simulated interview is not the model role-playing a fake person from imagination — it is the model **answering within the constraints of the evidence** it was given, and it must not "know" answers that aren't in that evidence.

## When to use

- "Who is our customer?" / "build me personas for this product."
- "What should I ask in user interviews?"
- "Run a simulated interview with my target user."
- "What are the jobs-to-be-done and pain points for this segment?"
- Preparing for real customer discovery, or standing in for it before real users are reachable.

## The three capabilities

| # | Capability | Produces | Feeds |
|---|---|---|---|
| 1 | **Personas** | Named segments with goals, JTBD, pains, context | interview guides + discovery's "Customer problems" |
| 2 | **Interview guides** | Question scripts, in order, with probe branches | real + simulated interviews |
| 3 | **Simulated interviews** | Transcribed Q&A grounded in evidence | discovery validation + assumptions to test |

### Capability 1 — Personas

Build personas that are **evidence syntheses**, not demographics-with-a-name.

Each persona records:

- **Name + segment label** — a memorable handle for the segment (not a single invented person pretending to be the whole market).
- **Goals** — what this person is trying to achieve (their jobs-to-be-done).
- **JTBD** — the functional, emotional, and social jobs, in the *customer's own language* where possible.
- **Pain points** — the frustrations and unmet needs, each tagged with its source.
- **Context** — role, environment, constraints (platform, team, budget, time).
- **Current solution / workarounds** — what they use today and why it falls short.
- **Success criteria** — what "working" looks like to them.

**Rules:**

- **Each persona must trace to evidence.** Every goal/pain/behavior either cites a source (HN comment, Reddit thread, Stack Exchange question, interview, survey) or is labeled an **Assumption**. A persona with no sources is a stereotype.
- **Do not invent demographics.** Age/gender/location/income that aren't in the evidence are Assumptions — say so, or omit them.
- **Personas are segments, not individuals.** A persona represents a *pattern across a segment*. Name it by the pattern ("The File-Owning Developer"), not a fabricated person ("John, 34, San Francisco").
- **One persona per distinct job, not per fringe behavior.** Split segments only when the JTBD or pain points genuinely differ.

### Capability 2 — Interview guides

Write a guide that surfaces what the customer actually does and feels, in an order that avoids leading.

**Structure (in order):**

1. **Warm-up / context** — who they are, their role, their environment. (Builds rapport, establishes facts.)
2. **Current behavior** — "walk me through the last time you did X." (Behavior, not opinion.)
3. **Jobs-to-be-done** — what they're trying to accomplish, and why it matters.
4. **Pain points & workarounds** — what's hard, what they hack around, what they've tried.
5. **Willingness & constraints** — what they'd pay, what would block adoption.
6. **Wrap-up** — anything else, and a request for referral to another user.

**Rules:**

- **Ask about past behavior, not hypotheticals.** "Tell me about the last time you…" beats "Would you use a tool that…". Hypotheticals invite aspirational, useless answers.
- **Open-ended, non-leading.** "What happened next?" not "Did the lag make you switch?"
- **One question at a time.** No compound questions.
- **Probe, don't accept the first answer.** Have follow-ups ("why?", "tell me more about that", "what did you do then?").
- **Write the guide so the *persona's* evidence drives it.** Each question should target a specific JTBD or pain from the persona; a question that maps to no pain point is filler.

### Capability 3 — Simulated interviews

Run a simulated interview with a persona and produce a transcript **that stays inside the evidence**. This is the risky part, so the rules are strict:

**Setup — before any question is asked:**

1. **Ground the persona.** Assemble every source element for that persona (goals, JTBD, pains, context, current solution) into a single "persona evidence" block. The persona must answer *from this block*.
2. **Declare the evidence boundaries.** State explicitly: *"The persona only knows what is in the evidence block. Answers outside it must be flagged as the model's inference, not the persona's knowledge."*

**Rules for the simulated interviewee:**

- **Answer only from the evidence.** Where the evidence is silent, the persona says "I don't have anything about that" or flags the answer as an inference the model is adding — it must **not** fabricate a confident answer.
- **Stay in character's constraints.** A persona who uses a Mac must not suddenly describe a Windows workflow, unless the evidence supports it.
- **Do not validate the interviewer.** The persona is not a cheerleader for the product idea. If the evidence suggests skepticism or an existing workaround, the persona expresses it. The goal is signal, not confirmation.
- **Resist leading questions.** If the interviewer asks "would you want X?", the persona should answer in terms of its actual jobs and pains, not agree reflexively.

**After the interview, output:**

- **Transcript** — the full Q&A.
- **Evidence map** — which answers were grounded in which source element vs. which were model inference (flagged).
- **Unsurfaced threads** — questions the interviewer *should* have asked but didn't, given the persona's pains.
- **Assumptions to test** — every answer that was inference (not evidence) becomes a real assumption to validate against real users later.

> **⚠️ Honesty about simulation:** a simulated interview is a **thought aid and a hypothesis generator**, not a substitute for real user research. It surfaces the questions worth asking and the assumptions worth testing, but it cannot *discover* what real users would say that isn't already in your evidence. Always hand off real talk to real users when reachable; treat simulated answers as **Inference**, never **Fact**.

## Core principles

1. **Evidence over stereotype.** Personas and answers trace to sources or are labeled Assumption/Inference.
2. **Same evidence ladder.** Weak (one comment) / Medium (multiple independent) / Strong (primary data, direct interviews). Act accordingly.
3. **Behavior over opinion.** Question and answer about what people *do*, not what they *say they'd do*.
4. **No leading, no confirmation-seeking.** The guide and the simulated interviewee both resist steering toward a desired answer.
5. **Simulation is bounded.** A simulated interviewee cannot know what its evidence doesn't contain, and must say so.

## Relationship to the other skills

- **[product-discovery](../product-discovery/SKILL.md)** — supplies the raw complaint/problem language (HN/Reddit/Stack Exchange) that becomes persona pain points. In turn, this skill's personas and (real or simulated) interviews deepen discovery's "Customer problems" section.
- **[product-research](../product-research/SKILL.md)** — supplies the market segments (who) and willingness-to-pay (what they'll pay) that persona context and interview "willingness & constraints" questions depend on.

## Input

A user-communication run needs a target. If the user has not supplied one, ask for (or infer and state):

- `product_or_category` — what we're building or studying (the context for the personas).
- `target_market` — the segment(s) to persona-ize.
- `evidence` — the source material (discovery report, research report, interviews, survey results) the personas and simulations must stay grounded in. If none exists, run [product-discovery](../product-discovery/SKILL.md) and/or [product-research](../product-research/SKILL.md) first — do **not** invent evidence.

## Output

Produce one or more of:

1. **Persona cards** — one per segment, each with a source/Assumption tag on every claim.
2. **Interview guide(s)** — the ordered question script with probe branches, one per persona.
3. **Simulated interview transcript(s)** — Q&A + evidence map + unsurfaced threads + assumptions to test.

Store alongside the project (e.g. `PERSONAS.md`, `INTERVIEW_GUIDES.md`, `interviews/`). Do not dump into chat.

## Guardrails

- **Never** present a persona or a simulated answer as a real user or as validated Fact.
- **Never** fabricate evidence to make a persona feel complete.
- **Never** let a simulated interviewee answer beyond its evidence block without flagging it as inference.
- **Always** distinguish real interviews (Fact) from simulated ones (Inference) in any downstream use.
- **Respect** user privacy: anonymize real interview content before storing it.
