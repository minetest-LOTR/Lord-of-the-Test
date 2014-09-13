--Thanks for all the things in this file, and the related textures goes to catninja!--

-------------
--- Items ---
-------------

-- TREES
-- Vine tree

minetest.register_node("lottdecoration:tree_vine", {
	description = "Tree with vines",
	tiles = {"tree_vine_top.png", "tree_vine_top.png", "tree_vine.png", "tree_vine.png", "tree_vine.png", "tree_vine.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2,snappy=2},
})

stairs.register_stair_and_slab("tree_vine", "lottdecoration:tree_vine",
		{choppy=2,snappy=2},
		{"tree_vine.png"},
		"tree_vine",
		"tree_vine"
)

-- Mossy tree

minetest.register_node("lottdecoration:tree_mossy", {
	description = "Tree with moss",
	tiles = {"tree_mossy_top.png", "tree_mossy_top.png", "tree_mossy.png", "tree_mossy.png", "tree_mossy.png", "tree_mossy.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2},
})

stairs.register_stair_and_slab("tree_mossy", "lottdecoration:tree_mossy",
		{choppy=2},
		{"tree_mossy.png"},
		"tree_mossy",
		"tree_mossy"
)

-- Leafroof dark

minetest.register_node("lottdecoration:leafroof_dark", {
	description = "Dark leafroof",
	tiles = {"leafroof.png"},
	paramtype = "light",
	drawtype = "allfaces_optional",
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=2,oddly_breakable_by_hand=2,leaves=1},
})

stairs.register_stair_and_slab("leafroof_dark", "lottdecoration:leafroof_dark",
		{oddly_breakable_by_hand=2,leaves=1},
		{"leafroof.png"},
		"leafroof_dark",
		"leafroof_dark"
)


-- MALLORN
-- Leafroof mallorn

minetest.register_node("lottdecoration:leafroof_mallorn", {
	description = "mallorn leaf roof",
	tiles = {"mallornroof.png"},
	paramtype = "light",
	drawtype = "allfaces_optional",
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
	grups = {oddly_breakable_by_hand=2,leaves=1},
})

stairs.register_stair_and_slab("leafroof_mallorn", "lottdecoration:leafroof_mallorn",
		{oddly_breakable_by_hand=2,leaves=1},
		{"mallornroof.png"},
		"leafroof_mallorn",
		"leafroof_mallorn"
)

-- mallorn pillar

minetest.register_node("lottdecoration:mallorn_pillar", {
	description = "Mallorn pillar",
	tiles = {"mallorn_pillar.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2},
})

stairs.register_stair_and_slab("mallorn_pillar", "lottdecoration:mallorn_pillar",
		{snappy=2,choppy=2},
		{"mallorn_pillar.png"},
		"mallorn_pillar",
		"mallorn_pillar"
)

-- mallorn White

minetest.register_node("lottdecoration:mallorn_white", {
	description = "White mallorn",
	tiles = {"mallorn_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2},
})

stairs.register_stair_and_slab("mallorn_white", "lottdecoration:mallorn_white",
		{snappy=2,choppy=2},
		{"mallorn_pillar.png"},
		"mallorn_white",
		"mallorn_white"
)

-- DWARFSTONE
-- white

minetest.register_node("lottdecoration:dwarfstone_white", {
	description = "White dwarf stone",
	tiles = {"dwarfstone_white_top.png", "dwarfstone_white_top.png", "dwarfstone_white_side.png", "dwarfstone_white_side.png", "dwarfstone_white_side.png", "dwarfstone_white_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

stairs.register_stair_and_slab("dwarfstone_white", "lottdecoration:dwarfstone_white",
		{cracky=2},
		{"dwarfstone_white_top.png"},
		"dwarfstone_white",
		"dwarfstone_white"
)

-- black

minetest.register_node("lottdecoration:dwarfstone_black", {
	description = "Black dwarf stone",
	tiles = {"dwarfstone_black_top.png", "dwarfstone_black_top.png", "dwarfstone_black_side.png", "dwarfstone_black_side.png", "dwarfstone_black_side.png", "dwarfstone_black_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

stairs.register_stair_and_slab("dwarfstone_black", "lottdecoration:dwarfstone_black",
		{cracky=2},
		{"dwarfstone_black_top.png"},
		"dwarfstone_black",
		"dwarfstone_black"
)

-- stripe

minetest.register_node("lottdecoration:dwarfstone_stripe", {
	description = "Stripe dwarf stone",
	tiles = {"dwarfstone_stripe_top.png", "dwarfstone_stripe_bottom.png", "dwarfstone_stripe_l.png", "dwarfstone_stripe_l.png", "dwarfstone_stripe_r.png", "dwarfstone_stripe_r.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

--------------
--- Crafts ---
--------------

--TREES
-- vine

minetest.register_craft({
	output = 'lottdecoration:tree_vine 4',
	recipe = {
		{'default:tree', 'default:grass_1'},
		{'default:grass_1', 'default:tree'},
	}
})

-- mossy tree

minetest.register_craft({
	output = 'lottdecoration:tree_mossy 4',
	recipe = {
		{'default:grass_1', 'default:grass_1', 'default:grass_1'},
		{'default:grass_1', 'default:tree', 'default:grass_1'},
		{'default:grass_1', 'default:grass_1', 'default:grass_1'},
	}
})

-- leafroof dark


minetest.register_craft({
	output = 'lottdecoration:leafroof_dark',
	recipe = {
		{'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves'},
	}
})

-- MALLORN
-- leafroof mallorn

minetest.register_craft({
	output = 'lottdecoration:leafroof_mallorn',
	recipe = {
		{'lottplants:mallornleaf', 'lottplants:mallornleaf'},
		{'lottplants:mallornleaf', 'lottplants:mallornleaf'},
	}
})

-- White mallorn

minetest.register_craft({
	output = 'lottdecoration:mallorn_white',
	recipe = {
		{'dye:white'},
		{'lottplants:mallornwood'},
	}
})

-- Mallorn pillar

minetest.register_craft({
	output = 'lottdecoration:mallorn_pillar',
	recipe = {
		{'lottplants:mallorntree', 'default:gold_ingot'},
		{'default:gold_ingot', 'lottplants:mallorntree'},
	}
})

-- DWARFSTONE
-- white

minetest.register_craft({
	output = 'lottdecoration:dwarfstone_white 4',
	recipe = {
		{'default:steel_ingot', 'default:stone', 'default:steel_ingot'},
		{'default:stone', 'default:steel_ingot', 'default:stone'},
		{'default:steel_ingot', 'default:stone', 'default:steel_ingot'},
	}
})

-- black

minetest.register_craft({
	output = 'lottdecoration:dwarfstone_black 4',
	recipe = {
		{'default:coal_lump', 'default:stone', 'default:coal_lump'},
		{'default:stone', 'default:coal_lump', 'default:stone'},
		{'default:coal_lump', 'default:stone', 'default:coal_lump'},
	}
})

-- stripe

minetest.register_craft({
	output = 'lottdecoration:dwarfstone_stripe 4',
	recipe = {
		{'default:stone', 'default:coal_lump'},
		{'default:stone', 'default:coal_lump'},
	}
})
