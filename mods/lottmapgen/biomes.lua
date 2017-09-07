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

local c_air = minetest.get_content_id("air")
local c_morstone = minetest.get_content_id("lottmapgen:mordor_stone")
local c_desertsand = minetest.get_content_id("default:desert_sand")
local c_dessandstone = minetest.get_content_id("default:desert_sandstone")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_stone = minetest.get_content_id("default:stone")
local c_sand = minetest.get_content_id("default:sand")
local c_sandstone = minetest.get_content_id("default:sandstone")
local c_silsand = minetest.get_content_id("default:silver_sand")
local c_dirt = minetest.get_content_id("default:dirt")
local c_gravel = minetest.get_content_id("default:gravel")
local c_darkgravel = minetest.get_content_id("default:dark_gravel")
local c_dirtsnow = minetest.get_content_id("default:dirt_with_snow")
local c_dirtgrass = minetest.get_content_id("default:dirt_with_grass")
local c_bluegrass = minetest.get_content_id("lottmapgen:blue_mountains_grass")
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
local c_whitegrass = minetest.get_content_id("lottmapgen:white_mountains_grass")
local c_angsnowblock = minetest.get_content_id("lottmapgen:angsnowblock")
local c_snow = minetest.get_content_id("default:snow")
local c_snowblock = minetest.get_content_id("default:snowblock")
local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
local c_ice = minetest.get_content_id("default:ice")
local c_bluestone = minetest.get_content_id("default:blue_stone")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_dryshrub = minetest.get_content_id("default:dry_shrub")
local c_mountainshrub = minetest.get_content_id("lottplants:mountain_shrub")
local c_melon = minetest.get_content_id("lottplants:melon_wild")
local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
local c_mallos = minetest.get_content_id("lottplants:mallos")
local c_menelluin = minetest.get_content_id("lottplants:menelluin")
local c_sunflower = minetest.get_content_id("lottplants:sunflower")
local c_silsandstone = minetest.get_content_id("default:silver_sandstone")
local c_morwat = minetest.get_content_id("lottmapgen:blacksource")

lottmapgen.register_biome(1, {
	name = "Forodwaith",
	surface = function(data, vi)
		if math.random(250) == 2 then
			data[vi] = c_ice
		elseif math.random(25) == 2 then
			data[vi] = c_frozenstone
		else
			data[vi] = c_snowblock
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, _, noise)
		if math.random(PLANT11) == 1 then
			data[vi] = c_dryshrub
		elseif math.random(TREE5) == 3 then
			 if noise < -0.85 then
				lottmapgen_frozentree(x, y, z, area, data, p2data)
			end
		elseif noise > 0.1 and noise < 0.25 then
			data[vi] = c_snow
			p2data[vi] = math.random(150, 185)
		elseif noise > 0.75 then
			data[vi] = c_snow
			p2data[vi] = math.random(50, 225)
		else
			data[vi] = c_snow
			p2data[vi] = math.random(150, 165)
		end
	end,
	soil = c_snowblock,
	soil_depth = 3,
	stone = c_gravel,
	stone_depth = 16,
	water = c_ice,
	beach = c_gravel,
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
	soil = c_dirt,
	soil_depth = 2,
	beach = c_gravel,
})

lottmapgen.register_biome(3, {
	name = "Ettenmoors",
	surface = function(data, vi)
		data[vi] = c_ettenmoorgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_silsand
		elseif noise > 0.25 then
			data[vi] = c_snow
			if noise > 0.9 then
				if math.random(TREE3) == 3 then
					lottmapgen_pinetree(x, y, z, area, data, true)
				end
			end
		else
			if math.random(PLANT5) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT12) == 1 then
				lottmapgen_farmingplants(data, vi, p2data)
			elseif math.random(PLANT12) == 2 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif noise < -0.9 then
				if math.random(TREE3) == 3 then
					lottmapgen_pinetree(x, y, z, area, data, false)
				elseif math.random(TREE5) == 4 then
					lottmapgen_beechtree(x, y, z, area, data)
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 3,
	beach = c_silsand,
})

