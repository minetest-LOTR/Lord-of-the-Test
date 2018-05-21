local c_dunland_grass = minetest.get_content_id("lottitems:dunland_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")

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
