# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### Added
- Added deployment cadence policy in `docs/DEPLOYMENT_POLICY.md` (local-first; no automatic production deploy for every small task).

### Changed
- Aligned canonical public URL references to `https://vendor-watch.caesar.no` in project governance/docs.
- Updated GitHub repository homepage metadata to `https://vendor-watch.caesar.no`.

## [0.1.0] - 23 May 2026
### Added
- Established the first controlled runtime baseline: `v0.1.0`.
- Added project accounting/governance files:
  - `PROJECT_STATE.md`
  - `CHANGELOG.md`
  - `NEXT_ACTIONS.md`
  - `DECISIONS.md`
  - `RELEASES.md`

### Changed
- Removed local macOS artifact `app/.DS_Store` from the repository working tree.

### Notes
- This release freezes the current runtime state for controlled follow-up tasks.
- No feature-level runtime behavior changes were introduced in T001.
