/**
 * E2E tests for lobby command generation.
 */

import { describe, expect, test } from 'bun:test';

import { decode } from '@/lib/base64';
import { buildLobbySections } from '@/lib/commands/command-builder';
import { Configuration, DEFAULT_CONFIGURATION } from '@/lib/configuration';
import {
    BASE_COMMANDS,
    BASE_TWEAKS,
    CONFIGURATION_MAPPING,
    MAX_COMMAND_LENGTH,
    MAX_SLOTS_PER_TYPE,
} from '@/lib/data/configuration-mapping';
import { stripCommentPrefix } from '@/lib/lua-comments';
import { TweakValue } from '@/types/types';

import { getBundle } from './utils/bundle';

/**
 * Helper function to map configuration settings to expected commands and Lua files.
 * @param configuration Target configuration
 * @returns The list of expected commands and Lua file paths
 */
function mapSettingsToConfig(configuration: Configuration): string[] {
    const mapped: string[] = [
        ...BASE_COMMANDS,
        ...BASE_TWEAKS.tweakdefs,
        ...BASE_TWEAKS.tweakunits,
    ];

    // Include always-enabled base tweaks

    for (const configKey in configuration) {
        const configValue = configuration[configKey as keyof Configuration];
        const mapping = CONFIGURATION_MAPPING[configKey as keyof Configuration];
        const tweakValue = mapping.values[
            `${configValue}` as keyof typeof mapping.values
        ] as TweakValue | undefined;

        if (!tweakValue) continue;

        // Process commands
        const commands = tweakValue.command;
        if (commands && commands.length > 0) {
            mapped.push(...commands);
        }

        // Process Lua files (tweakdefs and tweakunits)
        for (const paths of [tweakValue.tweakdefs, tweakValue.tweakunits]) {
            if (paths && paths.length > 0) {
                mapped.push(...paths);
            }
        }
    }

    return mapped;
}

describe('Command generation', () => {
    test('Default configuration generates expected commands', () => {
        const config = DEFAULT_CONFIGURATION;
        const bundle = getBundle();
        if (!bundle) expect.unreachable('Bundle should exist');

        const luaFiles = bundle.files;
        const generatedLobbySections = buildLobbySections(config, luaFiles);
        const sections = generatedLobbySections.sections;

        expect(sections.length).toBeGreaterThan(0);
        const generatedTweaks = [];
        for (const section of sections) {
            expect(section.length).toBeLessThanOrEqual(MAX_COMMAND_LENGTH);
            generatedTweaks.push(...section.split('\n'));
        }

        // Decode generated tweaks to extract source references
        const tweaks = [];
        let tweakdefsCnt = 0;
        let tweakunitsCnt = 0;
        for (const generatedTweak of generatedTweaks) {
            if (!/^!bset tweakdefs|^!bset tweakunits/.test(generatedTweak)) {
                tweaks.push(generatedTweak);
                continue;
            }

            if (generatedTweak.startsWith('!bset tweakdefs')) tweakdefsCnt++;
            if (generatedTweak.startsWith('!bset tweakunits')) tweakunitsCnt++;
            const base64 = generatedTweak.replace(
                /^!bset tweakdefs\d* |^!bset tweakunits\d* /,
                ''
            );
            const decodedLines = decode(base64).split('\n');
            const sourceRefs = [];
            for (const line of decodedLines) {
                if (line.startsWith('-- Source: ')) {
                    sourceRefs.push(
                        stripCommentPrefix(line).trim().replace('Source: ', '')
                    );
                }
            }
            tweaks.push(...sourceRefs);
        }

        // Verify slot counts are within limits
        expect(tweakdefsCnt).toBeLessThanOrEqual(MAX_SLOTS_PER_TYPE);
        expect(tweakunitsCnt).toBeLessThanOrEqual(MAX_SLOTS_PER_TYPE);

        const expectedTweaks = mapSettingsToConfig(config);
        for (const expectedTweak of expectedTweaks) {
            expect(tweaks).toContain(expectedTweak);
        }
    });
});
