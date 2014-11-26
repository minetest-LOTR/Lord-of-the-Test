minetest.register_node("gul:blue_flame", {
	description = "Blue Flame",
	drawtype = "plantlike",
	tiles = {{
		name="gul_blue_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "gul_blue_flame.png",
	light_source = 14,
	groups = {igniterblue=2,dig_immediate=3,hot=3},
	drop = '',
	walkable = false,
	buildable_to = true,
	damage_per_second = 4,
	
	after_place_node = function(pos, placer)
		fire.on_flame_add_at(pos)
	end,
	
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		fire.on_flame_remove_at(pos)
	end,
})

gul = {}
gul.D = 6
gul.sounds = {}

function gul.get_area_p0p1(pos)
	local p0 = {
		x=math.floor(pos.x/gul.D)*gul.D,
		y=math.floor(pos.y/gul.D)*gul.D,
		z=math.floor(pos.z/gul.D)*gul.D,
	}
	local p1 = {
		x=p0.x+gul.D-1,
		y=p0.y+gul.D-1,
		z=p0.z+gul.D-1
	}
	return p0, p1
end

function gul.update_sounds_around(pos)
	local p0, p1 = gul.get_area_p0p1(pos)
	local cp = {x=(p0.x+p1.x)/2, y=(p0.y+p1.y)/2, z=(p0.z+p1.z)/2}
	local flames_p = minetest.find_nodes_in_area(p0, p1, {"gul:blue_flame"})
	local should_have_sound = (#flames_p > 0)
	local wanted_sound = nil
	if #flames_p >= 9 then
		wanted_sound = {name="fire_large", gain=1.5}
	elseif #flames_p > 0 then
		wanted_sound = {name="fire_small", gain=1.5}
	end
	local p0_hash = minetest.hash_node_position(p0)
	local sound = gul.sounds[p0_hash]
	if not sound then
		if should_have_sound then
			gul.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos=cp, loop=true}),
				name = wanted_sound.name,
			}
		end
	else
		if not wanted_sound then
			minetest.sound_stop(sound.handle)
			gul.sounds[p0_hash] = nil
		elseif sound.name ~= wanted_sound.name then
			minetest.sound_stop(sound.handle)
			gul.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos=cp, loop=true}),
				name = wanted_sound.name,
			}
		end
	end
end

function gul.on_flame_add_at(pos)
	gul.update_sounds_around(pos)
end

function gul.on_flame_remove_at(pos)
	gul.update_sounds_around(pos)
end

function gul.find_pos_for_flame_around(pos)
	return minetest.find_node_near(pos, 1, {"air"})
end

function gul.flame_should_extinguish(pos)
	if minetest.setting_getbool("disable_gul") then return true end
	local p0 = {x=pos.x-2, y=pos.y, z=pos.z-2}
	local p1 = {x=pos.x+2, y=pos.y, z=pos.z+2}
	local ps = minetest.find_nodes_in_area(p0, p1, {"group:puts_out_gul"})
	return (#ps ~= 0)
end

minetest.register_abm({
	nodenames = {"group:flammableblue"},
	neighbors = {"group:igniterblue"},
	interval = 1,
	chance = 2,
	action = function(p0, node, _, _)
		if gul.flame_should_extinguish(p0) then
			return
		end
		local p = gul.find_pos_for_flame_around(p0)
		if p then
			minetest.set_node(p, {name="gul:blue_flame"})
			gul.on_flame_add_at(p)
		end
	end,
})

minetest.register_abm({
	nodenames = {"group:igniterblue"},
	neighbors = {"air"},
	interval = 2,
	chance = 10,
	action = function(p0, node, _, _)
		local reg = minetest.registered_nodes[node.name]
		if not reg or not reg.groups.igniterblue or reg.groups.igniterblue < 2 then
			return
		end
		local d = reg.groups.igniterblue
		local p = minetest.find_node_near(p0, d, {"group:flammableblue"})
		if p then
			if gul.flame_should_extinguish(p) then
				return
			end
			local p2 = gul.find_pos_for_flame_around(p)
			if p2 then
				minetest.set_node(p2, {name="gul:blue_flame"})
				gul.on_flame_add_at(p2)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"gul:blue_flame"},
	interval = 1,
	chance = 2,
	action = function(p0, node, _, _)
		if gul.flame_should_extinguish(p0) then
			minetest.remove_node(p0)
			gul.on_flame_remove_at(p0)
			return
		end
		if math.random(1,3) == 1 then
			return
		end
		if not minetest.find_node_near(p0, 1, {"group:flammableblue"}) then
			minetest.remove_node(p0)
			gul.on_flame_remove_at(p0)
			return
		end
		if math.random(1,4) == 1 then
			local p = minetest.find_node_near(p0, 1, {"group:flammableblue"})
			if p then
				if gul.flame_should_extinguish(p0) then
					return
				end
				minetest.remove_node(p)
				nodeupdate(p)
			end
		else
			minetest.remove_node(p0)
			gul.on_flame_remove_at(p0)
		end
	end,
})

