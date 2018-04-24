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
local c_morstone = minetest.get_content_id("lottitems:mordor_stone")
local c_red_stone = minetest.get_content_id("lottitems:red_stone")
local c_desertsand = minetest.get_content_id("lottitems:desert_sand")
local c_dessandstone = minetest.get_content_id("lottitems:desert_sandstone")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_stone = minetest.get_content_id("lottitems:stone")
local c_sand = minetest.get_content_id("lottitems:sand")
local c_sandstone = minetest.get_content_id("lottitems:sandstone")
local c_silsand = minetest.get_content_id("lottitems:silver_sand")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_gravel = minetest.get_content_id("lottitems:gravel")
local c_darkgravel = minetest.get_content_id("lottitems:dark_gravel")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_snowblock = minetest.get_content_id("lottitems:snow")
local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
local c_ice = minetest.get_content_id("lottitems:ice")
local c_bluestone = minetest.get_content_id("lottitems:blue_stone")
-------------------
local c_frozenstone = minetest.get_content_id("lottitems:stone")--"lottmapgen:frozen_stone")
-----------
local c_dryshrub = minetest.get_content_id("lottplants:dry_shrub")
local c_mountainshrub = minetest.get_content_id("lottplants:mountain_shrub")
local c_melon = minetest.get_content_id("lottplants:melon_wild")
local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
local c_mallos = minetest.get_content_id("lottplants:mallos")
local c_menelluin = minetest.get_content_id("lottplants:menelluin")
local c_sunflower = minetest.get_content_id("lottplants:sunflower")
local c_bluebell = minetest.get_content_id("lottplants:bluebell")
local c_silsandstone = minetest.get_content_id("lottitems:silver_sandstone")
local c_morwat = minetest.get_content_id("lottmapgen:blacksource")
local c_mountain_grass = minetest.get_content_id("lottplants:mountain_grass")
local c_encyclia = minetest.get_content_id("lottplants:encyclia")
local c_black_tulip = minetest.get_content_id("lottplants:tulip_black")

-- Grasses
local c_base_grass = minetest.get_content_id("lottitems:base_grass")
local c_snowy_grass = minetest.get_content_id("lottitems:snowy_grass")
local c_blue_mountains_grass = minetest.get_content_id("lottitems:blue_mountains_grass")
local c_dunland_grass = minetest.get_content_id("lottitems:dunland_grass")
local c_gondor_grass = minetest.get_content_id("lottitems:gondor_grass")
local c_lorien_grass = minetest.get_content_id("lottitems:lorien_grass")
local c_fangorn_grass = minetest.get_content_id("lottitems:fangorn_grass")
local c_mirkwood_grass = minetest.get_content_id("lottitems:mirkwood_grass")
local c_rohan_grass = minetest.get_content_id("lottitems:rohan_grass")
local c_shire_grass = minetest.get_content_id("lottitems:shire_grass")
local c_iron_hills_grass = minetest.get_content_id("lottitems:iron_hills_grass")
local c_rhun_grass = minetest.get_content_id("lottitems:rhun_grass")
local c_ettenmoors_grass = minetest.get_content_id("lottitems:ettenmoors_grass")
local c_lindon_grass = minetest.get_content_id("lottitems:lindon_grass")
local c_breeland_grass = minetest.get_content_id("lottitems:breeland_grass")
local c_eregion_grass = minetest.get_content_id("lottitems:eregion_grass")
local c_wilderland_grass = minetest.get_content_id("lottitems:wilderland_grass")
local c_minhiriath_grass = minetest.get_content_id("lottitems:minhiriath_grass")
local c_enedwaith_grass = minetest.get_content_id("lottitems:enedwaith_grass")
local c_arthedain_grass = minetest.get_content_id("lottitems:arthedain_grass")
local c_white_mountains_grass = minetest.get_content_id("lottitems:white_mountains_grass")


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
				lottmapgen.frozen_tree(x, y, z, area, data, p2data)
			end
		elseif noise > 0.1 and noise < 0.25 then
			data[vi] = c_snow
			p2data[vi] = math.random(10, 25)
		elseif noise > 0.75 then
			data[vi] = c_snow
			p2data[vi] = math.random(20, 50)
		else
			data[vi] = c_snow
			p2data[vi] = math.random(40, 55)
		end
	end,
	soil = c_snowblock,
	soil_depth = 3,
	stone = c_gravel,
	stone_depth = 16,
	water = c_ice,
	beach = c_gravel,
	clouds = {
		density = 1,
		thickness = 100,
		color = {
			r = 150,
			g = 150,
			b = 150,
			a = 229
		},
		height = 170
	},
})

lottmapgen.register_biome(2, {
	name = "Angmar",
	surface = function(data, vi)
		data[vi] = c_snowy_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 < -0.15 then
			if noise > 0.7 then
				if math.random(TREE7) == 1 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				elseif math.random(TREE4) == 2 then
					lottmapgen.rock(x, y, z, area, data, nil, true)
				elseif math.random(PLANT7) == 3 then
					lottmapgen.pine_grass(data, vi, p2data)
				elseif data[vi] == c_air then
					data[vi] = c_snow
				end
			else
				if math.random(TREE3) == 3 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				elseif math.random(PLANT5) == 4 then
					lottmapgen.pine_grass(data, vi, p2data)
				elseif math.random(TREE8) == 5 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:pine_trunk",
						"lottplants:pine_needles", true)
				elseif math.random(TREE10) == 6 then
					lottmapgen.rock(x, y, z, area, data, nil, true)
				elseif data[vi] == c_air then
					data[vi] = c_snow
				end
			end
		elseif noise2 < 0.5 then
			if math.random(TREE6) == 2 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk",
					"lottplants:pine_needles", true)
			elseif math.random(TREE9) == 3 then
				lottmapgen.pine_tree(x, y, z, area, data, true)
			elseif math.random(PLANT9) == 4 then
				lottmapgen.pine_grass(data, vi, p2data)
			elseif math.random(TREE8) == 5 then
				lottmapgen.rock(x, y, z, area, data, nil, true)
			elseif data[vi] == c_air then
				data[vi] = c_snow
			end
		else
			if math.random(TREE7) == 1 then
				lottmapgen.rock(x, y, z, area, data, nil, true)
			elseif math.random(TREE10) == 2 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk",
					"lottplants:pine_needles", true)
			elseif data[vi] == c_air then
				data[vi] = c_snow
			end
		end
	end,
	water_surface = function(data, p2data, vi, area, x, y, z, noise)
		noise = noise / 2 - 0.1
		local viu = area:index(x, y - 1, z)
		if noise < -0.3 then
			-- Do nothing, water
		elseif noise < -0.2 then
			if math.random(5) == 1 then
				data[viu] = c_ice
			end
		elseif noise < -0.1 then
			if math.random(3) == 1 then
				data[viu] = c_ice
			end
		elseif noise < 0 then
			if math.random(2) == 1 then
				data[viu] = c_ice
			end
		else
			data[viu] = c_ice
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_gravel,
})

