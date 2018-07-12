local c_ice = minetest.get_content_id("lottitems:ice")
local c_gravel = minetest.get_content_id("lottitems:gravel")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_snowblock = minetest.get_content_id("lottitems:snow")
local c_dryshrub = minetest.get_content_id("lottplants:dry_shrub")

lottmapgen.register_biome(1, {
	name = "Forodwaith",
	surface = function(data, vi)
		if math.random(250) == 2 then
			data[vi] = c_ice
		elseif math.random(25) == 2 then
			data[vi] = c_gravel
		else
			data[vi] = c_snowblock
		end
	end,
	deco = function(data, p2data, vi, area, x, y, z, _, noise)
		if math.random(PLANT11) == 1 then
			data[vi] = c_dryshrub
		elseif math.random(TREE5) == 3 then
			 if noise < -0.85 then
				lottmapgen.generate_tree(x, y, z, area, data, p2data,
					"lottitems:stone",
					"air", math.random(4, 6))
			end
		elseif noise > 0.8 then
			data[vi] = c_snow
			p2data[vi] = math.random(20, 50)
		elseif noise > 0.4 then
			if math.random(TREE2) == 1 then
				lottmapgen.rock(x, y, z, area, data, "lottitems:snow", true)
			elseif math.random(TREE4) == 1 then
				lottmapgen.rock(x, y, z, area, data, "lottitems:stone", true)
			end
		elseif noise > 0.1 and noise < 0.25 then
			data[vi] = c_snow
			p2data[vi] = math.random(10, 25)
		else
			if math.random(TREE9) == 1 then
				lottmapgen.rock(x, y, z, area, data, "lottitems:stone", true)
			end
			data[vi] = c_snow
			p2data[vi] = math.random(40, 55)
		end
	end,
	soil = c_snowblock,
	soil_depth = 3,
	stone = c_gravel,
	stone_depth = 6,
	water = c_ice,
	beach = c_gravel,
	clouds = {
		density = 1,
		thickness = 100,
		color = {
			r = 150,
			g = 150,
			b = 150,
			a = 229
		},
		height = 170
	},
})
