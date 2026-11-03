---
name: definition-of-done
description: "Define, enforce, and evolve the Definition of Done (DoD): a shared checklist of quality criteria that all work must meet before it can be considered complete. Covers DoD vs Acceptance Criteria, standard criteria templates, verification workflows, DoD review, and integration with the backlog-management skill."
compatibility: "Works with any coding agent harness that supports reading/writing files and running shell commands."
metadata:
  version: "2.0.0"
  patterns: "definition-of-done, quality-gates, acceptance-criteria, done-checklist"
---

# Definition of Done

The **Definition of Done (DoD)** is a shared, explicit checklist of quality criteria that every piece of work must meet before it can be considered complete. It protects quality by ensuring nothing is called "done" prematurely.

> **DoD is not negotiable per item.** Acceptance Criteria vary per story. The DoD applies to *everything* the team delivers. If an item doesn't meet the DoD, it's not done — regardless of whether its Acceptance Criteria are satisfied.

> **Relationship to other skills:** The [backlog-management](../backlog-management/SKILL.md) skill covers writing Acceptance Criteria for individual items. The [agent-collaboration](../agent-collaboration/SKILL.md) skill's `WORKING_AGREEMENT.md` **references** this skill's `DEFINITION_OF_DONE.md` rather than duplicating it. This skill defines *what "Done" actually means* — the gate that must be passed before an item is marked complete — and `DEFINITION_OF_DONE.md` is the **single authoritative** DoD.

---

## Quick Start

If you're entering a project that already has a DoD:

```bash
# Read the current Definition of Done
cat DEFINITION_OF_DONE.md
```

If no DoD exists, initialize one:

```bash
# Scripts are located at <SKILL_DIR>/scripts/
# Replace <SKILL_DIR> with the path to this skill directory.
<SKILL_DIR>/scripts/init-dod.sh
```

---

## Core Concepts

### What is a Definition of Done?

The Definition of Done is a **shared quality checklist** that the entire team agrees to. Every backlog item — every PBI, every story, every task — must pass every item on this checklist before it can be marked as "Done."

| Aspect | DoD | Acceptance Criteria |
|--------|-----|---------------------|
| **Scope** | Applies to ALL work | Specific to ONE item |
| **Content** | Quality standards, process gates | Functional behavior, edge cases |
| **Who defines** | The whole team | The Product Owner |
| **When set** | Once, reviewed periodically | Per item, during refinement |
| **Negotiable?** | No — team agreement | Yes — can be adjusted per item |

> **Example:** A story's Acceptance Criteria say "User receives a reset link within 30 seconds." The DoD says "All unit tests pass, code reviewed, integration tests pass, documentation updated." Both must be satisfied for the item to be done.

> **Guardrail:** The DoD applies **uniformly** to every item that crosses the finish line, regardless of its unique scope. If a validation step applies only to a specific task — a particular performance benchmark, a niche security requirement, a one-time data migration check — it belongs in that task's **Acceptance Criteria**, not the global DoD. Adding item-specific rules to the DoD breaks the universal contract and forces every item to meet criteria that don't apply to it.

### Why a DoD Matters

- **Prevents technical debt** — no cutting corners on quality to meet a deadline
- **Shared understanding** — everyone agrees on what "done" means, avoiding arguments when work is declared complete
- **Consistent quality** — every item meets the same bar, regardless of who built it
- **Transparency** — stakeholders know what "done" actually means

---

## Shared Structure

```
project-root/
 DEFINITION_OF_DONE.md        # ← READ THIS FIRST. The team's DoD.
 .dod/
    CONFIG.md                # DoD scope, exceptions, review cadence
    CHECKLIST.md             # The full DoD checklist (machine-readable)
    VERIFICATION_LOG.md      # Records of items verified against the DoD
    REVIEW_LOG.md            # DoD review/evolution history
```

---

## Example DoD Criteria (Software Team)

> **DoD varies by context.** The example below works for a software development team building and deploying services. A team building a physical product, a marketing campaign, or a regulatory filing will have a completely different DoD. **Define your own DoD** — use this as inspiration, not as a mandate.

The criteria that matter depend on what you're building:

| Team Context | Example DoD Criteria |
|-------------|---------------------|
| **Software** | Tests pass, code reviewed, deployed, logged |
| **Physical product** | Prototype tested, materials sourced, safety certified, assembly documented |
| **Marketing** | Copy reviewed, assets approved, campaign scheduled, analytics tagged |
| **Regulatory** | Filing reviewed, evidence compiled, signatures obtained, submitted |

