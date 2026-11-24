---
name: product-discovery
description: Autonomous, evidence-driven product discovery. Use when deciding what is worth building, researching a market, analyzing competitors, or validating a product opportunity. Guides a seven-stage loop (understand, research market, analyze competitors, discover customer problems, identify opportunities, validate, decide) that gathers real evidence from Hacker News, Stack Exchange, and the App Store, then produces a build / don't-build / investigate decision with a cited evidence log.
license: MIT
metadata:
  version: "0.1.0"
  patterns: "evidence-driven, opportunity-solution-tree, jobs-to-be-done, competitive-analysis, market-validation"
---

# Product Discovery

Autonomous, evidence-driven product discovery. This skill helps founders, product managers, and AI agents discover **what is worth building, why it matters, and how to validate it** — before writing any code or committing resources.

> **Where this fits:** this is the **first stage** of the product flow (discovery → backlog → build → done). See the collection [README](../README.md) for the full end-to-end pipeline.

> **Core shift:** this skill *discovers and validates* opportunities. It does not merely document an idea, generate a generic plan, or output frameworks for their own sake. Every conclusion must be traceable to gathered evidence, a source, and a timestamp.

## When to use

- "Should I build X?" / "is there a market for X?"
- "What are people actually complaining about in this space?"
- "Who are the competitors and where are the gaps?"
- "Which of these opportunities is worth validating first?"
- Early-stage product strategy before a PRD or roadmap.

## The seven-stage loop

Run stages in order. Each stage consumes the evidence gathered so far. Do not skip ahead to a decision without evidence.

Each stage lists **→ source** (which verified source supplies its data) and **→ lands in** (which report section it feeds). A stage with no reachable source is a deliberate **Gap** you record, not something to fabricate or silently drop.

1. **Understand the opportunity** — the problem space, target market, and explicit initial hypotheses.
   → source: the input brief only (no external fetch). → lands in: the report header + "Opportunity summary".
