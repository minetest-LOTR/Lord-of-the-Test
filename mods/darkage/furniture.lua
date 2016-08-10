minetest.register_node("darkage:chain", {
	description = "Chain",
	drawtype = "signlike",
	tiles = {"darkage_chain.png"},
	inventory_image = "darkage_chain.png",
	wield_image = "darkage_chain.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = false,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {snappy=1,cracky=2,oddly_breakable_by_hand=2},
	legacy_wallmounted = true
})

minetest.register_node("darkage:iron_bars", {
	description = "Iron Bars",
	drawtype = "glasslike",
	tiles = {"darkage_iron_bars.png"},
	inventory_image = "darkage_iron_bars.png",
	wield_image = "darkage_iron_bars.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:lamp", {
	description = "Lamp",
	tiles = { "darkage_lamp.png" },
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX-1,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,flammable=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("darkage:iron_grille", {
	description = "Iron Grille",
	drawtype = "glasslike",
	tiles = {"darkage_iron_grille.png"},
	inventory_image = "darkage_iron_grille.png",
	wield_image = "darkage_iron_grille.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:wood_bars", {
	description = "Wooden Bars",
	drawtype = "glasslike",
	tiles = {"darkage_wood_bars.png"},
	inventory_image = "darkage_wood_bars.png",
	wield_image = "darkage_wood_bars.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=1,choppy=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:wood_grille", {
	description = "Wooden Grille",
	drawtype = "glasslike",
	tiles = {"darkage_wood_grille.png"},
	inventory_image = "darkage_wood_grille.png",
	wield_image = "darkage_wood_grille.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=1,choppy=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:wood_frame", {
	description = "Wooden Frame",
	drawtype = "glasslike",
	tiles = {"darkage_wood_frame.png"},
	inventory_image = "darkage_wood_frame.png",
	wield_image = "darkage_wood_frame.png",
	is_ground_content = false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=1,choppy=2},
	sounds = default.node_sound_stone_defaults()
})

---------------
-- Crafts Item
---------------


----------
-- Crafts 
----------

minetest.register_craft({
	output = "darkage:chain 2",
	recipe = {
		{"darkage:iron_stick"},
		{"darkage:iron_stick"},
		{"darkage:iron_stick"},
	}
})

minetest.register_craft({
	output = "darkage:iron_bars 2",
	recipe = {
		{"darkage:iron_stick", "", "darkage:iron_stick"},
		{"darkage:iron_stick", "", "darkage:iron_stick"},
		{"darkage:iron_stick", "", "darkage:iron_stick"},
	}
})

minetest.register_craft({
	output = "darkage:iron_grille 3",
	recipe = {
    {"",					"darkage:iron_bars",	""},
    {"darkage:iron_bars",	"",						"darkage:iron_bars"},
    {"",					"darkage:iron_bars",	""},
	}
})

minetest.register_craft({
	output = "darkage:lamp",
	recipe = {
		{"group:stick",	"",				 "group:stick"},
		{"",			"default:torch", ""},
		{"group:stick",	"",				 "group:stick"},
	}
})

minetest.register_craft({
	output = "darkage:wood_bars 2",
	recipe = {
    {"group:stick", "", "group:stick"},
    {"group:stick", "", "group:stick"},
    {"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	output = "darkage:wood_grille 3",
	recipe = {
		{"",					"darkage:wood_bars", ""},
		{"darkage:wood_bars",	"",					 "darkage:wood_bars"},
		{"",					"darkage:wood_bars", ""},
	}
})

minetest.register_craft({
	output = "darkage:wood_frame",
	recipe = {
		{"group:stick",	"",					"group:stick"},
		{"",			"default:glass",	""},
		{"group:stick",	"",					"group:stick"},
	}
})


-- Cookings
minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "darkage:wood_frame",
})
