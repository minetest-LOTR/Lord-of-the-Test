local c_fangorn_grass = minetest.get_content_id("lottitems:fangorn_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_black_tulip = minetest.get_content_id("lottplants:tulip_black")

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