lottmapgen.register_biome(4, {
	name = "Arthedain",
	surface = function(data, vi)
		data[vi] = c_arthedaingrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.35 then
			if noise < -0.7 or noise > 0.7 then
				if math.random(PLANT1) == 1 then
					lottmapgen_grass(data, vi, p2data)
				elseif math.random(PLANT6) == 2 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			else
				if math.random(TREE3) == 2 then
					lottmapgen_defaulttree(x, y, z, area, data)
				elseif math.random(TREE5) == 3 then
					lottmapgen_oaktree(x, y, z, area, data)
				elseif math.random(TREE7) == 4 then
					lottmapgen_appletree(x, y, z, area, data)
				elseif math.random(PLANT4) == 5 then
					lottmapgen_grass(data, vi, p2data)
				elseif math.random(PLANT8) == 6 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			end
		elseif noise2 < -0.4 then
			if math.random(TREE4) == 1 then
				lottmapgen_pinetree(x, y, z, area, data, false)
			elseif math.random(TREE6) == 2 then
				lottmapgen_pinebush(x, y, z, area, data)
			elseif math.random(PLANT5) == 5 then
				lottmapgen_grass(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(TREE10) == 3 then
				lottmapgen_defaultbush(x, y, z, area, data)
			end
			if noise > 0.6 then
				if math.random(PLANT9) == 2 then
					lottmapgen_farmingplants(data, vi, p2data)
				end
			elseif noise < -0.65 then
				if math.random(PLANT5) == 5 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			end
		end
	end,
	beach = c_sand,
	soil = c_dirt,
	soil_depth = 2,
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
	soil = c_dirt,
	soil_depth = 3,
	beach = c_sand,
})

lottmapgen.register_biome(7, {
	name = "Lindon",
	surface = function(data, vi)
		data[vi] = c_lindongrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if noise > 0.6 then
			if math.random(TREE5) == 2 then
				lottmapgen_rowantree(x, y, z, area, data)
			elseif math.random(TREE5) == 4 then
				lottmapgen_short_birchtree(x, y, z, area, data)
			elseif math.random(TREE8) == 6 then
				lottmapgen_birchtree(x, y, z, area, data)
			elseif math.random(PLANT3) == 3 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT5) == 2 then
				lottmapgen_lorien_grass(data, vi, p2data)
			elseif math.random(PLANT9) == 1 then
				data[vi] = c_menelluin
				p2data[vi] = 10
			end
		elseif noise < -0.8 then
			if math.random(PLANT4) == 1 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(PLANT1) == 3 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT3) == 2 then
				lottmapgen_lorien_grass(data, vi, p2data)
			elseif math.random(PLANT8) == 1 then
				data[vi] = c_menelluin
				p2data[vi] = 10
			end
		else
			if math.random(PLANT2) == 3 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT4) == 2 then
				lottmapgen_lorien_grass(data, vi, p2data)
			elseif math.random(PLANT6) == 1 then
				data[vi] = c_menelluin
				p2data[vi] = 10
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	beach = c_dirt,
})

lottmapgen.register_biome(8, {
	name = "Shire",
	surface = function(data, vi)
		data[vi] = c_shiregrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if y < 3 then
			local vil =  area:index(x, y - 1, z)
			data[vil] = c_sand
		elseif y == 3 then
			if math.random(4) == 2 then
				local vil =  area:index(x, y - 1, z)
				data[vil] = c_sand
			end
		else
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
		end
	end,
	soil = c_dirt,
	soil_depth = 4,
	beach = c_sand,
})

