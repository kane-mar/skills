---
name: product-research
description: Evidence-driven market research for a product or category. Use when sizing a market (TAM/SAM/SOM), mapping distribution channels, analyzing monetization/pricing models, or defining a North Star metric. Produces a cited Market Research Report whose every figure is tagged Fact / Inference / Assumption / Gap / Directional and tied to a source + timestamp. Complements product-discovery (which finds the opportunity) by supplying the market, channel, monetization, and metric evidence the decision rests on.
license: MIT
metadata:
  version: "0.1.0"
  patterns: "market-sizing, tam-sam-som, channels, monetization, pricing, north-star-metric"
---

# Product Research

Evidence-driven market research for a product, category, or opportunity. This skill answers four questions — **how big is the market, how does it reach customers, how does it make money, and what single number tells us it's working** — using sourced, timestamped evidence rather than vibes.

> **Where this fits:** this is the **market/economic layer** beneath [product-discovery](../product-discovery/SKILL.md). Discovery *finds and validates the opportunity* (problems, competitors, build/don't-build). This skill supplies the **market sizing, channels, monetization, and North Star** evidence that a build decision must rest on. A discovery decision that needs these numbers should call this skill rather than fabricate them.

> **Core shift:** every figure is tagged and sourced, or explicitly labeled a **Gap**. A TAM number you cannot defend is not a number — it is a Gap dressed up as an answer.

## When to use

- "How big is the market for X?" / "TAM/SAM/SOM for my idea?"
- "What channels should we distribute through, and what do they cost?"
- "How should we monetize this — subscription, one-time, usage-based, marketplace?"
- "What's our pricing, and what do competitors charge?"
- "What North Star metric should we track?"
- Any discovery run where market size or willingness-to-pay is being treated as a *fact*.

## The four modules

Run the modules in order — each feeds the next. Sizing bounds everything; you cannot do a credible channel or monetization analysis of a market whose size is unknown (in which case you proceed with explicit, labeled assumptions instead of fake precision).

| # | Module | Question | Key bound |
|---|---|---|---|
| 1 | **Market sizing** | How big is the opportunity, numerically? | TAM / SAM / SOM, each tagged |
| 2 | **Channels** | How does the product reach its customers? | channel list + CAC / reach cost |
| 3 | **Monetization** | How does it make money, and at what price? | model + price point + willingness-to-pay evidence |
| 4 | **North Star** | What single metric best captures delivered value? | metric + the reasoning linking it to value |

### Module 1 — Market sizing (TAM / SAM / SOM)

Estimate three concentric numbers, in that order, each tagged for how it was derived:

- **TAM** — total addressable market: everyone who *could* use the product, unconstrained by your segment or reach.
- **SAM** — serviceable addressable market: the slice of TAM you can actually reach with your segment and channels.
- **SOM** — serviceable obtainable market: the realistic share you can capture in a given time window (next 12–24 months), given competition and budget.

**How to tag each:**

- **Fact** — a primary figure with a citable source (SEC filing, government statistics, an audited report, a company's own disclosed numbers).
- **Inference** — a number you derived by *multiplying sourced datums* (e.g. `paying users × ARPU`), where each input is a Fact. Show the arithmetic.
- **Assumption** — a conversion rate, "% who would pay," or capture share you *asserted* without direct evidence.
- **Gap** — a number you could not source or derive at all.

**Rules:**

- **Never** present an Assumption as if it were a Fact or Inference. Write `SOM ≈ $X (Assumption: assumes 2% share)`.
- **Show your arithmetic.** TAM/SAM/SOM must be reproducible: list each input and its source.
- **Bottom-up beats top-down when both are available.** Bottom-up (count the *customers/transactions/units* and multiply) is more defensible than top-down (take a big reported number and carve a %) because its inputs are checkable.
- **Sources for sizing** (realtime, key-less where possible; see `references/sources.md`):
  - Company **SEC 10-K/10-Q** filings (EDGAR, key-less) — revenue, user counts, market commentary.
  - **Government / census / statistical agencies** — population, industry revenue.
  - **Public earnings calls / investor materials** — TAM statements (treat as *directional*, they are self-interested).
  - **Industry-analyst figures** (Gartner/IDC/Statista headlines) — treat as **Inference at best** when you only have a secondary citation; a paywalled report you cannot read is a **Gap**, not a Fact.
- **Label the base year.** A $X billion market is meaningless without the year. If a number is stale, say so.

### Module 2 — Channels

Map how the product reaches customers, and what each channel costs.

For each candidate channel, record:

- **Channel** — app store, SEO/organic, paid ads, content, marketplace, outbound sales, partnerships, community, referrals, PR, influencers.
- **Fit** — why this channel matches this segment (evidence, not assertion).
- **Reach** — the size of the audience it exposes you to (sourced where possible).
- **Cost / CAC** — what it costs to acquire a customer through it (a real benchmark or a labeled estimate).
- **Conversion assumptions** — any rates you assumed, flagged as Assumption.

**Rules:**

- Distinguish **where customers already are** (pull channels — SEO, app-store search, community) from **where you must pay to be** (push channels — ads, sponsorships). A channel with no evidence of customer presence is an Assumption.
- **Verify a channel actually exists before citing it.** "Post on /r/<subreddit>" must be backed by the subreddit having real activity; "sell on <marketplace>" by the marketplace carrying this category. This is the same no-fabrication rule as discovery.
- Signal strength: *multiple competitors visibly using a channel* is **Medium** evidence for that channel; a single anecdote is **Weak**.

### Module 3 — Monetization

Determine *how* the product makes money and *at what price*, grounded in what the market actually pays.

**Monetization models** to evaluate (and the evidence to gather for each): subscription (recurring, per-seat/per-user), one-time purchase, usage-based/metered, freemium, marketplace/take-rate, advertising, transactional, licensing.

For each plausible model, record:

- **Who pays** — the buyer vs the user (they may differ).
- **Price point** — real competitor prices (sourced from the app store `formattedPrice`, pricing pages, or disclosed ARPU).
- **Willingness-to-pay evidence** — do customers actually pay this, or is it an assumption?
- **Unit economics sanity** — does the price cover CAC + delivery cost, or is it subsidized?

**Rules:**

- **A price is only a Fact if you observed it at the source** (e.g. iTunes `formattedPrice`, a live pricing page). A price you "estimate" is an **Assumption**.
- **Competitor pricing is the strongest key-less signal for willingness-to-pay** — use iTunes Search/Lookup (`formattedPrice`) and public pricing pages. A screenshot/claim you can't verify is a Gap.
- **Never** let a rating or a comment count stand in for willingness-to-pay ("4.8 stars" ≠ "people will pay"). Reuse the discovery evidence ladder here.
- If you cannot establish willingness-to-pay from existing sellers, the monetization question is *unresolved* — record it as a Gap and defer to a validation experiment (a pricing test / pre-order), not a guessed number.

### Module 4 — North Star metric

Choose the single metric that best captures the value the product delivers to users, then justify it.

**A good North Star:**

- Measures **delivered value to the user**, not revenue or vanity ("notes created per week," not "registrations").
- Is **a rate or a per-user quantity** over a time window, not a raw cumulative count.
- **Aligns the team** — early-stage you push this one number; it is bounded and unambiguous.

**Rules:**

- North Star is a **recommendation + rationale**, not a sourced Fact. Tag the *supporting inputs* (e.g. the user value it proxies, the evidence from discovery's "Customer problems" section) but the choice itself is an **Inference** — an argued judgment, not a measurement.
- **State the input metric and the time window precisely** ("weekly active users who create ≥1 note," not "engagement").
- **Tie it to the evidence.** Explain *why* this metric reflects the value you found in discovery — the pain point or job-to-be-done it maps to.
- **Give 1–2 counter-metrics** you rejected and why (e.g. rejected "downloads" because it rewards acquisition, not value).

## Core principles

1. **Every number is tagged.** Fact / Inference / Assumption / Gap / Directional — no untagged figure survives.
2. **Same evidence ladder as discovery.** Weak (one uncorroborated source) / Medium (multiple independent, or named methodology) / Strong (primary: SEC, govt, direct measurement). Build decisions rest on Medium/Strong.
3. **Realtime only.** Query sources live; never cache a snapshot; never invent a number to fill a gap. A failed query → record "unavailable," not a guess.
4. **Degrade gracefully.** No single source failing should abort the run. Missing sizing → proceed with labeled assumptions and flag the dependency.
5. **Show your work.** Any derived number must be reproducible from its listed inputs.
6. **Verify at a primary source.** Never accept a figure from a summary/snippet when the underlying primary (EDGAR, the app-store metadata, a govt table) is reachable.

## Data sources (verified, realtime)

Read `references/sources.md` for exact endpoints, query patterns, and caveats. Do **not** reconstruct endpoints from memory.

| Source | Tier | Provides | Access |
|---|---|---|---|
| SEC EDGAR (`full-text`, `companyfacts`) | 1 | 10-K/10-Q revenue, user counts, market commentary | Key-less |
| U.S. Census / BLS / govt statistics | 1 | Population, industry revenue, employment for bottom-up sizing | Key-less |
| iTunes Search / Lookup | 1 | Competitor price (`formattedPrice`), category, rating counts | Key-less |
| Hacker News (Algolia) | 1 | Community discussion of pricing, channels, monetization sentiment | Key-less |
| Stack Exchange | 1 | "how do I…" / willingness-to-pay signals in Q&A | Key-less |
| Reddit (Arctic Shift mirror) | 1 | Real buyer language on pricing, channels, switching costs | Key-less |

**Out of scope (do not attempt):** scraping paywalled analyst reports (Gartner/IDC full text), app-store review *text*, and any source requiring scraping or anti-bot bypass. A paywalled number you cannot read is a **Gap**, not a Fact.

## Input

A research run needs a target. If the user has not supplied one, ask for (or infer and state):

- `product_or_category` — what are we researching (must be concrete enough to size and channel).
- `target_market` — segment, geography, platform (defines SAM boundary).
- `hypotheses` — what the user already believes about the market, channels, price, and success metric.

Example:

```
{
  "product_or_category": "Mac note-taking apps for knowledge workers",
  "target_market": "macOS users, US + EU, who own their files",
  "hypotheses": ["market is large", "app store is the main channel", "one-time pricing beats subscription"]
}
```

## Output

Produce a **Market Research Report** containing:

1. **Market sizing** — TAM / SAM / SOM, each with its tag, arithmetic, and source/timestamp.
2. **Channel map** — candidate channels with fit, reach, cost, and tagged assumptions.
3. **Monetization** — recommended model, price point(s) with source, willingness-to-pay evidence (or a Gap), unit-economics sanity.
4. **North Star** — the recommended metric, its precise definition + time window, the value it proxies, and the counter-metrics rejected.
5. **Evidence log** — one row per claim:
   | Claim | Type | Strength | Source (endpoint) | Timestamp |
6. **Limitations** — everything the available sources could *not* confirm (paywalled reports, unsourced TAM claims, unresolved willingness-to-pay).

Store it alongside the user's project (e.g. `MARKET_RESEARCH.md` or a `research/` directory). Do not dump it into chat.

## Handoff

- **To product-discovery:** this report is the market/economic layer a discovery decision should cite. Hand the sizing, channel, monetization, and North Star sections into discovery stages 2, 3, and 6 rather than have discovery re-derive them.
- **To backlog-management:** a validated North Star metric becomes the **product goal** in [backlog-management](../backlog-management/SKILL.md); unresolved willingness-to-pay becomes a **validation item** (e.g. "run a pricing test"), never a `feature`.
- **To user-communication:** monetization/channel assumptions that depend on *who the customer is* feed [user-communication](../user-communication/SKILL.md) personas and interview guides.

## Guardrails

- **Never** present an Assumption as a Fact, a rating/comment-count as willingness-to-pay, or a paywalled number as read.
- **Never** cite a source you did not query in this run.
- **Never** backfill a failed query with a plausible number.
- **Always** tag a base year on any market-size figure; flag stale numbers.
- **Respect** rate limits (see `references/sources.md`) and terms of use. Scraping or bypass — no.
