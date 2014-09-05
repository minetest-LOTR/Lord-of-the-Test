-- Ores:

minetest.register_node("lottores:limestone_ore", {
	description = "Limestone Ore",
	tiles = {"default_stone.png^lottores_limestone_ore.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'lottores:limestone_lump',
	sounds = default.node_sound_stone_defaults(),
})

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

minetest.register_node("lottores:blue_gem_ore", {
	description = "Blue Gem Ore",
	tiles = {"default_stone.png^lottores_bluegem_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = {
		items = {
			{
				items = {'lottores:blue_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:white_gem_ore", {
	description = "White Gem Ore",
	tiles = {"default_stone.png^lottores_whitegem_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = {
		items = {
			{
				items = {'lottores:white_gem'},
				rarity = 5,
			},
			{
				items = {''},
			}
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:red_gem_ore", {
	description = "Red Gem Ore",
	tiles = {"default_stone.png^lottores_redgem_ore.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = {
		items = {
			{
				items = {'lottores:red_gem'},
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
	ore            = "lottores:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -60,
	height_max     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone_ore",
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
	ore            = "lottores:limestone_ore",
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
	ore            = "lottores:silver_ore",
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
	ore            = "lottores:silver_ore",
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
	ore            = "lottores:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -60,
	height_max     = -20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:tin_ore",
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
	ore            = "lottores:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -60,
	height_max     = -30,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:lead_ore",
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
	ore            = "lottores:rough_rock",
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
	ore            = "lottores:rough_rock",
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
	ore            = "lottores:blue_gem_ore",
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
	ore            = "lottores:red_gem_ore",
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
	ore            = "lottores:white_gem_ore",
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
	ore            = "lottores:mithril_ore",
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
	ore            = "lottores:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -31000,
	height_max     = -256,
	flags          = "absheight",
})

-- Craft Items

minetest.register_craftitem("lottores:limestone_lump", {
	description = "Limestone Lump",
	inventory_image = "lottores_limestone_lump.png",
})

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

minetest.register_craftitem("lottores:blue_gem", {
	description = "Blue Gem",
	inventory_image = "lottores_bluegem.png",
})

minetest.register_craftitem("lottores:red_gem", {
	description = "Red Gem",
	inventory_image = "lottores_redgem.png",
})

minetest.register_craftitem("lottores:white_gem", {
	description = "White Gem",
	inventory_image = "lottores_whitegem.png",
})

-- Nodes

minetest.register_node("lottores:tilkal", {
	description = "Tilkal",
	tiles = {"lottores_tilkal.png"},
	sounds = default.node_sound_defaults(),
	groups = {forbidden=1},
})

minetest.register_node("lottores:limestone", {
	description = "Limestone",
	tiles = {"lottores_limestone_ore.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottores:marble", {
	description = "Marble",
	tiles = {"lottores_marble.png"},
	is_ground_content = true,
	groups = {cracky=3},
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

-- Ithildin

minetest.register_node("lottores:ithildin_0", {
	description = "Ithildin",
	tiles = {"ithildin_0.png"},
	drawtype = "glasslike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "lottores:ithildin_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_1", {
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
	drop = "lottores:ithildin_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_stone_0", {
	description = "Ithildin Stone",
	tiles = {"default_stone.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	drop = "lottores:ithildin_stone_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_stone_1", {
	description = "Ithildin Stone",
	tiles = {"default_stone.png^ithildin_1.png"},
	drawtype = 'glasslike',
	walkable = false,
	pointable = true,
	sunlight_propagates = false,
	light_source = 8,
	drop = "lottores:ithildin_stone_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_stonelamp_0", {
	description = "Ithildin Stonelamp",
	tiles = {"default_stone.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	drop = "lottores:ithildin_stonelamp_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_stonelamp_1", {
	description = "Ithildin Stonelamp",
	tiles = {"default_stone.png^ithildin_lamp_1.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	light_source = 8,
	drop = "lottores:ithildin_stonelamp_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_lamp_0", {
	description = "Ithildin Lamp",
	tiles = {"ithildin_lamp_0.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "lottores:ithildin_lamp_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottores:ithildin_lamp_1", {
	description = "Ithildin Lamp",
	tiles = {"ithildin_lamp_1.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = true,
	pointable = true,
	sunlight_propagates = true,
	light_source = 8,
	drop = "lottores:ithildin_lamp_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Functions

minetest.register_abm(
	{nodenames = {"lottores:ithildin_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stone_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_stone_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stone_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_stone_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stonelamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_stonelamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stonelamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_stonelamp_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_lamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_lamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_lamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="lottores:ithildin_lamp_1"})
		end
	end,
})

-- Tools
-- Pickaxe

minetest.register_tool("lottores:copperpick", {
	description = "Copper Pickaxe",
	inventory_image = "lottores_copperpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:tinpick", {
	description = "Tin Pickaxe",
	inventory_image = "lottores_tinpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:silverpick", {
	description = "Silver Pickaxe",
	inventory_image = "lottores_silverpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:goldpick", {
	description = "Gold Pickaxe",
	inventory_image = "lottores_goldpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:galvornpick", {
	description = "Galvorn Pickaxe",
	inventory_image = "lottores_galvornpick.png",
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
minetest.register_tool("lottores:mithrilpick", {
	description = "Mithril Pickaxe",
	inventory_image = "lottores_mithrilpick.png",
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

minetest.register_tool("lottores:copperaxe", {
	description = "Copper Axe",
	inventory_image = "lottores_copperaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:tinaxe", {
	description = "Tin Axe",
	inventory_image = "lottores_tinaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:silveraxe", {
	description = "Silver Axe",
	inventory_image = "lottores_silveraxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:goldaxe", {
	description = "Gold Axe",
	inventory_image = "lottores_goldaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("lottores:galvornaxe", {
	description = "Galvorn Axe",
	inventory_image = "lottores_galvornaxe.png",
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
minetest.register_tool("lottores:mithrilaxe", {
	description = "Mithril Axe",
	inventory_image = "lottores_mithrilaxe.png",
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

minetest.register_tool("lottores:coppersword", {
	description = "Copper Sword",
	inventory_image = "lottores_coppersword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("lottores:tinsword", {
	description = "Tin Sword",
	inventory_image = "lottores_tinsword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("lottores:silversword", {
	description = "Silver Sword",
	inventory_image = "lottores_silversword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("lottores:goldsword", {
	description = "Gold Sword",
	inventory_image = "lottores_goldsword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("lottores:galvornsword", {
	description = "Galvorn Sword",
	inventory_image = "lottores_galvornsword.png",
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
minetest.register_tool("lottores:mithrilsword", {
	description = "Mithril Sword",
	inventory_image = "lottores_mithrilsword.png",
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

minetest.register_tool("lottores:coppershovel", {
	description = "Copper Shovel",
	inventory_image = "lottores_coppershovel.png",
	wield_image = "lottores_coppershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("lottores:tinshovel", {
	description = "Tin Shovel",
	inventory_image = "lottores_tinshovel.png",
	wield_image = "lottores_tinshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("lottores:silvershovel", {
	description = "Silver Shovel",
	inventory_image = "lottores_silvershovel.png",
	wield_image = "lottores_silvershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("lottores:goldshovel", {
	description = "Gold Shovel",
	inventory_image = "lottores_goldshovel.png",
	wield_image = "lottores_goldshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("lottores:galvornshovel", {
	description = "Galvorn Shovel",
	inventory_image = "lottores_galvornshovel.png",
	wield_image = "lottores_galvornshovel.png^[transformR90",
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
minetest.register_tool("lottores:mithrilshovel", {
	description = "Mithril Shovel",
	inventory_image = "lottores_mithrilshovel.png",
	wield_image = "lottores_mithrilshovel.png^[transformR90",
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

stairs.register_stair_and_slab("tilkal", "lottores:tilkal",
        {forbidden=1},
		{"lottores_tilkal.png"},
		"Tilkal Stair",
		"Tilkal Slab",
		default.node_sound_stone_defaults())
		
stairs.register_stair_and_slab("limestone", "lottores:limestone",
        {cracky=3, stone=2},
		{"lottores_limestone_ore.png"},
		"Limestone Stair",
		"Limestone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("marble", "lottores:marble",
        {cracky=3},
		{"lottores_marble.png"},
		"Marble Stair",
		"Marble Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("silver_block", "lottores:silver_block",
        {cracky=1,level=2},
		{"lottores_silver_block.png"},
		"Silver Stair",
		"Silver Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("tin_block", "lottores:tin_block",
        {cracky=1},
		{"lottores_tin_block.png"},
		"Tin Stair",
		"Tin Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("lead_block", "lottores:lead_block",
        {cracky=1},
		{"lottores_lead_block.png"},
		"Lead Stair",
		"Lead Slab",
		default.node_sound_stone_defaults())
	
stairs.register_stair_and_slab("mithril_block", "lottores:mithril_block",
        {cracky=1,level=2},
		{"lottores_mithril_block.png"},
		"Mithril Stair",
		"Mithril Slab",
		default.node_sound_stone_defaults())
	
stairs.register_stair_and_slab("tin_block", "lottores:galvorn_block",
        {cracky=1,level=2,forbidden=1},
		{"lottores_galvorn_block.png"},
		"Galvorn Stair",
		"Galvorn Slab",
		default.node_sound_stone_defaults())
	
-- Crafting

minetest.register_craft({
	output = 'lottores:galvorn_ingot',
	recipe = {
		{'lottores:lead_ingot', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'lottores:tilkal',
	recipe = {
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:tilkal_ingot 9',
	recipe = {
		{'lottores:tilkal'},
	}
})

minetest.register_craft({
	output = 'lottores:tilkal_ingot',
	recipe = {
		{'default:copper_ingot', 'lottores:silver_ingot', 'lottores:tin_ingot'},
		{'lottores:lead_ingot', 'default:steel_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:limestone',
	recipe = {
		{'lottores:limestone_lump', 'lottores:limestone_lump', 'lottores:limestone_lump'},
		{'lottores:limestone_lump', 'lottores:limestone_lump', 'lottores:limestone_lump'},
		{'lottores:limestone_lump', 'lottores:limestone_lump', 'lottores:limestone_lump'},
	}
})

minetest.register_craft({
	output = 'lottores:limestone_lump 9',
	recipe = {
		{'lottores:limestone'},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "lottores:marble",
	recipe = "lottores:limestone",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:geodes_crystal_1",
	recipe = "lottores:rough_rock_lump",
})

minetest.register_craft({
	output = 'lottores:silver_block',
	recipe = {
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:silver_ingot 9',
	recipe = {
		{'lottores:silver_block'},
	}
})

minetest.register_craft({
	output = 'lottores:tin_block',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:tin_ingot 9',
	recipe = {
		{'lottores:tin_block'},
	}
})

minetest.register_craft({
	output = 'lottores:lead_block',
	recipe = {
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:lead_ingot 9',
	recipe = {
		{'lottores:lead_block'},
	}
})

minetest.register_craft({
	output = 'lottores:mithril_block',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:mithril_ingot 9',
	recipe = {
		{'lottores:mithril_block'},
	}
})

minetest.register_craft({
	output = 'lottores:galvorn_block',
	recipe = {
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:galvorn_ingot 9',
	recipe = {
		{'lottores:galvorn_block'},
	}
})

minetest.register_craft({
	output = 'lottores:ithildin_1',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:geodes_crystal_1'},
	}
})

minetest.register_craft({
	output = 'lottores:ithildin_stone_1',
	recipe = {
		{'lottores:ithildin_1', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'lottores:ithildin_lamp_1',
	recipe = {
		{'lottores:mithril_ingot', 'lottother:blue_torch'},
	}
})

minetest.register_craft({
	output = 'lottores:ithildin_stonelamp_1',
	recipe = {
		{'lottores:ithildin_lamp_1', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'lottores:copperpick',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottores:tinpick',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottores:silverpick',
	recipe = {
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottores:goldpick',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottores:galvornpick',
	recipe = {
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottores:mithrilpick',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottores:copperaxe',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:tinaxe',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:silveraxe',
	recipe = {
		{'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:goldaxe',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:galvornaxe',
	recipe = {
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:mithrilaxe',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:silver_ingot",
	recipe = "lottores:silver_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:tin_ingot",
	recipe = "lottores:tin_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:lead_ingot",
	recipe = "lottores:lead_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:mithril_ingot",
	recipe = "lottores:mithril_lump",
})

minetest.register_craft({
	output = 'lottores:coppersword',
	recipe = {
		{'default:copper_ingot'},
		{'default:copper_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:tinsword',
	recipe = {
		{'lottores:tin_ingot'},
		{'lottores:tin_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:silversword',
	recipe = {
		{'lottores:silver_ingot'},
		{'lottores:silver_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:goldsword',
	recipe = {
		{'default:gold_ingot'},
		{'default:gold_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:galvornsword',
	recipe = {
		{'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:mithrilsword',
	recipe = {
		{'lottores:mithril_ingot'},
		{'lottores:mithril_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:coppershovel',
	recipe = {
		{'default:copper_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:tinshovel',
	recipe = {
		{'lottores:tin_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:silvershovel',
	recipe = {
		{'lottores:silver_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:goldshovel',
	recipe = {
		{'default:gold_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:galvornshovel',
	recipe = {
		{'lottores:galvorn_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottores:mithrilshovel',
	recipe = {
		{'lottores:mithril_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

--Blocks

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
	sounds = default.node_sound_dirt_defaults,
})

minetest.register_node( "lottores:pearl_block", {
	description = "Pearl Block",
     alpha = 200,
	tile_images = { "default_sand.png^lottores_pearl_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
     sounds = default.node_sound_glass_defaults(),
})

minetest.register_node( "lottores:salt_block", {
	description = "Salt Block",
	tile_images = { "default_clay.png^lottores_salt_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	on_use = minetest.item_eat(9),
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

-- Craft items

minetest.register_craftitem("lottores:pearl", {
	description = "Pearl",
	inventory_image = "lottores_pearl.png",
})	

-- Crafting

minetest.register_craft( {
	output = 'lottores:pearl_block',
	recipe = {
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
	}
})

minetest.register_craft({
	output = 'lottores:salt_block',
	recipe = {
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
	}
})

minetest.register_craft({
	output = 'lottores:salt 9',
	recipe = {
		{'lottores:salt_block'},
	}
})

minetest.register_craft({
	output = 'lottores:pearl_block',
	recipe = {
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
	}
})

minetest.register_craft({
	output = 'lottores:pearl 9',
	recipe = {
		{'lottores:pearl_block'},
	}
})

stairs.register_stair_and_slab("pearl", "lottores:pearl_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"lottores_pearl_block.png"},
		"Pearl Stair",
		"Pearl Slab",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("salt", "lottores:salt_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"lottores_salt_block.png"},
		"Salt Stair",
		"Salt Slab",
		default.node_sound_stone_defaults())
