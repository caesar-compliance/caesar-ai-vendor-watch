import { getAppBaseUrl } from '@/lib/app-config';

export { getAppBaseUrl };

/**
 * Generate a shareable link for a specific change
 * @param commitId - The first 8 characters of the commit SHA (used as anchor)
 * @returns Full URL with hash anchor for direct navigation
 */
export function getChangeShareLink(commitId: string): string {
  const baseUrl = getAppBaseUrl();
  return `${baseUrl}/change/${commitId}`;
}

/**
 * Extract commit ID from a full change ID
 * @param changeId - Full change ID (format: sha-filename-timestamp)
 * @returns First 8 characters (commit SHA prefix)
 */
export function extractCommitId(changeId: string): string {
  return changeId.substring(0, 8);
}