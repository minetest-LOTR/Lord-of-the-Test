local c_blue_mountains_grass = minetest.get_content_id("lottitems:blue_mountains_grass")
local c_bluestone = minetest.get_content_id("lottitems:blue_stone")
local c_gravel = minetest.get_content_id("lottitems:gravel")
local c_darkgravel = minetest.get_content_id("lottitems:dark_gravel")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_snowblock = minetest.get_content_id("lottitems:snow")
local c_ice = minetest.get_content_id("lottitems:ice")
local c_mountain_grass = minetest.get_content_id("lottplants:mountain_grass")
local c_mountainshrub = minetest.get_content_id("lottplants:mountain_shrub")
local c_blue_brick = minetest.get_content_id("lottitems:blue_stone_brick")
local c_blue_block = minetest.get_content_id("lottitems:blue_stone_block")

lottmapgen.register_biome(26, {
	name = "Blue Mountains",
	surface = function(data, vi, y)
		if y < 15 then
			data[vi] = c_blue_mountains_grass
		elseif y == 15 then
			if math.random(5) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		elseif y == 16 then
			if math.random(4) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		elseif y == 17 then
			if math.random(3) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		elseif y == 18 then
			if math.random(2) ~= 2 then
				data[vi] = c_blue_mountains_grass
			else
				data[vi] = c_bluestone
			end
		else
			data[vi] = c_bluestone
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		local viu = area:index(x, y - 1, z)
		if y > 85 and noise > -0.2 then
			data[viu] = c_ice
			local rand = math.random(40)
			if rand == 1 then
				data[vi] = c_gravel
			elseif rand < 4 then
				data[vi] = c_bluestone
			elseif rand < 7 then
				data[vi] = c_ice
			else
				data[vi] = c_snowblock
			end
		elseif y < 15 then
			if math.random(TREE6) == 4 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
			elseif math.random(TREE7) == 3 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(TREE9) == 4 then
				lottmapgen.pine_tree(x, y, z, area, data, false)
			elseif math.random(PLANT8) == 4 then
				lottmapgen.mountain_flowers(data, area:index(x, y, z), p2data)
			elseif math.random(PLANT10) == 9 then
				lottmapgen.petuniae(data, area:index(x, y, z), p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.grass(data, area:index(x, y, z), p2data)
			elseif math.random(PLANT4) == 2 then
				data[vi] = c_mountainshrub
				p2data[vi] = 50
			elseif math.random(PLANT7) == 2 then
				data[vi] = c_mountain_grass
			end
		elseif y > 35 and noise > 0.6 then
			data[viu] = c_darkgravel
			data[vi] = c_darkgravel
			if y > 55 then
				data[area:index(x, y + 1, z)] = c_snow
			end
		elseif y == 54 then
			if math.random(3) == 2 then
				data[vi] = c_snow
			end
		elseif y == 55 then
			if math.random(2) == 1 then
				data[vi] = c_snow
			end
		elseif y > 55 then
			data[vi] = c_snow
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_mountainshrub
			p2data[vi] = 42
		elseif math.random(25000) == 1 then
			lottmapgen.generate_bush(x, y, z, area, data,
				"lottplants:pine_trunk", "lottplants:pine_needles")
		elseif y < 32 then
			if math.random(PLANT9) == 5 then
				lottmapgen.mountain_flowers(data, vi, p2data)
			end
		end
	end,
	stone_depth = 68,
	stone = c_bluestone,
	beach = c_gravel,
	clouds = {
		density = 0.75,
		thickness = 50,
		color = {
			r = 195,
			g = 205,
			b = 226,
			a = 229
		},
		height = 80
	},
})
