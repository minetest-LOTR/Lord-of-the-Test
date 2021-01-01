local c_breeland_grass = minetest.get_content_id("lottitems:breeland_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")
local c_bluebell = minetest.get_content_id("lottplants:bluebell")

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
					"lottitems:apple")
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
			elseif math.random(PLANT5) == 9 then
				lottmapgen.leaf_litter(x, y, z, area, data)
			elseif math.random(PLANT6) == 8 then
				lottmapgen.perma_dirt(x, y, z, area, data)
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
