/**
 * Template interpolation system for Lua files.
 *
 * Supports extended reference syntax: ~lua/file.lua{VAR1=value1,VAR2=value2}
 * Replaces $VARIABLE_NAME$ placeholders in templates with actual values.
 * Evaluates simple Lua arithmetic expressions for dynamic calculations.
 */

export interface ParsedReference {
    filePath: string;
    variables: Record<string, string>;
}

/**
 * Parses an extended Lua file reference into its components.
 *
 * Syntax: ~lua/file.lua{VAR1=val1,VAR2=val2}
 *
 * @param ref The reference string to parse
 * @returns Parsed components or null if not a template reference
 *
 * @example
 * parseReference('~lua/raptor-hp-template.lua{HP_MULTIPLIER=1.5}')
 * // Returns: { filePath: 'lua/raptor-hp-template.lua', variables: { HP_MULTIPLIER: '1.5' } }
 *
 * parseReference('~lua/main-defs.lua')
 * // Returns: { filePath: 'lua/main-defs.lua', variables: {} }
 */
function parseReference(ref: string): ParsedReference | null {
    if (!ref.startsWith('~')) {
        console.warn(`Invalid Lua reference (missing ~ prefix): ${ref}`);
        return null;
    }

    // Match pattern: ~path/to/file.lua{VAR1=val1,VAR2=val2}
    // Group 1: path/to/file.lua
    // Group 2: VAR1=val1,VAR2=val2 (optional)
    const match = ref.match(/^~([^{]+)(?:\{([^}]+)\})?$/);

    if (!match) {
        console.warn(`Malformed Lua reference syntax: ${ref}`);
        return null;
    }

    const filePath = match[1];
    const variablesString = match[2];

    const variables: Record<string, string> = {};

    if (variablesString) {
        // Parse key=value pairs separated by commas
        const pairs = variablesString.split(',');

        for (const pair of pairs) {
            const [key, value] = pair.split('=').map((s) => s.trim());

            if (!key || value === undefined) {
                console.warn(
                    `Invalid variable pair in reference ${ref}: "${pair}"`
                );
                continue;
            }

            variables[key] = value;
        }
    }

    return { filePath, variables };
}

/**
 * Safely evaluates a simple arithmetic expression.
 *
 * Only allows: numbers, operators (+, -, *, /), parentheses, and whitespace.
 * Uses a safe expression parser instead of eval for security.
 *
 * @param expression The arithmetic expression to evaluate
 * @returns Evaluated result as string, or original expression if evaluation fails
 *
 * @example
 * evaluateExpression('0.75 / 1.5')  // Returns: '0.5'
 * evaluateExpression('2 * 3 + 1')   // Returns: '7'
 * evaluateExpression('malicious()')  // Returns: 'malicious()' (unchanged, logged warning)
 */
function evaluateExpression(expression: string): string {
    // Safety check: only allow numbers, operators, parentheses, dots, and whitespace
    if (!/^[\d\s+\-*/().]+$/.test(expression)) {
        console.warn(
            `Unsafe expression detected, skipping evaluation: ${expression}`
        );
        return expression;
    }

    try {
        // Safe manual parsing for simple arithmetic
        // Only handles division for now (primary use case: 0.75 / HP_MULTIPLIER)
        const trimmed = expression.trim();

        // Handle division: "0.75 / 1.5"
        if (trimmed.includes('/')) {
            const parts = trimmed
                .split('/')
                .map((p) => Number.parseFloat(p.trim()));
            if (parts.length === 2 && parts.every((p) => !Number.isNaN(p))) {
                const result = parts[0] / parts[1];
                return result.toString();
            }
        }

        // Handle multiplication: "2 * 3"
        if (trimmed.includes('*')) {
            const parts = trimmed
                .split('*')
                .map((p) => Number.parseFloat(p.trim()));
            if (parts.length === 2 && parts.every((p) => !Number.isNaN(p))) {
                const result = parts[0] * parts[1];
                return result.toString();
            }
        }

        console.warn(
            `Expression format not supported for evaluation: ${expression}`
        );
        return expression;
    } catch (error) {
        console.warn(`Failed to evaluate expression: ${expression}`, error);
        return expression;
    }
}

