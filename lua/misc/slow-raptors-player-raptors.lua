--Slow playable raptors/scav
-- bar-nuttyb-collective.github.io/configurator/
local unitDefs = UnitDefs or {}
for unit, unitDef in pairs(unitDefs) do
	if unit.name:find('raptor') or unit.name:find('_scav') then
		unitDef.speed = unitDef.speed * 0.5
	end
end
