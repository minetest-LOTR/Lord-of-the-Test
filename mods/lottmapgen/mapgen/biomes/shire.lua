local c_shire_grass = minetest.get_content_id("lottitems:shire_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")

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
				lottmapgen.poplar_tree(x, y, z, area, data)
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
			elseif math.random(PLANT7) == 9 then
				lottmapgen.leaf_litter(x, y, z, area, data)
			elseif math.random(PLANT8) == 8 then
				lottmapgen.perma_dirt(x, y, z, area, data)
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
					lottmapgen.poplar_tree(x, y, z, area, data)
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
