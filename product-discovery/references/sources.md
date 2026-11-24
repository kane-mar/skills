# Data Sources — Verified Endpoint Map

This is the authoritative, **runtime-verified** map of data sources for this skill. Use these exact endpoints. Do not reconstruct them from memory.

All sources are queried **live, in realtime** during a discovery run. No caching, no scheduled pulls.

## Summary table

| Source | Tier | Key? | Realtime | Confidence |
|---|---|---|---|---|
| Hacker News (Algolia) | 1 | ❌ No | ✅ Yes | High |
| Stack Exchange | 1 | ❌ No | ✅ Yes | High |
| iTunes Search / Lookup | 1 | ❌ No | ✅ Yes | High (metadata only, **no review text**) |
| Reddit (via Arctic Shift mirror) | 1 | Subreddit + comment-body search — real complaint/need language | Key-less |

---

## Tier 1 — key-less

### Hacker News (Algolia Search API)

- **Base:** `https://hn.algolia.com/api/v1/`
- **Story + comment full-text search:**
  - `https://hn.algolia.com/api/v1/search?query=<url-encoded>&tags=<tag>&hitsPerPage=<n>`
- **`tags` values:**
  - `story` — post titles and URLs only.
  - `comment` — **full comment text** (highest-value for discovering complaint/pain language).
  - `comment,story` — both (default when omitted).
  - `front_page` — currently on the front page.
  - `author_<username>` — everything by one user.
- **Other useful params:** `numericFilters` (e.g. `points>40`, `created_at_i>1580000000`) — comma-separated for multiple filters. `created_at_i` bounds recency correctly.
- **⚠️ NO sort parameter.** Do not pass `sortBy` / `sort` — the API returns `400 Unknown parameter`. Result ordering is Algolia relevance-only and cannot be overridden.
- **Response shape:** `{ hits: [{ title, url, author, points, num_comments, comment_text, story_title, created_at, updated_at }] }`.
- **⚠️ Note:** `comment_text` is HTML-escaped (e.g. `&#x27;` for apostrophe). Unescape before reading/quoting.
- **⚠️ Timestamp caveat:** `created_at` is the true publish time; `updated_at` changes when Algolia re-indexes an old comment (e.g. a 2013 comment may show `updated_at: 2024`). Use `created_at` for any freshness/recency claim.
- **Rate limit:** generous; no key required. Back off with retry on non-200.

Verified working: `tags=comment` returns real comment text for complaint-mining queries.

### Stack Exchange API

- **Base:** `https://api.stackexchange.com/2.3/`
- **Search:** `https://api.stackexchange.com/2.3/search/advanced?q=<query>&site=<site>&pagesize=<n>`
- **Key `site` values** for product/pain-point discovery:
  - `stackoverflow` — technical "how do I…" tooling pain (richest for concrete unmet needs).
  - `pm` — **Project Management Stack Exchange** (secondary; thin/dated).
  - `softwareengineering` — architecture/practice pain (poor fit for consumer categories).
- **`--compressed` (gzip)** with `curl` is *recommended* to reduce payload size, but not mandatory — bare `curl` works fine.
- **`filter=withbody`** is a first-class parameter, not optional for Stage 4: the default response returns **no body text at all**, only metadata. Add `&filter=withbody` to get the `body` field. **Note it returns the question body only, not answers** — answers require a separate `/answers/{id}` call per question.
- **Response shape:** `{ items: [{ title, tags, score, view_count, answer_count, question_id, link, creation_date, body }] }` (with `filter=withbody`).
- **Rate limit:** anonymous key-less quota is essentially the same as keyed (~300/day/IP; checks show `quota_remaining` near 291 without a key). Add a `key` if you have one, but it works key-less.
- **⚠️ Relevance caveat:** `pm` and `softwareengineering` return thin/dated/irrelevant results for consumer-product pain (e.g. "note taking" → architecture/refactoring questions). Prefer `stackoverflow` for concrete "how do I…" tooling pain. Treat Stack Exchange as a *secondary* source for consumer categories — HN `tags=comment` is usually richer.

Verified working: `site=pm` returns product-management questions; `--compressed` is optional (bare curl works).

### iTunes Search API (app discovery + metadata)

- **Search for an app (find `trackId`):**
  - `https://itunes.apple.com/search?term=<app name>&entity=software&limit=1`
- **Lookup metadata by ID:**
  - `https://itunes.apple.com/lookup?id=<trackId>`