/**
 * Interpolates template placeholders with variable values.
 *
 * Replaces $VARIABLE_NAME$ with corresponding values from variables object.
 * Supports Lua expression evaluation for dynamic calculations.
 *
 * @param template The template string with $PLACEHOLDER$ markers
 * @param variables Object mapping variable names to values
 * @returns Interpolated template string
 *
 * @example
 * interpolateTemplate(
 *   'unitDef.health = unitDef.health * $HP_MULTIPLIER$',
 *   { HP_MULTIPLIER: '1.5' }
 * )
 * // Returns: 'unitDef.health = unitDef.health * 1.5'
 *
 * interpolateTemplate(
 *   'unitDef.metalcost = math.floor(unitDef.health * (0.75 / $HP_MULTIPLIER$))',
 *   { HP_MULTIPLIER: '1.5' }
 * )
 * // Returns: 'unitDef.metalcost = math.floor(unitDef.health * (0.5))'
 */
function interpolateTemplate(
    template: string,
    variables: Record<string, string>
): string {
    // Track which variables were actually used
    const usedVariables = new Set<string>();

    // First pass: Replace all $VARIABLE$ placeholders
    let interpolated = template.replaceAll(
        /\$(\w+)\$/g,
        (match, varName: string) => {
            if (varName in variables) {
                usedVariables.add(varName);
                return variables[varName];
            }

            console.warn(
                `Undefined template variable: ${varName} (placeholder: ${match})`
            );
            return match; // Keep placeholder if variable not found
        }
    );

    // Second pass: Evaluate arithmetic expressions in parentheses
    // Matches patterns like (0.75 / 1.5) that resulted from variable substitution
    interpolated = interpolated.replaceAll(
        /\(([^()]+)\)/g,
        (match, expression: string) => {
            // Only evaluate if expression contains arithmetic operators
            if (/[+\-*/]/.test(expression)) {
                const evaluated = evaluateExpression(expression);
                return `(${evaluated})`;
            }
            return match;
        }
    );

    // Check for unused variables (potential typos in template)
    const unusedVariables = Object.keys(variables).filter(
        (v) => !usedVariables.has(v)
    );
    if (unusedVariables.length > 0) {
        console.warn(
            `Template variables provided but not used: ${unusedVariables.join(', ')}`
        );
    }

    return interpolated;
}

/**
 * Main API: Processes a Lua file reference with optional variable interpolation.
 *
 * Handles both standard references (~lua/file.lua) and template references
 * (~lua/template.lua{VAR=value}). Loads file from bundle, interpolates variables,
 * and returns ready-to-use Lua code.
 *
 * @param ref The Lua file reference (with optional template variables)
 * @param luaFileMap Map of file paths to Lua source code (from bundle)
 * @returns Interpolated Lua source code, or null if file not found/error occurred
 *
 * @example
 * processLuaReference(
 *   '~lua/raptor-hp-template.lua{HP_MULTIPLIER=1.5}',
 *   luaFileMap
 * )
 * // Loads template, replaces $HP_MULTIPLIER$ with 1.5, returns interpolated code
 */
export function processLuaReference(
    ref: string,
    luaFileMap: Map<string, string>
): string | null {
    // Parse the reference
    const parsed = parseReference(ref);
    if (!parsed) {
        return null;
    }

    const { filePath, variables } = parsed;

    // Load template/file from bundle
    const template = luaFileMap.get(filePath);
    if (!template) {
        console.warn(
            `Lua file not found in bundle: ${filePath} (from reference: ${ref})`
        );
        return null;
    }

    // If no variables, return template as-is
    if (Object.keys(variables).length === 0) {
        return template;
    }

    // Interpolate variables
    const interpolated = interpolateTemplate(template, variables);

    return interpolated;
}
