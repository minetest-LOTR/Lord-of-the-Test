local c_iron_hills_grass = minetest.get_content_id("lottitems:iron_hills_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_mountain_grass = minetest.get_content_id("lottplants:mountain_grass")
local c_encyclia = minetest.get_content_id("lottplants:encyclia")

lottmapgen.register_biome(21, {
	name = "Iron Hills",
	surface = function(data, vi)
		data[vi] = c_iron_hills_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if noise > -0.1 then
			if math.random(TREE3) == 3 then
				if y > 55 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				else
					lottmapgen.pine_tree(x, y, z, area, data, false)
				end
			elseif math.random(PLANT5) == 5 and y < 87 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT4) == 6 and y < 82 then
				lottmapgen.grass(data, vi, p2data)
			elseif y == 69 then
				if math.random(3) == 1 then
					data[vi] = c_snow
				end
			elseif y == 70 then
				if math.random(3) ~= 1 then
					data[vi] = c_snow
				end
			elseif y > 70 then
				data[vi] = c_snow
			elseif math.random(TREE7) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(PLANT7) == 7 and y < 47 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT7) == 8 and y < 38 then
				data[vi] = c_encyclia
			elseif math.random(PLANT6) == 9 and y < 26 then
				lottmapgen.petuniae(data, vi, p2data)
			elseif math.random(TREE10) == 2 and y < 35 then
				lottmapgen.beech_tree(x, y, z, area, data)
			end
		elseif noise > -0.5 then
			if math.random(PLANT4) == 5 and y < 87 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT3) == 6 and y < 82 then
				lottmapgen.grass(data, vi, p2data)
			elseif y == 69 then
				if math.random(3) == 1 then
					data[vi] = c_snow
				end
			elseif y > 70 then
				data[vi] = c_snow
			elseif y == 70 then
				if math.random(3) ~= 1 then
					data[vi] = c_snow
				end
			elseif math.random(PLANT6) == 7 and y < 47 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT6) == 8 and y < 38 then
				data[vi] = c_encyclia
			elseif math.random(PLANT5) == 9 and y < 26 then
				lottmapgen.petuniae(data, vi, p2data)
			end
		else
			if math.random(PLANT4) == 5 and y < 87 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT3) == 6 and y < 82 then
				lottmapgen.grass(data, vi, p2data)
			elseif y == 69 then
				if math.random(3) == 1 then
					data[vi] = c_snow
				end
			elseif y == 70 then
				if math.random(3) ~= 1 then
					data[vi] = c_snow
				end
			elseif y > 70 then
				data[vi] = c_snow
			elseif math.random(TREE4) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(TREE8) == 1 then
				lottmapgen.generate_bush(x, y, z, area, data, "lottplants:beech_trunk", "lottplants:beech_leaves")
			elseif math.random(PLANT7) == 7 and y < 47 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT7) == 8 and y < 38 then
				data[vi] = c_encyclia
			elseif math.random(PLANT6) == 9 and y < 26 then
				lottmapgen.petuniae(data, vi, p2data)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	beach = c_dirt,
	water_surface = function(data, p2data, vi, area, x, y, z, noise)
		noise = math.abs(noise / 2) - 0.1
		if noise > 0.05 then
			if math.random(PLANT5) == 2 then
				lottmapgen.waterlily(data, vi, p2data, math.random(2))
			end
		end
	end,
	clouds = {
		density = 0.55,
		thickness = 50,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 90
	},
})