lottmapgen.register_biome(3, {
	name = "Ettenmoors",
	surface = function(data, vi)
		data[vi] = c_ettenmoors_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_silsand
		elseif noise > 0.25 or y > 60 then
			data[vi] = c_snow
			if math.random(TREE9) == 4 then
				lottmapgen.rock(x, y, z, area, data, _, true)
			elseif noise > 0.5 then
				if math.random(TREE3) == 3 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				end
			end
		elseif y == 60 then
			if math.random(4) ~= 4 then
				data[vi] = c_snow
			end
		elseif y == 59 then
			if math.random(2) == 2 then
				data[vi] = c_snow
			end
		elseif y == 58 then
			if math.random(4) == 1 then
				data[vi] = c_snow
			end
		else
			if math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 3 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT12) == 1 then
				lottmapgen.farming_plants(data, vi, p2data)
			elseif math.random(PLANT12) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT11) == 4 then
				data[vi] = c_encyclia
			elseif math.random(TREE8) == 8 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(TREE9) == 9 then
				lottmapgen.rock(x, y, z, area, data)
			elseif noise < -0.5 then
				if math.random(TREE3) == 3 then
					lottmapgen.pine_tree(x, y, z, area, data, false)
				elseif math.random(TREE5) == 4 then
					lottmapgen.beech_tree(x, y, z, area, data)
				elseif math.random(PLANT5) == 5 then
					lottmapgen.pine_grass(data, vi, p2data)
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
		data[vi] = c_arthedain_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.35 then
			if noise < -0.7 or noise > 0.7 then
				if math.random(PLANT1) == 1 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT6) == 2 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			else
				if math.random(TREE3) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves",
						math.random(4, 5))
				elseif math.random(TREE5) == 3 then
					lottmapgen.generate_tall_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves")
				elseif math.random(TREE7) == 4 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves",
						math.random(4, 5),
						"lottplants:apple")
				elseif math.random(PLANT4) == 5 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT8) == 6 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		elseif noise2 < -0.6 then
			if math.random(TREE3) == 1 then
				lottmapgen.pine_tree(x, y, z, area, data, false)
			elseif math.random(TREE6) == 2 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk",
					"lottplants:pine_needles")
			elseif math.random(PLANT5) == 5 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT4) == 6 then
				lottmapgen.pine_grass(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE10) == 3 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves")
			end
			if noise > 0.6 then
				if math.random(PLANT9) == 2 then
					--lottmapgen.farming_plants(data, vi, p2data)
				end
			elseif noise < -0.65 then
				if math.random(PLANT5) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
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
		data[vi] = c_breeland_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise_1)
		if noise_1 < -0.15 and noise_1 > -0.3 then
			if math.random(PLANT4) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT1) == 1 then
				lottmapgen.grass(data, vi, p2data)
			end
		else
			if math.random(TREE3) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:birch_trunk",
					"lottplants:birch_leaves",
					math.random(5, 7))
			elseif math.random(TREE5) == 3 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:apple_trunk",
					"lottplants:apple_leaves", 5,
					"lottplants:apple")
			elseif math.random(TREE3) == 5 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves", 4)
			elseif math.random(TREE4) == 6 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:elm_trunk",
					"lottplants:elm_leaves", 9)
			elseif math.random(PLANT6) == 7 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT2) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif noise_1 > 0.5 then
				if math.random(PLANT3) == 2 then
					data[vi] = c_bluebell
				end
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
		data[vi] = c_lindon_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y < 60 then
			if noise2 > -0.45 then
				if noise > 0.6 then
					if math.random(TREE5) == 2 then
						lottmapgen.rowan_tree(x, y, z, area, data)
					elseif math.random(TREE5) == 4 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:birch_trunk",
							"lottplants:birch_leaves",
							math.random(5, 7))
					elseif math.random(TREE8) == 6 then
						lottmapgen.birch_tree(x, y, z, area, data)
					elseif math.random(PLANT3) == 3 then
						lottmapgen.grass(data, vi, p2data)
					elseif math.random(PLANT5) == 2 then
						lottmapgen.lorien_grass(data, vi, p2data)
					elseif math.random(PLANT9) == 1 then
						data[vi] = c_menelluin
						p2data[vi] = 10
					end
				elseif noise < -0.65 then
					if math.random(PLANT4) == 1 then
						lottmapgen.basic_flowers(data, vi, p2data)
					elseif math.random(PLANT1) == 3 then
						lottmapgen.grass(data, vi, p2data)
					elseif math.random(PLANT3) == 2 then
						lottmapgen.lorien_grass(data, vi, p2data)
					elseif math.random(PLANT8) == 1 then
						data[vi] = c_menelluin
						p2data[vi] = 10
					elseif math.random(PLANT7) == 4 then
						lottmapgen.petuniae(data, vi, p2data)
					elseif math.random(PLANT7) == 4 then
						lottmapgen.gerberae(data, vi, p2data)
					elseif math.random(TREE7) == 4 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:birch_trunk",
							"lottplants:birch_leaves",
							math.random(5, 7))
					end
				else
					if math.random(PLANT2) == 3 then
						lottmapgen.grass(data, vi, p2data)
					elseif math.random(PLANT5) == 2 then
						lottmapgen.lorien_grass(data, vi, p2data)
					elseif math.random(PLANT6) == 1 then
						data[vi] = c_menelluin
						p2data[vi] = 10
					elseif math.random(PLANT8) == 4 then
						lottmapgen.petuniae(data, vi, p2data)
					elseif math.random(PLANT9) == 5 then
						lottmapgen.basic_flowers(data, vi, p2data)
					elseif math.random(PLANT9) == 4 then
						lottmapgen.gerberae(data, vi, p2data)
					elseif math.random(TREE10) == 4 then
						lottmapgen.rowan_tree(x, y, z, area, data)
					elseif math.random(TREE10) == 7 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:birch_trunk",
							"lottplants:birch_leaves",
							math.random(5, 7))
					elseif math.random(TREE9) == 4 then
						lottmapgen.generate_bush(x, y, z, area, data,
							"lottplants:rowan_trunk", "lottplants:rowan_leaves")
					elseif math.random(TREE9) == 5 then
						lottmapgen.generate_bush(x, y, z, area, data,
							"lottplants:birch_trunk", "lottplants:birch_leaves")
					end
				end
			else
				if math.random(TREE5) == 4 then
					lottmapgen.rowan_tree(x, y, z, area, data)
				elseif math.random(TREE4) == 7 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:birch_trunk",
						"lottplants:birch_leaves",
						math.random(5, 7))
				elseif math.random(TREE4) == 3 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
				elseif math.random(TREE8) == 4 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:rowan_trunk", "lottplants:rowan_leaves")
				elseif math.random(TREE8) == 5 then
					lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:birch_trunk", "lottplants:birch_leaves")
				elseif math.random(PLANT4) == 3 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT7) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(PLANT11) == 4 then
					lottmapgen.petuniae(data, vi, p2data)
				elseif math.random(PLANT8) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		elseif y > 63 then
			if math.random(TREE9) == 2 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			else
				data[vi] = c_snow
			end
		elseif y == 60 then
			if math.random(TREE9) == 2 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(5) == 1 then
				data[vi] = c_snow
			end
		elseif y == 61 then
			if math.random(PLANT6) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(4) == 1 then
				data[vi] = c_snow
			end
		elseif y == 62 then
			if math.random(PLANT7) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(3) == 1 then
				data[vi] = c_snow
			end
		elseif y == 63 then
			if math.random(PLANT8) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(2) == 1 then
				data[vi] = c_snow
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	beach = c_dirt,
	clouds = {
		density = 0.4,
		thickness = 20,
		color = {
			r = 215,
			g = 255,
			b = 255,
			a = 229
		},
		height = 80
	},
})

