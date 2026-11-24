# Trigger Evals

This eval verifies that the `product-discovery` skill **triggers (loads) on the right prompts and stays silent on the wrong ones**. A skill that fails to route is useless regardless of how good its instructions are.

## How it works

`evals/trigger-evals.json` is a list of `{ "query": ..., "should_trigger": boolean }` pairs:

- **`should_trigger: true`** — the query is a product-discovery task; the skill should load.
- **`should_trigger: false`** — the query is unrelated (bugs, SQL, deploys, translation, refactoring); the skill should **not** load.

Run the eval, count how many prompts the skill correctly fires/doesn't fire on, and compare against a control (a run with the skill disabled) to isolate the skill's effect versus the model's base behavior.

## Running it

There is no universal eval harness — the mechanism is agent-specific. The portable approach:

1. For each prompt in `trigger-evals.json`, present it to the agent and observe whether the skill's instructions (reading `SKILL.md`, running the seven-stage loop) get pulled in.
2. Record `fired` (true/false).
3. Tally:
   - **True positives** — `should_trigger: true` → fired.
   - **True negatives** — `should_trigger: false` → not fired.
   - **False positives** — `should_trigger: false` → fired (over-triggering).
   - **False negatives** — `should_trigger: true` → not fired (misses).

Acceptance bar (starting point; tighten as you iterate):

- ≥ 5/6 `should_trigger: true` fire (≥83% recall) — never miss a genuine discovery task.
- ≥ 5/6 `should_trigger: false` stay silent (≥83% precision) — don't hijack unrelated tasks.
- Zero false negatives on the *strongest* discovery signals (e.g. "should I build X", "is there a market").

For Pi specifically: you can force-load with `/skill:product-discovery` to confirm the skill's *content* is sound, but the **trigger eval is about automatic model selection**, so do NOT use the explicit command for the routing test — present the raw query and observe whether the model reads the skill on its own.

## Results (to fill in)

| Query | should_trigger | fired | correct? |
|---|---|---|---|
| (run and record here) | | | |

See `results.json` for a recorded run and `results-control.json` for a control run (skill disabled) to baseline against.
