--[[
	This function registers the nodes and craft rezieps for the reinforce stuff
	 * name: String which is used in description and as technical name (lower letters)
	 * craftItem: the Item where the reinforce is crafted out of
	 * nodedef: Nodedefinition table as used as in minetest.register_node()

	The Nodes are caled
	<modname>:reinforced_<name>
	<modname>:reinforced_<name>_slope
	<modname>:reinforced_<name>_arrow
	<modname>:reinforced_<name>_bars

	The modname is automatically the mod that currently calls this function. 
	e.g. if you call darkage.register_reinforce from the mod medieval modname will be medieval
]]
function darkage.register_reinforce(name, craftItem, nodedef)
	assert(type(nodedef.tiles)=="table","ERRROR: nodedef.tiles have to be a table")
	assert(nodedef.tiles[1], "ERROR: "..dump(nodedef.tiles).." requires at least 1 entry")
	local modname = minetest.get_current_modname();
	local tname = name:lower(); -- Technical name

-- Reinforced X
	local reinforced = table.copy(nodedef);
	local reinforced_tname = modname..":reinforced_"..tname
	reinforced.description = "Reinforced "..name
	for i,tile in ipairs(reinforced.tiles) do
		reinforced.tiles[i] = tile .."^darkage_reinforce.png"
	end

	minetest.register_node(reinforced_tname, reinforced)

	minetest.register_craft({
		output = reinforced_tname,
		recipe = {
			{"group:stick",	craftItem, 		"group:stick"},
			{craftItem,		"group:stick", 	craftItem},
			{"group:stick",	craftItem, 		"group:stick"},
		}
	})
	-- Recycling
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ reinforced_tname },
		}
	})

-- Reinforced Slope
	local slope = table.copy(nodedef);
	local slope_tname = modname..":reinforced_"..tname.."_slope"
	slope.description = "Reinforced "..name.." Slope"
	slope.paramtype2 = "facedir";
	local slope_tile_extend = {"^darkage_reinforce_right.png" , "^darkage_reinforce_right.png" , --top ,down
			"^darkage_reinforce_right.png" , "^darkage_reinforce_right.png" , --right, left
			"^darkage_reinforce_left.png" , "^darkage_reinforce_left.png"} -- front, back
	for i=1,6 do
		local tile = slope.tiles[i] or nodedef.tiles[1]; -- There have to be at least one tile.
		slope.tiles[i] = tile ..slope_tile_extend[i]	
	end

	minetest.register_node(slope_tname, slope)

	minetest.register_craft({
		output = slope_tname,
		recipe = {
			{craftItem,		craftItem,		"group:stick"},
			{craftItem,		"group:stick",	craftItem},
			{"group:stick",	craftItem,		craftItem},
		}
	})
	-- Flipped recipe
	minetest.register_craft({
		output = slope_tname,
		recipe = {
			{"group:stick",	craftItem,		craftItem},
			{craftItem,		"group:stick",	craftItem},
			{craftItem,		craftItem,		"group:stick"},
		}
	})
	-- Recycling
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ slope_tname }
		}
	})

	-- Alias to convert old nodes
	minetest.register_alias(modname..":reinforced_"..tname.."_right", slope_tname)
	minetest.register_alias(modname..":reinforced_"..tname.."_left", slope_tname)

-- Arrow bar
	local arrow = table.copy(nodedef)
	local arrow_tname = modname..":reinforced_"..tname.."_arrow"
	arrow.paramtype2 = "facedir";
	arrow.description = "Reinforced "..name.." Arrow"
	local arrow_tile_extend = {"" , "" , --top ,down
			"^(darkage_reinforce_arrow.png^[transformR90)" , "^(darkage_reinforce_arrow.png^[transformR270)" , --right, left
			"^(darkage_reinforce_arrow.png^[transformR180)" , "^darkage_reinforce_arrow.png"} -- front, back
	for i=1,6 do
		local tile = arrow.tiles[i] or arrow.tiles[1]; -- There have to be at least one tile.
		arrow.tiles[i] = tile .. arrow_tile_extend[i]
	end
	minetest.register_node(arrow_tname, arrow)

	minetest.register_craft({
		output = arrow_tname,
		recipe = {
			{craftItem, 	"group:stick",	craftItem},
			{"group:stick",	 craftItem, 	"group:stick"},
			{"group:stick",	 craftItem, 	"group:stick"},
		}
	})
	-- Recycling
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ arrow_tname }
		}
	})

-- Reinforced Bars
	local bars = table.copy(nodedef)
	local bars_tname = modname..":reinforced_"..tname.."_bars"
	bars.description = name.." Bars"
	for i,tile in ipairs(bars.tiles) do
		bars.tiles[i] = tile .."^darkage_reinforce_bars.png"
	end
	minetest.register_node(bars_tname, bars)

	minetest.register_craft({
		output = bars_tname,
		recipe = {
			{"group:stick", craftItem, "group:stick"},
			{"group:stick", craftItem, "group:stick"},
			{"group:stick", craftItem, "group:stick"},
		}
	})
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ bars_tname }
		}
	})
end

darkage.register_reinforce("Chalk", "darkage:chalk_powder", {
	tiles = {"darkage_chalk.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

darkage.register_reinforce("Wood", "default:wood", {
	tiles = {"default_wood.png"},
	groups = {snappy=2, choppy=3, flammable=3},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("darkage:glass", {
	description = "Medieval Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	use_texture_alpha=true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("darkage:glow_glass", {
	description = "Medieval Glow Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	use_texture_alpha=true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX-1,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "darkage:glow_glass 1",
	recipe = {
		{"darkage:glass", "", ""},
		{"default:torch", "", ""},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "darkage:glass 1",
	recipe = {
		{"darkage:glow_glass"},
	}
})

minetest.register_craft({
	output = "darkage:glass 8",
	recipe = {
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:glass", "default:steel_ingot", "default:glass"},
	}
})

minetest.register_craft({
	output = "darkage:chalk",
	recipe = {
    {"darkage:chalk_powder","darkage:chalk_powder"},
	{"darkage:chalk_powder","darkage:chalk_powder"},
	}
})

minetest.register_craft({
	output = "darkage:glow_glass 1",
	recipe = {
		{"darkage:glass", "", ""},
		{"default:torch", "", ""},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "darkage:glass 1",
	recipe = {
		{"darkage:glow_glass"},
	}
})
