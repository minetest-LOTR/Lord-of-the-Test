local c_enedwaith_grass = minetest.get_content_id("lottitems:enedwaith_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_silsand = minetest.get_content_id("lottitems:silver_sand")
local c_silsandstone = minetest.get_content_id("lottitems:silver_sandstone")

lottmapgen.register_biome(11, {
	name = "Enedwaith",
	surface = function(data, vi)
		data[vi] = c_enedwaith_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 > 0.25 then
			if math.random(TREE4) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:birch_trunk",
					"lottplants:birch_leaves",
					math.random(5, 7))
			elseif math.random(TREE5) == 3 then
				lottmapgen.generate_tall_tree(x, y, z, area, data,
					"lottplants:birch_trunk",
					"lottplants:birch_leaves")
			elseif math.random(TREE5) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(4, 5))
			elseif math.random(TREE7) == 7 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(PLANT4) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 4 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(TREE9) == 2 then
				lottmapgen.generate_tall_tree(x, y, z, area, data,
					"lottplants:elm_trunk",
					"lottplants:elm_leaves")
			elseif math.random(TREE8) == 5 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:birch_trunk",
					math.random(2, 3))
			elseif math.random(TREE9) == 5 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:oak_trunk",
					math.random(2, 3))
			elseif math.random(TREE10) == 5 then
				lottmapgen.generate_log(x, y, z, area, data, p2data,
					"lottplants:rowan_trunk",
					math.random(2, 3))
			elseif math.random(PLANT5) == 9 then
				lottmapgen.leaf_litter(x, y, z, area, data)
			elseif math.random(PLANT6) == 8 then
				lottmapgen.perma_dirt(x, y, z, area, data)
			end
		elseif noise2 < -0.7 then
			if math.random(PLANT6) == 1 then
				lottmapgen.dry_grass(data, vi, p2data)
			elseif math.random(TREE10) == 2 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:birch_trunk",
					"lottplants:birch_leaves")
			end
		else
			if math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE10) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:birch_trunk",
					"lottplants:birch_leaves")
			end
			if noise > 0.7 then
				if math.random(PLANT8) == 2 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise < -0.7 then
				if math.random(PLANT9) == 1 then
					--lottmapgen.farming_plants(data, vi, p2data)
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
