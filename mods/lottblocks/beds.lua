local player_in_bed = 0
local function lay_down(player, pos, bed_pos, state, skip)
	local name = player:get_player_name()
	local hud_flags = player:hud_get_flags()

	if not player or not name then
		return
	end

	-- stand up
	if state ~= nil and not state then
		local p = beds.pos[name] or nil
		if lottblocks.beds.player[name] ~= nil then
			beds.player[name] = nil
			player_in_bed = player_in_bed - 1
		end
		-- skip here to prevent sending player specific changes (used for leaving players)
		if skip then
			return
		end
		if p then
			player:setpos(p)
		end

		-- physics, eye_offset, etc
		player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
		player:set_look_horizontal(math.random(1, 180) / 100)
		default.player_attached[name] = false
		player:set_physics_override(1, 1, 1)
		hud_flags.wielditem = true
		default.player_set_animation(player, "stand" , 30)

	-- lay down
	else
		lottblocks.beds.player[name] = 1
		lottblocks.beds.pos[name] = pos
		player_in_bed = player_in_bed + 1

		-- physics, eye_offset, etc
		player:set_eye_offset({x = 0, y = -13, z = 0}, {x = 0, y = 0, z = 0})
		local yaw, param2 = get_look_yaw(bed_pos)
		player:set_look_horizontal(yaw)
		local dir = minetest.facedir_to_dir(param2)
		local p = {x = bed_pos.x + dir.x / 2, y = bed_pos.y, z = bed_pos.z + dir.z / 2}
		player:set_physics_override(0, 0, 0)
		player:setpos(p)
		default.player_attached[name] = true
		hud_flags.wielditem = false
		default.player_set_animation(player, "lay" , 0)
	end

	player:hud_set_flags(hud_flags)
end
local function check_in_beds(players)
	local in_bed = lottblocks.beds.player
	if not players then
		players = minetest.get_connected_players()
	end

	for n, player in ipairs(players) do
		local name = player:get_player_name()
		if not in_bed[name] then
			return false
		end
	end

	return #players > 0
end
function lottblocks.beds.on_rightclick(pos, player)
	local name = player:get_player_name()
	local ppos = player:getpos()
	local tod = minetest.get_timeofday()

	if tod > 0.2 and tod < 0.805 then
		if lottblocks.beds.player[name] then
			lay_down(player, nil, nil, false)
		end
		minetest.chat_send_player(name, "You can only sleep at night.")
		return
	end

	-- move to bed
	if not lottblocks.beds.player[name] then
		lay_down(player, ppos, pos)
		beds.set_spawns() -- save respawn positions when entering bed
	else
		lay_down(player, nil, nil, false)
	end

	if not is_sp then
		update_formspecs(false)
	end

	-- skip the night and let all players stand up
	if check_in_beds() then
		minetest.after(2, function()
			if not is_sp then
				update_formspecs(is_night_skip_enabled())
			end
			if is_night_skip_enabled() then
				lottblocks.beds.skip_night()
				lottblocks.beds.kick_players()
			end
		end)
	end
end
local lottblocks_list = {
	{ "Red Bed", "red"},
	{ "Blue Bed", "blue"},
	{ "Green Bed", "green"},
}

for i in ipairs(lottblocks_list) do
	local beddesc = lottblocks_list[i][1]
	local colour = lottblocks_list[i][2]

	minetest.register_node("lottblocks:bed_bottom_"..colour, {
		description = beddesc,
		drawtype = "nodebox",
		tiles = {"lottblocks_bed_top_bottom_"..colour..".png", "default_wood.png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,flammable=3},
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, 0.0, -0.5, 0.5, 0.3125, 0.5},

						-- legs
						{-0.5, -0.5, -0.5, -0.4, 0.0, -0.4},
						{0.4, 0.0, -0.4, 0.5, -0.5, -0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.3125, 1.5},
					}
		},
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			beds.on_rightclick(pos, clicker)
			return itemstack
		end,
		after_place_node = function(pos, placer, itemstack)
			local node = minetest.get_node(pos)
			local p = {x=pos.x, y=pos.y, z=pos.z}
			local param2 = node.param2
			node.name = "lottblocks:bed_top_"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
				minetest.set_node(pos, node)
			else
				minetest.remove_node(p)
				return true
			end
		end,

		on_destruct = function(pos)
			local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "lottblocks:bed_top_"..colour ) then
				if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.remove_node(pos)
				end
			end
		end
	})

	minetest.register_node("lottblocks:bed_top_"..colour, {
		drawtype = "nodebox",
		tiles = {"lottblocks_bed_top_top_"..colour..".png", "default_wood.png",  "lottblocks_bed_side_top_r_"..colour..".png",  "lottblocks_bed_side_top_l_"..colour..".png",  "lottblocks_bed_top_front.png",  "lottblocks_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,flammable=3},
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, 0.0, -0.5, 0.5, 0.3125, 0.5},
						{-0.4375, 0.3125, 0.1, 0.4375, 0.4375, 0.5},

						-- legs
						{-0.4, 0.0, 0.4, -0.5, -0.5, 0.5},
						{0.5, -0.5, 0.5, 0.4, 0.0, 0.4},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})
	minetest.register_alias("lottblocks:bed_"..colour, "lottblocks:bed_bottom_"..colour)

	minetest.register_craft({
		output = "lottblocks:bed_"..colour,
		recipe = {
			{"wool:white", "wool:"..colour, "wool:"..colour },
			{"default:stick", "", "default:stick", }
		}
	})
end

minetest.register_alias("lottblocks:bed_bottom", "lottblocks:bed_bottom_blue")
minetest.register_alias("lottblocks:bed_top", "lottblocks:bed_top_blue")
minetest.register_alias("lottblocks:bed", "lottblocks:bed_bottom_blue")
