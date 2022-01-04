-- Functions derived from beds mod in minetest_game default mod collection.
local player_in_bed = 0
local pi = math.pi
local is_sp = minetest.is_singleplayer()
local enable_respawn = minetest.settings:get_bool("enable_bed_respawn")
if enable_respawn == nil then
	enable_respawn = true
end
local formspec = "size[8,15;true]" ..
	"bgcolor[#080808BB; true]" ..
	"button_exit[2,12;4,0.75;leave;Leave Bed]"
local function get_look_yaw(pos)
	local rotation = minetest.get_node(pos).param2
	if rotation > 3 then
		rotation = rotation % 4 -- Mask colorfacedir values
	end
	if rotation == 1 then
		return pi / 2, rotation
	elseif rotation == 3 then
		return -pi / 2, rotation
	elseif rotation == 0 then
		return pi, rotation
	else
		return 0, rotation
	end
end

local function is_night_skip_enabled()
	local enable_night_skip = minetest.settings:get_bool("enable_bed_night_skip")
	if enable_night_skip == nil then
		enable_night_skip = true
	end
	return enable_night_skip
end

local function update_formspecs(finished)
	local ges = #minetest.get_connected_players()
	local form_n
	local is_majority = (ges / 2) < player_in_bed

	if finished then
		form_n = formspec .. "label[2.7,11; Good morning.]"
	else
		form_n = formspec .. "label[2.2,11;" .. tostring(player_in_bed) ..
			" of " .. tostring(ges) .. " players are in bed]"
		if is_majority and is_night_skip_enabled() then
			form_n = form_n .. "button_exit[2,8;4,0.75;force;Force night skip]"
		end
	end

	for name,_ in pairs(lottblocks.player) do
		minetest.show_formspec(name, "beds_form", form_n)
	end
end

local function bed_kick_players()
	for name, _ in pairs(lottblocks.player) do
		local player = minetest.get_player_by_name(name)
		lottblocks.lay_down(player, nil, nil, false)
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "beds_form" then
		return
	end
	if fields.quit or fields.leave then
		lottblocks.lay_down(player, nil, nil, false)
		update_formspecs(false)
	end

	if fields.force then
		update_formspecs(is_night_skip_enabled())
		if is_night_skip_enabled() then
			lottblocks.skip_night()
			bed_kick_players()
		end
	end
end)

function lottblocks.skip_night()
	minetest.set_timeofday(0.23)
end

function lottblocks.lay_down(player, pos, bed_pos, state, skip)
	local name = player:get_player_name()
	local hud_flags = player:hud_get_flags()

	if not player or not name then
		return
	end

	-- stand up
	if state ~= nil and not state then
		local p = lottblocks.pos[name] or nil
		if lottblocks.player[name] ~= nil then
			lottblocks.player[name] = nil
			player_in_bed = player_in_bed - 1
		end
		-- skip here to prevent sending player specific changes (used for leaving players)
		if skip then
			return
		end
		if p then
			player:set_pos(p)
		end

		-- physics, eye_offset, etc
		player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
		player:set_look_horizontal(math.random(1, 180) / 100)
		default.player_attached[name] = false
		player:set_physics_override({speed = 1, jump = 1, gravity = 1})
		hud_flags.wielditem = true
		default.player_set_animation(player, "stand" , 30)

	-- lay down
	else
		lottblocks.player[name] = 1
		lottblocks.pos[name] = pos
		player_in_bed = player_in_bed + 1

		-- physics, eye_offset, etc
		player:set_eye_offset({x = 0, y = -13, z = 0}, {x = 0, y = 0, z = 0})
		local yaw, param2 = get_look_yaw(bed_pos)
		player:set_look_horizontal(yaw)
		local dir = minetest.facedir_to_dir(param2)
		local p = {x = bed_pos.x + dir.x / 2, y = bed_pos.y, z = bed_pos.z + dir.z / 2}
		player:set_physics_override({speed = 0, jump = 0, gravity = 0})
		player:set_pos(p)
		default.player_attached[name] = true
		hud_flags.wielditem = false
		default.player_set_animation(player, "lay" , 0)
	end

	player:hud_set_flags(hud_flags)
end

local function check_in_beds(players)
	local in_bed = lottblocks.player
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

local function bed_on_rightclick(pos, player)
	local name = player:get_player_name()
	local ppos = player:get_pos()
	local tod = minetest.get_timeofday()

	if tod > 0.2 and tod < 0.805 then
		if lottblocks.player[name] then
			lottblocks.lay_down(player, nil, nil, false)
		end
		minetest.chat_send_player(name, "You can only sleep at night.")
		return
	end

	-- move to bed
	if not lottblocks.player[name] then
		lottblocks.lay_down(player, ppos, pos)
	else
		lottblocks.lay_down(player, nil, nil, false)
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
				lottblocks.skip_night()
				bed_kick_players()
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
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
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
			bed_on_rightclick(pos, clicker)
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
		groups = {snappy=1,choppy=2,flammable=3,oddly_breakable_by_hand=2},
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

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	lottblocks.lay_down(player, nil, nil, false, true)
	lottblocks.player[name] = nil
	if check_in_beds() then
		minetest.after(2, function()
			update_formspecs(is_night_skip_enabled())
			if is_night_skip_enabled() then
				lottblocks.skip_night()
				bed_kick_players()
			end
		end)
	end
end)

minetest.register_alias("lottblocks:bed_bottom", "lottblocks:bed_bottom_blue")
minetest.register_alias("lottblocks:bed_top", "lottblocks:bed_top_blue")
minetest.register_alias("lottblocks:bed", "lottblocks:bed_bottom_blue")
