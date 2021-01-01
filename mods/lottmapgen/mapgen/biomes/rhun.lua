local c_rhun_grass = minetest.get_content_id("lottitems:rhun_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")
local c_red_stone = minetest.get_content_id("lottitems:red_stone")
local c_sunflower = minetest.get_content_id("lottplants:sunflower")
local c_red_cobble = minetest.get_content_id("lottitems:red_cobble")
local c_red_bricks = minetest.get_content_id("lottitems:red_stone_brick")
local c_red_block = minetest.get_content_id("lottitems:red_stone_block")

lottmapgen.register_biome(22, {
	name = "Rhun",
	surface = function(data, vi, _, noise)
		data[vi] = c_rhun_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise, noise2)
		if noise2 < -0.6 then
			if math.random(TREE3) == 1 then
				lottmapgen.generate_tall_tree(x, y, z, area, data,
					"lottplants:cedar_trunk",
					"lottplants:cedar_leaves")
			elseif math.random(TREE5) == 5 then
				lottmapgen.generate_large_tree(x, y, z, area, data,
					"lottplants:cedar_trunk",
					"lottplants:cedar_leaves",
					math.random(7, 9))
			elseif math.random(TREE4) == 1 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(4, 5))
			elseif math.random(TREE7) == 2 then
				lottmapgen.generate_tree(x, y, z, area, data,
					"lottplants:oak_trunk",
					"lottplants:oak_leaves",
					math.random(4, 5),
					"lottplants:apple")
			elseif math.random(TREE6) == 7 then
				lottmapgen.generate_large_tree(x, y, z, area, data,
					"lottplants:rowan_trunk",
					"lottplants:rowan_leaves",
					math.random(7, 9))
			elseif math.random(PLANT4) == 3 then
				lottmapgen.grass(data, vi, p2data)
			elseif math.random(PLANT6) == 4 then
				lottmapgen.basic_flowers(data, vi, p2data)
			elseif math.random(PLANT5) == 5 then
				lottmapgen.tall_grass(x, y, z, area, data)
			elseif math.random(PLANT6) == 9 then
				lottmapgen.leaf_litter(x, y, z, area, data)
			elseif math.random(PLANT7) == 8 then
				lottmapgen.perma_dirt(x, y, z, area, data)
			end
		else
			if noise > 0.75 then
				if math.random(PLANT4) == 3 then
					data[vi] = c_sunflower
					if math.random(2) == 1 then
						p2data[vi] = 0
					else
						p2data[vi] = 2
					end
				elseif math.random(PLANT1) == 1 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT8) == 3 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			elseif noise < 0 then
				if math.random(PLANT2) == 2 then
					lottmapgen.tall_grass(x, y, z, area, data)
				elseif math.random(PLANT1) == 1 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT10) == 3 then
					data[vi] = c_sunflower
				elseif math.random(PLANT8) == 3 then
					lottmapgen.basic_flowers(data, vi, p2data)
				end
			else
				if math.random(PLANT3) == 2 then
					lottmapgen.grass(data, vi, p2data)
				elseif math.random(PLANT6) == 4 then
					lottmapgen.tall_grass(x, y, z, area, data)
				elseif math.random(PLANT7) == 3 then
					lottmapgen.basic_flowers(data, vi, p2data)
				elseif noise > 0.4 and noise < 0.5 then
					if math.random(PLANT5) == 1 then
						lottmapgen.basic_flowers(data, vi, p2data)
					end
				elseif math.random(TREE9) == 4 then
					lottmapgen.generate_tall_tree(x, y, z, area, data,
						"lottplants:cedar_trunk",
						"lottplants:cedar_leaves")
				elseif math.random(TREE10) == 5 then
					lottmapgen.ruin(x, y, z, area, data, c_red_cobble, c_red_bricks)
				elseif math.random(PLANT13) == 6 then
					lottmapgen.tower(x, y, z, area, data, c_red_bricks, c_red_block)
				end
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 4,
	beach = c_sand,
	stone = c_red_stone,
	stone_depth = 15,
	clouds = {
		density = 0.3,
		thickness = 12,
		color = {
			r = 255,
			g = 240,
			b = 240,
			a = 229
		},
		height = 140
	},
})
