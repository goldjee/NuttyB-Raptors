-- DeathEffectsReduction
-- Hides death and crash particles; explosion damage and wrecks stay the same.
-- https://github.com/nuttyb-community/nuttyb

do
    local unitDefs = UnitDefs or {}

    local function copy(source)
        local result = {}
        for key, value in pairs(source) do
            result[key] = type(value) == 'table' and copy(value) or value
        end
        return result
    end

    -- Shared death explosions (explodeas = 'fusionExplosion' and the like)
    -- live in weapons/*.lua, not in the unit's own weapondefs
    local explosions = {}
    if VFS and VFS.DirList and VFS.Include then
        local ok, system = pcall(VFS.Include, 'gamedata/system.lua')
        if ok and type(system) == 'table' then
            local shared = {}
            for _, path in ipairs(VFS.DirList('weapons/', '*.lua', nil, true)) do
                local env = {
                    Shared = shared,
                    BAR = BAR,
                    GetFilename = function()
                        return path
                    end,
                }
                env._G = env
                setmetatable(env, { __index = system })
                local loaded, weapons = pcall(VFS.Include, path, env)
                if loaded and type(weapons) == 'table' then
                    for name, weaponDef in pairs(weapons) do
                        if type(name) == 'string' and type(weaponDef) == 'table' then
                            explosions[string.lower(name)] = weaponDef
                        end
                    end
                end
            end
        end
    end

    local function silence(base)
        local silent = copy(base)
        silent.explosiongenerator = 'custom:blank'
        silent.cegtag = ''
        silent.camerashake = 0
        return silent
    end

    -- BAR resolves explodeas to <unit>_<name> first, then to the global name,
    -- so one armed unit can hold the silent copies for everyone
    local carrierName = 'armcom'
    local carrier = unitDefs[carrierName]
    if carrier and not carrier.weapondefs then
        carrier = nil
    end

    for _, unitDef in pairs(unitDefs) do
        -- Debris and crash particles
        unitDef.sfxtypes = unitDef.sfxtypes or {}
        for _, key in ipairs({
            'pieceexplosiongenerators',
            'crashexplosiongenerators',
        }) do
            local generators = unitDef.sfxtypes[key] or {}
            for i in pairs(generators) do
                generators[i] = 'blank'
            end
            if not next(generators) then
                generators[1] = 'blank'
            end
            unitDef.sfxtypes[key] = generators
        end

        -- Death explosions: a silent copy keeps the damage and area
        for _, key in ipairs({ 'explodeas', 'selfdestructas' }) do
            local name = unitDef[key]
            if type(name) == 'string' and name ~= '' then
                name = string.lower(name)
                local own = (unitDef.weapondefs or {})[name]
                if own then
                    -- Already armed, so one more weapondef changes nothing
                    local alias = 'nuttyb_quiet_' .. key
                    unitDef.weapondefs[alias] = silence(own)
                    unitDef[key] = alias
                elseif explosions[name] and carrier then
                    -- Shared explosions go on the carrier: a weapondef on an
                    -- unarmed unit would make BAR treat it as armed (WEAPON
                    -- category, antinukes no longer blocked by "No nukes")
                    local alias = 'nuttyb_quiet_' .. name
                    carrier.weapondefs[alias] = carrier.weapondefs[alias]
                        or silence(explosions[name])
                    unitDef[key] = carrierName .. '_' .. alias
                end
            end
        end
    end
end
