local c_lindon_grass = minetest.get_content_id("lottitems:lindon_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_menelluin = minetest.get_content_id("lottplants:menelluin")
local c_snow = minetest.get_content_id("lottitems:snow_layer")

lottmapgen.register_biome(7, {
	name = "Lindon",
	surface = function(data, vi)
		data[vi] = c_lindon_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if y < 60 then
			if noise2 > -0.45 then
				if noise > 0.6 then
					if math.random(TREE5) == 2 then
						lottmapgen.rowan_tree(x, y, z, area, data)
					elseif math.random(TREE5) == 4 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:birch_trunk",
							"lottplants:birch_leaves",
							math.random(5, 7))
					elseif math.random(TREE8) == 6 then
						lottmapgen.birch_tree(x, y, z, area, data)
					elseif math.random(PLANT3) == 3 then
						lottmapgen.grass(data, vi, p2data)
					elseif math.random(PLANT5) == 2 then
						lottmapgen.lorien_grass(data, vi, p2data)
					elseif math.random(PLANT9) == 1 then
						data[vi] = c_menelluin
						p2data[vi] = 10
					end
				elseif noise < -0.65 then
					if math.random(PLANT4) == 1 then
						lottmapgen.basic_flowers(data, vi, p2data)
					elseif math.random(PLANT1) == 3 then
						lottmapgen.grass(data, vi, p2data)
					elseif math.random(PLANT3) == 2 then
						lottmapgen.lorien_grass(data, vi, p2data)
					elseif math.random(PLANT8) == 1 then
						data[vi] = c_menelluin
						p2data[vi] = 10
					elseif math.random(PLANT7) == 4 then
						lottmapgen.petuniae(data, vi, p2data)
					elseif math.random(PLANT7) == 4 then
						lottmapgen.gerberae(data, vi, p2data)
					elseif math.random(TREE7) == 4 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:birch_trunk",
							"lottplants:birch_leaves",
							math.random(5, 7))
					end
				else
					if math.random(PLANT2) == 3 then
						lottmapgen.grass(data, vi, p2data)
					elseif math.random(PLANT5) == 2 then
						lottmapgen.lorien_grass(data, vi, p2data)
					elseif math.random(PLANT6) == 1 then
						data[vi] = c_menelluin
						p2data[vi] = 10
					elseif math.random(PLANT8) == 4 then
						lottmapgen.petuniae(data, vi, p2data)
					elseif math.random(PLANT9) == 5 then
						lottmapgen.basic_flowers(data, vi, p2data)
					elseif math.random(PLANT9) == 4 then
						lottmapgen.gerberae(data, vi, p2data)
					elseif math.random(TREE10) == 4 then
						lottmapgen.rowan_tree(x, y, z, area, data)
					elseif math.random(TREE10) == 7 then
						lottmapgen.generate_tree(x, y, z, area, data,
							"lottplants:birch_trunk",
							"lottplants:birch_leaves",
							math.random(5, 7))
					elseif math.random(TREE9) == 4 then
						lottmapgen.generate_bush(x, y, z, area, data,
							"lottplants:rowan_trunk", "lottplants:rowan_leaves")
					elseif math.random(TREE9) == 5 then
						lottmapgen.generate_bush(x, y, z, area, data,
							"lottplants:birch_trunk", "lottplants:birch_leaves")
					end
				end
			else
				if math.random(TREE5) == 4 then
					lottmapgen.rowan_tree(x, y, z, area, data)
				elseif math.random(TREE4) == 7 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:birch_trunk",
						"lottplants:birch_leaves",
						math.random(5, 7))
				elseif math.random(TREE4) == 3 then
					lottmapgen.generate_tree(x, y, z, area, data,
						"lottplants:oak_trunk", "lottplants:oak_leaves", 4)
				elseif math.random(TREE8) == 4 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:rowan_trunk", "lottplants:rowan_leaves")
				elseif math.random(TREE8) == 5 then
					lottmapgen.generate_bush(x, y, z, area, data,
					"lottplants:birch_trunk", "lottplants:birch_leaves")
				elseif math.random(PLANT4) == 3 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT7) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(PLANT11) == 4 then
					lottmapgen.petuniae(data, vi, p2data)
				elseif math.random(PLANT8) == 5 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			end
		elseif y > 63 then
			if math.random(TREE9) == 2 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			else
				data[vi] = c_snow
			end
		elseif y == 60 then
			if math.random(TREE9) == 2 then
				lottmapgen.rowan_tree(x, y, z, area, data)
			elseif math.random(PLANT5) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(5) == 1 then
				data[vi] = c_snow
			end
		elseif y == 61 then
			if math.random(PLANT6) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(4) == 1 then
				data[vi] = c_snow
			end
		elseif y == 62 then
			if math.random(PLANT7) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(3) == 1 then
				data[vi] = c_snow
			end
		elseif y == 63 then
			if math.random(PLANT8) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(2) == 1 then
				data[vi] = c_snow
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	beach = c_dirt,
	clouds = {
		density = 0.4,
		thickness = 20,
		color = {
			r = 215,
			g = 255,
			b = 255,
			a = 229
		},
		height = 80
	},
})
