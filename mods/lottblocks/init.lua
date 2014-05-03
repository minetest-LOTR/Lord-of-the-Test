dofile(minetest.get_modpath("lottblocks").."/doors.lua") --This has doors and fences.
dofile(minetest.get_modpath("lottblocks").."/tables.lua") --This has tables and chairs.
dofile(minetest.get_modpath("lottblocks").."/beds.lua") --This has beds.

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
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"lottblocks_orc_brick.png"},
		"Orc Brick",
		"Orc Brick"
)
