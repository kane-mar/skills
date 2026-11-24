# Reddit Setup (legacy — for users with existing credentials)

> ⚠️ **New Reddit app registration is effectively closed** (~2025). Attempting to create a new app in `prefs/apps` fails with **"max clients reached"**, and the page now force-redirects to login. This guide is retained only for users who **already hold** a working `client_id`/`client_secret` created before the door closed. Most new users should treat Reddit as unavailable and rely on the key-less sources (HN, Stack Exchange, iTunes).

Reddit is the richest community source for complaint/need language, but it requires OAuth credentials. Reddit activates only when credentials already exist.

## 1. (Only if you don't already have an app) Verify credentials

If you already hold a `client_id`/`secret`, skip to step 2. Creating a **new** app is generally impossible now — the form throws "max clients reached." Don't waste time on it.

## 2. Store the credentials

Two options (the skill reads them in this precedence order):

**Option A — environment variables (recommended):**

```bash
export REDDIT_CLIENT_ID="<your client_id>"
export REDDIT_CLIENT_SECRET="<your secret>"
```

**Option B — local config file (git-ignored):**

Copy the template and fill it in:

```bash
cp references/config.example.json references/config.json
# edit references/config.json, paste your client_id and secret
```

`references/config.json` is already git-ignored (see the repo root `.gitignore`), so it won't be committed.

## 3. Verify it works

Run this once to confirm the credentials are valid. It performs the exact two-step flow the skill uses:

```bash
# Step 1 — get a bearer token (client-credentials grant)
TOKEN=$(curl -s -X POST "https://www.reddit.com/api/v1/access_token" \
  -H "User-Agent: product-discovery/0.1" \
  -H "Authorization: Basic $(printf '%s:%s' "$REDDIT_CLIENT_ID" "$REDDIT_CLIENT_SECRET" | base64)" \
  -d "grant_type=client_credentials" \
  | python3 -c "import json,sys; print(json.load(sys.stdin)['access_token'])")

echo "token length: ${#TOKEN}"

# Step 2 — fetch a subreddit (authenticated)
curl -s "https://oauth.reddit.com/r/productmanagement/top?limit=3" \
  -H "User-Agent: product-discovery/0.1" \
  -H "Authorization: bearer $TOKEN" \
  | python3 -c "import json,sys; [print(c['data']['title'][:70]) for c in json.load(sys.stdin)['data']['children']]"
```

If you see post titles, it's working. If you get `{"error": 401}`, the credentials are wrong or the app type isn't "script".

## Notes

- **Read-only.** The skill only does `GET` requests (search, list). It never posts, votes, or messages. Keep the app type "script" — no redirect URL or user authorization flow is needed.
- **Tokens expire ~24h.** The skill requests a fresh bearer token on each run (client-credentials grant is cheap). Do not store the token.
- **User-Agent.** Reddit requires a unique, descriptive `User-Agent`. The skill uses `product-discovery/0.1`; if you fork it, change this to your own string.
- **Rate limits.** ~100 req/min authenticated (vs ~10–30 anonymous). The skill's realtime queries fit comfortably within this.
