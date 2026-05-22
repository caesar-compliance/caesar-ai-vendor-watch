# LLM Fallback Strategy — Caesar AI Vendor Watch

Research date: May 2026. Goal: maximize free AI summary capacity with a reliable fallback chain for cron + backfill.

## Current state

- Single provider: OpenRouter (`lib/ai.ts` + `llm.yaml`)
- Model today: `google/gemini-2.5-pro` (paid via OpenRouter credits)
- OpenAI-compatible client already used → easy to add providers
- Heuristic pre-checks already exist (tracking errors, availability patterns) — no LLM cost

## Workload (this app)

| Scenario | LLM calls | Free tier fit |
|----------|-----------|---------------|
| Vercel cron 2×/day, few new commits | ~0–30/day | Excellent |
| Full backfill from 2025 | 500–2000+ | Poor on free-only — need throttling + paid backup |

Each changed `.md` file in a commit = 1 LLM call (~2–20 KB diff + prompt).

---

## Free provider options (ranked for this project)

### Tier A — Best fit (OpenAI-compatible, no card or generous free)

| # | Provider | Where to get key | Base URL | Suggested model | Free limits (approx.) | JSON mode |
|---|----------|------------------|----------|-----------------|----------------------|-----------|
| 1 | **Google AI Studio (Gemini direct)** | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) | `https://generativelanguage.googleapis.com/v1beta/openai/` | `gemini-2.0-flash` | ~15 RPM, ~1500 RPD ([rate limits](https://ai.google.dev/gemini-api/docs/rate-limits)) | Yes |
| 2 | **Groq** | [console.groq.com/keys](https://console.groq.com/keys) | `https://api.groq.com/openai/v1` | `llama-3.1-8b-instant` | ~30 RPM, up to ~14.4K RPD ([docs](https://console.groq.com/docs/rate-limits)) | Yes |
| 3 | **OpenRouter free models** | Existing OpenRouter account | `https://openrouter.ai/api/v1` | See below | ~20 RPM aggregate on free models ([free collection](https://openrouter.ai/collections/free-models)) | Most support JSON |

**OpenRouter free models worth testing** (quality vs policy diffs):

- `google/gemma-3-27b-it:free` or `google/gemma-4-31b-it:free`
- `meta-llama/llama-3.3-70b-instruct:free`
- `deepseek/deepseek-v4-flash:free`
- `openrouter/free` — auto-picks free model ([docs](https://openrouter.ai/docs/guides/routing/routers/free-router))

### Tier B — Backup / optional

| Provider | Notes |
|----------|--------|
| **OpenRouter paid** | Current setup; keep as last paid fallback when free exhausted |
| **Mistral free tier** | Occasional credits; separate SDK — lower priority |
| **Cloudflare Workers AI** | Only if app moves to CF; not for current Vercel setup |
| **Ollama** | Local dev only; not for Vercel cron |

### Tier C — Always free (no API)

| Layer | What it does |
|-------|----------------|
| **Heuristics** | `tracking.ts`, availability patterns, `condition: all` — already in `ai.ts` |
| **Template fallback** | `${service} updated ${documentType}. See diff.` |
| **Rule-based minor** | Large repeated diff lines → minor without LLM |

---

## Recommended fallback chain

```
generateSummary()
  │
  ├─ 0. Heuristics (tracking / availability)     → free, instant
  │
  ├─ 1. Google Gemini direct (GEMINI_API_KEY)   → free tier primary
  │
  ├─ 2. Groq (GROQ_API_KEY)                     → free tier secondary
  │
  ├─ 3. OpenRouter free (LLM_API_KEY + :free model)
  │
  ├─ 4. OpenRouter paid (LLM_API_KEY + cheap flash model)
  │
  └─ 5. Template fallback                         → always succeeds
```

**Production cron:** try 1 → 2 → 3 → 4 → 5.  
**Backfill:** add 200ms delay between calls + stop chain on daily quota errors.

---

## Environment variables (planned)

```env
# Provider chain (comma-separated): gemini,groq,openrouter_free,openrouter_paid,template
LLM_PROVIDER_CHAIN=gemini,groq,openrouter_free,openrouter_paid,template

# Google Gemini (direct)
GEMINI_API_KEY=
GEMINI_MODEL=gemini-2.0-flash

# Groq
GROQ_API_KEY=
GROQ_MODEL=llama-3.1-8b-instant

# OpenRouter (existing)
LLM_API_KEY=
OPENROUTER_FREE_MODEL=google/gemma-3-27b-it:free
OPENROUTER_PAID_MODEL=google/gemini-2.0-flash

# Optional: disable paid tier entirely
LLM_ALLOW_PAID=false
```

Keep backward compatibility: if only `LLM_API_KEY` is set, behave as today (OpenRouter paid).

---

## Code changes (implementation plan)

### Phase 1 — Config + provider abstraction

- [ ] `lib/llm/types.ts` — `LLMProvider`, `SummaryRequest`, `ProviderResult`
- [ ] `lib/llm/providers/gemini.ts`
- [ ] `lib/llm/providers/groq.ts`
- [ ] `lib/llm/providers/openrouter.ts`
- [ ] `lib/llm/providers/template.ts`
- [ ] `lib/llm/chain.ts` — ordered execution, logging `providerUsed`
- [ ] Refactor `lib/ai.ts` to call chain (thin wrapper)

### Phase 2 — Observability

- [ ] Log provider name per summary (Vercel logs)
- [ ] Optional DB field `summaryProvider` on `Change` (migration) — audit which key worked
- [ ] Cron response: `providers: { gemini: 12, groq: 3, template: 1 }`

### Phase 3 — Rate limit safety

- [ ] Per-provider cooldown on 429
- [ ] Cron: increase delay from 200ms → 500ms when using free tiers
- [ ] Cap `newChanges` LLM calls per cron run (e.g. 50) — rest queued for next run

### Phase 4 — Docs + Vercel env

- [ ] Update `.env.example` with all keys
- [ ] README section «AI providers»
- [ ] Add keys to Vercel (Production + Preview)

---

## Where to register (checklist)

| Step | Action | Account |
|------|--------|---------|
| 1 | Create Gemini API key | `nazzarkoartem@gmail.com` → [AI Studio](https://aistudio.google.com) |
| 2 | Create Groq API key | Same email → [Groq Console](https://console.groq.com) |
| 3 | OpenRouter free models | Existing key; switch model to `:free` variant |
| 4 | Add all keys to Vercel | Project → Environment Variables |
| 5 | Add to local `.env` | Never commit |

---

## Cost expectations

| Mode | Monthly cost |
|------|----------------|
| Cron only (few updates/day) | **$0** with free chain |
| OpenRouter paid backup | ~$1–5 if free quotas hit |
| Full historical backfill | **Not free** — budget $5–20 or run over several days on free tiers |

---

## Risks

| Risk | Mitigation |
|------|------------|
| Free quota exhausted mid-cron | Chain falls through; template still stores row |
| JSON parse failures on small models | Retry next provider; validate schema |
| Different summary quality per model | Acceptable for v1; optional `summaryProvider` label |
| OpenRouter free model downtime | `openrouter/free` router or multiple `:free` models |

---

## Next development session

1. You create **GEMINI_API_KEY** + **GROQ_API_KEY**
2. We implement Phase 1 (chain + 3 providers)
3. Test locally with one diff
4. Deploy to Vercel + run cron once
5. Compare `providerUsed` in logs

---

## References

- [Gemini API rate limits](https://ai.google.dev/gemini-api/docs/rate-limits)
- [Groq rate limits](https://console.groq.com/docs/rate-limits)
- [OpenRouter free models](https://openrouter.ai/collections/free-models)
- [OpenRouter free router](https://openrouter.ai/docs/guides/routing/routers/free-router)
