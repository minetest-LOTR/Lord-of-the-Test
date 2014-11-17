dofile(minetest.get_modpath("curwe").."/nodes/doors.lua") --This has doors and fences.
dofile(minetest.get_modpath("curwe").."/nodes/tables.lua") --This has tables and chairs.
dofile(minetest.get_modpath("curwe").."/nodes/beds.lua") --This has beds.
dofile(minetest.get_modpath("curwe").."/nodes/hatches.lua") --This has hatches/trapdoors, by catninja.
dofile(minetest.get_modpath("curwe").."/nodes/decoration.lua") --This has various decoration nodes, by catninja.

minetest.register_node("curwe:snowycobble", {
	description = "Snowy Cobblestone",
	tiles = {"curwe_snowycobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})
minetest.register_node("curwe:orc_brick", {
	description = "Orc Brick",
	tiles = {"curwe_orc_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("orc_brick", "curwe:orc_brick",
		{cracky=2},
		{"curwe_orc_brick.png"},
		"Orc Brick",
		"Orc Brick"
)
minetest.register_node("curwe:marble_brick", {
	description = "Marble Brick",
	tiles = {"curwe_marble_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("marble_brick", "curwe:marble_brick",
		{cracky=2},
		{"curwe_marble_brick.png"},
		"Marble Brick",
		"Marble Brick"
)
minetest.register_craft({
	output = 'curwe:marble_brick 4',
	recipe = {
		{'cemen:marble', 'cemen:marble'},
		{'cemen:marble', 'cemen:marble'},
	}
})
minetest.register_craft({
	output = 'curwe:orc_brick 4',
	recipe = {
		{'cemen:mordor_stone', 'cemen:mordor_stone'},
		{'cemen:mordor_stone', 'cemen:mordor_stone'},
	}
})
