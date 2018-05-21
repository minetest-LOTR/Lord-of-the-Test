local c_mirkwood_grass = minetest.get_content_id("lottitems:mirkwood_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")

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
				--data[vi] = lottmapgen.buildings.enqueue_building("Mirkwood House", {x=x, y=y, z=z})
			end
		end
	end,
	beach = c_sand,
	soil = c_dirt,
	soil_depth = 4,
})

