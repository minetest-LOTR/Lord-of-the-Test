local c_lorien_grass = minetest.get_content_id("lottitems:lorien_grass")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_silsand = minetest.get_content_id("lottitems:silver_sand")

lottmapgen.register_biome(15, {
	name = "Lorien",
	surface = function(data, vi)
		data[vi] = c_lorien_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z, noise)
		if y == 1 then
			if math.random(3) == 1 then
				local viu = area:index(x, y - 1, z)
				data[viu] = c_silsand
			end
			if math.random(PLANT4) == 3 then
				lottmapgen.lorien_grass(data, vi, p2data)
			end
		else
			if noise > 0.6 then
				if math.random(TREE5) == 2 then
					lottmapgen.young_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT1) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(TREE10) == 3 then
					lottmapgen.small_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT3) == 7 then
					lottmapgen.lorien_plants(data, vi, p2data)
				elseif math.random(TREE6) == 8 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:mallorn_trunk", "lottplants:mallorn_leaves")
				end
			elseif noise < -0.65 then
				if math.random(TREE4) == 2 then
					lottmapgen.small_mallorn_tree(x, y, z, area, data)
				elseif math.random(TREE6) == 2 then
					lottmapgen.young_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT4) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(TREE2) == 3 then
					lottmapgen.mallorn_tree(x, y, z, area, data)
				end
			else
				if math.random(TREE3) == 2 then
					lottmapgen.small_mallorn_tree(x, y, z, area, data)
				elseif math.random(TREE2) == 2 then
					lottmapgen.young_mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT1) == 2 then
					lottmapgen.lorien_grass(data, vi, p2data)
				elseif math.random(TREE5) == 3 then
					lottmapgen.mallorn_tree(x, y, z, area, data)
				elseif math.random(PLANT5) == 11 then
					lottmapgen.lorien_plants(data, vi, p2data)
				elseif math.random(TREE8) == 8 then
					lottmapgen.generate_bush(x, y, z, area, data,
						"lottplants:mallorn_trunk", "lottplants:mallorn_leaves")
				elseif math.random(PLANT13) == 13 then
					if math.random(1, 2) == 1 then
						lottmapgen.buildings.enqueue_building("Mallorn House", {x=x, y=y, z=z})
					else
						lottmapgen.buildings.enqueue_building("Lorien House", {x=x, y=y, z=z})
					end
				end
			end
		end
	end,
	beach = c_silsand,
	water_surface = function(data, p2data, vi, area, x, y, z, noise)
		noise = math.abs(noise / 2) - 0.1
		if noise > 0.075 then
			if math.random(PLANT5) == 2 then
				lottmapgen.waterlily(data, vi, p2data, math.random(4))
			end
		end
	end,
	soil = c_dirt,
	soil_depth = 2,
	clouds = {
		density = 0.5,
		thickness = 16,
		color = {
			r = 246,
			g = 255,
			b = 196,
			a = 229
		},
		height = 130
	},
})
