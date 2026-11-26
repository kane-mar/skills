# User Communication — Evidence Inputs

This skill does **not** fetch its own market data, but it is still **data-grounded**: its personas and simulated interviews must rest on evidence that was **live-fetched at run time** by the companion skills, not pasted in from memory or an unsourced description. This file defines where that evidence comes from and how to keep the simulation honest.

## Where the evidence comes from

These are fetched **live** by running the companion skill and pointing back at the actual queried datums (endpoint + timestamp). A companion *report file* on disk is a useful summary but is **not** the evidence itself — you must be able to cite the underlying datum (HN comment id, Reddit permalink/`created_utc`, Stack Exchange question id, iTunes metadata, SEC/Census figure) that the report's claim came from.

| Evidence type | Produced by | Retrieval |
|---|---|---|
| Customer problems, pain language, JTBD | [product-discovery](../product-discovery/SKILL.md) | live query of HN / Stack Exchange / Reddit (Arctic Shift) — cite comment/question id |
| Competitive landscape (who alternates to) | [product-discovery](../product-discovery/SKILL.md) | live iTunes `search`/`lookup` + HN/Reddit mentions |
| Market segments (who the customer is) | [product-research](../product-research/SKILL.md) | SEC EDGAR / Census / BLS fetches |
| Willingness-to-pay (what they'd pay) | [product-research](../product-research/SKILL.md) | iTunes `formattedPrice` + pricing pages |
| Real user interviews / surveys | the user (out of scope for the key-less skills) | provided by the user; anonymize; treat interview transcript as **Fact** only for what was actually said |

## The evidence block (required before personas / simulation)

Before building a persona or running a simulated interview, **run the companion skill(s) and assemble** a single **evidence block** for that segment, in which every claim carries a source datum (endpoint + id + timestamp) or an explicit `Assumption` tag. A persona or simulated answer that is not backed by this live-fetched block is fabrication.

Example evidence block:

```
Segment: File-owning macOS knowledge workers
- [Fact] Prefer plain .md files so data is portable — HN comment (id 42539021), 2026-11-14
- [Fact] Frustrated by Electron apps' memory use — Reddit r/notetaking body="electron" (created_utc 1789177445)
- [Inference] Likely one-time-price tolerant — 3 independent HN comments favor one-time over subscription
- [Assumption] Geographic concentration in US/EU — not yet sourced
```

## Rules for grounded simulation

- The evidence block is **live-fetched** (see above), never pasted-in or recalled. Every source element carries endpoint + id + timestamp.
- The simulated interviewee **only knows what is in its evidence block**.
- Where the block is silent, the persona must say so ("I don't have anything about that") or flag the answer as model inference — it must **not** invent a confident answer.
- Every simulated answer that is **not** traceable to the block must be listed in the "Assumptions to test" section and handed off as a real-world question.

## Referenced source endpoints

For the underlying endpoints (HN Algolia, Stack Exchange, iTunes, Reddit via Arctic Shift), see [`../product-discovery/references/sources.md`](../product-discovery/references/sources.md). For sizing/monetization inputs, see [`../product-research/references/sources.md`](../product-research/references/sources.md). Do **not** reconstruct endpoints from memory.
