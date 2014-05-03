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

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:angsnowblock",
	sidelen = 16,
	fill_ratio = 0.003,
	schematic = minetest.get_modpath("lottmapgen").."/schems/witchking_fort.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:lorien_grass",
	sidelen = 16,
	fill_ratio = 0.003,
	schematic = minetest.get_modpath("lottmapgen").."/schems/mallornhouse.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:mirkwood_grass",
	sidelen = 16,
	fill_ratio = 0.003,
	schematic = minetest.get_modpath("lottmapgen").."/schems/mirkwoodelvenhouse.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:mordor_stone",
	sidelen = 16,
	fill_ratio = 0.003,
	schematic = minetest.get_modpath("lottmapgen").."/schems/orcfort.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:rohan_grass",
	sidelen = 16,
	fill_ratio = 0.003,
	schematic = minetest.get_modpath("lottmapgen").."/schems/rohan_fort.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:gondor_grass",
	sidelen = 16,
	fill_ratio = 0.003,
	schematic = minetest.get_modpath("lottmapgen").."/schems/gondor_fort.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:shire_grass",
	sidelen = 16,
	fill_ratio = 0.010,
	schematic = minetest.get_modpath("lottmapgen").."/schems/hobbithole.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "lottmapgen:shire_grass",
	sidelen = 16,
	fill_ratio = 0.005,
	schematic = minetest.get_modpath("lottmapgen").."/schems/hobbit_farm.mts",
	flags = "place_center_x, place_center_z",
})