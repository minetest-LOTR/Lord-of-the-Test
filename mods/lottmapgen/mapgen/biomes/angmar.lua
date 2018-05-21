local c_snowy_grass = minetest.get_content_id("lottitems:snowy_grass")
local c_air = minetest.get_content_id("air")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_ice = minetest.get_content_id("lottitems:ice")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_gravel = minetest.get_content_id("lottitems:gravel")

lottmapgen.register_biome(2, {
	name = "Angmar",
	surface = function(data, vi)
		data[vi] = c_snowy_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 < -0.15 then
			if noise > 0.7 then
				if math.random(TREE7) == 1 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				elseif math.random(TREE4) == 2 then
					lottmapgen.rock(x, y, z, area, data, nil, true)
				elseif math.random(PLANT7) == 3 then
					lottmapgen.pine_grass(data, vi, p2data)
				elseif data[vi] == c_air then
					data[vi] = c_snow
				end
			else
				if math.random(TREE3) == 3 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				elseif math.random(PLANT5) == 4 then
					lottmapgen.pine_grass(data, vi, p2data)
				elseif math.random(TREE8) == 5 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:pine_trunk",
						"lottplants:pine_needles", true)
				elseif math.random(TREE10) == 6 then
					lottmapgen.rock(x, y, z, area, data, nil, true)
				elseif data[vi] == c_air then
					data[vi] = c_snow
				end
			end
		elseif noise2 < 0.5 then
			if math.random(TREE6) == 2 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk",
					"lottplants:pine_needles", true)
			elseif math.random(TREE9) == 3 then
				lottmapgen.pine_tree(x, y, z, area, data, true)
			elseif math.random(PLANT9) == 4 then
				lottmapgen.pine_grass(data, vi, p2data)
			elseif math.random(TREE8) == 5 then
				lottmapgen.rock(x, y, z, area, data, nil, true)
			elseif data[vi] == c_air then
				data[vi] = c_snow
			end
		else
			if math.random(TREE7) == 1 then
				lottmapgen.rock(x, y, z, area, data, nil, true)
			elseif math.random(TREE10) == 2 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk",
					"lottplants:pine_needles", true)
			elseif data[vi] == c_air then
				data[vi] = c_snow
			end
		end
	end,
	water_surface = function(data, p2data, vi, area, x, y, z, noise)
		noise = noise / 2 - 0.1
		local viu = area:index(x, y - 1, z)
		if noise < -0.3 then
			-- Do nothing, water
		elseif noise < -0.2 then
			if math.random(5) == 1 then
				data[viu] = c_ice
			end
		elseif noise < -0.1 then
			if math.random(3) == 1 then
				data[viu] = c_ice
			end
		elseif noise < 0 then
			if math.random(2) == 1 then
				data[viu] = c_ice
			end
		else
			data[viu] = c_ice
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_gravel,
})
