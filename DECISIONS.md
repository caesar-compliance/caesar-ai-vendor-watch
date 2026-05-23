# DECISIONS

## 23 May 2026 - D001
- Task: T001
- Version impact: v0.1.0
- Decision: The local repository is the source of truth; uploaded archives may be partial.
- Why: Prevent false assumptions about missing files and keep audits accurate.

## 23 May 2026 - D002
- Task: T001
- Version impact: v0.1.0
- Decision: Freeze the current runtime state as `v0.1.0` before further feature work.
- Why: Establish a controlled baseline for traceable, low-risk iterations.

## 23 May 2026 - D003
- Task: T001
- Version impact: v0.1.0+
- Decision: All meaningful future work is tracked with `T###`, version impact, validation logs, and release records.
- Why: Improve operational discipline, release accountability, and rollback clarity.

## 23 May 2026 - D004
- Task: T001
- Version impact: v0.1.0+
- Decision: Broad local agent permissions are allowed, but secret leakage and destructive production actions remain blocked.
- Why: Maintain development velocity without compromising safety boundaries.

## 23 May 2026 - D005
- Task: T001A
- Version impact: v0.1.0 (governance update)
- Decision: Canonical public URL is `https://vendor-watch.caesar.no`.
- Why: Keep product metadata, docs, and public references consistent.

## 23 May 2026 - D006
- Task: T001A
- Version impact: v0.1.0 (process update)
- Decision: Development is local-first; production deployment is performed only in approved release batches or explicit deploy tasks.
- Why: Avoid unnecessary Vercel production deploys on every small change.
