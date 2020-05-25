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

-- ABMs

minetest.register_abm(
	{nodenames = {"lottores:ithildin_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.2 and minetest.get_timeofday() < 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stone_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.2 and minetest.get_timeofday() < 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_stone_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stone_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_stone_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stonelamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.2 and minetest.get_timeofday() < 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_stonelamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_stonelamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_stonelamp_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_lamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.2 and minetest.get_timeofday() < 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_lamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"lottores:ithildin_lamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.8
		then
			minetest.set_node(pos, {name="lottores:ithildin_lamp_1"})
		end
	end,
})
