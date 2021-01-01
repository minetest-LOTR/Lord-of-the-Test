local c_arthedain_grass = minetest.get_content_id("lottitems:arthedain_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")


lottmapgen.register_biome(4, {
	name = "Arthedain",
	surface = function(data, vi)
		data[vi] = c_arthedain_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if math.random(PLANT14) == 1 then
			lottmapgen.ruin(x, y, z, area, data)
		elseif math.random(PLANT15) == 2 then
			lottmapgen.tower(x, y, z, area, data)
		elseif noise2 > 0.35 then
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
				elseif math.random(TREE5) == 7 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:dark_oak_trunk",
						"lottplants:dark_oak_leaves",
						math.random(5, 6))
				elseif math.random(TREE8) == 8 then
					lottmapgen.generate_large_tree(x, y, z, area, data,
						"lottplants:beech_trunk",
						"lottplants:beech_leaves",
						math.random(8, 10))
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
				elseif math.random(PLANT5) == 9 then
					lottmapgen.leaf_litter(x, y, z, area, data)
				elseif math.random(PLANT6) == 8 then
					lottmapgen.perma_dirt(x, y, z, area, data)
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
			elseif math.random(PLANT7) == 9 then
				lottmapgen.leaf_litter(x, y, z, area, data)
			elseif math.random(PLANT8) == 8 then
				lottmapgen.perma_dirt(x, y, z, area, data)
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
