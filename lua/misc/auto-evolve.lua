--Auto Unit Evolution
local a = {
	arm = {
		{from = 'armwin', fromDesc = 'Wind Turbine', to = 'armsolar', toDesc = 'Solar Collector', timer = 60},
		{from = 'armsolar', fromDesc = 'Solar Collector', to = 'armadvsol', toDesc = 'Advanced Solar Collector', timer = 120},
		{
			from = 'armadvsol',
			fromDesc = 'Advanced Solar Collector',
			to = 'armwint2',
			toDesc = 'Advanced Wind Turbine',
			timer = 240
		},
		{from = 'armwint2', fromDesc = 'Fusion Reactor', to = 'armfus', toDesc = 'Advanced Fusion Reactor', timer = 360},
		{from = 'armfus', fromDesc = 'Fusion Reactor', to = 'armafus', toDesc = 'Advanced Fusion Reactor', timer = 360},
		{
			from = 'armgeo',
			fromDesc = 'Geothermal Powerplant',
			to = 'armfakegeo',
			toDesc = '-Workaround Fake Geo-',
			timer = 360
		},
		{
			from = 'armfakegeo',
			fromDesc = '-Workaround Fake Geo-',
			to = 'armageo',
			toDesc = 'Advanced Geothermal Powerplant',
			timer = 2
		},
		{from = 'armtide', fromDesc = 'Tidal Generator', to = 'armuwfus', toDesc = 'Naval Fusion Reactor', timer = 300},
		{from = 'armmex', fromDesc = 'Metal Extractor', to = 'armfakemex', toDesc = '-Workaround Fake Mex-', timer = 360},
		{
			from = 'armfakemex',
			fromDesc = '-Workaround Fake Mex-',
			to = 'armmoho',
			toDesc = 'Advanced Metal Extractor',
			timer = 2
		},
		{from = 'armdrag', fromDesc = "Dragon's Teeth", to = 'armfort', toDesc = 'Fortification Wall', timer = 360},
		{
			from = 'armnanotc',
			fromDesc = 'Construction Turret',
			to = 'armnanotct2',
			toDesc = 'Advanced Construction Turret',
			timer = 120
		},
		{
			from = 'armnanotcplat',
			fromDesc = 'Naval Construction Turret',
			to = 'armnanotc2plat',
			toDesc = 'Advanced Naval Construction Turret',
			timer = 120
		},
		{
			from = 'armfasp',
			fromDesc = 'Water Air Repair Pad',
			to = 'mission_command_tower',
			toDesc = 'Mission Command Tower',
			timer = 60,
			announce = true,
			anSize = 25
		}
	},
	cor = {
		{from = 'corwin', fromDesc = 'Wind Turbine', to = 'corsolar', toDesc = 'Solar Collector', timer = 60},
		{from = 'corsolar', fromDesc = 'Solar Collector', to = 'coradvsol', toDesc = 'Advanced Solar Collector', timer = 120},
		{
			from = 'coradvsol',
			fromDesc = 'Advanced Solar Collector',
			to = 'corwint2',
			toDesc = 'Advanced Wind Turbine',
			timer = 240
		},
		{from = 'corwint2', fromDesc = 'Advanced Wind Turbine', to = 'corfus', toDesc = 'Fusion Reactor', timer = 300},
		{from = 'corfus', fromDesc = 'Fusion Reactor', to = 'corafus', toDesc = 'Advanced Fusion Reactor', timer = 360},
		{
			from = 'corgeo',
			fromDesc = 'Geothermal Powerplant',
			to = 'corfakegeo',
			toDesc = '-Workaround Fake Geo-',
			timer = 360
		},
		{
			from = 'corfakegeo',
			fromDesc = '-Workaround Fake Geo-',
			to = 'corageo',
			toDesc = 'Advanced Geothermal Powerplant',
			timer = 2
		},
		{from = 'cortide', fromDesc = 'Tidal Generator', to = 'coruwfus', toDesc = 'Naval Fusion Reactor', timer = 300},
		{from = 'cormex', fromDesc = 'Metal Extractor', to = 'corfakemex', toDesc = '-Workaround Fake Mex-', timer = 360},
		{
			from = 'corfakemex',
			fromDesc = '-Workaround Fake Mex-',
			to = 'cormoho',
			toDesc = 'Advanced Metal Extractor',
			timer = 2
		},
		{from = 'cordrag', fromDesc = "Dragon's Teeth", to = 'corfort', toDesc = 'Fortification Wall', timer = 360},
		{
			from = 'cornanotc',
			fromDesc = 'Construction Turret',
			to = 'cornanotct2',
			toDesc = 'Advanced Construction Turret',
			timer = 120
		},
		{
			from = 'cornanotcplat',
			fromDesc = 'Naval Construction Turret',
			to = 'cornanotc2plat',
			toDesc = 'Advanced Naval Construction Turret',
			timer = 120
		},
		{
			from = 'corfasp',
			fromDesc = 'Water Air Repair Pad',
			to = 'mission_command_tower',
			toDesc = 'Mission Command Tower',
			timer = 60,
			announce = true,
			anSize = 25
		}
	},
	leg = {
		{from = 'legwin', fromDesc = 'Wind Turbine', to = 'legsolar', toDesc = 'Solar Collector', timer = 60},
		{from = 'legsolar', fromDesc = 'Solar Collector', to = 'legadvsol', toDesc = 'Advanced Solar Collector', timer = 120},
		{
			from = 'legadvsol',
			fromDesc = 'Advanced Solar Collector',
			to = 'corwint2',
			toDesc = 'Advanced Wind Turbine',
			timer = 240
		},
		{from = 'legtide', fromDesc = 'Tidal Generator', to = 'coruwfus', toDesc = 'Naval Fusion Reactor', timer = 300},
		{from = 'legmex', fromDesc = 'Metal Extractor', to = 'legfakemex', toDesc = '-Workaround Fake Mex-', timer = 360},
		{
			from = 'legfakemex',
			fromDesc = '-Workaround Fake Mex-',
			to = 'legmoho',
			toDesc = 'Advanced Metal Extractor',
			timer = 2
		},
		{from = 'legdrag', fromDesc = "Dragon's Teeth", to = 'corfort', toDesc = 'Fortification Wall', timer = 360}
	}
}
UnitDefs['armfakemex'] = table.copy(UnitDefs['armmex'])
UnitDefs['armfakemex'].extractsmetal = 0
UnitDefs['armfakegeo'] = table.copy(UnitDefs['armgeo'])
UnitDefs['armfakegeo'].customparams.geothermal = nil
UnitDefs['corfakemex'] = table.copy(UnitDefs['cormex'])
UnitDefs['corfakemex'].extractsmetal = 0
UnitDefs['corfakegeo'] = table.copy(UnitDefs['corgeo'])
UnitDefs['corfakegeo'].customparams.geothermal = nil
if UnitDefs['legmex'] then
	UnitDefs['legfakemex'] = table.copy(UnitDefs['legmex'])
	UnitDefs['legfakemex'].extractsmetal = 0