-- Ithildin

minetest.register_node("gul:ithildin_0", {
	description = "Ithildin",
	tiles = {"ithildin_0.png"},
	drawtype = "glasslike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "gul:ithildin_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_1", {
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
	drop = "gul:ithildin_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_stone_0", {
	description = "Ithildin Stone",
	tiles = {"default_stone.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	drop = "gul:ithildin_stone_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_stone_1", {
	description = "Ithildin Stone",
	tiles = {"default_stone.png^ithildin_1.png"},
	drawtype = 'glasslike',
	walkable = false,
	pointable = true,
	sunlight_propagates = false,
	light_source = 8,
	drop = "gul:ithildin_stone_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_stonelamp_0", {
	description = "Ithildin Stonelamp",
	tiles = {"default_stone.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	drop = "gul:ithildin_stonelamp_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_stonelamp_1", {
	description = "Ithildin Stonelamp",
	tiles = {"default_stone.png^ithildin_lamp_1.png"},
	drawtype = 'normal',
	walkable = true,
	pointable = true,
	sunlight_propagates = false,
	light_source = 8,
	drop = "gul:ithildin_stonelamp_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_lamp_0", {
	description = "Ithildin Lamp",
	tiles = {"ithildin_lamp_0.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "gul:ithildin_lamp_1",
	groups = {snappy=2,cracky=3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("gul:ithildin_lamp_1", {
	description = "Ithildin Lamp",
	tiles = {"ithildin_lamp_1.png"},
	paramtype = "light",
	drawtype = 'glasslike',
	walkable = true,
	pointable = true,
	sunlight_propagates = true,
	light_source = 8,
	drop = "gul:ithildin_lamp_1",
	groups = {snappy=2,cracky=3,forbidden=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Functions

minetest.register_abm(
	{nodenames = {"gul:ithildin_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_stone_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_stone_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_stone_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_stone_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_stonelamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_stonelamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_stonelamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_stonelamp_1"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_lamp_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_lamp_0"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"gul:ithildin_lamp_0"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8
		then
			minetest.env:set_node(pos, {name="gul:ithildin_lamp_1"})
		end
	end,
})

minetest.register_craft({
	output = 'gul:ithildin_1',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:geodes_crystal_1'},
	}
})

minetest.register_craft({
	output = 'gul:ithildin_stone_1',
	recipe = {
		{'gul:ithildin_1', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'gul:ithildin_lamp_1',
	recipe = {
		{'cemen:mithril_ingot', 'curwe:blue_torch'},
	}
})

minetest.register_craft({
	output = 'gul:ithildin_stonelamp_1',
	recipe = {
		{'gul:ithildin_lamp_1', 'group:stone'},
	}
})