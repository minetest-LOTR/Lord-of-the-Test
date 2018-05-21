local c_wilderland_grass = minetest.get_content_id("lottitems:wilderland_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")

lottmapgen.register_biome(25, {
	name = "Wilderland",
	surface = function(data, vi)
		data[vi] = c_wilderland_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise1, noise2)
		if y < 3 then
			local viu = area:index(x, y - 1, z)
			data[viu] = c_sand
			if math.random(PLANT6) == 2 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif y == 3 then
			if math.random(3) == 2 then
				local viu = area:index(x, y - 1, z)
				data[viu] = c_sand
			end
			if math.random(PLANT4) == 2 then
				lottmapgen.grass(data, vi, p2data)
			end
		elseif noise2 > 0.6 then
			if math.random(PLANT1) == 2 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.tall_grass(x, y, z, area, data)
			elseif noise1 < 0.5 then
				if math.random(PLANT9) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise1 > 0.5 then
				if math.random(PLANT5) == 3 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		elseif noise1 < -0.6 then
			if math.random(PLANT3) == 4 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT8) == 2 then
				lottmapgen.farming_plants(data, vi, p2data)
			end
		elseif noise1 > 0.7 then
			if math.random(PLANT3) == 4 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT7) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(TREE7) == 3 then
				lottmapgen.default_bush(x, y, z, area, data)
			end
		elseif noise2 < -0.6 then
			if math.random(PLANT5) == 1 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(TREE6) == 2 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(TREE5) == 3 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(TREE7) == 4 then
				lottmapgen.alder_tree(x, y, z, area, data)
			elseif math.random(TREE8) == 5 then
				lottmapgen.apple_tree(x, y, z, area, data)
			elseif math.random(TREE7) == 6 then
				lottmapgen.culumalda_tree(x, y, z, area, data)
			end
		else
			if math.random(TREE10) == 6 then
				lottmapgen.default_bush(x, y, z, area, data)
			elseif math.random(15000) == 5 then
				lottmapgen.rowan_bush(x, y, z, area, data)
			elseif math.random(25000) == 4 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(25000) == 3 then
				lottmapgen.default_tree(x, y, z, area, data)
			elseif math.random(PLANT10) == 2 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT3) == 1 then
				lottmapgen.grass(data, vi, p2data)
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
})