lottmapgen.register_biome(9, {
	name = "Minhiriath",
	surface = function(data, vi)
		data[vi] = c_minhiriathgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y == 1 then
			local vil = area:index(x, y - 1, z)
			data[vil] = c_sand
			if math.random(PLANT5) == 2 then
				data[vi] = c_dryshrub
			end
		elseif y == 2 then
			if math.random(3) == 2 then
				local vil = area:index(x, y - 1, z)
				data[vil] = c_sand
				if math.random(PLANT5) == 2 then
					data[vi] = c_dryshrub
				end
			end
		elseif noise2 > 0.7 then
			if math.random(PLANT1) == 1 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen_farmingplants(data, vi, p2data)
			elseif math.random(PLANT9) == 3 then
				lottmapgen_default_flowers(data, vi, p2data)
			end
		elseif noise2 < -0.4 then
			if noise > -0.3 then
				if math.random(PLANT5) == 7 then
					lottmapgen_grass(data, vi, p2data)
				elseif math.random(TREE4) == 6 then
					lottmapgen_defaulttree(x, y, z, area, data)
				elseif math.random(TREE5) == 5 then
					lottmapgen_aldertree(x, y, z, area, data)
				elseif math.random(TREE7) == 4 then
					lottmapgen_elmtree(x, y, z, area, data)
				elseif math.random(TREE6) == 3 then
					lottmapgen_short_elmtree(x, y, z, area, data)
				end
			else
				if math.random(PLANT3) == 1 then
					lottmapgen_grass(data, vi, p2data)
				elseif math.random(PLANT8) == 2 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			end
		elseif noise > 0.45 then
			if math.random(PLANT4) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen_tall_grass(x, y, z, area, data)
			end
		elseif noise < -0.6 then
			if math.random(PLANT4) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT7) == 3 then
				lottmapgen_farmingplants(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(TREE9) == 3 then
				lottmapgen_defaulttree(x, y, z, area, data)
			elseif math.random(TREE10) == 4 then
				lottmapgen_appletree2(x, y, z, area, data)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	stone = c_sandstone,
	stone_depth = 20,
	beach = c_sand,
})

lottmapgen.register_biome(11, {
	name = "Enedwaith",
	surface = function(data, vi)
		data[vi] = c_enedwaithgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.25 then
			if math.random(TREE3) == 2 then
				lottmapgen_short_birchtree(x, y, z, area, data)
			elseif math.random(TREE5) == 3 then
				lottmapgen_birchtree(x, y, z, area, data)
			elseif math.random(PLANT4) == 1 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT7) == 4 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(TREE9) == 2 then
				lottmapgen_elmtree(x, y, z, area, data)
			end
		elseif noise2 < -0.7 then
			if math.random(PLANT6) == 1 then
				lottmapgen_dry_grass(data, vi, p2data)
			elseif math.random(TREE10) == 2 then
				lottmapgen_defaultbush(x, y, z, area, data)
			end
		else
			if math.random(PLANT5) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(TREE10) == 1 then
				lottmapgen_birchbush(x, y, z, area, data)
			end
			if noise > 0.7 then
				if math.random(PLANT8) == 2 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			elseif noise < -0.7 then
				if math.random(PLANT9) == 1 then
					lottmapgen_farmingplants(data, vi, p2data)
				elseif math.random(PLANT7) == 2 then
					lottmapgen_tall_grass(x, y, z, area, data)
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_silsand,
	stone = c_silsandstone,
	stone_depth = 12,
})

