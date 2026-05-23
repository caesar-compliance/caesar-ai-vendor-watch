# PROJECT_STATE

- Date: 23 May 2026
- Product: Caesar AI Vendor Watch
- Baseline: v0.1.0 - Initial controlled runtime baseline
- Current Task: T001A - Production URL Alignment and Deployment Cadence Policy

## Purpose
Track, compare, summarize, and publish policy/legal document changes (ToS, privacy, acceptable use, service terms, subprocessors) for AI and platform vendors.

## Architecture Snapshot
- Frontend/runtime: Next.js 16 App Router + React 19 (Node runtime routes)
- Data/API: App routes (`/api/cron`, `/api/changes`, `/api/filter-options`, `/rss`)
- DB: PostgreSQL (Supabase) via Prisma
- Ingestion: GitHub OpenTermsArchive repositories via Octokit
- AI summaries: OpenRouter-compatible endpoint via `openai` SDK and `llm.yaml`
- Deployment: Vercel (`vercel.json` cron schedules at 01:00 and 13:00)

## Data Sources
- `OpenTermsArchive/pga-versions`
- `OpenTermsArchive/genai-eu-versions`

## Deployment Status
- Canonical public production URL: `https://vendor-watch.caesar.no`
- Technical Vercel deployment URLs may exist, but they are not canonical public links.
- Current deployment state in this task: no deployment executed in T001/T001A

## Runtime/DB Status
- Prisma models: `Change`, `LastCheck`
- Existing migration path: `prisma/migrations/20250522120000_init`
- No schema/database changes applied in T001

## Safety Boundaries
- Local repository is source of truth.
- No secrets are to be printed or committed.
- No destructive production DB operations.
- Cron/security behavior changes must be explicitly documented.
- Local-first development by default; do not merge/deploy every small task.

## Current Product Status
- Live runtime product with ingestion, summaries, filterable UI, RSS, and cron flow.
- Not yet guaranteed: ingestion idempotency under concurrent runs, strict duplicate prevention, comprehensive observability, summary version metadata.

## Next Recommended Task
- T002 - Ingestion Idempotency, DB Uniqueness, and API Safety
