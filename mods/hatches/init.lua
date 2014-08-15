dofile(minetest.get_modpath(minetest.get_current_modname()).."/lebethronwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/birchwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/alderwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/mallornwood.lua")
local function update_door(pos, node)
	minetest.set_node(pos, node)
end

local function punch(pos)
	local meta = minetest.get_meta(pos)
	local state = meta:get_int("state")
	local me = minetest.get_node(pos)
	local tmp_node
	local tmp_node2
	oben = {x=pos.x, y=pos.y+1, z=pos.z}
		if state == 1 then
			state = 0
			minetest.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="doors:trapdoor", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="doors:trapdoor_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end
