----------
-- Nodes
----------

minetest.register_node("darkage:adobe", {
	description = "Adobe",
	tiles = {"darkage_adobe.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("darkage:basalt", {
	description = "Basalt",
	tiles = {"darkage_basalt.png"},
	is_ground_content = true,
	drop = 'darkage:basalt_cobble',
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:basalt_cobble", {
	description = "Basalt Cobble",
	tiles = {"darkage_basalt_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:chalk", {
	description = "Chalk",
	tiles = {"darkage_chalk.png"},
	is_ground_content = true,
	drop = 'darkage:chalk_powder 4',
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:cobble_with_plaster", {
	description = "Cobblestone with Plaster",
	tiles = {
		"default_cobble.png^(darkage_plaster.png^[transform1)",
		"default_cobble.png^(darkage_plaster.png^[transform3)",
		"default_cobble.png^darkage_plaster.png",
		"default_cobble.png^(darkage_plaster.png^[transform2)",
		"default_cobble.png",
		"darkage_chalk.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("darkage:stonebrick_with_plaster", {
	description = "Stone Brick with Plaster",
	tiles = {
		"default_stone_brick.png^(darkage_plaster.png^[transform1)",
		"default_stone_brick.png^(darkage_plaster.png^[transform3)",
		"default_stone_brick.png^darkage_plaster.png",
		"default_stone_brick.png^(darkage_plaster.png^[transform2)",
		"default_stone_brick.png",
		"darkage_chalk.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("darkage:desert_stone_with_iron", {
	description = "Desert Iron Ore",
	tiles = {"default_desert_stone.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("darkage:darkdirt", {
	description = "Dark Dirt",
	tiles = {"darkage_darkdirt.png"},
	is_ground_content = false,
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("darkage:dry_leaves", {
	description = "Dry Leaves",
	tiles = {"darkage_dry_leaves.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("darkage:gneiss", {
	description = "Gneiss",
	tiles = {"darkage_gneiss.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get cobbles with 1/3 chance
				items = {'darkage:gneiss_cobble'},
				rarity = 3,
			},
			{
				items = {'darkage:gneiss'},
			}
		}
	},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:gneiss_cobble", {
	description = "Gneiss Cobble",
	tiles = {"darkage_gneiss_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:mud", {
	description = "Mud",
	tiles = {"darkage_mud_up.png","darkage_mud.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'darkage:mud_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("darkage:ors", {
	description = "Old Red Sandstone",
	tiles = {"darkage_ors.png"},
	is_ground_content = true,
	drop = 'darkage:ors_cobble',
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:ors_cobble", {
	description = "Old Red Sandstone Cobble",
	tiles = {"darkage_ors_cobble.png"},
	is_ground_content = false,
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:shale", {
	description = "Shale",
	tiles = {"darkage_shale.png","darkage_shale.png","darkage_shale_side.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:schist", {
	description = "Schist",
	tiles = {"darkage_schist.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:silt", {
	description = "Silt",
	tiles = {"darkage_silt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'darkage:silt_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("darkage:slate", {
	description = "Slate",
	tiles = {"darkage_slate.png","darkage_slate.png","darkage_slate_side.png"},
	is_ground_content = true,
	drop = 'darkage:slate_cobble',
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:slate_cobble", {
	description = "Slate Cobble",
	tiles = {"darkage_slate_cobble.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:slate_tile", {
	description = "Slate Tile",
	tiles = {"darkage_slate_tile.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

-- Removed straw, because its in minetst game. Registering alias for compatibility reasons
minetest.register_alias("darkage:straw", "farming:straw")

minetest.register_node("darkage:straw_bale", {
	description = "Straw Bale",
	tiles = {"darkage_straw_bale.png"},
	is_ground_content = false,
	drop = 'farming:straw 4',
	groups = {snappy=2, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

--[[
	Tuff
]]
minetest.register_node("darkage:tuff", {
	description = "Tuff",
	tiles = {"darkage_tuff.png"},
	is_ground_content = true,
	legacy_mineral = true,
	groups = {cracky = 3, stone = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player get tuff node if he is lucky :)
				items = {'darkage:tuff'},
				rarity = 3,
			},
			{
				-- player will get rubble with 2/3 chance
				items = {'darkage:tuff_rubble'},
			}

		}
	},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:tuff_bricks", {
	description = "Tuff Bricks",
	tiles = {"darkage_tuff_bricks.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

-- abm to turn Tuff bricks to old Tuff bricks if water is nearby
minetest.register_abm({
	nodenames = {"darkage:tuff_bricks"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "darkage:old_tuff_bricks"})
	end
})

minetest.register_node("darkage:tuff_rubble", {
	description = "Tuff Rubble",
	tiles = {"darkage_tuff_rubble.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
})
--[[
	Rhyolitic Tuff
]]
minetest.register_node("darkage:rhyolitic_tuff", {
	description = "Rhyolitic Tuff",
	tiles = {"darkage_rhyolitic_tuff.png"},
	is_ground_content = true,
	legacy_mineral = true,
	groups = {cracky = 3, stone = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player get tuff node if he is lucky :)
				items = {'darkage:rhyolitic_tuff'},
				rarity = 3,
			},
			{
				-- player will get rubble with 2/3 chance
				items = {'darkage:rhyolitic_tuff_rubble'},
			}

		}
	},
	sounds = default.node_sound_stone_defaults()
})



minetest.register_node("darkage:rhyolitic_tuff_bricks", {
	description = "Rhyolitic Tuff Bricks",
	tiles = {"darkage_rhyolitic_tuff_bricks.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:old_tuff_bricks", {
	description = "Old Tuff Bricks",
	tiles = {"darkage_old_tuff_bricks.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})





minetest.register_node("darkage:rhyolitic_tuff_rubble", {
	description = "Rhyolitic Tuff Rubble",
	tiles = {"darkage_rhyolitic_tuff_rubble.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
})
