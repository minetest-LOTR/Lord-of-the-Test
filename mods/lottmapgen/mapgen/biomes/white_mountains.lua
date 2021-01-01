local c_white_mountains_grass = minetest.get_content_id("lottitems:white_mountains_grass")
local c_silsandstone = minetest.get_content_id("lottitems:silver_sandstone")
local c_silsand = minetest.get_content_id("lottitems:silver_sand")
local c_snowblock = minetest.get_content_id("lottitems:snow")
local c_gravel = minetest.get_content_id("lottitems:gravel")
local c_dryshrub = minetest.get_content_id("lottplants:dry_shrub")
local c_mallos = minetest.get_content_id("lottplants:mallos")

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
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(4, 6))
			elseif math.random(TREE6) == 5 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves")
			elseif math.random(TREE10) == 6 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:apple_trunk",
					"lottplants:apple_leaves",
					math.random(5, 6),
					"lottitems:apple")
			elseif math.random(PLANT3) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT10) == 2 then
				data[vi] = c_mallos
				p2data[vi] = 42
			elseif math.random(PLANT10) == 1 then
				--lottmapgen.farming_plants(data, vi, p2data)
			elseif math.random(640000) == 39 then
				lottmapgen.white_tree(x, y, z, area, data)
			end
		elseif y > 99 then
			data[area:index(x, y - 1, z)] = c_snowblock
		elseif y > 70 and noise > 0.65 then
			data[area:index(x, y - 1, z)] = c_snowblock
		elseif math.random(TREE9) == 1 then
			lottmapgen.generate_bush(x, y, z, area, data,
				"lottplants:oak_trunk",
				"lottplants:oak_leaves")
		elseif y > 40 and noise < -0.55 then
			data[area:index(x, y - 1, z)] = c_gravel
		elseif math.random(PLANT8) == 2 then
			data[vi] = c_dryshrub
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
