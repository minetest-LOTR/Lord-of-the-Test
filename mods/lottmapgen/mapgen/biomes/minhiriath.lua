local c_minhiriath_grass = minetest.get_content_id("lottitems:minhiriath_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")
local c_dryshrub = minetest.get_content_id("lottplants:dry_shrub")
local c_sandstone = minetest.get_content_id("lottitems:sandstone")

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
				--lottmapgen.farming_plants(data, vi, p2data)
			elseif math.random(PLANT6) == 3 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(TREE6) == 3 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:elm_trunk",
					"lottplants:elm_leaves",
					math.random(7, 9))
			end
		elseif noise2 < -0.4 then
			if noise > -0.3 then
				if math.random(PLANT5) == 7 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(TREE4) == 6 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk",
						"lottplants:oak_leaves",
						math.random(4, 6))
				elseif math.random(TREE5) == 5 then
					lottmapgen.alder_tree(x, y, z, area, data)
				elseif math.random(TREE7) == 4 then
					lottmapgen.generate_tall_tree(x, y, z, area, data,
						"lottplants:elm_trunk",
						"lottplants:elm_leaves")
				elseif math.random(TREE6) == 3 then
					lottmapgen.short_elm_tree(x, y, z, area, data)
				elseif math.random(TREE8) == 8 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:oak_trunk",
						math.random(2, 3))
				elseif math.random(TREE9) == 9 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:alder_trunk",
						math.random(2, 3))
				elseif math.random(TREE9) == 10 then
					lottmapgen.generate_log(x, y, z, area, data, p2data,
						"lottplants:elm_log",
						math.random(2, 4))
				elseif math.random(PLANT7) == 9 then
					lottmapgen.leaf_litter(x, y, z, area, data)
				elseif math.random(PLANT8) == 8 then
					lottmapgen.perma_dirt(x, y, z, area, data)
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
				--lottmapgen.farming_plants(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT9) == 1 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(TREE9) == 3 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves")
			elseif math.random(TREE9) == 3 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(4, 6))
			elseif math.random(TREE10) == 4 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(4, 6),
					"lottplants:apple")
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	stone = c_sandstone,
	stone_depth = 20,
	beach = c_sand,
})