lottmapgen.register_biome(8, {
	name = "Shire",
	surface = function(data, vi)
		data[vi] = c_shire_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y < 3 then
			local vil =  area:index(x, y - 1, z)
			data[vil] = c_sand
			if math.random(PLANT5) == 1 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif y == 3 then
			if math.random(4) == 2 then
				local vil =  area:index(x, y - 1, z)
				data[vil] = c_sand
			end
			if math.random(PLANT5) == 1 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif noise2 > 0.5 then -- Forest
			if math.random(TREE5) == 1 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
			elseif math.random(TREE5) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:birch_trunk", "lottplants:birch_leaves", 4)
			elseif math.random(TREE7) == 3 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:elm_trunk", "lottplants:elm_leaves", 8)
			elseif math.random(TREE9) == 4 then
				lottmapgen.generate_tall_tree(x, y, z, area, data,
					"lottplants:poplar_trunk", "lottplants:poplar_leaves")
			elseif math.random(PLANT13) == 5 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:oak_trunk", math.random(2, 4))
			elseif math.random(PLANT13) == 6 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:birch_trunk", 3)
			elseif math.random(PLANT13) == 9 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:elm_trunk", math.random(3, 4))
			elseif math.random(PLANT13) == 10 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:poplar_trunk", math.random(2, 4))
			elseif math.random(PLANT4) == 7 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT10) == 8 then
				lottmapgen.shire_flowers(data, vi, p2data)
			elseif math.random(PLANT8) == 11 then
				lottmapgen.basic_flowers(data, vi, p2data)
			end
		elseif noise2 > -0.15 then -- Sparse trees
			if math.random(TREE9) == 1 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 5)
			elseif math.random(TREE9) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:birch_trunk", "lottplants:birch_leaves", 4)
			elseif math.random(TREE9) == 3 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves")
			elseif math.random(TREE9) == 4 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:birch_trunk", "lottplants:birch_leaves")
			elseif math.random(PLANT4) == 5 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT8) == 3 then
				lottmapgen.shire_flowers(data, vi, p2data)
			end
		elseif noise2 > -0.7 then -- Open
			if math.random(PLANT7) == 1 then
				lottmapgen.shire_flowers(data, vi, p2data)
			elseif math.random(PLANT2) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif noise > 0.6 then -- Clusters of poplars
				if math.random(TREE4) == 3 then
					lottmapgen.generate_tall_tree(x, y, z, area, data,
						"lottplants:poplar_trunk", "lottplants:poplar_leaves")

				end
			elseif noise < -0.75 then -- Small birch wood
				if math.random(TREE5) == 4 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:birch_trunk", "lottplants:birch_leaves", 4)
				elseif math.random(TREE6) == 5 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:birch_trunk", "lottplants:birch_leaves")
				end
			end
		else -- Pine forest
			if math.random(TREE4) == 1 then
				lottmapgen.pine_tree(x, y, z, area, data, false)
			elseif math.random(PLANT3) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.pine_grass(data, vi, p2data)
			elseif math.random(PLANT9) == 4 then
				lottmapgen.shire_flowers(data, vi, p2data)
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
		data[vi] = c_minhiriath_grass
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
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen.farming_plants(data, vi, p2data)
			elseif math.random(PLANT9) == 3 then
				lottmapgen.basic_flowers(data, vi, p2data)
			end
		elseif noise2 < -0.4 then
			if noise > -0.3 then
				if math.random(PLANT5) == 7 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(TREE4) == 6 then
					lottmapgen.default_tree(x, y, z, area, data)
				elseif math.random(TREE5) == 5 then
					lottmapgen.alder_tree(x, y, z, area, data)
				elseif math.random(TREE7) == 4 then
					--lottmapgen.elm_tree(x, y, z, area, data)
				elseif math.random(TREE6) == 3 then
					lottmapgen.short_elm_tree(x, y, z, area, data)
				end
			else
				if math.random(PLANT3) == 1 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT8) == 2 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		elseif noise > 0.45 then
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.tall_grass(x, y, z, area, data)
			end
		elseif noise < -0.6 then
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 3 then
				lottmapgen.farming_plants(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE9) == 3 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(TREE10) == 4 then
				lottmapgen.apple_tree2(x, y, z, area, data)
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
		data[vi] = c_enedwaith_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.25 then
			if math.random(TREE3) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:birch_trunk",
					"lottplants:birch_leaves",
					math.random(5, 7))
			elseif math.random(TREE5) == 3 then
				lottmapgen.birch_tree(x, y, z, area, data)
			elseif math.random(PLANT4) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 4 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(TREE9) == 2 then
				--lottmapgen.elm_tree(x, y, z, area, data)
			end
		elseif noise2 < -0.7 then
			if math.random(PLANT6) == 1 then
				lottmapgen.dry_grass(data, vi, p2data)
			elseif math.random(TREE10) == 2 then
				lottmapgen.default_bush(x, y, z, area, data)
			end
		else
			if math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE10) == 1 then
				lottmapgen.birch_bush(x, y, z, area, data)
			end
			if noise > 0.7 then
				if math.random(PLANT8) == 2 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise < -0.7 then
				if math.random(PLANT9) == 1 then
					lottmapgen.farming_plants(data, vi, p2data)
				elseif math.random(PLANT7) == 2 then
					lottmapgen.tall_grass(x, y, z, area, data)
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
		data[vi] = c_eregion_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_silsand
			if math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif y == 67 then
			if math.random(2) == 1 then
				data[vi] = c_snow
			end
		elseif y > 67 then
			if math.random(PLANT7) == 1 then
				lottmapgen.mountain_flowers(data, vi, p2data)
			elseif math.random(PLANT8) == 2 then
				lottmapgen.grass(data, vi, p2data)
			else
				data[vi] = c_snow
			end
		else
			if noise2 < -0.35 then
				if math.random(TREE2) == 3 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:holly_trunk", "lottplants:holly_leaves")
				elseif math.random(TREE4) == 5 then
					lottmapgen.holly_tree(x, y, z, area, data)
				elseif math.random(PLANT4) == 3 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT6) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise2 > 0.65 then
				if math.random(TREE5) == 1 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:holly_trunk", "air", 4)
				elseif math.random(TREE5) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "air", 5)
				elseif math.random(TREE10) == 3 then
					lottmapgen.holly_tree(x, y, z, area, data)
				elseif math.random(TREE10) == 4 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
				elseif math.random(PLANT7) == 3 then
					lottmapgen.grass(data, vi, p2data)
				end
			else
				if math.random(PLANT3) == 2 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT11) == 1 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(PLANT8) == 5 and y < 48 then
					lottmapgen.basic_flowers(data, vi, p2data)
				elseif math.random(TREE10) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
				elseif math.random(TREE10) == 4 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves")
				elseif math.random(PLANT8) == 5 and y > 20 then
					lottmapgen.mountain_flowers(data, vi, p2data)
				elseif noise > 0.75 and y < 45 then
					if math.random(TREE3) == 1 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
					elseif math.random(TREE2) == 2 then
						lottmapgen.generate_bush(x, y, z, area, data,
							"lottplants:oak_trunk", "lottplants:oak_leaves")
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
		data[vi] = c_dunland_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.3 then
			if math.random(TREE3) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
			elseif math.random(TREE4) == 5 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:rowan_trunk", "lottplants:rowan_leaves", 5)
			elseif math.random(TREE8) == 6 then
				lottmapgen.generate_large_tree(x, y, z, area, data,
					"lottplants:maple_trunk", "lottplants:maple_leaves", 7)
			elseif math.random(PLANT11) == 4 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:oak_trunk", 3)
			elseif math.random(PLANT12) == 5 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:rowan_trunk", 3)
			elseif math.random(PLANT13) == 9 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:maple_trunk", 3)
			elseif math.random(TREE7) == 3 then
				lottmapgen.apple_tree2(x, y, z, area, data)
			elseif math.random (PLANT5) == 4 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif noise2 > -0.3 then
			if math.random(TREE6) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
			elseif math.random(TREE7) == 3 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:rowan_trunk", "lottplants:rowan_leaves", 5)
			elseif math.random(TREE9) == 6 then
				lottmapgen.generate_large_tree(x, y, z, area, data,
					"lottplants:maple_trunk", "lottplants:maple_leaves", 7)
			elseif math.random(TREE9) == 10 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves")
			elseif math.random(TREE9) == 11 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:rowan_trunk", "lottplants:rowan_leaves")
			elseif math.random(PLANT12) == 4 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:oak_trunk", 3)
			elseif math.random(PLANT13) == 5 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:rowan_trunk", 3)
			elseif math.random(PLANT13) == 9 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:maple_trunk", 3)
			elseif math.random(PLANT5) == 7 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT9) == 8 then
				lottmapgen.basic_flowers(data, vi, p2data)
			end
		else
			-- TODO: More farmingish plants.
			if math.random(PLANT3) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT4) == 3 then
				lottmapgen.tall_grass(x, y, z, area, data, p2data)
			elseif math.random(PLANT13) == 4 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 5)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 5,
	beach = c_dirt,
})