lottmapgen.register_biome(12, {
	name = "Eregion",
	surface = function(data, vi)
		data[vi] = c_eregiongrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_silsand
			if math.random(PLANT5) == 2 then
				lottmapgen_grass(data, vi, p2data)
			end
		else
			if noise2 < -0.35 then
				if math.random(TREE2) == 3 then
					lottmapgen_hollybush(x, y, z, area, data)
				elseif math.random(TREE4) == 5 then
					lottmapgen_hollytree(x, y, z, area, data)
				elseif math.random(PLANT4) == 3 then
					lottmapgen_grass(data, vi, p2data)
				end
			elseif noise2 > 0.6 then
				if math.random(TREE3) == 1 then
					lottmapgen_deadtree(x, y, z, area, data)
				end
			else
				if math.random(PLANT3) == 2 then
					lottmapgen_grass(data, vi, p2data)
				elseif math.random(PLANT11) == 1 then
					lottmapgen_lorien_grass(data, vi, p2data)
				elseif math.random(TREE10) == 2 then
					lottmapgen_deadtree(x, y, z, area, data)
				elseif math.random(TREE10) == 4 then
					lottmapgen_defaultbush(x, y, z, area, data)
				elseif noise > 0.75 then
					if math.random(TREE3) == 1 then
						lottmapgen_defaulttree(x, y, z, area, data)
					elseif math.random(TREE2) == 2 then
						lottmapgen_defaultbush(x, y, z, area, data)
					end
				elseif noise < -0.7 then
					if math.random(PLANT11) == 7 then
						data[vi] = c_menelluin
					elseif math.random(PLANT8) == 8 then
						lottmapgen_default_flowers(data, vi, p2data)
					end
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_silsand,
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
	soil = c_dirt,
	soil_depth = 5,
	beach = c_dirt,
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
	beach = c_sand,
	soil = c_dirt,
	soil_depth = 4,
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
	beach = c_silsand,
	soil = c_dirt,
	soil_depth = 2,
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
	soil = c_dirt,
	soil_depth = 6,
	beach = c_dirt,
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
	soil = c_dirt,
	soil_depth = 1
	beach = c_desertsand,
	stone = c_desertstone,
	stone_depth = 55,
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
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
	stone = c_sandstone,
	stone_depth = 53,
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
	stone = c_morstone,
	stone_depth = 256,
	water = c_morwat,
})

lottmapgen.register_biome(20, {
	name = "Misty Mountains",
	surface = function(data, vi, y)
		if y > 45 then
			data[vi] = c_snowblock
		elseif y == 45 then
			if math.random(2) == 1 then
				data[vi] = c_snowblock
			else
				data[vi] = c_gravel
			end
		elseif y > 25 then
			data[vi] = c_gravel
		elseif y == 25 then
			if math.random(2) == 1 then
				data[vi] = c_dirtgrass
			else
				data[vi] = c_gravel
			end
		else
			data[vi] = c_dirtgrass
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y > 45 then
			if noise > 0.1 then
				data[vi] = c_snow
				p2data[vi] = math.random(100, 120)
			end
		elseif y < 25 then
			if math.random(PLANT4) == 1 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(TREE10) == 2  and y < 12 then
				lottmapgen_defaulttree(x, y, z, area, data)
			elseif math.random(TREE10) == 3 then
				lottmapgen_defaultbush(x, y, z, area, data)
			end
			if noise < -0.5 then
				if math.random(PLANT4) == 4 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			end
		end
	end,
	soilf = function(data, vi, y)
		if y > 49 then
			data[vi] = c_snowblock
		elseif y > 20 then
			data[vi] = c_gravel
		else
			data[vi] = c_dirt
		end
	end,
	soil_depth = 4,
	stone = c_frozenstone,
	stone_depth = 0,
	beach = c_darkgravel,
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
	soil = c_dirt,
	soil_depth = 2,
	beach = c_dirt,
})

lottmapgen.register_biome(22, {
	name = "Rhun",
	surface = function(data, vi)
		data[vi] = c_rhungrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 < -0.7 then
			if math.random(TREE3) == 1 then
				lottmapgen_defaulttree(x, y, z, area, data)
			elseif math.random(TREE7) == 1 then
				lottmapgen_appletree(x, y, z, area, data)
			elseif math.random(PLANT5) == 2 then
				lottmapgen_grass(data, vi, p2data)
			end
		else
			if noise > 0.7 then
				if math.random(PLANT4) == 3 then
					data[vi] = c_sunflower
					if math.random(2) == 1 then
						p2data[vi] = 0
					else
						p2data[vi] = 2
					end
				elseif math.random(PLANT1) == 1 then
					lottmapgen_grass(data, vi, p2data)
				end
			elseif noise < 0 then
				if math.random(PLANT1) == 2 then
					lottmapgen_tall_grass(x, y, z, area, data)
				elseif math.random(PLANT1) == 1 then
					lottmapgen_grass(data, vi, p2data)
				end
			else
				if math.random(PLANT3) == 2 then
					lottmapgen_grass(data, vi, p2data)
				elseif math.random(PLANT10) == 3 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 4,
	beach = c_sand,
	stone = c_desertstone,
	stone_depth = 15,
})

