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

-- Ores Spawning

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -60,
	height_max     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -61,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 15,
	clust_size     = 6,
	height_min     = -31000,
	height_max     = -50,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:silver_ore",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	height_min     = -200,
	height_max     = -50,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:silver_ore",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 6,
	clust_size     = 3,
	height_min     = -31000,
	height_max     = -201,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -60,
	height_max     = -20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 10,
	clust_size     = 5,
	height_min     = -31000,
	height_max     = -61,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -60,
	height_max     = -30,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	height_min     = -31000,
	height_max     = -61,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:rough_rock",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	height_min     = -300,
	height_max     = -70,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:rough_rock",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 3,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -301,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:blue_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -256,
	flags          = "absheight",
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:red_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -256,
	flags          = "absheight",
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:white_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -256,
	flags          = "absheight",
})


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -255,
	height_max     = -128,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "cemen:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -31000,
	height_max     = -256,
	flags          = "absheight",
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

-- Ithildin

minetest.register_node("cemen:ithildin_0", {
	description = "Ithildin",
	tiles = {"ithildin_0.png"},
	drawtype = "glasslike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "cemen:ithildin_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_1", {
	description = "Ithildin",
	tiles = {"ithildin_1.png"},
	inventory_image = {"ithildin_1.png"},
	wield_image = {"ithildin_1.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = false,
	pointable = true,
	sunlight_propagates = true,
	light_source = 8,
	drop = "cemen:ithildin_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_stone_0", {
	description = "Ithildin Stone",
	tiles = {"default_stone.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	drop = "cemen:ithildin_stone_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_stone_1", {
	description = "Ithildin Stone",
	tiles = {"default_stone.png^ithildin_1.png"},
	drawtype = 'glasslike',
	walkable = false,
	pointable = true,
	sunlight_propagates = false,
	light_source = 8,
	drop = "cemen:ithildin_stone_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_stonelamp_0", {
	description = "Ithildin Stonelamp",
	tiles = {"default_stone.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	drop = "cemen:ithildin_stonelamp_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_stonelamp_1", {
	description = "Ithildin Stonelamp",
	tiles = {"default_stone.png^ithildin_lamp_1.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	light_source = 8,
	drop = "cemen:ithildin_stonelamp_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_lamp_0", {
	description = "Ithildin Lamp",
	tiles = {"ithildin_lamp_0.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "cemen:ithildin_lamp_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("cemen:ithildin_lamp_1", {
	description = "Ithildin Lamp",
	tiles = {"ithildin_lamp_1.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = true,
	pointable = true,
	sunlight_propagates = true,
	light_source = 8,
	drop = "cemen:ithildin_lamp_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Functions

minetest.register_abm(
	{nodenames = {"cemen:ithildin_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_stone_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_stone_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_stone_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_stone_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_stonelamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_stonelamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_stonelamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_stonelamp_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_lamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_lamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"cemen:ithildin_lamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="cemen:ithildin_lamp_1"})
		end
	end,
})

-- Tools
-- Pickaxe

minetest.register_tool("cemen:copperpick", {
	description = "Copper Pickaxe",
	inventory_image = "cemen_copperpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:tinpick", {
	description = "Tin Pickaxe",
	inventory_image = "cemen_tinpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:silverpick", {
	description = "Silver Pickaxe",
	inventory_image = "cemen_silverpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:goldpick", {
	description = "Gold Pickaxe",
	inventory_image = "cemen_goldpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:galvornpick", {
	description = "Galvorn Pickaxe",
	inventory_image = "cemen_galvornpick.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})
minetest.register_tool("cemen:mithrilpick", {
	description = "Mithril Pickaxe",
	inventory_image = "cemen_mithrilpick.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.5, [2]=0.8, [3]=0.40}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

-- Axe

minetest.register_tool("cemen:copperaxe", {
	description = "Copper Axe",
	inventory_image = "cemen_copperaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:tinaxe", {
	description = "Tin Axe",
	inventory_image = "cemen_tinaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:silveraxe", {
	description = "Silver Axe",
	inventory_image = "cemen_silveraxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:goldaxe", {
	description = "Gold Axe",
	inventory_image = "cemen_goldaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:galvornaxe", {
	description = "Galvorn Axe",
	inventory_image = "cemen_galvornaxe.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})
minetest.register_tool("cemen:mithrilaxe", {
	description = "Mithril Axe",
	inventory_image = "cemen_mithrilaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.80, [2]=0.60, [3]=0.30}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

-- Sword

minetest.register_tool("cemen:coppersword", {
	description = "Copper Sword",
	inventory_image = "cemen_coppersword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("cemen:tinsword", {
	description = "Tin Sword",
	inventory_image = "cemen_tinsword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("cemen:silversword", {
	description = "Silver Sword",
	inventory_image = "cemen_silversword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("cemen:goldsword", {
	description = "Gold Sword",
	inventory_image = "cemen_goldsword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("cemen:galvornsword", {
	description = "Galvorn Sword",
	inventory_image = "cemen_galvornsword.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})
minetest.register_tool("cemen:mithrilsword", {
	description = "Mithril Sword",
	inventory_image = "cemen_mithrilsword.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.70, [2]=0.80, [3]=0.25}, uses=80, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})

-- Shovel

minetest.register_tool("cemen:coppershovel", {
	description = "Copper Shovel",
	inventory_image = "cemen_coppershovel.png",
	wield_image = "cemen_coppershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("cemen:tinshovel", {
	description = "Tin Shovel",
	inventory_image = "cemen_tinshovel.png",
	wield_image = "cemen_tinshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("cemen:silvershovel", {
	description = "Silver Shovel",
	inventory_image = "cemen_silvershovel.png",
	wield_image = "cemen_silvershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("cemen:goldshovel", {
	description = "Gold Shovel",
	inventory_image = "cemen_goldshovel.png",
	wield_image = "cemen_goldshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("cemen:galvornshovel", {
	description = "Galvorn Shovel",
	inventory_image = "cemen_galvornshovel.png",
	wield_image = "cemen_galvornshovel.png^[transformR90",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("cemen:mithrilshovel", {
	description = "Mithril Shovel",
	inventory_image = "cemen_mithrilshovel.png",
	wield_image = "cemen_mithrilshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.20}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
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
	
-- Crafting

minetest.register_craft({
	output = 'cemen:galvorn_ingot',
	recipe = {
		{'cemen:lead_ingot', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'cemen:tilkal',
	recipe = {
		{'cemen:tilkal_ingot', 'cemen:tilkal_ingot', 'cemen:tilkal_ingot'},
		{'cemen:tilkal_ingot', 'cemen:tilkal_ingot', 'cemen:tilkal_ingot'},
		{'cemen:tilkal_ingot', 'cemen:tilkal_ingot', 'cemen:tilkal_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:tilkal_ingot 9',
	recipe = {
		{'cemen:tilkal'},
	}
})

minetest.register_craft({
	output = 'cemen:tilkal_ingot',
	recipe = {
		{'default:copper_ingot', 'cemen:silver_ingot', 'cemen:tin_ingot'},
		{'cemen:lead_ingot', 'default:steel_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:limestone',
	recipe = {
		{'cemen:limestone_lump', 'cemen:limestone_lump', 'cemen:limestone_lump'},
		{'cemen:limestone_lump', 'cemen:limestone_lump', 'cemen:limestone_lump'},
		{'cemen:limestone_lump', 'cemen:limestone_lump', 'cemen:limestone_lump'},
	}
})

minetest.register_craft({
	output = 'cemen:limestone_lump 9',
	recipe = {
		{'cemen:limestone'},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "cemen:marble",
	recipe = "cemen:limestone",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:geodes_crystal_1",
	recipe = "cemen:rough_rock_lump",
})

minetest.register_craft({
	output = 'cemen:silver_block',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:silver_ingot 9',
	recipe = {
		{'cemen:silver_block'},
	}
})

minetest.register_craft({
	output = 'cemen:tin_block',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:tin_ingot 9',
	recipe = {
		{'cemen:tin_block'},
	}
})

minetest.register_craft({
	output = 'cemen:lead_block',
	recipe = {
		{'cemen:lead_ingot', 'cemen:lead_ingot', 'cemen:lead_ingot'},
		{'cemen:lead_ingot', 'cemen:lead_ingot', 'cemen:lead_ingot'},
		{'cemen:lead_ingot', 'cemen:lead_ingot', 'cemen:lead_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:lead_ingot 9',
	recipe = {
		{'cemen:lead_block'},
	}
})

minetest.register_craft({
	output = 'cemen:mithril_block',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:mithril_ingot 9',
	recipe = {
		{'cemen:mithril_block'},
	}
})

minetest.register_craft({
	output = 'cemen:galvorn_block',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:galvorn_ingot 9',
	recipe = {
		{'cemen:galvorn_block'},
	}
})

minetest.register_craft({
	output = 'cemen:ithildin_1',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:geodes_crystal_1'},
	}
})

minetest.register_craft({
	output = 'cemen:ithildin_stone_1',
	recipe = {
		{'cemen:ithildin_1', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'cemen:ithildin_lamp_1',
	recipe = {
		{'cemen:mithril_ingot', 'lottother:blue_torch'},
	}
})

minetest.register_craft({
	output = 'cemen:ithildin_stonelamp_1',
	recipe = {
		{'cemen:ithildin_lamp_1', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'cemen:copperpick',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'cemen:tinpick',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'cemen:silverpick',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'cemen:goldpick',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'cemen:galvornpick',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'cemen:mithrilpick',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'cemen:copperaxe',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:tinaxe',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:silveraxe',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:goldaxe',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:galvornaxe',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:mithrilaxe',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:silver_ingot",
	recipe = "cemen:silver_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:tin_ingot",
	recipe = "cemen:tin_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:lead_ingot",
	recipe = "cemen:lead_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:mithril_ingot",
	recipe = "cemen:mithril_lump",
})

minetest.register_craft({
	output = 'cemen:coppersword',
	recipe = {
		{'default:copper_ingot'},
		{'default:copper_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:tinsword',
	recipe = {
		{'cemen:tin_ingot'},
		{'cemen:tin_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:silversword',
	recipe = {
		{'cemen:silver_ingot'},
		{'cemen:silver_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:goldsword',
	recipe = {
		{'default:gold_ingot'},
		{'default:gold_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:galvornsword',
	recipe = {
		{'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:mithrilsword',
	recipe = {
		{'cemen:mithril_ingot'},
		{'cemen:mithril_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:coppershovel',
	recipe = {
		{'default:copper_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:tinshovel',
	recipe = {
		{'cemen:tin_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:silvershovel',
	recipe = {
		{'cemen:silver_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:goldshovel',
	recipe = {
		{'default:gold_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:galvornshovel',
	recipe = {
		{'cemen:galvorn_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'cemen:mithrilshovel',
	recipe = {
		{'cemen:mithril_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

--Blocks

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

-- Craft items

minetest.register_craftitem("cemen:pearl", {
	description = "Pearl",
	inventory_image = "cemen_pearl.png",
})	

-- Crafting

minetest.register_craft( {
	output = 'cemen:pearl_block',
	recipe = {
		{ 'craft "cemen:pearl"', 'craft "cemen:pearl"', 'craft "cemen:pearl"' },
		{ 'craft "cemen:pearl"', 'craft "cemen:pearl"', 'craft "cemen:pearl"' },
		{ 'craft "cemen:pearl"', 'craft "cemen:pearl"', 'craft "cemen:pearl"' },
	}
})

minetest.register_craft({
	output = 'cemen:salt_block',
	recipe = {
		{'cemen:salt', 'cemen:salt', 'cemen:salt'},
		{'cemen:salt', 'cemen:salt', 'cemen:salt'},
		{'cemen:salt', 'cemen:salt', 'cemen:salt'},
	}
})

minetest.register_craft({
	output = 'cemen:salt 9',
	recipe = {
		{'cemen:salt_block'},
	}
})

minetest.register_craft({
	output = 'cemen:pearl_block',
	recipe = {
		{'cemen:pearl', 'cemen:pearl', 'cemen:pearl'},
		{'cemen:pearl', 'cemen:pearl', 'cemen:pearl'},
		{'cemen:pearl', 'cemen:pearl', 'cemen:pearl'},
	}
})

minetest.register_craft({
	output = 'cemen:pearl 9',
	recipe = {
		{'cemen:pearl_block'},
	}
})

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
