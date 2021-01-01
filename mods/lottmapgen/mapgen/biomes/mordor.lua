local c_morstone = minetest.get_content_id("lottitems:mordor_stone")
local c_morwat = minetest.get_content_id("lottitems:mordor_water_source")
local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")

lottmapgen.register_biome(19, {
	name = "Mordor",
	surface = function(data, vi)
		data[vi] = c_morstone
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE10) == 2 then
			--lottmapgen.burned_tree(x, y, z, area, data)
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_bomordor
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.buildings.enqueue_building("Orc Fort", {x=x, y=y, z=z})
		end
	end,
	stone = c_morstone,
	stone_depth = 256,
	water = c_morwat,
	clouds = {
		density = 0.85,
		thickness = 50,
		color = {r = 255, g = 129, b = 129, a = 229},
		height = 70,
	},
})
