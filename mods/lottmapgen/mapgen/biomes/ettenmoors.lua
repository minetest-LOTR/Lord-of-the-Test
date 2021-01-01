local c_ettenmoors_grass = minetest.get_content_id("lottitems:ettenmoors_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_silsand = minetest.get_content_id("lottitems:silver_sand")
local c_snow = minetest.get_content_id("lottitems:snow_layer")
local c_mountain_grass = minetest.get_content_id("lottplants:mountain_grass")
local c_encyclia = minetest.get_content_id("lottplants:encyclia")

lottmapgen.register_biome(3, {
	name = "Ettenmoors",
	surface = function(data, vi)
		data[vi] = c_ettenmoors_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_silsand
		elseif noise > 0.25 or y > 60 then
			data[vi] = c_snow
			if math.random(TREE9) == 4 then
				lottmapgen.rock(x, y, z, area, data, nil, true)
			elseif noise > 0.5 then
				if math.random(TREE3) == 3 then
					lottmapgen.pine_tree(x, y, z, area, data, true)
				end
			end
		elseif y == 60 then
			if math.random(4) ~= 4 then
				data[vi] = c_snow
			end
		elseif y == 59 then
			if math.random(2) == 2 then
				data[vi] = c_snow
			end
		elseif y == 58 then
			if math.random(4) == 1 then
				data[vi] = c_snow
			end
		else
			if math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 3 then
				data[vi] = c_mountain_grass
			elseif math.random(PLANT12) == 1 then
				--lottmapgen.farming_plants(data, vi, p2data)
			elseif math.random(PLANT12) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT11) == 4 then
				data[vi] = c_encyclia
			elseif math.random(TREE8) == 8 then
				lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:pine_trunk", "lottplants:pine_needles")
			elseif math.random(TREE9) == 9 then
				lottmapgen.rock(x, y, z, area, data)
			elseif noise < -0.5 then
				if math.random(TREE3) == 3 then
					lottmapgen.pine_tree(x, y, z, area, data, false)
				elseif math.random(TREE5) == 4 then
					lottmapgen.beech_tree(x, y, z, area, data)
				elseif math.random(PLANT5) == 5 then
					lottmapgen.pine_grass(data, vi, p2data)
				elseif math.random(PLANT5) == 9 then
					lottmapgen.leaf_litter(x, y, z, area, data)
				elseif math.random(PLANT7) == 8 then
					lottmapgen.perma_dirt(x, y, z, area, data)
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 3,
	beach = c_silsand,
})
