# Deployment Policy

Date: 23 May 2026  
Task: T001A

## Default mode
- Development is local-first by default.
- Feature branches may be pushed for backup and review.
- Production deployment is not required for every task.

## When production deployment is allowed
Production deployment should happen only:
1. For larger release batches.
2. After validation is green.
3. After DB migration plan is clear.
4. After explicit owner approval or a release-task instruction.

## What should not auto-deploy
- Small docs/internal/hardening tasks should not automatically deploy production.
- Because Vercel auto-deploys `main`, agents must avoid merging to `main` when deployment is not intended.

## Recommended workflow
1. Create branch.
2. Implement change locally.
3. Run local validation.
4. Commit and push branch.
5. Publish final report.
6. Get Control Tower/owner approval.
7. Merge/deploy only when approved.

## Optional ways to reduce unnecessary Vercel deploys
1. Keep auto-deploy on `main`, but batch small tasks before merge.
2. Use a dedicated production branch (for example `production`) as Vercel production branch.
3. Configure an ignored build step to skip non-release commits (for example only when commit message contains `[deploy]`).
4. Prefer PR/branch review and local validation over immediate production merges.

## Canonical URL policy
- Canonical public production URL: `https://vendor-watch.caesar.no`.
- Technical Vercel deployment URLs may exist for platform operations, but are not canonical public references in docs/metadata.
