-- Ores:

minetest.register_node("cemen:limestone_ore", {
	description = "Limestone Ore",
	tiles = {"default_stone.png^cemen_limestone_ore.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'cemen:limestone_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:rough_rock", {
	description = "Rough Rock",
	tiles = {"default_stone.png^cemen_rough_rock.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'cemen:rough_rock_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:silver_ore", {
	description = "Silver Ore",
	tiles = {"default_stone.png^cemen_silver_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'cemen:silver_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:tin_ore", {
	description = "Tin Ore",
	tiles = {"default_stone.png^cemen_tin_ore.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = "cemen:tin_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:lead_ore", {
	description = "Lead Ore",
	tiles = {"default_stone.png^cemen_lead_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "cemen:lead_lump",
	sounds = default.node_sound_stone_defaults(),
})
	
minetest.register_node("cemen:mithril_ore", {
	description = "Mithril Ore",
	tiles = {"default_stone.png^cemen_mithril_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = "cemen:mithril_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:blue_gem_ore", {
	description = "Blue Gem Ore",
	tiles = {"default_stone.png^cemen_bluegem_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = {
		items = {
			{
				items = {'cemen:blue_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:white_gem_ore", {
	description = "White Gem Ore",
	tiles = {"default_stone.png^cemen_whitegem_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = {
		items = {
			{
				items = {'cemen:white_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:red_gem_ore", {
	description = "Red Gem Ore",
	tiles = {"default_stone.png^cemen_redgem_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = {
		items = {
			{
				items = {'cemen:red_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:mineral_pearl", {
	description = "Pearl Ore",
	tiles = {"default_sand.png^cemen_mineral_pearl.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	drop = {
		items = {
			{
				items = {'cemen:pearl'},
			},
			{
				items = {'default:sand'},
			}
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("cemen:mineral_salt", {
	description = "Salt Mineral",
	tiles = {"default_dirt.png^cemen_mineral_salt.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	drop = {
		items = {
			{
				items = {'cemen:salt'},
			},
			{
				items = {'default:dirt'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults,
})

-- Craft Items

minetest.register_craftitem("cemen:limestone_lump", {
	description = "Limestone Lump",
	inventory_image = "cemen_limestone_lump.png",
})

minetest.register_craftitem("cemen:rough_rock_lump", {
	description = "Rough Rock Lump",
	inventory_image = "cemen_rough_rock_lump.png",
})

minetest.register_craftitem("cemen:silver_lump", {
	description = "Silver Lump",
	inventory_image = "cemen_silver_lump.png",
})

minetest.register_craftitem("cemen:silver_ingot", {
	description = "Silver Ingot",
	inventory_image = "cemen_silver_ingot.png",
})

minetest.register_craftitem("cemen:tin_lump", {
	description = "Tin Lump",
	inventory_image = "cemen_tin_lump.png",
})

minetest.register_craftitem("cemen:tin_ingot", {
	description = "Tin Ingot",
	inventory_image = "cemen_tin_ingot.png",
})

minetest.register_craftitem("cemen:lead_lump", {
	description = "Lead Lump",
	inventory_image = "cemen_lead_lump.png",
})

minetest.register_craftitem("cemen:lead_ingot", {
	description = "Lead Ingot",
	inventory_image = "cemen_lead_ingot.png",
})

minetest.register_craftitem("cemen:mithril_lump", {
	description = "Mithril Lump",
	inventory_image = "cemen_mithril_lump.png",
})

minetest.register_craftitem("cemen:mithril_ingot", {
	description = "Mithril Ingot",
	inventory_image = "cemen_mithril_ingot.png",
})

minetest.register_craftitem("cemen:galvorn_ingot", {
	description = "Galvorn Ingot",
	inventory_image = "cemen_galvorn_ingot.png",
     groups = {forbidden=1},
})

minetest.register_craftitem("cemen:tilkal_ingot", {
	description = "Tilkal Ingot",
	inventory_image = "cemen_tilkal_ingot.png",
     groups = {forbidden=1},
})

minetest.register_craftitem("cemen:blue_gem", {
	description = "Blue Gem",
	inventory_image = "cemen_bluegem.png",
})

minetest.register_craftitem("cemen:red_gem", {
	description = "Red Gem",
	inventory_image = "cemen_redgem.png",
})

minetest.register_craftitem("cemen:white_gem", {
	description = "White Gem",
	inventory_image = "cemen_whitegem.png",
})

minetest.register_craftitem("cemen:pearl", {
	description = "Pearl",
	inventory_image = "cemen_pearl.png",
})

-- Nodes

minetest.register_node("cemen:tilkal", {
	description = "Tilkal",
	tiles = {"cemen_tilkal.png"},
	sounds = default.node_sound_defaults(),
	groups = {forbidden=1},
})

minetest.register_node("cemen:limestone", {
	description = "Limestone",
	tiles = {"cemen_limestone_ore.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:marble", {
	description = "Marble",
	tiles = {"cemen_marble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:geodes_crystal_1", {
	description = "Geodes Crystal",
	drawtype = "nodebox",
	tiles = {"cemen_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
     node_box = {
        type = "fixed",
        fixed = {
            {-0.1875,-0.5,-0.125,0.1875,0.3125,0.1875},
            {0.0625,-0.5,-0.25,0.3125,0,0},
            {0.0625,-0.5,0.1875,0.25,0.1875,0.375},
            {-0.3125,-0.5,-0.3125,-0.0625,0.0625,0},
            {-0.375,-0.5,0.0625,-0.125,-0.0625,0.3125},
        }
    },
     on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("cemen:geodes_crystal_"..math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cemen:geodes_crystal_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
})

minetest.register_node("cemen:geodes_crystal_2", {
	drawtype = "nodebox",
	tiles = {"cemen_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "cemen:geodes_crystal_1",
     node_box = {
        type = "fixed",
        fixed = {
            {-0.1875,-0.5,-0.125,0.1875,0.5,0.1875},
            {0.1875,-0.5,-0.25,0.5,0.1875,0},
            {0.0625,-0.5,0.1875,0.375,0.375,0.375},
            {-0.375,-0.5,-0.3125,-0.0625,0.25,0},
            {-0.5,-0.5,-0.0625,-0.125,0,0.3125},
            {0,-0.5,-0.5,0.3125,-0.0625,-0.1875},
        }
    }
})

minetest.register_node("cemen:geodes_crystal_3", {
	drawtype = "nodebox",
	tiles = {"cemen_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "cemen:geodes_crystal_1",
     node_box = {
        type = "fixed",
        fixed = {
            {-0.125,-0.5,-0.25,0.25,0.5,0.1875},
            {-0.125,-0.5,-0.4375,0.125,0.25,-0.1875},
            {0,-0.5,-0.125,0.461539,0,0.3125},
            {-0.5,-0.5,0,-0.0625,0.25,0.413465},
            {-0.375,-0.5,-0.25,-0.0625,-0.0625,0.0625},
            {0.1875,-0.5,-0.5,0.5,-0.25,-0.1875},
            {-0.4375,-0.5,-0.5,-0.0625,-0.25,-0.125},
        }
    }
})

minetest.register_node("cemen:geodes_crystal_4", {
	drawtype = "nodebox",
	tiles = {"cemen_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "cemen:geodes_crystal_1",
     node_box = {
        type = "fixed",
        fixed = {
            {0.125,-0.5,-0.25,0.5,-0.125,0.125},
            {-0.125,-0.5,-0.0625,0.1875,0.375,0.3125},
            {0.0625,-0.5,-0.5,0.375,-0.0625,-0.125},
            {-0.3125,-0.5,-0.3125,0,-0.1875,0.0625},
            {-0.0625,-0.5,-0.1875,0.375,0.25,0.125},
            {-0.375,-0.5,0.125,0,0.25,0.5},
        }
    }
})

minetest.register_node("cemen:geodes_crystal_5", {
	drawtype = "nodebox",
	tiles = {"cemen_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "cemen:geodes_crystal_1",
     node_box = {
        type = "fixed",
        fixed = {
            {-0.3125,-0.5,-0.1875,0,0.5,0.125},
            {-0.1875,-0.5,-0.3125,0.1875,0.125,0},
            {-0.25,-0.5,-0.5,0.0625,0.3125,-0.1875},
            {0.0625,-0.5,-0.125,0.375,-0.125,0.1875},
            {0.0625,-0.5,-0.375,0.3125,-0.25,-0.1875},
            {-0.1875,-0.5,0,0.125,0.0625,0.5},
        }
    }
})

minetest.register_node("cemen:silver_block", {
	description = "Silver Block",
	tiles = {"cemen_silver_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:tin_block", {
	description = "Tin Block",
	tiles = {"cemen_tin_block.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:lead_block", {
	description = "Lead Block",
	tiles = {"cemen_lead_block.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:mithril_block", {
	description = "Mithril Block",
	tiles = {"cemen_mithril_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:galvorn_block", {
	description = "Galvorn Block",
	tiles = {"cemen_galvorn_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2,forbidden=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node( "cemen:pearl_block", {
	description = "Pearl Block",
     alpha = 200,
	tile_images = { "default_sand.png^cemen_pearl_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
     sounds = default.node_sound_glass_defaults(),
})

minetest.register_node( "cemen:salt_block", {
	description = "Salt Block",
	tile_images = { "default_clay.png^cemen_salt_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	on_use = minetest.item_eat(9),
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cemen:salt", {
	description = "Salt",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"cemen_salt.png"},
	inventory_image = "cemen_salt.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=1},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_defaults(),
})

-- Stairs & Slabs

stairs.register_stair_and_slab("tilkal", "cemen:tilkal",
        {forbidden=1},
		{"cemen_tilkal.png"},
		"Tilkal Stair",
		"Tilkal Slab",
		default.node_sound_stone_defaults())
		
stairs.register_stair_and_slab("limestone", "cemen:limestone",
        {cracky=3, stone=2},
		{"cemen_limestone_ore.png"},
		"Limestone Stair",
		"Limestone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("marble", "cemen:marble",
        {cracky=3},
		{"cemen_marble.png"},
		"Marble Stair",
		"Marble Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("silver_block", "cemen:silver_block",
        {cracky=1,level=2},
		{"cemen_silver_block.png"},
		"Silver Stair",
		"Silver Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("tin_block", "cemen:tin_block",
        {cracky=1},
		{"cemen_tin_block.png"},
		"Tin Stair",
		"Tin Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("lead_block", "cemen:lead_block",
        {cracky=1},
		{"cemen_lead_block.png"},
		"Lead Stair",
		"Lead Slab",
		default.node_sound_stone_defaults())
	
stairs.register_stair_and_slab("mithril_block", "cemen:mithril_block",
        {cracky=1,level=2},
		{"cemen_mithril_block.png"},
		"Mithril Stair",
		"Mithril Slab",
		default.node_sound_stone_defaults())
	
stairs.register_stair_and_slab("tin_block", "cemen:galvorn_block",
        {cracky=1,level=2,forbidden=1},
		{"cemen_galvorn_block.png"},
		"Galvorn Stair",
		"Galvorn Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("pearl", "cemen:pearl_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"cemen_pearl_block.png"},
		"Pearl Stair",
		"Pearl Slab",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("salt", "cemen:salt_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"cemen_salt_block.png"},
		"Salt Stair",
		"Salt Slab",
		default.node_sound_stone_defaults())
		
dofile(minetest.get_modpath("cemen").."/ores/oregen.lua")
dofile(minetest.get_modpath("cemen").."/ores/crafting.lua")