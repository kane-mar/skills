# Data Sources — Verified Endpoint Map (product-research)

This is the authoritative, runtime-verified map of the *additional* sources product-research uses for **market sizing, channels, monetization, and North Star**. It extends (not replaces) the map in [`../product-discovery/references/sources.md`](../product-discovery/references/sources.md) — that file covers HN, Stack Exchange, iTunes, and Reddit, which product-research also uses for channels/monetization sentiment and willingness-to-pay proxies.

Query sources **live, in realtime**. No caching, no scheduled pulls.

## Summary table

| Source | Tier | Key? | Provides |
|---|---|---|---|
| SEC EDGAR | 1 | ❌ No | 10-K/10-Q revenue, user counts, market commentary (bottom-up sizing inputs) |
| U.S. Census / BLS / govt statistics | 1 | ❌ No | Population, industry revenue, employment (bottom-up sizing denominators) |
| iTunes Search / Lookup | 1 | ❌ No | Competitor `formattedPrice`, category, rating counts (willingness-to-pay proxies) |
| HN / Stack Exchange / Reddit | 1 | ❌ No | Pricing/channel sentiment, buyer language (see discovery sources map) |

---

## SEC EDGAR (key-less)

Primary source for **company-disclosed** figures: revenue, user/seat counts, paying-customer counts, market commentary. Use these to build bottom-up TAM/SAM/SOM and to sanity-check competitor pricing/ARPU.

- **Full-text search API:**
  - `https://efts.sec.gov/LATEST/search-index?q=<query>&dateRange=custom&startdt=<YYYY-MM-DD>&enddt=<YYYY-MM-DD>`
  - Returns filing hits with accession numbers; then fetch the filing documents via the archive URL.
- **Company facts API (numeric XBRL facts):**
  - `https://data.sec.gov/api/xbrl/companyfacts/CIK<10-digit-ciK>.json`
  - Gives structured `revenue`, `user` (rare), `shares`, etc. — including quarterly series, which is ideal for "is this growing" directional claims.
- **Company concept API:**
  - `https://data.sec.gov/api/xbrl/companyconcept/CIK<10-digit-ciK>/us-gaap/Revenues.json`
- **⚠️ Requires a `User-Agent` header.** EDGAR rejects requests without a descriptive `User-Agent` (e.g. `User-Agent: <your-name> <email>`). Set it on every request or you get a 403.
- **Note:** most SaaS/consumer companies are *private* and do not file with the SEC. A private target company with no EDGAR record is a **Gap**, not a Fact — do not invent revenue. Public competitors are the useful EDGAR lookup targets.

## U.S. Census / BLS / government statistics (key-less)

Bottom-up sizing **denominators**: population, employment by occupation, industry revenue, household counts.

- **Census Data API:**
  - `https://api.census.gov/data/<year>/<dataset>?get=<variables>&for=<geography>`
  - e.g. population by state: `https://api.census.gov/data/2020/dec/pl?get=NAME,P1_001N&for=state:*`
- **BLS (employment / occupation wage / count):**
  - Occupational Employment and Wage Statistics: `https://www.bls.gov/oes/` (tables; no simple JSON API — scrape-free: download the published tables).
- **SBA / Census business counts** (for B2B sizing by firm size/NAICS):
  - Census Business Dynamics / County Business Patterns.
- **⚠️ Use for denominators, not for product demand.** A population number is a **Fact**; multiplying it by an assumed adoption % is an **Assumption** — label the product accordingly.

## iTunes Search / Lookup (monetization — same as discovery)

Reused from [`../product-discovery/references/sources.md`](../product-discovery/references/sources.md). Key monetization fields: `formattedPrice` (real, observed price), `averageUserRating`, `userRatingCount`, `primaryGenreName`.

- Search: `https://itunes.apple.com/search?term=<app>&entity=software&limit=1`
- Lookup: `https://itunes.apple.com/lookup?id=<trackId>`
- **⚠️ `formattedPrice` is the observed price — a Fact.** Do not infer willingness-to-pay from a star rating; a rating is a *directional* signal only.

## Industry-analyst figures (Gartner / IDC / Statista)

- **Treat as Inference at best, Gap by default.** A headline number you read in a summary is **not** a Fact. The underlying report is paywalled; if you cannot open and read the methodology, record it as a **Gap** ("analyst TAM figure, methodology not readable").
- A number *reported by a named, methodology-disclosing public source* (e.g. a government release citing its survey) can be **Medium** at best.

---

## Out of scope (do NOT attempt)

| Source | Why excluded |
|---|---|
| Paywalled analyst reports (Gartner/IDC full text) | Cannot read; a headline is not a Fact |
| App Store review **text** | RSS endpoint retired; needs scraping or ASC API |
| Private-company revenue (no EDGAR) | Not disclosed; do not invent |
| Any source requiring scraping or anti-bot bypass | ToS gray area — no |

Recording a Gap is correct. Scraping or bypassing is not.

---

## Sizing / monetization query cheat-sheet

| Goal | Source | Sample |
|---|---|---|
| Public competitor revenue / users | EDGAR `companyfacts` | companyfacts for a public competitor's CIK |
| Population / occupation denominator | Census / BLS | population of target geography |
| Observed competitor price | iTunes `lookup` (`formattedPrice`) | lookup a competitor trackId |
| Pricing/channel community sentiment | HN `tags=comment` / Reddit `body=` | `"<product> pricing"` or `"worth it"` |
| Willingness-to-pay proxy | Stack Exchange "how do I…" + HN pricing threads | `<category> how much should I pay` |
