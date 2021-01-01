local c_gondor_grass = minetest.get_content_id("lottitems:gondor_grass")
local c_mallos = minetest.get_content_id("lottplants:mallos")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")
local c_sandstone = minetest.get_content_id("lottitems:sandstone")
local c_sandstone_brick = minetest.get_content_id("lottitems:sandstone_brick")

lottmapgen.register_biome(18, {
	name = "Gondor",
	surface = function(data, vi)
		data[vi] = c_gondor_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise1, noise2)
		if noise2 > 0.4 then
			if noise1 > -0.35 then
				if math.random(TREE3) == 1 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves",
						math.random(4, 5))
				elseif math.random(TREE7) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:apple_trunk",
						"lottplants:apple_leaves",
						math.random(4, 6),
						"lottitems:apple")
				elseif math.random(TREE4) == 3 then
					lottmapgen.alder_tree(x, y, z, area, data)
				elseif math.random(TREE4) == 6 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:elm_trunk",
						"lottplants:elm_leaves",
						math.random(7, 9))
				elseif math.random(640000) == 39 then
					lottmapgen.white_tree(x, y, z, area, data)
				elseif math.random(PLANT4) == 4 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT10) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				elseif math.random(TREE8) == 7 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:oak_trunk",
						math.random(2, 4))
				elseif math.random(TREE9) == 8 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:alder_trunk",
						math.random(3, 4))
				elseif math.random(TREE9) == 9 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:elm_trunk",
						math.random(3, 4))
				elseif math.random(PLANT5) == 9 then
					lottmapgen.leaf_litter(x, y, z, area, data)
				elseif math.random(PLANT6) == 8 then
					lottmapgen.perma_dirt(x, y, z, area, data)
				end
			else
				if math.random(PLANT2) == 1 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT7) == 2 then
					lottmapgen.basic_flowers(data, vi, p2data)
				elseif math.random(TREE10) == 7 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:oak_trunk",
						math.random(2, 4))
				elseif math.random(TREE10) == 8 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:alder_trunk",
						math.random(3, 4))
				elseif math.random(TREE10) == 9 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:elm_trunk",
						math.random(3, 4))
				end
			end
		elseif noise2 < -0 and noise2 > -0.4 then
			if noise1 < 0.6 and noise1 > 0.5 then
				if math.random(TREE4) == 1 then
					lottmapgen.generate_tall_tree(x, y, z, area, data,
						"lottplants:elm_trunk",
						"lottplants:elm_leaves")
				elseif math.random(TREE5) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:elm_trunk",
						"lottplants:elm_leaves",
						math.random(7, 9))
				elseif math.random(PLANT4) == 3 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT7) == 4 then
					lottmapgen.tall_grass(x, y, z, area, data)
				end
			else
				if math.random(TREE6) == 1 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves")
				elseif math.random(PLANT9) == 2 then
					lottmapgen.basic_flowers(data, vi, p2data)
				elseif math.random(PLANT3) == 2 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT5) == 4 then
					lottmapgen.tall_grass(x, y, z, area, data)
				end
			end
		elseif noise2 > -0.6 then
			if math.random(TREE6) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves")
			elseif math.random(PLANT9) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT3) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT5) == 4 then
				lottmapgen.tall_grass(x, y, z, area, data)
			elseif math.random(PLANT11) == 5 then
				data[vi] = c_mallos
			end
		else
			if math.random(PLANT3) == 1 then
				lottmapgen.tall_grass(x, y, z, area, data)
			elseif math.random(PLANT2) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT9) == 3 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT11) == 4 then
				data[vi] = c_mallos
			elseif math.random(TREE10) == 5 then
				lottmapgen.alder_tree(x, y, z, area, data)
			elseif math.random(TREE9) == 4 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:alder_trunk",
					"lottplants:alder_leaves")
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
	stone = c_sandstone,
	dungeon_wall = c_sandstone_brick,
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
