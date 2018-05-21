local c_gondor_grass = minetest.get_content_id("lottitems:gondor_grass")
local c_mallos = minetest.get_content_id("lottplants:mallos")
local c_dirt = minetest.get_content_id("lottitems:dirt")
local c_sand = minetest.get_content_id("lottitems:sand")
local c_sandstone = minetest.get_content_id("lottitems:sandstone")
local c_sandstone_brick = minetest.get_content_id("lottitems:sandstone_brick")

lottmapgen.register_biome(18, {
	name = "Gondor",
	surface = function(data, vi)
		data[vi] = c_gondor_grass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen.default_tree(x, y, z, area, data)
		elseif math.random(TREE8) == 6 then
			lottmapgen.alder_tree(x, y, z, area, data)
		elseif math.random(TREE9) == 3 then
			lottmapgen.apple_tree(x, y, z, area, data)
		elseif math.random(TREE8) == 4 then
			lottmapgen.plum_tree(x, y, z, area, data)
		elseif math.random(TREE10) == 9 then
			--lottmapgen.elm_tree(x, y, z, area, data)
		elseif math.random(PLANT13) == 10 then
			lottmapgen.white_tree(x, y, z, area, data)
		elseif math.random(TREE10) == 12 then
			lottmapgen.lebethron_tree(x, y, z, area, data)
		elseif math.random(PLANT3) == 5 then
			lottmapgen.grass(data, vi, p2data)
		elseif math.random(PLANT8) == 7 then
			lottmapgen.farming_plants(data, vi, p2data)
		elseif math.random(PLANT13) == 8 then
			lottmapgen.farming_plants_rare(data, vi, p2data)
		elseif math.random(PLANT10) == 11 then
			lottmapgen.ithildin_plants(data, vi, p2data)
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_mallos
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.buildings.enqueue_building("Gondor Fort", {x=x, y=y, z=z})
		end
	end,
	soil = c_dirt,
	soil_depth = 1,
	beach = c_sand,
	stone = c_sandstone,
	dungeon_wall = c_sandstone_brick,
	stone_depth = 53,
	clouds = {
		density = 0.55,
		thickness = 34,
		color = {
			r = 255,
			g = 225,
			b = 225,
			a = 229
		},
		height = 100
	},
})
