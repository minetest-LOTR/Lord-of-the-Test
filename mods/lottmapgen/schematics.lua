-- Buildings

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:snowblock",
	sidelen = 16,
	fill_ratio = 0.004,
	schematic = minetest.get_modpath("lottmapgen").."/schems/abandoned_fort.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:snowblock",
	sidelen = 16,
	fill_ratio = 0.0045,
	schematic = minetest.get_modpath("lottmapgen").."/schems/abandoned_tower.mts",
	flags = "place_center_x, place_center_z",
})