dofile(minetest.get_modpath("lottblocks").."/doors.lua") --This has doors and fences.
dofile(minetest.get_modpath("lottblocks").."/tables.lua") --This has tables and chairs.
dofile(minetest.get_modpath("lottblocks").."/beds.lua") --This has beds.
dofile(minetest.get_modpath("lottblocks").."/hatches.lua") --This has hatches/trapdoors.

minetest.register_node("lottblocks:snowycobble", {
	description = "Snowy Cobblestone",
	tiles = {"lottblocks_snowycobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})
minetest.register_node("lottblocks:orc_brick", {
	description = "Orc Brick",
	tiles = {"lottblocks_orc_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("orc_brick", "lottblocks:orc_brick",
		{cracky=2},
		{"lottblocks_orc_brick.png"},
		"Orc Brick",
		"Orc Brick"
)
minetest.register_node("lottblocks:marble_brick", {
	description = "Marble Brick",
	tiles = {"lottblocks_marble_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("marble_brick", "lottblocks:marble_brick",
		{cracky=2},
		{"lottblocks_marble_brick.png"},
		"Marble Brick",
		"Marble Brick"
)
minetest.register_craft({
	output = 'lottblocks:marble_brick 4',
	recipe = {
		{'lottores:marble', 'lottores:marble'},
		{'lottores:marble', 'lottores:marble'},
	}
})
minetest.register_craft({
	output = 'lottblocks:orc_brick 4',
	recipe = {
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
	}
})
