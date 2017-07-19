function lottmapgen.register_biome(id, table)
	lottmapgen_biome[id] = table
end

dofile(minetest.get_modpath("lottmapgen") .. "/biome_table.lua")
dofile(minetest.get_modpath("lottmapgen") .. "/height.lua")

function lottmapgen_biomes(noisy_x, noisy_z)
	local small_x = math.floor(noisy_x / 160)
	local small_z = math.floor(noisy_z / 160)
	small_x = small_x + 200
	small_z = (small_z - 200) * -1
	if biomes[small_z] and biomes[small_z][small_x] then
		return biomes[small_z][small_x]
	else
		return 99
	end
end

function lottmapgen_height(noisy_x, noisy_z)
	local small_x = math.floor(noisy_x / 160)
	local small_z = math.floor(noisy_z / 160)
	local dx = math.abs(small_x - (noisy_x / 160))
	local dz = math.abs(small_z - (noisy_z / 160))
	small_x = small_x + 200
	small_z = (small_z - 200) * -1
	if height[small_z] and height[small_z][small_x] then
		local noise = height[small_z][small_x] * 20
		for nz = -1, 1 do
		for nx = -1, 1 do
			local h = height[small_z + nz][small_x + nx]
			if h and h < height[small_z][small_x] then
				local mult = 20
				if nz == -1 and nx == -1 then
					mult =  math.floor(dx*20 + 1/dz)
				elseif nz == -1 and nx == 0 then
					mult = math.floor(1/dz)
				elseif nz == -1 and nx == 1 then
					mult = math.floor(1/dx + 1/dz)
				elseif nz == 0 and nx == -1 then
					mult = math.floor(dx*20)
				elseif nz == 0 and nx == 1 then
					mult = math.floor(1/dx)
				elseif nz == 1 and nx == -1 then
					mult = math.floor(dx*20 + dz*20)
				elseif nz == 1 and nx == 0 then
					mult = math.floor(dz*20)
				elseif nz == 1 and nx == 1 then
					mult = math.floor(1/dx + dz*20)
				end
				local new_noise = (height[small_z][small_x] - 1) * 20 + mult
				if new_noise < noise then
					noise = new_noise
				end
			end
		end
		end
		return noise
	else
		return 0
	end
end

--Rarity for Trees

local TREE1 = 30
local TREE2 = 50
local TREE3 = 100
local TREE4 = 200
local TREE5 = 300
local TREE6 = 500
local TREE7 = 750
local TREE8 = 1000
local TREE9 = 2000
local TREE10 = 5000

--Rarity for Plants

local PLANT1 = 3
local PLANT2 = 5
local PLANT3 = 10
local PLANT4 = 20
local PLANT5 = 50
local PLANT6 = 100
local PLANT7 = 200
local PLANT8 = 500
local PLANT9 = 750
local PLANT10 = 1000
local PLANT11 = 2000
local PLANT12 = 5000
local PLANT13 = 10000
local PLANT14 = 100000
local PLANT15 = 500000

local c_morstone = minetest.get_content_id("lottmapgen:mordor_stone")
local c_desertsand = minetest.get_content_id("default:desert_sand")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_dirtsnow = minetest.get_content_id("default:dirt_with_snow")
local c_dungrass = minetest.get_content_id("lottmapgen:dunland_grass")
local c_gondorgrass = minetest.get_content_id("lottmapgen:gondor_grass")
local c_loriengrass = minetest.get_content_id("lottmapgen:lorien_grass")
local c_fangorngrass = minetest.get_content_id("lottmapgen:fangorn_grass")
local c_mirkwoodgrass = minetest.get_content_id("lottmapgen:mirkwood_grass")
local c_rohangrass = minetest.get_content_id("lottmapgen:rohan_grass")
local c_shiregrass = minetest.get_content_id("lottmapgen:shire_grass")
local c_junglegrass = minetest.get_content_id("lottmapgen:jungle_grass")
local c_ironhillgrass = minetest.get_content_id("lottmapgen:ironhill_grass")
local c_rhungrass = minetest.get_content_id("lottmapgen:rhun_grass")
local c_ettenmoorgrass = minetest.get_content_id("lottmapgen:ettenmoors_grass")
local c_lindongrass = minetest.get_content_id("lottmapgen:lindon_grass")
local c_breelandgrass = minetest.get_content_id("lottmapgen:breeland_grass")
local c_eregiongrass = minetest.get_content_id("lottmapgen:eregion_grass")
local c_wildergrass = minetest.get_content_id("lottmapgen:wilderland_grass")
local c_minhiriathgrass = minetest.get_content_id("lottmapgen:minhiriath_grass")
local c_cardolangrass = minetest.get_content_id("lottmapgen:cardolan_grass")
local c_enedwaithgrass = minetest.get_content_id("lottmapgen:enedwaith_grass")
local c_arthedaingrass = minetest.get_content_id("lottmapgen:arthedain_grass")
local c_rhudaurgrass = minetest.get_content_id("lottmapgen:rhudaur_grass")
local c_angsnowblock = minetest.get_content_id("lottmapgen:angsnowblock")
local c_snowblock = minetest.get_content_id("default:snowblock")
local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
local c_ice = minetest.get_content_id("default:ice")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_dryshrub = minetest.get_content_id("default:dry_shrub")
local c_melon = minetest.get_content_id("lottplants:melon_wild")
local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
local c_mallos = minetest.get_content_id("lottplants:mallos")
local c_silsandstone = minetest.get_content_id("default:silver_sandstone")

