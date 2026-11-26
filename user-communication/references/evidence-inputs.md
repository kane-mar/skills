# User Communication — Evidence Inputs

This skill does **not** fetch its own market data. Its personas and simulated interviews must stay grounded in evidence produced by the companion skills (or real user research). This file defines where that evidence comes from and how to keep the simulation honest.

## Where the evidence comes from

| Evidence type | Produced by | File |
|---|---|---|
| Customer problems, pain language, JTBD | [product-discovery](../product-discovery/SKILL.md) | Discovery Report — "Customer problems" |
| Competitive landscape (who alternates to) | [product-discovery](../product-discovery/SKILL.md) | Discovery Report — "Competitive landscape" |
| Market segments (who the customer is) | [product-research](../product-research/SKILL.md) | Market Research Report — sizing/segments |
| Willingness-to-pay (what they'd pay) | [product-research](../product-research/SKILL.md) | Market Research Report — monetization |
| Real user interviews / surveys | the user (out of scope for the key-less skills) | provided by the user; anonymize |

## The evidence block (required before personas / simulation)

Before building a persona or running a simulated interview, assemble a single **evidence block** for that segment. Every claim in it must carry a source reference or an explicit `Assumption` tag. A persona or simulated answer that is not backed by this block is fabrication.

Example evidence block:

```
Segment: File-owning macOS knowledge workers
- [Fact] Prefer plain .md files so data is portable — HN comment (id 42539021), 2026-11-14
- [Fact] Frustrated by Electron apps' memory use — Reddit r/notetaking body="electron" (created_utc 1789177445)
- [Inference] Likely one-time-price tolerant — 3 independent HN comments favor one-time over subscription
- [Assumption] Geographic concentration in US/EU — not yet sourced
```

## Rules for grounded simulation

- The simulated interviewee **only knows what is in its evidence block**.
- Where the block is silent, the persona must say so ("I don't have anything about that") or flag the answer as model inference — it must **not** invent a confident answer.
- Every simulated answer that is **not** traceable to the block must be listed in the "Assumptions to test" section and handed off as a real-world question.

## Referenced source endpoints

For the underlying endpoints (HN Algolia, Stack Exchange, iTunes, Reddit via Arctic Shift), see [`../product-discovery/references/sources.md`](../product-discovery/references/sources.md). For sizing/monetization inputs, see [`../product-research/references/sources.md`](../product-research/references/sources.md). Do **not** reconstruct endpoints from memory.
