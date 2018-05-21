local c_eregion_grass = minetest.get_content_id("lottitems:eregion_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_silsand = minetest.get_content_id("lottitems:silver_sand")
local c_snow = minetest.get_content_id("lottitems:snow_layer")

lottmapgen.register_biome(12, {
	name = "Eregion",
	surface = function(data, vi)
		data[vi] = c_eregion_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_silsand
			if math.random(PLANT5) == 2 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif y == 67 then
			if math.random(2) == 1 then
				data[vi] = c_snow
			end
		elseif y > 67 then
			if math.random(PLANT7) == 1 then
				lottmapgen.mountain_flowers(data, vi, p2data)
			elseif math.random(PLANT8) == 2 then
				lottmapgen.grass(data, vi, p2data)
			else
				data[vi] = c_snow
			end
		else
			if noise2 < -0.35 then
				if math.random(TREE2) == 3 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:holly_trunk", "lottplants:holly_leaves")
				elseif math.random(TREE4) == 5 then
					lottmapgen.holly_tree(x, y, z, area, data)
				elseif math.random(PLANT4) == 3 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT6) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise2 > 0.65 then
				if math.random(TREE5) == 1 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:holly_trunk", "air", 4)
				elseif math.random(TREE5) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "air", 5)
				elseif math.random(TREE10) == 3 then
					lottmapgen.holly_tree(x, y, z, area, data)
				elseif math.random(TREE10) == 4 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
				elseif math.random(PLANT7) == 3 then
					lottmapgen.grass(data, vi, p2data)
				end
			else
				if math.random(PLANT3) == 2 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT11) == 1 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(PLANT8) == 5 and y < 48 then
					lottmapgen.basic_flowers(data, vi, p2data)
				elseif math.random(TREE10) == 2 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
				elseif math.random(TREE10) == 4 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves")
				elseif math.random(PLANT8) == 5 and y > 20 then
					lottmapgen.mountain_flowers(data, vi, p2data)
				elseif noise > 0.75 and y < 45 then
					if math.random(TREE3) == 1 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
					elseif math.random(TREE2) == 2 then
						lottmapgen.generate_bush(x, y, z, area, data,
							"lottplants:oak_trunk", "lottplants:oak_leaves")
					end
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_silsand,
})