lottmapgen.register_biome(14, {
	name = "Mirkwood",
	surface = function(data, vi)
		data[vi] = c_mirkwood_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise > 0.65 then
			if math.random(PLANT2) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT6) == 4 then
				lottmapgen.basic_flowers(data, vi, p2data)
			end
		elseif noise < -0.7 then
			if math.random(TREE2) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data, "lottplants:oak_trunk",
					"lottplants:oak_leaves", math.random(5, 6))
			elseif math.random(PLANT3) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 4 then
				lottmapgen.basic_flowers(data, vi, p2data)
			end
		else
			if math.random(TREE5) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data, "lottplants:oak_trunk",
					"lottplants:oak_leaves", math.random(5, 6))
			elseif math.random(TREE1) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data, "lottplants:dark_oak_trunk",
					"lottplants:dark_oak_leaves", math.random(5, 6))
			elseif math.random(TREE1) == 3 then
				lottmapgen.large_oak_tree(x, y, z, area, data)
			elseif math.random(TREE2) == 4 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:dark_oak_trunk",
					"lottplants:dark_oak_leaves")
			elseif math.random(PLANT5) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT13) == 13 then
				data[vi] = lottmapgen.buildings.enqueue_building("Mirkwood House", {x=x, y=y, z=z})
			end
		end
	end,
	beach = c_sand,
	soil = c_dirt,
	soil_depth = 4,
})

