--Thanks for all the things in this file, and the related textures goes to catninja!--

-------------
--- Items ---
-------------

-- TREES
-- Vine tree

minetest.register_node("curwe:tree_vine", {
	description = "Tree With Vines",
	tiles = {"curwe_tree_vine_top.png", "curwe_tree_vine_top.png", "curwe_tree_vine.png", "curwe_tree_vine.png", "curwe_tree_vine.png", "curwe_tree_vine.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2,snappy=2},
})

stairs.register_stair_and_slab("tree_vine", "curwe:tree_vine",
		{choppy=2,snappy=2},
		{"curwe_tree_vine.png"},
		"tree_vine",
		"tree_vine"
)

-- Mossy tree

minetest.register_node("curwe:tree_mossy", {
	description = "Tree With Moss",
	tiles = {"curwe_tree_mossy_top.png", "curwe_tree_mossy_top.png", "curwe_tree_mossy.png", "curwe_tree_mossy.png", "curwe_tree_mossy.png", "curwe_tree_mossy.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2},
})

stairs.register_stair_and_slab("tree_mossy", "curwe:tree_mossy",
		{choppy=2},
		{"curwe_tree_mossy.png"},
		"tree_mossy",
		"tree_mossy"
)

-- Leafroof dark

minetest.register_node("curwe:leafroof_dark", {
	description = "Dark Leaf Roof",
	tiles = {"curwe_leafroof.png"},
	paramtype = "light",
	drawtype = "allfaces_optional",
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=2,oddly_breakable_by_hand=2,leaves=1},
})

stairs.register_stair_and_slab("leafroof_dark", "curwe:leafroof_dark",
		{oddly_breakable_by_hand=2,leaves=1},
		{"curwe_leafroof.png"},
		"leafroof_dark",
		"leafroof_dark"
)


-- MALLORN
-- Leafroof mallorn

minetest.register_node("curwe:leafroof_mallorn", {
	description = "Mallorn Leaf Roof",
	tiles = {"curwe_mallornroof.png"},
	paramtype = "light",
	drawtype = "allfaces_optional",
	is_ground_content = false,
	sounds = default.node_sound_leaves_defaults(),
	grups = {oddly_breakable_by_hand=2,leaves=1},
})

stairs.register_stair_and_slab("leafroof_mallorn", "curwe:leafroof_mallorn",
		{oddly_breakable_by_hand=2,leaves=1},
		{"curwe_mallornroof.png"},
		"leafroof_mallorn",
		"leafroof_mallorn"
)

-- mallorn pillar

minetest.register_node("curwe:mallorn_pillar", {
	description = "Mallorn Pillar",
	tiles = {"curwe_mallorn_pillar.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2},
})

stairs.register_stair_and_slab("mallorn_pillar", "curwe:mallorn_pillar",
		{snappy=2,choppy=2},
		{"curwe_mallorn_pillar.png"},
		"mallorn_pillar",
		"mallorn_pillar"
)

-- mallorn White

minetest.register_node("curwe:mallorn_white", {
	description = "White Mallorn",
	tiles = {"curwe_mallorn_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2},
})

stairs.register_stair_and_slab("mallorn_white", "curwe:mallorn_white",
		{snappy=2,choppy=2},
		{"curwe_mallorn_white.png"},
		"mallorn_white",
		"mallorn_white"
)

-- DWARFSTONE
-- white

minetest.register_node("curwe:dwarfstone_white", {
	description = "White Dwarf Stone",
	tiles = {"curwe_dwarfstone_white_top.png", "curwe_dwarfstone_white_top.png", "curwe_dwarfstone_white_side.png", "curwe_dwarfstone_white_side.png", "curwe_dwarfstone_white_side.png", "curwe_dwarfstone_white_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

stairs.register_stair_and_slab("dwarfstone_white", "curwe:dwarfstone_white",
		{cracky=2},
		{"curwe_dwarfstone_white_top.png"},
		"dwarfstone_white",
		"dwarfstone_white"
)

-- black

minetest.register_node("curwe:dwarfstone_black", {
	description = "Black Dwarf Stone",
	tiles = {"curwe_dwarfstone_black_top.png", "curwe_dwarfstone_black_top.png", "curwe_dwarfstone_black_side.png", "curwe_dwarfstone_black_side.png", "curwe_dwarfstone_black_side.png", "curwe_dwarfstone_black_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=3},
})

stairs.register_stair_and_slab("dwarfstone_black", "curwe:dwarfstone_black",
		{cracky=2},
		{"curwe_dwarfstone_black_top.png"},
		"dwarfstone_black",
		"dwarfstone_black"
)

-- stripe

minetest.register_node("curwe:dwarfstone_stripe", {
	description = "Stripe Dwarf Stone",
	tiles = {"curwe_dwarfstone_stripe_top.png", "curwe_dwarfstone_stripe_bottom.png", "curwe_dwarfstone_stripe_l.png", "curwe_dwarfstone_stripe_l.png", "curwe_dwarfstone_stripe_r.png", "curwe_dwarfstone_stripe_r.png"},
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
	output = 'curwe:tree_vine 4',
	recipe = {
		{'default:tree', 'default:grass_1'},
		{'default:grass_1', 'default:tree'},
	}
})

-- mossy tree

minetest.register_craft({
	output = 'curwe:tree_mossy 4',
	recipe = {
		{'default:grass_1', 'default:grass_1', 'default:grass_1'},
		{'default:grass_1', 'default:tree', 'default:grass_1'},
		{'default:grass_1', 'default:grass_1', 'default:grass_1'},
	}
})

-- leafroof dark


minetest.register_craft({
	output = 'curwe:leafroof_dark',
	recipe = {
		{'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves'},
	}
})

-- MALLORN
-- leafroof mallorn

minetest.register_craft({
	output = 'curwe:leafroof_mallorn',
	recipe = {
		{'olvar:mallornleaf', 'olvar:mallornleaf'},
		{'olvar:mallornleaf', 'olvar:mallornleaf'},
	}
})

-- White mallorn

minetest.register_craft({
	output = 'curwe:mallorn_white',
	recipe = {
		{'dye:white'},
		{'olvar:mallornwood'},
	}
})

-- Mallorn pillar

minetest.register_craft({
	output = 'curwe:mallorn_pillar',
	recipe = {
		{'olvar:mallorntree', 'default:gold_ingot'},
		{'default:gold_ingot', 'olvar:mallorntree'},
	}
})

-- DWARFSTONE
-- white

minetest.register_craft({
	output = 'curwe:dwarfstone_white 4',
	recipe = {
		{'default:steel_ingot', 'default:stone', 'default:steel_ingot'},
		{'default:stone', 'default:steel_ingot', 'default:stone'},
		{'default:steel_ingot', 'default:stone', 'default:steel_ingot'},
	}
})

-- black

minetest.register_craft({
	output = 'curwe:dwarfstone_black 4',
	recipe = {
		{'default:coal_lump', 'default:stone', 'default:coal_lump'},
		{'default:stone', 'default:coal_lump', 'default:stone'},
		{'default:coal_lump', 'default:stone', 'default:coal_lump'},
	}
})

-- stripe

minetest.register_craft({
	output = 'curwe:dwarfstone_stripe 4',
	recipe = {
		{'default:stone', 'default:coal_lump'},
		{'default:stone', 'default:coal_lump'},
	}
})
