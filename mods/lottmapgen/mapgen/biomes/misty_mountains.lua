local c_base_grass = minetest.get_content_id("lottitems:misty_mountains_grass")
local c_gravel = minetest.get_content_id("lottitems:gravel")
local c_darkgravel = minetest.get_content_id("lottitems:dark_gravel")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_snowblock = minetest.get_content_id("lottitems:snow")
local c_dirt = minetest.get_content_id("lottitems:dirt")
-------------------
local c_frozenstone = minetest.get_content_id("lottitems:stone")--"lottmapgen:frozen_stone")

lottmapgen.register_biome(20, {
	name = "Misty Mountains",
	surface = function(data, vi, y)
		if y > 45 then
			data[vi] = c_snowblock
		elseif y == 45 then
			if math.random(2) == 1 then
				data[vi] = c_snowblock
			else
				data[vi] = c_gravel
			end
		elseif y > 25 then
			data[vi] = c_gravel
		elseif y == 25 then
			if math.random(2) == 1 then
				data[vi] = c_base_grass
			else
				data[vi] = c_gravel
			end
		else
			data[vi] = c_base_grass
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y > 45 then
			if math.random(TREE7) == 3 then
				lottmapgen.rock(x, y, z, area, data, "lottitems:stone", true)
			elseif noise > 0.1 then
				data[vi] = c_snow
				p2data[vi] = math.random(20, 35)
			end
		elseif y < 18 then
			if math.random(PLANT4) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE9) == 2 and y < 12 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(3, 4))
			elseif math.random(TREE7) == 3 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves")
			end
			if noise < -0.5 then
				if math.random(PLANT4) == 4 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		end
	end,
	soilf = function(data, vi, y)
		if y > 49 then
			data[vi] = c_snowblock
		elseif y > 20 then
			data[vi] = c_gravel
		else
			data[vi] = c_dirt
		end
	end,
	soil_depth = 4,
	stone = c_frozenstone,
	stone_depth = 0,
	beach = c_darkgravel,
	clouds = {
		density = 0.75,
		thickness = 90,
		color = {
			r = 190,
			g = 190,
			b = 190,
			a = 229
		},
		height = 80
	},
})