end
for b, c in pairs(UnitDefs) do
	faction = string.sub(b, 1, 3)
	for d, e in pairs(a) do
		if faction == d then
			for e, f in ipairs(a[d]) do
				if b == f.from then
					if f.announce == nil then
						f.announce = false
					end
					c.customparams = c.customparams or {}
					c.customparams.evolution_target = f.to
					if f.announce == true then
						c.customparams.evolution_announcement = string.format('%s evolved to %s!', f.fromDesc, f.toDesc)
						c.customparams.evolution_announcement_size = f.anSize or 12.5
					end
					c.customparams.evolution_condition = 'timer'
					c.customparams.evolution_timer = f.timer or 120
					c.customparams.evolution_health_transfer = 'flat'
				end
			end
		end
	end
	if b == 'mission_command_tower' then
		c.weapondefs = c.weapondefs or {}
		c.weapondefs['repulsor'] = {
			avoidfeature = false,
			texture1 = 'Flame',
			craterareaofeffect = 0,
			craterboost = 0,
			cratermult = 0,
			edgeeffectiveness = c.health / 12000 + 0.04,
			name = 'PlasmaRepulsor',
			range = 777,
			soundhitwet = 'sizzle',
			weapontype = 'Shield',
			damage = {default = 420},
			shield = {
				alpha = 0.2,
				armortype = 'shields',
				force = c.health / 4200 + 0.42,
				intercepttype = 128,
				power = c.health * 0.35 + 420,
				powerregen = 117526.5,
				powerregenenergy = 500,
				radius = 777,
				repulser = true,
				smart = true,
				startingpower = c.health * 0.21,
				visible = true,
				visiblerepulse = true,
				badcolor = {[1] = 0.7, [2] = 0.1, [3] = 0.1, [4] = 0.2},
				goodcolor = {[1] = 1.1, [2] = 1.1, [3] = 1.1, [4] = 1}
			}
		}
		c.weapons = c.weapons or {}
		c.weapons[#c.weapons + 1] = {def = 'REPULSOR', onlytargetcategory = 'NOTSUB'}
	end
end