**The principle is the same regardless of context:** the DoD is a shared, universal quality checklist that applies to every item. What goes on that checklist depends entirely on what "quality" means for your team.

Below is an example for a software team building and deploying production services:

### Code Quality
- [ ] **No known defects** — all identified bugs are fixed or explicitly deferred
- [ ] **Technical debt addressed** — code has been refactored to reduce technical debt
- [ ] **Static analysis passed** — code passes all local linting, syntax verification, and static security analysis tool baselines
- [ ] **Peer review completed** — the pull request has been reviewed and approved by at least one other engineer, ensuring adherence to structural and architectural patterns
- [ ] **Mainline integration** — code branch is cleanly merged into the integration line with all build flags passing

### Testing
- [ ] **Unit tests pass** — automated unit tests execute successfully with no failures
- [ ] **Integration verification passed** — API contracts, database migrations, and cross-service dependencies validate successfully in an automated staging sweep
- [ ] **End-to-end functionality tested** — full E2E tests pass with no failures
- [ ] **Acceptance criteria satisfied** — the implemented logic satisfies all business-defined acceptance criteria mapped out in the parent backlog item

### Observability
- [ ] **Telemetry and logging added** — structured application logs and performance markers are exposed for system monitoring tools

### Documentation
- [ ] **Documentation updated** — system design changes, new API schemas, or configuration flag alterations are accurately cataloged in the team's shared knowledge base, FAQs, support guides
- [ ] **Compliance documentation completed** (for regulated industries)

### Deployment
- [ ] **Docker instance rebuilt and deployed** — the Docker image has been rebuilt and deployed to the target environment

> **Not all criteria apply to all teams.** Customize the checklist in `.dod/CHECKLIST.md` to match your team's context. A small team building a prototype may have a lightweight DoD. A regulated industry team may have an extensive one.

### Example: A Lean, Evidence-Driven DoD (Rust + Web)

A different team — smaller, shipping a Rust backend with a TypeScript web frontend — uses a tighter, more opinionated DoD. Notice the shift in emphasis: **every item demands *evidence* or a *live verification*, not a claimed status.** This is a good model when the cost of "it works on my machine" is high.

1. **Every AC in the item file is met, with evidence in the close-out section.** Acceptance criteria are not assumed satisfied; each one is answered against an artifact, log line, screenshot, or test result recorded in the item's close-out.
2. **TDD — failing test first where the change is behavioural; the suite is the guard.** Behavioural changes start with a red test that encodes the new behaviour before the implementation turns it green. The test suite, not intuition, is the authority for "done".
3. **Green locally — `cargo test`, `clippy` (0 warnings), plus web `tsc`/`eslint`/`i18n`.** The full local gate runs clean before anything is claimed: Rust unit/`clippy` with zero warnings, TypeScript type-check and lint, and i18n validation.
4. **Live verification on the durable host — a real request, a real row, a real 404, not "it compiles".** The change is exercised against the real, durable environment (not a throwaway container): a genuine request, a genuine database row written/read, a genuine not-found path. Compiling is necessary but never sufficient.
5. **Commit + push, status `done` (rank kept), item file archived to `.backlog/ARCHIVED/`, backlog row updated.** The work is committed and pushed; the table row's status is set to `done` and its rank preserved; the item's detail file moves to `.backlog/ARCHIVED/`; and the backlog table stays well-formed (right columns, no grouped sections).
6. **Deploy smoke passes — added today, after two outages shipped as "healthy".** A deploy smoke test is run and green. (This check exists to close a specific past failure mode: two outages had been shipped as "healthy" because there was no post-deploy verification.)

---

## DoD Workflows

### 1. Initializing the DoD

```bash
<SKILL_DIR>/scripts/init-dod.sh
```

This creates `DEFINITION_OF_DONE.md` with a starter DoD and `.dod/CHECKLIST.md` with the full machine-readable checklist.

Customize the checklist by editing `.dod/CHECKLIST.md` — enable or disable items based on your team's needs.

### 2. Checking an Item Against the DoD

Before marking any work as Done, verify it against every active criterion in the DoD:

```bash
<SKILL_DIR>/scripts/verify-dod.sh ITEM-003
```

The script reads the checklist from `.dod/CHECKLIST.md` and walks through each enabled criterion, prompting for a result for each one:

```
Verifying ITEM-003 against Definition of Done...

 [Code Quality] No known defects
 Met? (y/n/skip): y

 [Code Quality] Technical debt addressed
 Met? (y/n/skip): n

 [Testing] Unit tests pass
 Met? (y/n/skip): y

 ...

Result: NOT DONE — 1 of 12 criteria not met
 Logged in .dod/VERIFICATION_LOG.md
```

Three answers are accepted for each criterion:
- `y` (met) — counts toward a passing item
- `n` (not met) — counts as failed (unless an override applies)
- `s` / `skip` — skipped; recorded separately and does **not** count as failed

If any enabled criterion is not met, the item cannot be marked Done. Log the verification result in `.dod/VERIFICATION_LOG.md`.

> **Skipped criteria count as neither met nor failed.** The summary reports them separately ("N criteria were skipped") so they are visible, but a skipped criterion does not by itself block an item from being "Done". Be deliberate about skips — if the DoD lists a criterion you routinely skip, that criterion is a candidate for removal during the next DoD review.

### 3. Overriding the DoD (Rare)

In exceptional cases, the team may agree to waive the DoD for a specific item. This must be:

1. **Explicit** — logged in VERIFICATION_LOG.md with the reason
2. **Rare** — frequent overrides mean the DoD needs updating
3. **Team decision** — not a single agent's choice

```bash
<SKILL_DIR>/scripts/verify-dod.sh ITEM-003 --override "Integration tests waived — test environment down, will add later"
```

> **An override waives the *item*, not a single criterion.** When `--override` is supplied, *every* unmet criterion for that item is recorded as waived under the one reason given. This is a coarse instrument and is deliberately kept simple: the intent is to let the team explicitly accept a known gap and move on, not to surgically excuse one checklist line. If you need to waive individual criteria with per-criterion justification, prefer logging that decision manually in `VERIFICATION_LOG.md` (or revisit whether those criteria belong in the DoD at all).

> **Relationship to "not negotiable":** The DoD itself is not *silently* negotiable — no agent may quietly skip a criterion. An override is an *explicit, recorded, team-level* exception, which is a different thing from an agent deciding unilaterally that a criterion doesn't apply. Overrides should stay rare precisely because the DoD is meant to be uniform.

### 4. Reviewing the DoD

The DoD should be reviewed periodically (e.g., every quarter or when the team notices it drifting). Update it based on what the team has learned.

```bash
<SKILL_DIR>/scripts/review-dod.sh "Added security review criterion. Removed outdated browser test requirement."
```

Review history is logged in `.dod/REVIEW_LOG.md`.

---

## Quick Reference Cards

### Before Marking an Item as Done
- [ ] Run `verify-dod.sh <item-id>` to check every enabled DoD criterion
- [ ] Every enabled criterion must be met (or explicitly skipped with intent) — no exceptions without a logged override
- [ ] Acceptance Criteria are NOT a substitute for the DoD — both must be satisfied
- [ ] Log the verification result in VERIFICATION_LOG.md

### When Defining the DoD
- [ ] Involve the whole team — DoD is a team agreement, not a mandate
- [ ] Start simple — a 5-item DoD that's enforced is better than a 20-item DoD that's ignored
- [ ] Include criteria from: Code Quality, Testing, Documentation, Operations, Collaboration
- [ ] Write each criterion as a clear yes/no check — no ambiguity

### During DoD Review
- [ ] Review the DoD every quarter or when the team notices it drifting
- [ ] Ask: "Did we skip any DoD items recently?" — that's a signal the DoD is wrong
- [ ] Ask: "Are there new quality concerns not covered?" — add them
- [ ] Ask: "Are any criteria obsolete?" — remove them
- [ ] Log changes in REVIEW_LOG.md

### DoD vs Acceptance Criteria Quick Check

| Question | DoD | AC |
|----------|-----|----|
| Does this apply to every item? |  Yes |  Per item |
| Can an agent decide to skip it? |  No |  With PO |
| Is it about quality or behavior? | Quality | Behavior |
| Who defines it? | Team | Product Owner |

---

## References

- [DoD vs Acceptance Criteria Deep Dive](references/dod-vs-ac.md) — Detailed explanation with examples of when each applies.
- [Example DoD: Software Team](references/production-dod-template.md) — A production-ready DoD example for a software team (adapt to your own context).

---

## Helper Scripts

| Script | Purpose |
|--------|---------|
| `init-dod.sh` | Initialize the Definition of Done structure |
| `verify-dod.sh` | Check an item against every DoD criterion |
| `review-dod.sh` | Log a DoD review or update |

See [scripts/](scripts/) for implementation.