lottmapgen.register_biome(15, {
	name = "Lorien",
	surface = function(data, vi)
		data[vi] = c_lorien_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if y == 1 then
			if math.random(3) == 1 then
				local viu = area:index(x, y - 1, z)
				data[viu] = c_silsand
			end
			if math.random(PLANT4) == 3 then
				lottmapgen.lorien_grass(data, vi, p2data)
			end
		else
			if noise > 0.6 then
				if math.random(TREE5) == 2 then
					lottmapgen.young_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT1) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(TREE10) == 3 then
					lottmapgen.small_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT3) == 7 then
					lottmapgen.lorien_plants(data, vi, p2data)
				elseif math.random(TREE6) == 8 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:mallorn_trunk", "lottplants:mallorn_leaves")
				end
			elseif noise < -0.65 then
				if math.random(TREE4) == 2 then
					lottmapgen.small_mallorn_tree(x, y, z, area, data)
				elseif math.random(TREE6) == 2 then
					lottmapgen.young_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT4) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(TREE2) == 3 then
					lottmapgen.mallorn_tree(x, y, z, area, data)
				end
			else
				if math.random(TREE3) == 2 then
					lottmapgen.small_mallorn_tree(x, y, z, area, data)
				elseif math.random(TREE2) == 2 then
					lottmapgen.young_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT1) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(TREE5) == 3 then
					lottmapgen.mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT5) == 11 then
					lottmapgen.lorien_plants(data, vi, p2data)
				elseif math.random(TREE8) == 8 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:mallorn_trunk", "lottplants:mallorn_leaves")
				elseif math.random(PLANT13) == 13 then
					if math.random(1, 2) == 1 then
						lottmapgen.buildings.enqueue_building("Mallorn House", {x=x, y=y, z=z})
					else
						lottmapgen.buildings.enqueue_building("Lorien House", {x=x, y=y, z=z})
					end
				end
			end
		end
	end,
	beach = c_silsand,
	water_surface = function(data, p2data, vi, area, x, y, z, noise)
		noise = math.abs(noise / 2) - 0.1
		if noise > 0.075 then
			if math.random(PLANT5) == 2 then
				lottmapgen.waterlily(data, vi, p2data, math.random(4))
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	clouds = {
		density = 0.5,
		thickness = 16,
		color = {
			r = 246,
			g = 255,
			b = 196,
			a = 229
		},
		height = 130
	},
})

lottmapgen.register_biome(16, {
	name = "Fangorn",
	surface = function(data, vi)
		data[vi] = c_fangorn_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE8) == 1 then
			lottmapgen.great_oak_tree(x, y, z, area, data)
		elseif math.random(TREE3) == 2 then
			lottmapgen.generate_tree(x, y, z, area, data,
				"lottplants:oak_trunk",
				"lottplants:oak_leaves", 4)
		elseif math.random(TREE3) == 6 then
			lottmapgen.generate_tree(x, y, z, area, data,
				"lottplants:rowan_trunk",
				"lottplants:rowan_leaves", 4)
		elseif math.random(TREE5) == 3 then
			lottmapgen.generate_large_tree(x, y, z, area, data,
				"lottplants:ash_trunk",
				"lottplants:ash_leaves",
				math.random(7, 10))
		elseif math.random(TREE5) == 4 then
			lottmapgen.generate_large_tree(x, y, z, area, data,
				"lottplants:oak_trunk",
				"lottplants:oak_leaves",
				math.random(8, 10))
		elseif math.random(TREE5) == 5 then
			lottmapgen.generate_large_tree(x, y, z, area, data,
				"lottplants:rowan_trunk",
				"lottplants:rowan_leaves",
				math.random(6, 8))
		elseif math.random(TREE6) == 3 then
			lottmapgen.generate_tree(x, y, z, area, data,
				"lottplants:apple_trunk",
				"lottplants:apple_leaves", 5,
				"lottplants:apple")
		elseif math.random(TREE4) == 10 then
			lottmapgen.generate_tall_tree(x, y, z, area, data,
				"lottplants:oak_trunk",
				"lottplants:oak_leaves")
		elseif math.random(TREE4) == 11 then
			lottmapgen.generate_tall_tree(x, y, z, area, data,
				"lottplants:ash_trunk",
				"lottplants:ash_leaves")
		elseif math.random(TREE9) == 5 then
			lottmapgen.generate_log(x, y ,z, area, data, p2data,
				"lottplants:oak_trunk", math.random(2, 4))
		elseif math.random(TREE9) == 6 then
			lottmapgen.generate_log(x, y, z, area, data, p2data,
				"lottplants:ash_trunk", math.random(2, 4))
		elseif math.random(TREE9) == 7 then
			lottmapgen.generate_log(x, y, z, area, data, p2data,
				"lottplants:rowan_trunk", math.random(2, 4))
		elseif math.random(PLANT4) == 3 then
			lottmapgen.grass(data, vi, p2data)
		elseif math.random(PLANT8) == 4 then
			lottmapgen.basic_flowers(data, vi, p2data)
		elseif math.random(PLANT10) == 1 then
			data[vi] = c_black_tulip
		end
	end,
	soil = c_dirt,
	soil_depth = 6,
	beach = c_dirt,
	clouds = {
		density = 0.65,
		thickness = 50,
		color = {
			r = 220,
			g = 210,
			b = 210,
			a = 229
		},
		height = 40
	},
})

