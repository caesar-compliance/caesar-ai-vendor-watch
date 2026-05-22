/** Central branding, ownership, and URLs for Caesar AI Vendor Watch */

export const APP_SLUG = 'caesar-ai-vendor-watch';
export const APP_NAME = 'Caesar AI Vendor Watch';
export const APP_TAGLINE =
  'Tracking changes to Terms of Service across major platforms.';
export const APP_DESCRIPTION =
  'Monitor changes to Terms of Service, Privacy Policies, and Community Guidelines across major social media platforms and AI services.';

export const GITHUB_ORG = 'caesar-compliance';
export const GITHUB_USER = 'artemhobotun';
export const GITHUB_REPO = 'caesar-ai-vendor-watch';
export const GITHUB_REPO_URL = `https://github.com/${GITHUB_ORG}/${GITHUB_REPO}`;

export const AUTHOR_NAME = 'Artem Hobotun';
export const AUTHOR_EMAIL = 'nazzarkoartem@gmail.com';

export const APP_DEFAULT_URL = 'http://localhost:3000';

export function getAppBaseUrl(): string {
  return process.env.NEXT_PUBLIC_APP_URL || APP_DEFAULT_URL;
}

export function getGithubRepoUrl(): string {
  return process.env.NEXT_PUBLIC_GITHUB_REPO_URL || GITHUB_REPO_URL;
}

export function getPageTitle(suffix?: string): string {
  return suffix ? `${suffix} — ${APP_NAME}` : APP_NAME;
}