- **Useful fields in response:** `trackName`, `trackId`, `primaryGenreName`, `formattedPrice`, `averageUserRating`, `userRatingCount`, `averageUserRatingForCurrentVersion`, `userRatingCountForCurrentVersion`, `description`, `sellerName`.
- **Provides numeric ratings ONLY.** There is **no review text** available key-less.
- **Rate limit:** ~20 req/min. No key.

> ⚠️ **The legacy `rss/customerreviews` endpoint is DEAD** (verified: returns an empty feed with blank pagination links). Do not use it. Review *text* is not obtainable key-less and is out of scope for v1.

---

## Reddit data — via Arctic Shift (key-less mirror)

> ⚠️ **Native Reddit API is closed to new apps** ("max clients reached"; `prefs/apps` force-redirects). This skill fetches Reddit data through **Arctic Shift**, a free, key-less mirror of the Pushshift-style archive. Do **not** instruct users to register a Reddit app.

- **Base:** `https://arctic-shift.photon-reddit.com/api/`
- **Comments search (primary for pain-point mining):**
  ```
  GET https://arctic-shift.photon-reddit.com/api/comments/search
    ?subreddit=<name>&body=<keyword>&limit=<n>
  ```
  - `body=<keyword>` does full-text search of comment text (e.g. `body=frustrated`, `body="can't" OR "hate"`).
  - Returns `{ data: [{ author, created_utc, body, permalink, score, link_id, subreddit }] }`.
- **Submissions search (post titles/selftext):**
  ```
  GET https://arctic-shift.photon-reddit.com/api/submissions/search
    ?subreddit=<name>&limit=<n>
  ```
- **Timestamp:** `created_utc` is Unix epoch (seconds) — convert for human-readable dates.
- **Relevance signal:** `score` gives a coarse popularity proxy (do not treat as validated demand).
- **Rate limit & reliability ⚠️:** Arctic Shift is a community mirror and **times out frequently** — returned as HTTP **200** with body `{"data": null, "error": "Timeout. Maybe slow down a bit"}`. Detect the `error` field (or `data: null`), **not the status code**. On timeout, retry with backoff (wait a few seconds, not immediately); treat as failed if it persists after ~3 attempts. Do **not** mistake a `200` + `data: null` for empty results — it's a failed query.
- **⚠️ `body=<keyword>` is substring/relevance matching, not semantic search.** Results can be off-topic (e.g. `body=frustrated` matched "Frustrating" inside an unrelated comment about an airline chatbot). Manually filter for actual relevance to the category afterward.
- **Caveat:** search results and freshness depend on the mirror's ingestion recency. Treat as *directional* community signal, and pair with HN `tags=comment` for cross-validation.

For users who **already hold** a pre-closure Reddit OAuth app, the native `oauth.reddit.com` flow still works — see `references/reddit-setup.md`. But that is the legacy path, not the default.

---

## Out of scope for v1 (do NOT attempt)

| Source | Why excluded |
|---|---|
| App Store review **text** | RSS endpoint retired; text needs scraping or App Store Connect API |
| G2 / Capterra / Trustpilot / Amazon | No clean public API; scraping = anti-bot + ToS gray area |
| Product Hunt GraphQL | Needs API token; not yet verified |
| Discord / Slack / Quora / Indie Hackers | No public read API |

Recording a gap from these is correct. Scraping or bypassing anti-bot is not.

---

## Searching strategy cheat-sheet

| Goal | Source | Sample query |
|---|---|---|
| Raw complaint language | HN `tags=comment` | `"frustrated with" OR "pain point" <category>` |
| Unmet "how do I…" need | Stack Exchange `site=stackoverflow` | `<category> how to` |
| Popularity/engagement proxy | HN `tags=story` `numericFilters=points>40` | `<category>` |
| Existing product rating | iTunes `lookup` | (by `trackId`) |
| Community sentiment | Reddit via Arctic Shift `comments/search?body=` | `<problem>` |
| Volume/trend proxy | HN `numericFilters=created_at_i>...` | (date-bounded) |

Note: the `numericFilters` and date-bounded queries give a **directional** signal of recency/volume — not a true trend line (that would require scheduled accumulation, which is out of scope; this skill is realtime-only).

When querying Stack Exchange for customer language, use `filter=withbody` to retrieve actual question text, and weight recency by `creation_date` explicitly — results are often old.