lottmapgen.register_biome(23, {
	name = "Near Harad",
	surface = function(data, vi)
		data[vi] = c_desertsand
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2, vm)
		if noise2 < -0.8 then
			if math.random(TREE9) == 2 then
				lottmapgen_place_mts(x, y - 3, z, area, data, p2data,
					lottmapgen_schematics["desert_pillar" .. math.random(4)])
			end
		elseif noise2 < 0.8 then
			if math.random(PLANT8) == 2 then
				data[vi] = c_dryshrub
			elseif math.random(TREE10) == 2 then
				lottmapgen_cactus(x, y, z, area, data)
			end
		else
			if math.random(PLANT8) == 2 then
				data[vi] = c_dryshrub
			elseif math.random(TREE2) == 2 then
				lottmapgen_cactus(x, y, z, area, data)
			end
		end
	end,
	soil = c_desertsand,
	soil_depth = 3,
	stone = c_dessandstone,
	stone_depth = 83,
	water = c_air,
	beach = c_dessandstone,
})

lottmapgen.register_biome(25, {
	name = "Wilderland",
	surface = function(data, vi)
		data[vi] = c_wildergrass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise1, noise2)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_sand
			if math.random(PLANT6) == 2 then
				lottmapgen_grass(data, vi, p2data)
			end
		elseif y == 3 then
			if math.random(3) == 2 then
				local viu = area:index(x, y - 1, z)
				data[viu] = c_sand
			end
			if math.random(PLANT4) == 2 then
				lottmapgen_grass(data, vi, p2data)
			end
		elseif noise2 > 0.6 then
			if math.random(PLANT1) == 2 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen_tall_grass(x, y, z, area, data)
			elseif noise1 < 0.5 then
				if math.random(PLANT9) == 5 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			elseif noise1 > 0.5 then
				if math.random(PLANT5) == 3 then
					lottmapgen_default_flowers(data, vi, p2data)
				end
			end
		elseif noise1 < -0.6 then
			if math.random(PLANT3) == 4 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT8) == 2 then
				lottmapgen_farmingplants(data, vi, p2data)
			end
		elseif noise1 > 0.7 then
			if math.random(PLANT3) == 4 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(TREE7) == 3 then
				lottmapgen_defaultbush(x, y, z, area, data)
			end
		elseif noise2 < -0.6 then
			if math.random(PLANT5) == 1 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(TREE6) == 2 then
				lottmapgen_defaulttree(x, y, z, area, data)
			elseif math.random(TREE5) == 3 then
				lottmapgen_rowantree(x, y, z, area, data)
			elseif math.random(TREE7) == 4 then
				lottmapgen_aldertree(x, y, z, area, data)
			elseif math.random(TREE8) == 5 then
				lottmapgen_appletree(x, y, z, area, data)
			elseif math.random(TREE7) == 6 then
				lottmapgen_culumaldatree(x, y, z, area, data)
			end
		else
			if math.random(TREE10) == 6 then
				lottmapgen_defaultbush(x, y, z, area, data)
			elseif math.random(15000) == 5 then
				lottmapgen_rowanbush(x, y, z, area, data)
			elseif math.random(25000) == 4 then
				lottmapgen_rowantree(x, y, z, area, data)
			elseif math.random(25000) == 3 then
				lottmapgen_defaulttree(x, y, z, area, data)
			elseif math.random(PLANT10) == 2 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(PLANT3) == 1 then
				lottmapgen_grass(data, vi, p2data)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
})