2. **Research the market** — sizing, trends, customer segments, dynamics (numeric + directional signals only).
   → source: **none of the four key-less sources yields market size**; you can only extract *directional* signals (rating counts as popularity proxy, HN/Reddit comment volume as interest proxy). Sizing is normally a Gap — record it as such. → lands in: "Limitations" (unless you happened to find a citable primary number, which you won't from these sources).
3. **Analyze competitors** — direct/indirect, substitutes, positioning, pricing, gaps.
   → source: iTunes `search`/`lookup` (find apps, pricing, ratings) + HN/Reddit mentions of competitors. → lands in: "Competitive landscape".
4. **Discover customer problems** — JTBD, pain points, unmet needs, from *real* user language.
   → source: HN `tags=comment`, Reddit via Arctic Shift `body=`, Stack Exchange `filter=withbody`. → lands in: "Customer problems".
5. **Identify opportunities** — whitespace, opportunity mapping, prioritization.
   → source: synthesis of stages 2–4 (no new fetch). → lands in: "Competitive landscape" (the positioning-gap row) + "Decision" rationale. There is no separate sizing/prioritization section.
6. **Validate opportunities** — hypotheses, feasibility, willingness-to-pay proxies, validation criteria.
   → source: a *critical* reading of stages 3–4 evidence (ratings ≠ willingness-to-pay; sentiment ≠ demand). No new fetch; this is where you apply the evidence ladder. → lands in: "Decision" rationale + "If Build → riskiest assumption".
7. **Make a product decision** — Build / Don't Build / Investigate Further, plus a recommended MVP and an actionable product brief.
   → source: the ladder-scored claims from all prior stages. → lands in: "Decision" + "If Build".

**Stage → report-section mapping (do not improvise):**

| Stage | Feeds report section(s) |
|---|---|
| 1 Understand | header + Opportunity summary |
| 2 Research market | Limitations (sizing is a Gap) — plus any directional signals into the Evidence log |
| 3 Analyze competitors | Competitive landscape |
| 4 Discover problems | Customer problems |
| 5 Identify opportunities | Competitive landscape (positioning gap) + Decision rationale |
| 6 Validate opportunities | Decision rationale + If-Build riskiest assumption |
| 7 Decide | Decision + If Build |

## Core principles

1. **Evidence over assertion.** Every claim carries a source + a real timestamp, or is explicitly labeled. Never let a claim float without provenance.
2. **Tag every claim** with one of these types:
   - **Fact** — sourced, verifiable, with a direct endpoint + date.
   - **Inference** — derived from sourced data but requiring judgment (e.g. "rating count is rising" implies demand).
   - **Assumption** — unverified belief, flagged as needing validation.
   - **Gap** — a claim we could not test with the available sources (record *why*).
   - **Directional signal** — a real datum that suggests, but does not prove, a trend (numeric counts, volumes). Not as strong as a Fact, not an Inference.
3. **Rank evidence strength** using a simple ladder and act on it:
   - **Weak** — a single comment, one reviewer, a blog, a count without context.
   - **Medium** — multiple independent comments/reviews agreeing, or a named source with a methodology.
   - **Strong** — primary data (SEC filings, govt/direct measurement), or a replicated pattern across several sources.
   - Decisions to Build or Kill should rest on **Medium/Strong** evidence. Weak evidence can justify "Investigate Further," never a build commitment.
4. **Verify ratings at a primary source, never from a snippet** — a star count or headline is not the underlying evidence.
5. **Realtime only.** All sources are queried live during the run. Do not cache, do not fabricate a "snapshot." If a query fails, mark the data as unavailable and continue — never invent data to fill a gap.
6. **Degrade gracefully.** The skill runs fully key-less by default (HN, Stack Exchange, iTunes, Reddit via the Arctic Shift mirror). Never hard-fail the whole run over one source — if a mirror is down, note it and proceed with the rest.
7. **Confidence, not certainty.** Numeric ratings and counts are not the same as validated demand. Distinguish "people rate this 4.8" from "people will pay for a better alternative."

## Data sources (verified, realtime)

Read `references/sources.md` for the exact endpoints, query patterns, rate limits, and per-source caveats. Do NOT reconstruct endpoints from memory — use the verified map.

| Source | Tier | What it provides | Access |
|---|---|---|---|
| Hacker News (Algolia) | 1 | Story + comment full-text search — raw builder/user complaints and unmet needs | Key-less |
| Stack Exchange | 1 | Tagged Q&A (`pm`, `stackoverflow`, `softwareengineering`) — "how do I…" pain | Key-less |
| iTunes Search / Lookup | 1 | App metadata, category, price, **numeric ratings** (avg + count) | Key-less |
| Reddit (Arctic Shift) | 1 | Subreddit + comment-body search — real complaint/need language | Key-less |

**Out of scope for v1 (do not attempt):** App Store review *text*, G2/Capterra/Trustpilot/Amazon reviews, Product Hunt GraphQL, and any source requiring scraping or an anti-bot bypass. Recording a gap from these is correct behavior; scraping is not.

## Input

A discovery run needs a brief. If the user has not supplied one, ask for (or infer and state) at minimum:

- `product_or_category` — what are we researching (an existing product, a category, a vague idea)?
- `target_market` — who is this for (segment, geography, platform)?
- `hypotheses` — what does the user already believe (to be confirmed or refuted)?

Example:

```
{
  "product_or_category": "Markdown note-taking apps for macOS",
  "target_market": "knowledge workers who own their files",
  "hypotheses": ["simpler than Notion", "privacy matters", "one-time pricing beats subscription"]
}
```

## Output

Produce a **Discovery Report** containing:

1. **Opportunity summary** — one paragraph on what was discovered and whether it's worth building.
2. **Evidence log** — a table of every supporting claim. **One row = one claim** (not one datum). When a claim rests on multiple agreeing datums, cite one exemplar endpoint + timestamp in the row and summarize the agreement in the claim text; the *Strength* column already captures "multiple independent" (Medium) vs "single" (Weak). Columns:
   | Claim | Type (Fact / Inference / Assumption / Gap / Directional) | Strength (Weak / Medium / Strong) | Source (endpoint) | Timestamp |

   **Timestamp format:** use the source's true publish time, ISO-8601 UTC (e.g. `2022-05-02T22:39:02Z`). For Arctic Shift's `created_utc` (Unix epoch), convert to ISO-8601 UTC and optionally append the raw epoch in parentheses for verifiability (e.g. `2026-11-16 (1795277925)`). Never use fetch time.
3. **Competitive landscape** — the alternatives found, positioning, and gaps.
4. **Customer problems** — the pain points and unmet needs, in the customers' own words where possible.
5. **Decision** — Build / Don't Build / Investigate Further, with rationale.
6. **If Build** — a recommended MVP scope + the single riskiest assumption to validate first.
7. **Limitations** — everything the available sources could *not* confirm.

Store the report alongside the user's project (e.g. `PRODUCT_DISCOVERY.md` or a `discovery/` directory). Do not dump it into chat and lose it.

## Handoff to backlog

After producing the report, if the decision is **Build** or **Investigate Further**, turn the outcome into backlog items using the [backlog-management](../backlog-management/SKILL.md) skill, which is grounded in Scrum's single-ranked backlog discipline.

This is the bridge from *"what to build"* to *"the ordered work to build it."* Discovery produces a decision; the backlog turns that decision into ranked, pullable work. **Do not drop the discovery evidence** — it is the seed for the first backlog items and their acceptance criteria.

**The handoff, by decision:**

| Decision | What to seed into the backlog |
|---|---|
| **Build** | The recommended MVP scope becomes the top backlog item(s). The "riskiest assumption to validate first" becomes a validation item ranked **above** the build work (resolve the uncertainty before committing deeper). |
| **Investigate Further** | Seed the open questions as validation items (e.g. "test willingness-to-pay with a landing-page pre-order"), ordered by which uncertainty most gates the decision. Do **not** seed build work. |
| **Don't Build** | Seed nothing. Record the decision (and the evidence) for the record; the backlog stays untouched. |

**Steps:**
1. Read [backlog-management/SKILL.md](../backlog-management/SKILL.md) and follow its structure (`BACKLOG.md`, `.backlog/`). Run its `init-backlog.sh` if no backlog exists.
2. Set the **product goal** from the discovery's opportunity summary + the validation hypothesis, so every seeded item traces back to it.
3. For each MVP slice or validation question, capture it as an item. Use `type: feature` for build slices and `type: improvement` for validation items.
4. Write the **user story + acceptance criteria** on the top item(s), pulling the customer problems from the discovery report's "Customer problems" section — the acceptance criteria should encode the real, evidenced pain points, not guesses.
5. **Rank the items.** The riskiest-assumption validation item goes at the very top (it must be resolved first); the MVP slices follow. Reference the Discovery Report path in each item's technical notes so the evidence stays traceable.
6. If the discovery surfaced an **unvalidated hypothesis**, capture it as an open question in `REFINEMENT_LOG.md` rather than silently assuming it true.

> **Guardrail:** discovery evidence rates something Weak/Medium/Strong. Weak evidence must **not** become committed build work in the backlog — it becomes a validation item ("investigate/validate"), never a `feature` ("build"). This preserves the evidence ladder across the handoff.

## Configuration

By default the skill runs fully key-less: HN, Stack Exchange, iTunes, and Reddit **via the Arctic Shift mirror** (`arctic-shift.photon-reddit.com`). No credentials are required by default.

**Do not instruct the user to register a new Reddit app** — native Reddit API access is closed to new signups ("max clients reached"). The Arctic Shift mirror is the supported path. For the rare user who *already holds* a pre-closure Reddit OAuth app, `references/reddit-setup.md` documents the legacy native flow.

## Guardrails

- **Never** present a rating, star count, or comment count as validated demand or willingness-to-pay.
- **Never** cite a source you did not actually query in this run.
- **Never** backfill a failed query with plausible-sounding data.
- **Always** timestamp every fetched datum using the item's true `created_at` (not fetch time, and not `updated_at` — Algolia re-indexes old comments and would silently skew freshness). Freshness claims must use publish time, not re-index time.
- **Respect** each source's rate limits (see `references/sources.md`) and terms of use.
