-- Ores

minetest.register_node("lottores:rough_rock", {
	description = "Rough Rock",
	tiles = {"default_stone.png^lottores_rough_rock.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'lottores:rough_rock_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:silver_ore", {
	description = "Silver Ore",
	tiles = {"default_stone.png^lottores_silver_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'lottores:silver_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:tin_ore", {
	description = "Tin Ore",
	tiles = {"default_stone.png^lottores_tin_ore.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = "lottores:tin_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:limestone", {
	description = "Limestone",
	tiles = {"lottores_limestone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_alias("lottores:limestone_ore", "lottores:limestone")
minetest.register_alias("lottores:limestone_lump", "lottores:limestone")

minetest.register_node("lottores:lead_ore", {
	description = "Lead Ore",
	tiles = {"default_stone.png^lottores_lead_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "lottores:lead_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:mithril_ore", {
	description = "Mithril Ore",
	tiles = {"default_stone.png^lottores_mithril_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = "lottores:mithril_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:orc_ore", {
	description = "Ore Iron Ore",
	tiles = {"lottmapgen_mordor_stone.png^default_mineral_iron.png^[colorize:#00000055"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "lottores:orc_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:mineral_pearl", {
	description = "Pearl Ore",
	tiles = {"default_sand.png^lottores_mineral_pearl.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	drop = {
		items = {
			{
				items = {'lottores:pearl'},
			},
			{
				items = {'default:sand'},
			}
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("lottores:mineral_salt", {
	description = "Salt Mineral",
	tiles = {"default_dirt.png^lottores_mineral_salt.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	drop = {
		items = {
			{
				items = {'lottores:salt'},
			},
			{
				items = {'default:dirt'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults(),
})

-- Craft Items

minetest.register_craftitem("lottores:rough_rock_lump", {
	description = "Rough Rock Lump",
	inventory_image = "lottores_rough_rock_lump.png",
})

minetest.register_craftitem("lottores:silver_lump", {
	description = "Silver Lump",
	inventory_image = "lottores_silver_lump.png",
})

minetest.register_craftitem("lottores:silver_ingot", {
	description = "Silver Ingot",
	inventory_image = "lottores_silver_ingot.png",
})

minetest.register_craftitem("lottores:tin_lump", {
	description = "Tin Lump",
	inventory_image = "lottores_tin_lump.png",
})

minetest.register_craftitem("lottores:tin_ingot", {
	description = "Tin Ingot",
	inventory_image = "lottores_tin_ingot.png",
})

minetest.register_craftitem("lottores:lead_lump", {
	description = "Lead Lump",
	inventory_image = "lottores_lead_lump.png",
})

minetest.register_craftitem("lottores:lead_ingot", {
	description = "Lead Ingot",
	inventory_image = "lottores_lead_ingot.png",
})

minetest.register_craftitem("lottores:mithril_lump", {
	description = "Mithril Lump",
	inventory_image = "lottores_mithril_lump.png",
})

minetest.register_craftitem("lottores:mithril_ingot", {
	description = "Mithril Ingot",
	inventory_image = "lottores_mithril_ingot.png",
})

minetest.register_craftitem("lottores:galvorn_ingot", {
	description = "Galvorn Ingot",
	inventory_image = "lottores_galvorn_ingot.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottores:tilkal_ingot", {
	description = "Tilkal Ingot",
	inventory_image = "lottores_tilkal_ingot.png",
    groups = {forbidden=1},
})

minetest.register_craftitem("lottores:orc_lump", {
	description = "Orc Iron Lump",
	inventory_image = "default_iron_lump.png^[colorize:#00000055",
})

minetest.register_craftitem("lottores:orc_steel_ingot", {
	description = "Orc Steel Ingot",
	inventory_image = "default_steel_ingot.png^[colorize:#00000055",
})

minetest.register_craftitem("lottores:pearl", {
	description = "Pearl",
	inventory_image = "lottores_pearl.png",
})

-- Nodes

minetest.register_node("lottores:tilkal", {
	description = "Tilkal",
	tiles = {"lottores_tilkal.png"},
	sounds = default.node_sound_defaults(),
	groups = {forbidden=1, very_hard = 1, creative = 1},
})

minetest.register_node("lottores:marble", {
	description = "Marble",
	tiles = {"lottores_marble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:silver_block", {
	description = "Silver Block",
	tiles = {"lottores_silver_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:tin_block", {
	description = "Tin Block",
	tiles = {"lottores_tin_block.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:lead_block", {
	description = "Lead Block",
	tiles = {"lottores_lead_block.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:mithril_block", {
	description = "Mithril Block",
	tiles = {"lottores_mithril_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:galvorn_block", {
	description = "Galvorn Block",
	tiles = {"lottores_galvorn_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2,forbidden=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:salt", {
	description = "Salt",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottores_salt.png"},
	inventory_image = "lottores_salt.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=1},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_defaults(),
})

minetest.register_node( "lottores:pearl_block", {
	description = "Pearl Block",
	tiles = { "default_sand.png^lottores_pearl_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    sounds = default.node_sound_glass_defaults(),
})

minetest.register_node( "lottores:salt_block", {
	description = "Salt Block",
	tiles = { "default_clay.png^lottores_salt_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	on_use = minetest.item_eat(9),
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:geodes_crystal_1", {
	description = "Geodes Crystal",
	drawtype = "nodebox",
	tiles = {"lottores_geodes_crystal.png"},
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
		local stack = ItemStack("lottores:geodes_crystal_"..math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("lottores:geodes_crystal_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
})

minetest.register_node("lottores:geodes_crystal_2", {
	drawtype = "nodebox",
	tiles = {"lottores_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "lottores:geodes_crystal_1",
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

minetest.register_node("lottores:geodes_crystal_3", {
	drawtype = "nodebox",
	tiles = {"lottores_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "lottores:geodes_crystal_1",
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

minetest.register_node("lottores:geodes_crystal_4", {
	drawtype = "nodebox",
	tiles = {"lottores_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "lottores:geodes_crystal_1",
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

minetest.register_node("lottores:geodes_crystal_5", {
	drawtype = "nodebox",
	tiles = {"lottores_geodes_crystal.png"},
     paramtype = "light",
	sunlight_propagates = true,
     light_source = 8,
     alpha = 200,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
     drop = "lottores:geodes_crystal_1",
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


dofile(minetest.get_modpath("lottores") .. "/mapgen.lua")
dofile(minetest.get_modpath("lottores") .. "/tools.lua")
dofile(minetest.get_modpath("lottores") .. "/ithildin.lua")
dofile(minetest.get_modpath("lottores") .. "/stairs.lua")
dofile(minetest.get_modpath("lottores") .. "/crafting.lua")