lottmapgen.register_biome(26, {
	name = "Blue Mountains",
	surface = function(data, vi)
		data[vi] = c_bluestone
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		local viu = area:index(x, y - 1, z)
		if y > 85 and noise > -0.2 then
			data[viu] = c_ice
			local rand = math.random(40)
			if rand == 1 then
				data[vi] = c_gravel
			elseif rand < 4 then
				data[vi] = c_bluestone
			elseif rand < 7 then
				data[vi] = c_ice
			else
				data[vi] = c_snowblock
			end
		elseif y < 15 then
			data[viu] = c_dirt
			data[vi] = c_bluegrass
			if math.random(TREE6) == 4 then
				lottmapgen_defaulttree(x, y + 1, z, area, data)
			elseif math.random(TREE7) == 3 then
				lottmapgen_pinebush(x, y, z, area, data)
			elseif math.random(TREE9) == 4 then
				lottmapgen_pinetree(x, y + 1, z, area, data, false)
			elseif math.random(PLANT4) == 2 then
				local via = area:index(x, y + 1, z)
				data[via] = c_mountainshrub
				p2data[via] = 50
			end
		elseif y == 15 then
			if math.random(5) ~= 2 then
				data[viu] = c_dirt
				data[vi] = c_bluegrass
			else
				data[vi] = c_bluestone
			end
		elseif y == 16 then
			if math.random(4) ~= 2 then
				data[viu] = c_dirt
				data[vi] = c_bluegrass
			else
				data[vi] = c_bluestone
			end
		elseif y == 17 then
			if math.random(3) ~= 2 then
				data[viu] = c_dirt
				data[vi] = c_bluegrass
			else
				data[vi] = c_bluestone
			end
		elseif y == 18 then
			if math.random(2) ~= 2 then
				data[viu] = c_dirt
				data[vi] = c_bluegrass
			else
				data[vi] = c_bluestone
			end
		elseif y > 35 and noise > 0.6 then
			data[viu] = c_darkgravel
			data[vi] = c_darkgravel
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_mountainshrub
			p2data[vi] = 42
		elseif math.random(25000) == 1 then
			lottmapgen_pinebush(x, y, z, area, data)
		end
	end,
	stone_depth = 68,
	stone = c_bluestone,
	beach = c_gravel,
})

lottmapgen.register_biome(27, {
	name = "White Mountains",
	surface = function(data, vi)
		data[vi] = c_silsandstone
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		local viu = area:index(x, y - 1, z)
		if y < 30 then
			data[viu] = c_whitegrass
			if math.random(TREE7) == 4 then
				lottmapgen_defaulttree(x, y + 1, z, area, data)
			elseif math.random(TREE9) == 6 then
				lottmapgen_appletree(x, y, z, area, data)
			elseif math.random(PLANT3) == 3 then
				lottmapgen_grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen_default_flowers(data, vi, p2data)
			elseif math.random(PLANT10) == 2 then
				data[vi] = c_mallos
				p2data[vi] = 42
			elseif math.random(PLANT10) == 1 then
				lottmapgen_farmingplants(data, vi, p2data)
			elseif math.random(45000) == 39 then
				lottmapgen_whitebush(x, y, z, area, data)
			end
		elseif y == 30 then
			if math.random(5) ~= 2 then
				data[viu] = c_whitegrass
			else
				data[viu] = c_silsandstone
			end
		elseif y == 31 then
			if math.random(4) ~= 2 then
				data[viu] = c_whitegrass
			else
				data[viu] = c_silsandstone
			end
		elseif y == 32 then
			if math.random(3) ~= 2 then
				data[viu] = c_whitegrass
			else
				data[viu] = c_silsandstone
			end
		elseif y == 33 then
			if math.random(2) ~= 2 then
				data[viu] = c_whitegrass
			else
				data[viu] = c_silsandstone
			end
		elseif y > 99 then
			data[viu] = c_snowblock
		elseif y > 70 and noise > 0.65 then
			data[viu] = c_snowblock
		elseif math.random(TREE9) == 1 then
			lottmapgen_defaultbush(x, y, z, area, data)
		elseif y > 40 and noise < -0.55 then
			data[viu] = c_gravel
		elseif math.random(PLANT8) == 2 then
			data[vi] = c_dryshrub
		elseif math.random(45000) == 39 then
			lottmapgen_whitebush(x, y, z, area, data)
		end
	end,
	stone_depth = 45,
	stone = c_silsandstone,
	beach = c_silsand,
})