lottmapgen.register_biome(17, {
	name = "Rohan",
	surface = function(data, vi)
		data[vi] = c_rohan_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.2 then
			if math.random(PLANT2) == 2 then
				lottmapgen.dry_grass(data, vi, p2data)
			elseif noise > -0.3 then
				if math.random(PLANT2) == 3 then
					lottmapgen.tall_dry_grass(x, y, z, area, data, p2data)
				end
			end
		elseif noise2 > -0.4 then
			if math.random(PLANT4) == 2 then
				lottmapgen.dry_grass(data, vi, p2data)
			elseif math.random(PLANT6) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif noise < -0.3 and noise > -0.4 then
				if math.random(TREE4) == 4 then
					lottmapgen.generate_tall_tree(x, y, z, area, data,
						"lottplants:poplar_trunk", "lottplants:poplar_leaves")
				end
			end
		else
			if math.random(PLANT4) == 4 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT9) == 5 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT7) == 6 then
				lottmapgen.dry_grass(data, vi, p2data)
			elseif noise > 0.55 then
				if math.random(TREE4) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves", math.random(4, 5))
				elseif math.random(TREE9) == 3 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:oak_trunk", math.random(2, 3))
				end
			elseif noise < -0.4 then
				if math.random(TREE3) == 3 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:alder_trunk",
						"lottplants:alder_leaves", math.random(5, 6))
				elseif math.random(TREE5) == 4 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:alder_trunk",
						"lottplants:alder_leaves")
				elseif math.random(TREE7) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves", math.random(4, 5))
				elseif math.random(TREE9) == 5 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:alder_trunk", math.random(2, 4))
				end
			end
		end
		--[[if math.random(TREE7) == 2 then
			lottmapgen.default_tree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen.apple_tree(x, y, z, area, data)
		elseif math.random(TREE8) == 4 then
			lottmapgen.plum_tree(x, y, z, area, data)
		elseif math.random(TREE10) == 9 then
			--lottmapgen.elm_tree(x, y, z, area, data)
		elseif math.random(PLANT2) == 5 then
			lottmapgen.grass(data, vi, p2data)
		elseif math.random(PLANT8) == 6 then
			lottmapgen.farming_plants(data, vi, p2data)
		elseif math.random(PLANT13) == 7 then
			data[vi] = c_melon
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_pilinehtar
			p2data[vi] = 2
		elseif math.random(PLANT13) == 13 then
			lottmapgen.buildings.enqueue_building("Rohan Fort", {x=x, y=y, z=z})
		end]]
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_desertsand,
	stone = c_red_stone,
	stone_depth = 55,
})

lottmapgen.register_biome(18, {
	name = "Gondor",
	surface = function(data, vi)
		data[vi] = c_gondor_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen.default_tree(x, y, z, area, data)
		elseif math.random(TREE8) == 6 then
			lottmapgen.alder_tree(x, y, z, area, data)
		elseif math.random(TREE9) == 3 then
			lottmapgen.apple_tree(x, y, z, area, data)
		elseif math.random(TREE8) == 4 then
			lottmapgen.plum_tree(x, y, z, area, data)
		elseif math.random(TREE10) == 9 then
			--lottmapgen.elm_tree(x, y, z, area, data)
		elseif math.random(PLANT13) == 10 then
			lottmapgen.white_tree(x, y, z, area, data)
		elseif math.random(TREE10) == 12 then
			lottmapgen.lebethron_tree(x, y, z, area, data)
		elseif math.random(PLANT3) == 5 then
			lottmapgen.grass(data, vi, p2data)
		elseif math.random(PLANT8) == 7 then
			lottmapgen.farming_plants(data, vi, p2data)
		elseif math.random(PLANT13) == 8 then
			lottmapgen.farming_plants_rare(data, vi, p2data)
		elseif math.random(PLANT10) == 11 then
			lottmapgen.ithildin_plants(data, vi, p2data)
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_mallos
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.buildings.enqueue_building("Gondor Fort", {x=x, y=y, z=z})
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
	stone = c_sandstone,
	stone_depth = 53,
	clouds = {
		density = 0.55,
		thickness = 34,
		color = {
			r = 255,
			g = 225,
			b = 225,
			a = 229
		},
		height = 100
	},
})

lottmapgen.register_biome(19, {
	name = "Mordor",
	surface = function(data, vi)
		data[vi] = c_morstone
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE10) == 2 then
			lottmapgen.burned_tree(x, y, z, area, data)
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_bomordor
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.buildings.enqueue_building("Orc Fort", {x=x, y=y, z=z})
		end
	end,
	stone = c_morstone,
	stone_depth = 256,
	water = c_morwat,
	clouds = {
		density = 0.85,
		thickness = 50,
		color = {r = 255, g = 129, b = 129, a = 229},
		height = 70,
	},
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
				data[vi] = c_base_grass
			else
				data[vi] = c_gravel
			end
		else
			data[vi] = c_base_grass
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y > 45 then
			if noise > 0.1 then
				data[vi] = c_snow
				p2data[vi] = math.random(20, 35)
			end
		elseif y < 25 then
			if math.random(PLANT4) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE10) == 2  and y < 12 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(TREE10) == 3 then
				lottmapgen.default_bush(x, y, z, area, data)
			end
			if noise < -0.5 then
				if math.random(PLANT4) == 4 then
					lottmapgen.basic_flowers(data, vi, p2data)
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
	clouds = {
		density = 0.75,
		thickness = 90,
		color = {
			r = 190,
			g = 190,
			b = 190,
			a = 229
		},
		height = 80
	},
})

