# Caesar Vendor Watch

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Next.js](https://img.shields.io/badge/Next.js-16-black?logo=next.js)](https://nextjs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supabase-336791?logo=postgresql&logoColor=white)](https://supabase.com/)
[![Deployed on Vercel](https://img.shields.io/badge/Deploy-Vercel-black?logo=vercel)](https://vercel.com/)
[![Live](https://img.shields.io/badge/Live-vendor--watch.caesar.no-2563eb)](https://vendor-watch.caesar.no/)

Track changes to **Terms of Service**, **Privacy Policies**, and related vendor legal documents across major platforms. AI-powered summaries, filters, RSS, and a clean reading experience.

**Live:** [https://vendor-watch.caesar.no](https://vendor-watch.caesar.no)

Maintained by **[Caesar Compliance](https://github.com/caesar-compliance)** · [@artemhobotun](https://github.com/artemhobotun)

---

## Why this stack?

| Platform | Fit for this app |
|----------|------------------|
| **Vercel** | Best — Next.js, API routes, cron (`vercel.json`), env vars |
| **Cloudflare Pages** | Possible, but cron/long API need extra Workers setup |
| **GitHub Pages** | Not suitable — static only, no server/API/database |

Use **GitHub for the repo**, **Vercel for the live site**.

---

## Features

- Timeline of ToS / policy changes (social + AI vendors)
- AI summaries via OpenRouter (minor changes filtered)
- Filters by service, document type, category
- Per-change share links and diff view
- RSS feed at `/rss`
- Automated sync twice daily (Vercel Cron)

## Data sources

Public archives from [Open Terms Archive](https://opentermsarchive.org/):

- [Platform Governance Archive](https://opentermsarchive.org/en/collections/pga/) → `OpenTermsArchive/pga-versions`
- [Generative AI Governance Archive](https://opentermsarchive.org/en/collections/genai-eu/) → `OpenTermsArchive/genai-eu-versions`

---

## Quick start (local)

```bash
git clone https://github.com/caesar-compliance/caesar-vendor-watch.git
cd caesar-vendor-watch
npm install
cp .env.example .env
# Fill DATABASE_URL, GITHUB_TOKEN, LLM_API_KEY, CRON_SECRET
npx prisma migrate deploy
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

**Load data:**

```bash
npm run reset:db
curl -H "Authorization: Bearer $CRON_SECRET" http://localhost:3000/api/cron
```

---

## Environment variables

| Variable | Required | Description |
|----------|----------|-------------|
| `DATABASE_URL` | Yes | Supabase **Session pooler** URI (port 5432) |
| `GITHUB_TOKEN` | Yes | GitHub PAT (public repo read) |
| `LLM_API_KEY` | Yes | OpenRouter API key |
| `CRON_SECRET` | Yes | Random string; protects `/api/cron` |
| `NEXT_PUBLIC_APP_URL` | Yes | Production URL (e.g. `https://your-app.vercel.app`) |
| `NEXT_PUBLIC_GITHUB_REPO_URL` | No | Footer link to this repo |
| `NEXT_PUBLIC_EMAIL_SUBSCRIBE_URL` | No | External newsletter URL |

See [`.env.example`](.env.example).

---

## Deploy on Vercel

1. Push this repo to `caesar-compliance/caesar-vendor-watch` on GitHub.
2. [vercel.com](https://vercel.com) → **Add New Project** → import the repo.
3. **Environment Variables** — copy all from `.env.example` (use Supabase pooler `DATABASE_URL`).
4. Set `NEXT_PUBLIC_APP_URL` to your Vercel URL (e.g. `https://caesar-vendor-watch.vercel.app`).
5. Deploy. Cron runs automatically (see `vercel.json`).

**Supabase note:** on **Vercel**, use the **Transaction pooler** URI (port **6543**, `?pgbouncer=true`). For local dev, session pooler (port **5432**) is fine. Direct `db.*.supabase.co` often fails from Vercel/home networks.

Set `NEXT_PUBLIC_APP_URL=https://vendor-watch.caesar.no` in Vercel env vars.

**Custom domain:** Vercel → Project → Domains → add your domain → update `NEXT_PUBLIC_APP_URL`.

---

## Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Development server |
| `npm run build` | Production build |
| `npm run start` | Run production build locally |
| `npm run reset:db` | Clear changes; set sync from 2025-01-01 |
| `npm run clean:db` | Delete all changes |

---

## Tech stack

- **Framework:** Next.js 16 (App Router)
- **Database:** PostgreSQL + Prisma
- **Styling:** Tailwind CSS
- **AI:** OpenRouter (OpenAI-compatible)
- **Deploy:** Vercel

---

## Maintainer

- **Organization:** [caesar-compliance](https://github.com/caesar-compliance)
- **GitHub:** [@artemhobotun](https://github.com/artemhobotun)
- **Email:** nazzarkoartem@gmail.com

## License

MIT — see [LICENSE](LICENSE). Copyright (c) Caesar Compliance — Artem Hobotun.

## Acknowledgments

- [Open Terms Archive](https://opentermsarchive.org/) for source data
