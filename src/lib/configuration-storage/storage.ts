import {
    Configuration,
    DEFAULT_CONFIGURATION,
} from '@/lib/command-generator/data/configuration';

/**
 * Structure stored in localStorage for configuration.
 * Includes Git SHA for version tracking.
 */
export interface StoredConfiguration {
    /** The user's saved configuration */
    configuration: Configuration;
    /** Git SHA of the app version when config was saved */
    gitSha: string;
}

/**
 * Get the current Git SHA from environment.
 * Returns 'development' if not set (local dev without git).
 */
function getCurrentGitSha(): string {
    return process.env.NEXT_PUBLIC_GIT_SHA ?? 'development';
}

/**
 * Default stored configuration with current Git SHA.
 */
export function getDefaultStoredConfiguration(): StoredConfiguration {
    return {
        configuration: DEFAULT_CONFIGURATION,
        gitSha: getCurrentGitSha(),
    };
}

/**
 * Validates stored configuration against current app version.
 * Merges stored config with defaults to ensure all fields exist.
 *
 * @param stored The stored configuration from localStorage
 * @returns The stored configuration merged with defaults, or null if invalid
 */
export function validateStoredConfiguration(
    stored: StoredConfiguration
): StoredConfiguration | null {
    // Ensure configuration object exists
    if (!stored.configuration || typeof stored.configuration !== 'object') {
        return null;
    }

    // Merge stored config with defaults to ensure all fields exist
    // (handles cases where new fields were added in updates)
    const mergedConfiguration: Configuration = {
        ...DEFAULT_CONFIGURATION,
        ...stored.configuration,
    };

    return {
        configuration: mergedConfiguration,
        gitSha: getCurrentGitSha(),
    };
}

/**
 * Creates a StoredConfiguration object with the current Git SHA.
 *
 * @param configuration The configuration to wrap
 * @returns StoredConfiguration ready for persistence
 */
export function createStoredConfiguration(
    configuration: Configuration
): StoredConfiguration {
    return {
        configuration,
        gitSha: getCurrentGitSha(),
    };
}