lottmapgen.register_biome(21, {
	name = "Iron Hills",
	surface = function(data, vi)
		data[vi] = c_iron_hills_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if noise > -0.1 then
			if math.random(TREE3) == 3 then
				if y > 55 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				else
					lottmapgen.pine_tree(x, y, z, area, data, false)
				end
			elseif math.random(PLANT5) == 5 and y < 87 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT4) == 6 and y < 82 then
				lottmapgen.grass(data, vi, p2data)
			elseif y == 69 then
				if math.random(3) == 1 then
					data[vi] = c_snow
				end
			elseif y == 70 then
				if math.random(3) ~= 1 then
					data[vi] = c_snow
				end
			elseif y > 70 then
				data[vi] = c_snow
			elseif math.random(TREE7) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(PLANT7) == 7 and y < 47 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT7) == 8 and y < 38 then
				data[vi] = c_encyclia
			elseif math.random(PLANT6) == 9 and y < 26 then
				lottmapgen.petuniae(data, vi, p2data)
			elseif math.random(TREE10) == 2 and y < 35 then
				lottmapgen.beech_tree(x, y, z, area, data)
			end
		elseif noise > -0.5 then
			if math.random(PLANT4) == 5 and y < 87 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT3) == 6 and y < 82 then
				lottmapgen.grass(data, vi, p2data)
			elseif y == 69 then
				if math.random(3) == 1 then
					data[vi] = c_snow
				end
			elseif y > 70 then
				data[vi] = c_snow
			elseif y == 70 then
				if math.random(3) ~= 1 then
					data[vi] = c_snow
				end
			elseif math.random(PLANT6) == 7 and y < 47 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT6) == 8 and y < 38 then
				data[vi] = c_encyclia
			elseif math.random(PLANT5) == 9 and y < 26 then
				lottmapgen.petuniae(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 5 and y < 87 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT3) == 6 and y < 82 then
				lottmapgen.grass(data, vi, p2data)
			elseif y == 69 then
				if math.random(3) == 1 then
					data[vi] = c_snow
				end
			elseif y == 70 then
				if math.random(3) ~= 1 then
					data[vi] = c_snow
				end
			elseif y > 70 then
				data[vi] = c_snow
			elseif math.random(TREE4) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(TREE8) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:beech_trunk", "lottplants:beech_leaves")
			elseif math.random(PLANT7) == 7 and y < 47 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT7) == 8 and y < 38 then
				data[vi] = c_encyclia
			elseif math.random(PLANT6) == 9 and y < 26 then
				lottmapgen.petuniae(data, vi, p2data)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	beach = c_dirt,
	water_surface = function(data, p2data, vi, area, x, y, z, noise)
		noise = math.abs(noise / 2) - 0.1
		if noise > 0.05 then
			if math.random(PLANT5) == 2 then
				lottmapgen.waterlily(data, vi, p2data, math.random(2))
			end
		end
	end,
	clouds = {
		density = 0.55,
		thickness = 50,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 90
	},
})

lottmapgen.register_biome(22, {
	name = "Rhun",
	surface = function(data, vi)
		data[vi] = c_rhun_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 < -0.7 then
			if math.random(TREE3) == 1 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(TREE7) == 1 then
				lottmapgen.apple_tree(x, y, z, area, data)
			elseif math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
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
					lottmapgen.grass(data, vi, p2data)
				end
			elseif noise < 0 then
				if math.random(PLANT1) == 2 then
					lottmapgen.tall_grass(x, y, z, area, data)
				elseif math.random(PLANT1) == 1 then
					lottmapgen.grass(data, vi, p2data)
				end
			else
				if math.random(PLANT3) == 2 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT10) == 3 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 4,
	beach = c_sand,
	stone = c_red_stone,
	stone_depth = 15,
	clouds = {
		density = 0.3,
		thickness = 12,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 140
	},
})

lottmapgen.register_biome(23, {
	name = "Near Harad",
	surface = function(data, vi)
		data[vi] = c_desertsand
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2, schems)
		if noise2 < -0.55 then
			if math.random(TREE8) == 2 then
				table.insert(schems, {"desert_pillar"
					.. math.random(1, 4) .. ".mts",
					{x = x, y = y - 4, z = z}})
			elseif math.random(TREE7) == 5 then
				local stone = "lottitems:desert_sandstone"
				if math.random(2) == 2 then
					stone = "lottitems:red_stone"
				end
				lottmapgen.rock(x, y, z, area, data, stone)
			elseif math.random(PLANT7) == 4 then
				data[vi] = c_dryshrub
			end
		elseif noise2 < -0.3 then
			if math.random(PLANT7) == 3 then
				data[vi] = c_dryshrub
			end
		elseif noise2 < 0.6 then
			if math.random(PLANT6) == 2 then
				data[vi] = c_dryshrub
			elseif math.random(TREE8) == 5 then
				local stone = "lottitems:desert_sandstone"
				if math.random(2) == 2 then
					stone = "lottitems:red_stone"
				end
				lottmapgen.rock(x, y, z, area, data, stone)
			elseif math.random(TREE9) == 2 then
				lottmapgen.cactus(x, y, z, area, data)
			elseif math.random(PLANT11) == 6 then
				lottmapgen.desert_flowers(data, vi, p2data)
			elseif noise > 0.75 then
				if math.random(PLANT8) == 3 then
					lottmapgen.desert_flowers(data, vi, p2data)
				end
			end
		else
			if math.random(PLANT7) == 2 then
				data[vi] = c_dryshrub
			elseif math.random(TREE5) == 2 then
				lottmapgen.cactus(x, y, z, area, data)
			end
		end
	end,
	soil = c_desertsand,
	soil_depth = 3,
	stone = c_dessandstone,
	stone_depth = 83,
	water = c_air,
	beach = c_dessandstone,
	clouds = {
		density = 0.2,
		thickness = 6,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 170
	},
})

