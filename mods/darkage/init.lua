darkage = {}; -- Create darkage namespace

local MODPATH = minetest.get_modpath("darkage")

dofile(MODPATH.."/nodes.lua")
dofile(MODPATH.."/mapgen.lua")
dofile(MODPATH.."/building.lua")
dofile(MODPATH.."/furniture.lua")
dofile(MODPATH.."/aliases.lua")
dofile(MODPATH.."/walls.lua")

dofile(MODPATH.."/stairs_functions.lua")
dofile(MODPATH.."/stairs.lua")


---------------
-- Crafts Items
---------------
minetest.register_craftitem("darkage:chalk_powder", {
	description = "Chalk Powder",
	inventory_image = "darkage_chalk_powder.png",
})

minetest.register_craftitem("darkage:mud_lump", {
	description = "Mud Lump",
	inventory_image = "darkage_mud_lump.png",
})

minetest.register_craftitem("darkage:silt_lump", {
	description = "Silt Lump",
	inventory_image = "darkage_silt_lump.png",
})

minetest.register_craftitem("darkage:iron_stick", {
	description = "Iron Stick",
	inventory_image = "darkage_iron_stick.png",
})


----------
-- Crafts
----------

minetest.register_craft({
	output = "darkage:adobe 4",
	recipe = {
		{"default:sand",		"default:sand"},
		{"default:clay_lump",	"farming:straw"},
	}
})


minetest.register_craft({
	output = "darkage:basalt_cobble 4",
	recipe = {
		{"default:cobble",		"default:cobble"},
		{"default:coal_lump",	"default:coal_lump"},
	}
})

minetest.register_craft({
	output = "darkage:cobble_with_plaster 2",
	recipe = {
		{"darkage:chalk_powder", "default:cobble"},
		{"darkage:chalk_powder", "default:cobble"},
	}
})

minetest.register_craft({
	output = "darkage:stonebrick_with_plaster 2",
	recipe = {
		{"darkage:chalk_powder", "default:stonebrick"},
		{"darkage:chalk_powder", "default:stonebrick"},
	}
})

minetest.register_craft({
	output = "darkage:darkdirt 4",
	recipe = {
		{"default:dirt",	"default:dirt"},
		{"default:gravel",	"default:gravel"},
	}
})

minetest.register_craft({
	output = "darkage:mud 3",
	recipe = {
		{"default:dirt",		"default:dirt"},
		{"default:clay_lump",	"darkage:silt_lump"},
	}
})

minetest.register_craft({
	output = "darkage:mud",
	recipe = {
		{"darkage:mud_lump", "darkage:mud_lump"},
		{"darkage:mud_lump", "darkage:mud_lump"},
	}
})

minetest.register_craft({
	output = "darkage:ors 4",
	recipe = {
		{"default:sandstone", "default:sandstone"},
		{"default:iron_lump", "default:sandstone"},
	}
})

minetest.register_craft({
	output = "darkage:silt 3",
	recipe = {
		{"default:sand",		"default:sand"},
		{"default:clay_lump",	"default:clay_lump"},
	}
})

minetest.register_craft({
	output = "darkage:silt",
	recipe = {
		{"darkage:silt_lump", "darkage:silt_lump"},
		{"darkage:silt_lump", "darkage:silt_lump"},
	}
})

minetest.register_craft({
	output = "darkage:slate_tile 2",
	recipe = {
		{"darkage:slate_cobble", "darkage:slate_cobble"},
		{"darkage:slate_cobble", "darkage:slate_cobble"},
	}
})

minetest.register_craft({
	output = "darkage:straw_bale",
	recipe = {
		{"farming:straw","farming:straw"},
		{"farming:straw","farming:straw"},
	}
})

minetest.register_craft({
	output = "darkage:iron_stick 4",
	recipe = {
		{"default:steel_ingot"},
	}
})

-- Cookings
minetest.register_craft({
	type = "cooking",
	output = "darkage:basalt",
	recipe = "darkage:basalt_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:dry_leaves",
	recipe = "default:leaves",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:schist",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:gneiss_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:ors",
	recipe = "darkage:ors_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:schist",
	recipe = "darkage:slate",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:shale",
	recipe = "darkage:mud",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:shale",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:slate_cobble",
})

-- Desert
minetest.register_craft({
	type = "cooking",
	output = "darkage:ors_cobble",
	recipe = "default:desert_stone",
})

-- Tuff
minetest.register_craft({
	output = "darkage:tuff 2",
	recipe = {
		{"darkage:gneiss", "default:stone"},
		{"default:stone", "darkage:gneiss"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:tuff",
	recipe = "darkage:tuff_rubble",
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:tuff",
	recipe = "darkage:old_tuff_bricks",
})

minetest.register_craft({
	output = "darkage:tuff_bricks",
	recipe = {
		{"darkage:tuff", "darkage:tuff"},
		{"darkage:tuff", "darkage:tuff"},
	}
})

-- Rhyolitic Tuff
minetest.register_craft({
	output = "darkage:rhyolitic_tuff 2",
	recipe = {
		{"darkage:gneiss", "default:desert_stone"},
		{"default:desert_stone", "darkage:gneiss"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "darkage:rhyolitic_tuff",
	recipe = "darkage:rhyolitic_tuff_rubble",
})

minetest.register_craft({
	output = "darkage:rhyolitic_tuff_bricks",
	recipe = {
		{"darkage:rhyolitic_tuff", "darkage:rhyolitic_tuff"},
		{"darkage:rhyolitic_tuff", "darkage:rhyolitic_tuff"},
	}
})