lottmapgen.register_biome(1, {
	name = "Forodwaith",
	surface = function(data, vi)
		if math.random(250) == 2 then
			data[vi] = c_ice
		elseif math.random(25) == 2 then
			data[vi] = c_frozenstone
		else
			data[vi] = c_angsnowblock
		end
	end,
})

lottmapgen.register_biome(2, {
	name = "Angmar",
	surface = function(data, vi)
		data[vi] = c_dirtsnow
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(PLANT3) == 2 then
			data[vi] = c_dryshrub
			p2data[vi] = 42
		elseif math.random(TREE10) == 2 then
			lottmapgen_beechtree(x, y, z, area, data)
		elseif math.random(TREE4) == 3 then
			lottmapgen_pinetree(x, y, z, area, data)
		elseif math.random(TREE3) == 4 then
			lottmapgen_firtree(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(3, {
	name = "Ettenmoors",
	surface = function(data, vi)
		data[vi] = c_ettenmoorgrass
	end,
})

lottmapgen.register_biome(4, {
	name = "Arthedain",
	surface = function(data, vi)
		data[vi] = c_arthedaingrass
	end,
})

lottmapgen.register_biome(5, {
	name = "Rhudaur",
	surface = function(data, vi)
		data[vi] = c_rhudaurgrass
	end,
})

lottmapgen.register_biome(6, {
	name = "Breeland",
	surface = function(data, vi)
		data[vi] = c_breelandgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise_1)
		if noise_1 < -0.15 and noise_1 > -0.3 then
			if math.random(PLANT4) == 2 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(PLANT1) == 1 then
				lottmapgen_grass(data, vi, p2data)
			end
		else
			if math.random(TREE3) == 2 then
				lottmapgen_short_birchtree(x, y, z, area, data)
			elseif math.random(TREE5) == 3 then
				lottmapgen_appletree2(x, y, z, area, data)
			elseif math.random(TREE3) == 5 then
				lottmapgen_defaulttree(x, y, z, area, data)
			elseif math.random(TREE4) == 6 then
				lottmapgen_short_elmtree(x, y, z, area, data)
			elseif math.random(PLANT6) == 7 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(PLANT2) == 1 then
				lottmapgen_grass(data, vi, p2data)
			end
		end
	end,
})

lottmapgen.register_biome(7, {
	name = "Lindon",
	surface = function(data, vi)
		data[vi] = c_lindongrass
	end,
})

lottmapgen.register_biome(8, {
	name = "Shire",
	surface = function(data, vi)
		data[vi] = c_shiregrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random(TREE7) == 4 then
			lottmapgen_plumtree(x, y, z, area, data)
		elseif math.random(TREE7) == 9 then
			lottmapgen_oaktree(x, y, z, area, data)
		elseif math.random(PLANT7) == 7 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT9) == 8 then
			data[vi] = c_melon
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Hobbit Hole", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(9, {
	name = "Minhiriath",
	surface = function(data, vi)
		data[vi] = c_minhiriathgrass
	end,
})

lottmapgen.register_biome(10, {
	name = "Cardolan",
	surface = function(data, vi)
		data[vi] = c_cardolangrass
	end,
})

lottmapgen.register_biome(11, {
	name = "Enedwaith",
	surface = function(data, vi)
		data[vi] = c_enedwaithgrass
	end,
})

lottmapgen.register_biome(12, {
	name = "Eregion",
	surface = function(data, vi)
		data[vi] = c_eregiongrass
	end,
})

lottmapgen.register_biome(13, {
	name = "Dunland",
	surface = function(data, vi)
		data[vi] = c_dungrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE5) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random (PLANT3) == 4 then
			lottmapgen_grass(data, vi, p2data)
		end
	end,
})

