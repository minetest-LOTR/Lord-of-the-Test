local c_desertsand = minetest.get_content_id("lottitems:desert_sand")
local c_dessandstone = minetest.get_content_id("lottitems:desert_sandstone")
local c_air = minetest.get_content_id("air")
local c_dryshrub = minetest.get_content_id("lottplants:dry_shrub")
local c_dessandstone_brick = minetest.get_content_id("lottitems:desert_sandstone_brick")

lottmapgen.register_biome(23, {
	name = "Near Harad",
	surface = function(data, vi)
		data[vi] = c_desertsand
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2, schems)
		if noise2 < -0.55 then
			if math.random(TREE8) == 2 then
				table.insert(schems, {"desert_pillar"
					.. math.random(1, 4) .. ".mts",
					{x = x, y = y - 4, z = z}})
			elseif math.random(TREE7) == 5 then
				local stone = "lottitems:desert_sandstone"
				if math.random(2) == 2 then
					stone = "lottitems:red_stone"
				end
				lottmapgen.rock(x, y, z, area, data, stone)
			elseif math.random(PLANT7) == 4 then
				data[vi] = c_dryshrub
			end
		elseif noise2 < -0.3 then
			if math.random(PLANT7) == 3 then
				data[vi] = c_dryshrub
			end
		elseif noise2 < 0.6 then
			if math.random(PLANT6) == 2 then
				data[vi] = c_dryshrub
			elseif math.random(TREE8) == 5 then
				local stone = "lottitems:desert_sandstone"
				if math.random(2) == 2 then
					stone = "lottitems:red_stone"
				end
				lottmapgen.rock(x, y, z, area, data, stone)
			elseif math.random(TREE9) == 2 then
				lottmapgen.cactus(x, y, z, area, data)
			elseif math.random(PLANT11) == 6 then
				lottmapgen.desert_flowers(data, vi, p2data)
			elseif noise > 0.75 then
				if math.random(PLANT8) == 3 then
					lottmapgen.desert_flowers(data, vi, p2data)
				end
			end
		else
			if math.random(PLANT7) == 2 then
				data[vi] = c_dryshrub
			elseif math.random(TREE5) == 2 then
				lottmapgen.cactus(x, y, z, area, data)
			end
		end
	end,
	soil = c_desertsand,
	soil_depth = 3,
	stone = c_dessandstone,
	dungeon_wall = c_dessandstone_brick,
	stone_depth = 83,
	water = c_air,
	beach = c_dessandstone,
	clouds = {
		density = 0.2,
		thickness = 6,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 170
	},
})
