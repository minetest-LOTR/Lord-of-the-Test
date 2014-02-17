--Blocks

minetest.register_node("lottseaores:mineral_pearl", {
	description = "Pearl Ore",
	tiles = {"default_sand.png^lottseaores_mineral_pearl.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

	drop = {
		items = {
			{
				items = {'lottseaores:pearl'},
			},
			{
				items = {'default:sand'},
			}
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("lottseaores:mineral_salt", {
	description = "Salt Mineral",
	tiles = {"default_sand.png^lottseaores_mineral_salt.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

	drop = {
		items = {
			{
				items = {'lottseaores:salt'},
			},
			{
				items = {'default:dirt'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults,
})

minetest.register_node( "lottseaores:pearl_block", {
	description = "Pearl Block",
    alpha = 200,
	tile_images = { "default_sand.png^lottseaores_pearl_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

        sounds = default.node_sound_glass_defaults(),

	drop = 'node "lottseaores:pearl" 9',
})

minetest.register_node( "lottseaores:salt_block", {
	description = "Salt Block",
	tile_images = { "default_clay.png^lottseaores_salt_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

	on_use = minetest.item_eat(8),
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "lottseaores:salt" 9',
})

minetest.register_node("lottseaores:salt", {
	description = "Salt",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottseaores_salt.png"},
	inventory_image = "lottseaores_salt.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=1},
	on_use = minetest.item_eat(8),
	sounds = default.node_sound_defaults(),
})

-- Craft items

minetest.register_craftitem("lottseaores:pearl", {
	description = "Pearl",
	inventory_image = "lottseaores_pearl.png",
})	

-- Crafting

minetest.register_craft( {
        output = 'node "lottseaores:salt_block" 1',
	recipe = {
		{ 'craft "lottseaores:salt"', 'craft "lottseaores:salt"', 'craft "lottseaores:salt"' },
		{ 'craft "lottseaores:salt"', 'craft "lottseaores:salt"', 'craft "lottseaores:salt"' },
		{ 'craft "lottseaores:salt"', 'craft "lottseaores:salt"', 'craft "lottseaores:salt"' },
	}
})

minetest.register_craft( {
	output = 'node "lottseaores:pearl_block" 1',
	recipe = {
		{ 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"' },
		{ 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"' },
		{ 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"' },
	}
})

stairs.register_stair_and_slab("pearl", "lottseaores:pearl_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"lottseaores_pearl_block.png"},
		"Pearl Stair",
		"Pearl Slab",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("salt", "lottseaores:salt_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"lottseaores_salt_block.png"},
		"Salt Stair",
		"Salt Slab",
		default.node_sound_stone_defaults())

-- Ore generation

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottseaores:mineral_salt",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -100,
	height_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottseaores:mineral_salt",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 2,
	clust_size     = 5,
	height_min     = -100,
	height_max     = 20,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottseaores:mineral_pearl",
	wherein        = "default:sand",
	clust_scarcity = 12*12*12,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -100,
	height_max     = 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottseaores:mineral_pearl",
	wherein        = "default:sand",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 5,
	height_min     = -100,
	height_max     = 20,
	flags          = "absheight",
})