lottmapgen.register_biome(14, {
	name = "Mirkwood",
	surface = function(data, vi)
		data[vi] = c_mirkwoodgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE2) == 2 then
			lottmapgen_mirktree(x, y, z, area, data)
		elseif math.random(TREE2) == 3 then
			lottmapgen_mirktree2(x, y, z, area, data)
		elseif math.random(PLANT13) == 13 then
			data[vi] = lottmapgen.enqueue_building("Mirkwood House", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(15, {
	name = "Lorien",
	surface = function(data, vi)
		data[vi] = c_loriengrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE3) == 2 then
			lottmapgen_mallornsmalltree(x, y, z, area, data)
		elseif math.random(TREE2) == 2 then
			lottmapgen_young_mallorn(x, y, z, area, data)
		elseif math.random(PLANT1) == 2 then
			lottmapgen_lorien_grass(data, vi, p2data)
		elseif math.random(TREE5) == 3 then
			lottmapgen_mallorntree(x, y, z, area, data)
		elseif math.random(PLANT4) == 11 then
			lottmapgen_lorienplants(data, vi, p2data)
		elseif math.random(PLANT13) == 13 then
			if math.random(1, 2) == 1 then
				lottmapgen.enqueue_building("Mallorn House", {x=x, y=y, z=z})
			else
				lottmapgen.enqueue_building("Lorien House", {x=x, y=y, z=z})
			end
		end
	end,
})

lottmapgen.register_biome(16, {
	name = "Fangorn",
	surface = function(data, vi)
		data[vi] = c_fangorngrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE3) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE4) == 6 then
			lottmapgen_rowantree(x, y, z, area, data)
		elseif math.random(TREE4) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random(TREE5) == 10 then
			lottmapgen_birchtree(x, y, z, area, data)
		elseif math.random(TREE5) == 4 then
			lottmapgen_plumtree(x, y, z, area, data)
		elseif math.random(TREE7) == 9 then
			lottmapgen_elmtree(x, y, z, area, data)
		elseif math.random(TREE6) == 11 then
			lottmapgen_oaktree(x, y, z, area, data)
		elseif math.random(PLANT4) == 7 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT9) == 8 then
			data[vi] = c_melon
		end
	end,
})

lottmapgen.register_biome(17, {
	name = "Rohan",
	surface = function(data, vi)
		data[vi] = c_rohangrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random(TREE8) == 4 then
			lottmapgen_plumtree(x, y, z, area, data)
		elseif math.random(TREE10) == 9 then
			lottmapgen_elmtree(x, y, z, area, data)
		elseif math.random(PLANT2) == 5 then
			lottmapgen_grass(data, vi, p2data)
		elseif math.random(PLANT8) == 6 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT13) == 7 then
			data[vi] = c_melon
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_pilinehtar
			p2data[vi] = 2
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Rohan Fort", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(18, {
	name = "Gondor",
	surface = function(data, vi)
		data[vi] = c_gondorgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE8) == 6 then
			lottmapgen_aldertree(x, y, z, area, data)
		elseif math.random(TREE9) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random(TREE8) == 4 then
			lottmapgen_plumtree(x, y, z, area, data)
		elseif math.random(TREE10) == 9 then
			lottmapgen_elmtree(x, y, z, area, data)
		elseif math.random(PLANT13) == 10 then
			lottmapgen_whitetree(x, y, z, area, data)
		elseif math.random(PLANT3) == 5 then
			lottmapgen_grass(data, vi, p2data)
		elseif math.random(PLANT8) == 7 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT13) == 8 then
			lottmapgen_farmingrareplants(data, vi, p2data)
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_mallos
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Gondor Fort", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(19, {
	name = "Mordor",
	surface = function(data, vi)
		data[vi] = c_morstone
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE10) == 2 then
			lottmapgen_burnedtree(x, y, z, area, data)
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_bomordor
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Orc Fort", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(20, {
	name = "Misty Mountains",
	surface = function(data, vi)
		data[vi] = c_snowblock
	end,
})

lottmapgen.register_biome(21, {
	name = "Iron Hills",
	surface = function(data, vi)
		data[vi] = c_ironhillgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE10) == 2 then
			lottmapgen_beechtree(x, y, z, area, data)
		elseif math.random(TREE4) == 3 then
			lottmapgen_pinetree(x, y, z, area, data)
		elseif math.random(TREE6) == 4 then
			lottmapgen_firtree(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(22, {
	name = "Rhun",
	surface = function(data, vi)
		data[vi] = c_rhungrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random (PLANT3) == 4 then
			lottmapgen_grass(data, vi, p2data)
		elseif math.random(TREE9) == 1 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE10) == 1 then
			lottmapgen_appletree(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(23, {
	name = "Near Harad",
	surface = function(data, vi)
		data[vi] = c_desertsand
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(PLANT6) == 2 then
			data[vi] = c_dryshrub
		elseif math.random(TREE8) == 2 then
			lottmapgen_cactus(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(24, {
	name = "Far Harad",
	surface = function(data, vi)
		data[vi] = c_junglegrass
	end,
})

lottmapgen.register_biome(25, {
	name = "Wilderland",
	surface = function(data, vi)
		data[vi] = c_wildergrass
	end,
})

lottmapgen.register_biome(26, {
	name = "Blue Mountains",
	surface = function(data, vi)
		data[vi] = c_ice
	end,
})

lottmapgen.register_biome(27, {
	name = "White Mountains",
	surface = function(data, vi)
		data[vi] = c_silsandstone
	end,
})
