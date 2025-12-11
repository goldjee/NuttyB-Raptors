-- This code was resurrected from base64, think the original author is `jackie188` on BAR.
-- Before publishing this we need to ask for permission.
--
-- T4 Cold fus
-- Local references for cleaner code
-- 工具函数：合并两个表（table.merge）
local a = UnitDefs or {}
local b = a
local c = table.merge
local d = {
	'arm',
	'cor',
	'leg',
}
local e = {
	arm = 'Armada ',
	cor = 'Cortex ',
	leg = 'Legion ',
}
local f = '_taxed'
local g = 1.2
local h = 1.3
local function i(a, d, e)
	if b[a] and not b[d] then
		b[d] = c(b[a], e)
	end
end
local c = {
	'armack',
	'armaca',
	'armacv',
	'corack',
	'coraca',
	'coracv',
	'legack',
	'legaca',
	'legacv',
}
for c, c in ipairs(d) do
	local d = (c == 'arm')
	local d = (c == 'cor')
	local d = (c == 'leg')
	local j = d and 'legadveconvt3' or c .. 'mmkrt3'
	local k = j .. f
	local l = b[j]
	if l then
		i(j, k, {
			metalcost = math.ceil(l.metalcost * g),
			energycost = math.ceil(l.energycost * g),
			buildtime = math.ceil(l.buildtime * g),
			health = math.ceil(l.health * g * 3),
			customparams = {
				energyconv_capacity = math.ceil(l.customparams.energyconv_capacity * g),
				energyconv_efficiency = 0.021,
				buildinggrounddecaldecayspeed = l.customparams.buildinggrounddecaldecayspeed,
				buildinggrounddecalsizex = l.customparams.buildinggrounddecalsizex,
				buildinggrounddecalsizey = l.customparams.buildinggrounddecalsizey,
				buildinggrounddecaltype = l.customparams.buildinggrounddecaltype,
				model_author = l.customparams.model_author,
				normaltex = l.customparams.normaltex,
				removestop = l.customparams.removestop,
				removewait = l.customparams.removewait,
				subfolder = l.customparams.subfolder,
				techlevel = l.customparams.techlevel,
				unitgroup = l.customparams.unitgroup,
				usebuildinggrounddecal = l.customparams.usebuildinggrounddecal,
				i18n_en_humanname = 'T3 Cold Energy Converter ',
				i18n_en_tooltip = 'Converts 7200 energy into 151 metal per sec. Non-Explosive!',
			},
			name = e[c] .. 'T3 cold Energy Converter',
			buildpic = l.buildpic,
			objectname = l.objectname,
			footprintx = 6,
			footprintz = 6,
			yardmap = l.yardmap,
			script = l.script,
			activatewhenbuilt = l.activatewhenbuilt,
			explodeas = 'largeBuildingexplosiongeneric',
			selfdestructas = 'largeBuildingExplosionGenericSelfd',
			sightdistance = l.sightdistance,
			seismicsignature = l.seismicsignature,
			idleautoheal = l.idleautoheal,
			idletime = l.idletime,
			maxslope = l.maxslope,
			maxwaterdepth = l.maxwaterdepth,
			maxacc = l.maxacc,
			maxdec = l.maxdec,
			corpse = l.corpse,
			canrepeat = l.canrepeat,
		})
	end
	local k = j .. '_200'
	if l then
		local a = 2.0
		i(j, k, {
			metalcost = math.ceil(l.metalcost * a),
			energycost = math.ceil(l.energycost * a),
			buildtime = math.ceil(l.buildtime * a),
			health = math.ceil(l.health * a * 6),
			customparams = {
				energyconv_capacity = math.ceil(l.customparams.energyconv_capacity * 2),
				energyconv_efficiency = 0.022,
				buildinggrounddecaldecayspeed = l.customparams.buildinggrounddecaldecayspeed,
				buildinggrounddecalsizex = l.customparams.buildinggrounddecalsizex,
				buildinggrounddecalsizey = l.customparams.buildinggrounddecalsizey,
				buildinggrounddecaltype = l.customparams.buildinggrounddecaltype,
				model_author = l.customparams.model_author,
				normaltex = l.customparams.normaltex,
				removestop = l.customparams.removestop,
				removewait = l.customparams.removewait,
				subfolder = l.customparams.subfolder,
				techlevel = l.customparams.techlevel,
				unitgroup = l.customparams.unitgroup,
				usebuildinggrounddecal = l.customparams.usebuildinggrounddecal,
				i18n_en_humanname = 'T4 cold Energy Converter',
				i18n_en_tooltip = 'Converts 12000 energy into 264 metal per sec. Non-Explosive!',
			},
			name = e[c] .. 'T4 Cold Energy Converter',
			buildpic = l.buildpic,
			objectname = l.objectname,
			footprintx = 6,
			footprintz = 6,
			yardmap = l.yardmap,
			script = l.script,
			activatewhenbuilt = l.activatewhenbuilt,
			explodeas = 'largeBuildingexplosiongeneric',
			selfdestructas = 'largeBuildingExplosionGenericSelfd',
			sightdistance = l.sightdistance,
			seismicsignature = l.seismicsignature,
			idleautoheal = l.idleautoheal,
			idletime = l.idletime,
			maxslope = l.maxslope,
			maxwaterdepth = l.maxwaterdepth,
			maxacc = l.maxacc,
			maxdec = l.maxdec,
			corpse = l.corpse,
			canrepeat = l.canrepeat,
		})
	end
	local j = c .. 'afust3'
	local k = j .. f
	local l = b[j]
	if l then
		i(j, k, {
			buildtime = math.ceil(l.buildtime * g * 1.8),
			metalcost = 108000,
			energycost = math.ceil(l.energycost * g),
			energymake = math.ceil(l.energymake * h),
			energystorage = math.ceil(l.energystorage * h),
			health = math.ceil(l.health * g * 3),
			buildpic = l.buildpic,
			collisionvolumeoffsets = l.collisionvolumeoffsets,
			collisionvolumescales = l.collisionvolumescales,
			collisionvolumetype = l.collisionvolumetype,
			damagemodifier = 0.95,
			buildangle = l.buildangle,
			objectname = l.objectname,
			footprintx = 12,
			footprintz = 12,
			yardmap = l.yardmap,
			script = l.script,
			activatewhenbuilt = l.activatewhenbuilt,
			explodeas = 'largeBuildingexplosiongeneric',
			selfdestructas = 'largeBuildingExplosionGenericSelfd',
			sightdistance = l.sightdistance,
			seismicsignature = l.seismicsignature,
			idleautoheal = math.ceil(l.idleautoheal * 6),
			idletime = l.idletime,
			maxslope = l.maxslope,
			maxwaterdepth = l.maxwaterdepth,
			maxacc = l.maxacc,
			maxdec = l.maxdec,
			corpse = l.corpse,
			canrepeat = l.canrepeat,
			customparams = {
				buildinggrounddecaldecayspeed = 30,
				buildinggrounddecalsizex = 18,
				buildinggrounddecalsizey = 18,
				buildinggrounddecaltype = l.customparams.buildinggrounddecaltype,
				model_author = l.customparams.model_author,
				normaltex = l.customparams.normaltex,
				subfolder = l.customparams.subfolder,
				removestop = true,
				removewait = true,
				techlevel = 3,
				unitgroup = 'energy',
				usebuildinggrounddecal = true,
				i18n_en_humanname = e[c] .. 'T3 Cold Fusion Reactor',
				i18n_en_tooltip = 'Produce 39000 Energy. Non-Explosive!',
			},
			sfxtypes = {
				pieceexplosiongenerators = {
					[1] = 'deathceg2',
					[2] = 'deathceg3',
					[3] = 'deathceg4',
				},
			},
			sounds = {
				canceldestruct = 'cancel2',
				underattack = 'warning1',
				count = {
					'count6',
					'count5',
					'count4',
					'count3',
					'count2',
					'count1',
				},
				select = {
					'fusion2',
				},
			},
		})
	end
	local g = j .. '_200'
	if l then
		i(j, g, {
			buildtime = math.ceil(l.buildtime * 1.8),
			name = e[c] .. 'T4 cold Fusion Reactor',
			metalcost = math.ceil(l.metalcost * 2.0),
			energycost = math.ceil(l.energycost * 2.0),
			energymake = math.ceil(l.energymake * 2.4),
			energystorage = math.ceil(l.energystorage * 6.0),
			health = math.ceil(l.health * 2.0 * 3),
			buildpic = l.buildpic,
			collisionvolumeoffsets = l.collisionvolumeoffsets,
			collisionvolumescales = l.collisionvolumescales,
			collisionvolumetype = l.collisionvolumetype,
			damagemodifier = 0.95,
			buildangle = l.buildangle,
			objectname = l.objectname,
			footprintx = 12,
			footprintz = 12,
			yardmap = l.yardmap,
			script = l.script,
			activatewhenbuilt = l.activatewhenbuilt,
			explodeas = 'largeBuildingexplosiongeneric',
			selfdestructas = 'largeBuildingExplosionGenericSelfd',
			sightdistance = l.sightdistance,
			seismicsignature = l.seismicsignature,
			idleautoheal = math.ceil(l.idleautoheal * 6),
			idletime = l.idletime,
			maxslope = l.maxslope,
			maxwaterdepth = l.maxwaterdepth,
			maxacc = l.maxacc,
			maxdec = l.maxdec,
			corpse = l.corpse,
			canrepeat = l.canrepeat,
			customparams = {
				buildinggrounddecaldecayspeed = 30,
				buildinggrounddecalsizex = 18,
				buildinggrounddecalsizey = 18,
				buildinggrounddecaltype = l.customparams.buildinggrounddecaltype,
				model_author = l.customparams.model_author,
				normaltex = l.customparams.normaltex,
				subfolder = l.customparams.subfolder,
				removestop = true,
				removewait = true,
				techlevel = 3,
				unitgroup = 'energy',
				usebuildinggrounddecal = true,
				i18n_en_humanname = e[c] .. 'T4 Cold Fusion Reactor',
				i18n_en_tooltip = 'Produce 72000 Energy! For the truly power-hungry. Non-Explosive!',
			},
			sfxtypes = {
				pieceexplosiongenerators = {
					[1] = 'deathceg2',
					[2] = 'deathceg3',
					[3] = 'deathceg4',
				},
			},
			sounds = {
				canceldestruct = 'cancel2',
				underattack = 'warning1',
				count = {
					'count6',
					'count5',
					'count4',
					'count3',
					'count2',
					'count1',
				},
				select = {
					'fusion2',
				},
			},
		})
	end
	local e = c .. 't3aide'
	local g = c .. 't3airaide'
	local e = a[e]
	local a = a[g]
	if e and a then
		local g = {}
		local d = d and 'legadveconvt3' or (c .. 'mmkrt3')
		if b[d .. f] then
			g[#g + 1] = d .. f
		end
		if b[d .. '_200'] then
			g[#g + 1] = d .. '_200'
		end
		local c = c .. 'afust3'
		if b[c .. f] then
			g[#g + 1] = c .. f
		end
		if b[c .. '_200'] then
			g[#g + 1] = c .. '_200'
		end
		for b, b in ipairs(g) do
			e.buildoptions[#e.buildoptions + 1] = b
			a.buildoptions[#a.buildoptions + 1] = b
		end
	end
end
local c = {
	'armack',
	'armaca',
	'armacv',
	'corack',
	'coraca',
	'coracv',
	'legack',
	'legaca',
	'legacv',
}
for c, c in pairs(c) do
	local d = c:sub(1, 3)
	local e = a[c].buildoptions
	if not e then
		e = {}
		a[c].buildoptions = e
	end
	local a = (d == 'leg')
	local a = a and 'legadveconvt3' or (d .. 'mmkrt3')
	local a = {
		a .. f,
		a .. '_200',
		d .. 'afust3' .. f,
		d .. 'afust3_200',
	}
	for a, a in ipairs(a) do
		if b[a] then
			e[#e + 1] = a
		end
	end
end