lottmapgen.register_biome(25, {
	name = "Wilderland",
	surface = function(data, vi)
		data[vi] = c_wilderland_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise1, noise2)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_sand
			if math.random(PLANT6) == 2 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif y == 3 then
			if math.random(3) == 2 then
				local viu = area:index(x, y - 1, z)
				data[viu] = c_sand
			end
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif noise2 > 0.6 then
			if math.random(PLANT1) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.tall_grass(x, y, z, area, data)
			elseif noise1 < 0.5 then
				if math.random(PLANT9) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise1 > 0.5 then
				if math.random(PLANT5) == 3 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		elseif noise1 < -0.6 then
			if math.random(PLANT3) == 4 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT8) == 2 then
				lottmapgen.farming_plants(data, vi, p2data)
			end
		elseif noise1 > 0.7 then
			if math.random(PLANT3) == 4 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(TREE7) == 3 then
				lottmapgen.default_bush(x, y, z, area, data)
			end
		elseif noise2 < -0.6 then
			if math.random(PLANT5) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE6) == 2 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(TREE5) == 3 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(TREE7) == 4 then
				lottmapgen.alder_tree(x, y, z, area, data)
			elseif math.random(TREE8) == 5 then
				lottmapgen.apple_tree(x, y, z, area, data)
			elseif math.random(TREE7) == 6 then
				lottmapgen.culumalda_tree(x, y, z, area, data)
			end
		else
			if math.random(TREE10) == 6 then
				lottmapgen.default_bush(x, y, z, area, data)
			elseif math.random(15000) == 5 then
				lottmapgen.rowan_bush(x, y, z, area, data)
			elseif math.random(25000) == 4 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(25000) == 3 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(PLANT10) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT3) == 1 then
				lottmapgen.grass(data, vi, p2data)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
})

lottmapgen.register_biome(26, {
	name = "Blue Mountains",
	surface = function(data, vi, y)
		if y < 15 then
			data[vi] = c_blue_mountains_grass
		elseif y == 15 then
			if math.random(5) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		elseif y == 16 then
			if math.random(4) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		elseif y == 17 then
			if math.random(3) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		elseif y == 18 then
			if math.random(2) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		else
			data[vi] = c_bluestone
		end
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
			if math.random(TREE6) == 4 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
			elseif math.random(TREE7) == 3 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(TREE9) == 4 then
				lottmapgen.pine_tree(x, y, z, area, data, false)
			elseif math.random(PLANT8) == 4 then
				lottmapgen.mountain_flowers(data, area:index(x, y, z), p2data)
			elseif math.random(PLANT10) == 9 then
				lottmapgen.petuniae(data, area:index(x, y, z), p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.grass(data, area:index(x, y, z), p2data)
			elseif math.random(PLANT4) == 2 then
				data[vi] = c_mountainshrub
				p2data[vi] = 50
			elseif math.random(PLANT7) == 2 then
				data[vi] = c_mountain_grass
			end
		elseif y > 35 and noise > 0.6 then
			data[viu] = c_darkgravel
			data[vi] = c_darkgravel
			if y > 55 then
				data[area:index(x, y + 1, z)] = c_snow
			end
		elseif y == 54 then
			if math.random(3) == 2 then
				data[vi] = c_snow
			end
		elseif y == 55 then
			if math.random(2) == 1 then
				data[vi] = c_snow
			end
		elseif y > 55 then
			data[vi] = c_snow
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_mountainshrub
			p2data[vi] = 42
		elseif math.random(25000) == 1 then
			lottmapgen.generate_bush(x, y, z, area, data,
				"lottplants:pine_trunk", "lottplants:pine_needles")
		elseif y < 32 then
			if math.random(PLANT9) == 5 then
				lottmapgen.mountain_flowers(data, vi, p2data)
			end
		end
	end,
	stone_depth = 68,
	stone = c_bluestone,
	beach = c_gravel,
	clouds = {
		density = 0.75,
		thickness = 50,
		color = {
			r = 195,
			g = 205,
			b = 226,
			a = 229
		},
		height = 80
	},
})

lottmapgen.register_biome(27, {
	name = "White Mountains",
	surface = function(data, vi, y)
		if y < 30 then
			data[vi] = c_white_mountains_grass
		elseif y == 30 then
			if math.random(5) ~= 2 then
				data[vi] = c_white_mountains_grass
			else
				data[vi] = c_silsandstone
			end
		elseif y == 31 then
			if math.random(4) ~= 2 then
				data[vi] = c_white_mountains_grass
			else
				data[vi] = c_silsandstone
			end
		elseif y == 32 then
			if math.random(3) ~= 2 then
				data[vi] = c_white_mountains_grass
			else
				data[vi] = c_silsandstone
			end
		elseif y == 33 then
			if math.random(2) ~= 2 then
				data[vi] = c_white_mountains_grass
			else
				data[vi] = c_silsandstone
			end
		else
			data[vi] = c_silsandstone
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if y < 30 then
			if math.random(TREE7) == 4 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(TREE9) == 6 then
				lottmapgen.apple_tree(x, y, z, area, data)
			elseif math.random(PLANT3) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT10) == 2 then
				data[vi] = c_mallos
				p2data[vi] = 42
			elseif math.random(PLANT10) == 1 then
				lottmapgen.farming_plants(data, vi, p2data)
			elseif math.random(45000) == 39 then
				lottmapgen.white_bush(x, y, z, area, data)
			end
		elseif y > 99 then
			data[viu] = c_snowblock
		elseif y > 70 and noise > 0.65 then
			data[viu] = c_snowblock
		elseif math.random(TREE9) == 1 then
			lottmapgen.default_bush(x, y, z, area, data)
		elseif y > 40 and noise < -0.55 then
			data[viu] = c_gravel
		elseif math.random(PLANT8) == 2 then
			data[vi] = c_dryshrub
		elseif math.random(45000) == 39 then
			lottmapgen.white_bush(x, y, z, area, data)
		end
	end,
	stone_depth = 45,
	stone = c_silsandstone,
	beach = c_silsand,
	clouds = {
		density = 0.75,
		thickness = 50,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 80
	},
})
