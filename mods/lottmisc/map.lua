lottmisc = {}

local function get_waypoints(player)
	local waypoints_string = player:get_attribute("lottmisc:waypoints")
	if not waypoints_string or waypoints_string == "" then
		return {}
	end
	return minetest.deserialize(waypoints_string)
end

function lottmisc.add_waypoint(player, pos, waypoint_name, colour)
	local name = player:get_player_name()
	local waypoints_string = player:get_attribute("lottmisc:waypoints")
	local waypoints_number = tonumber(player:get_attribute("lottmisc:waypoints_number") or 0)
	local waypoints = get_waypoints(player)
	if waypoints_number >= 10 then
		return false, "You can only have 10 waypoints at a time!"
	end
	for i, v in pairs(pos) do
		pos[i] = math.floor(v)
	end
	local ref = player:hud_add({
		hud_elem_type = "waypoint",
		name = waypoint_name,
		text = "n",
		world_pos = pos,
		number = tonumber("0x" .. colour) or 0xFFFFFF,
	})
	waypoints[waypoint_name] = {pos = pos, ref = ref, colour = tostring(colour)}
	player:set_attribute("lottmisc:waypoints", minetest.serialize(waypoints))
	player:set_attribute("lottmisc:waypoints_number", waypoints_number + 1)
	return true, "Waypoint Created!"
end

function lottmisc.delete_waypoint(player, waypoint_name)
	local waypoints = get_waypoints(player)
	local waypoints_number = player:get_attribute("lottmisc:waypoints_number") or 1
	player:hud_remove(waypoints[waypoint_name].ref)
	waypoints[waypoint_name] = nil
	player:set_attribute("lottmisc:waypoints", minetest.serialize(waypoints))
	player:set_attribute("lottmisc:waypoints_number", waypoints_number - 1)
end

local function base_map_formspec(player, pos, tab)
	local waypoints = ""
	local panel = ""
	local waypoints_table = get_waypoints(player)
	local x = math.floor((pos.x) / 160) + 200
	local z = (math.floor((pos.z) / 160) - 200) * -1
	for name, v in pairs(waypoints_table) do
		local wx = (v.pos.x / 160) + 200
		local wz = ((v.pos.z / 160) - 200) * -1
		waypoints = waypoints ..
			"image_button[" .. wx / 40 - 0.44 .. "," .. wz / 40 - 0.8 ..
				";0.75,0.75;lottmisc_flag_" .. v.colour .. ".png;flag_" .. v.colour ..
				";;true;false]" ..
			"tooltip[flag_" .. v.colour .. ";" .. minetest.formspec_escape(name) .. "]"
	end
	if tab == 1 then
		local _, biome = lottmapgen.get_biome_at_pos(pos)
		panel = "label[10,1.5;Position:\n\tx = " .. math.floor(pos.x) ..
				"\n\tz = " .. math.floor(pos.z) .. "]" ..
				"label[10,3;Altitude: " .. math.floor(pos.y) .. "]" ..
				"label[10,3.75;Current Biome: " .. biome .. "]"
	elseif tab == 2 then
		local x = 1
		for w_name, table in pairs(waypoints_table) do
			panel = panel .. "label[10.5," .. 1.5 + x / 2.5 .. ";" ..
				minetest.formspec_escape(minetest.colorize("#" .. table.colour, w_name)) .. "]"
			x = x + 1
		end
		panel = panel .. "button[10.5,7.5;4,1;add_delete_waypoint;Add/Delete Waypoint]" ..
			"field[10.8,7;4,1;waypoint_name;;]" ..
			"field_close_on_enter[waypoint_name,false]" ..
			"label[10.5,6.3;Waypoint name:]"
	end
	return "size[16,9.5]" ..
		"bgcolor[#0000]" ..
		"background[-0.2,-0.26;10,10;lottmisc_full_map.png]" ..
		"background[9.8,1.38;6,8.375;lottmisc_black.png]" ..
		"image[" .. x / 40 - 0.48 .. "," .. z / 40 - 0.52 .. ";0.5,0.5;lottmisc_player_marker.png]" ..
		"tabheader[10,1.65;tabs;Info,Waypoints;" .. tab .. ";true;false]" ..
		waypoints .. panel
end


minetest.register_on_joinplayer(function(player)
	local waypoints = get_waypoints(player)
	for name, def in pairs(waypoints) do
		local ref = player:hud_add({
			hud_elem_type = "waypoint",
			name = name,
			text = "n",
			world_pos = def.pos,
			number = tonumber("0x" .. def.colour),
		})
		--[[if ref == 0 then -- Hacky fix for a MT bug...
			ref = player:hud_add({
				hud_elem_type = "waypoint",
				name = name,
				text = "n",
				world_pos = def.pos,
				number = tonumber("0x" .. def.colour),
			})
		end]]
		waypoints[name].ref = ref
	end
	player:set_attribute("lottmisc:waypoints", minetest.serialize(waypoints))
end)

minetest.register_craftitem("lottmisc:map", {
	description = "Map",
	inventory_image = "lottmisc_map.png",
	on_place = function(_, user)
		local name = user:get_player_name()
		local pos = user:get_pos()
		local formspec = base_map_formspec(user, pos, 1)
		minetest.show_formspec(name, "lottmisc:map", formspec)
	end,
	on_secondary_use = function(_, user)
		local name = user:get_player_name()
		local pos = user:get_pos()
		local formspec = base_map_formspec(user, pos, 1)
		minetest.show_formspec(name, "lottmisc:map", formspec)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lottmisc:map" then
		return
	end
	local name = player:get_player_name()
	local pos = player:get_pos()
	if fields.tabs == "1" then
		local formspec = base_map_formspec(player, pos, 1)
		minetest.show_formspec(player:get_player_name(), "lottmisc:map", formspec)
	elseif fields.tabs == "2" then
		local formspec = base_map_formspec(player, pos, 2)
		minetest.show_formspec(player:get_player_name(), "lottmisc:map", formspec)
	elseif fields.add_delete_waypoint then
		local waypoints = get_waypoints(player)
		local label
		local colours = ""
		if waypoints[fields.waypoint_name] then
			label = "Are you sure you want to delete waypoint \"" ..
				minetest.formspec_escape(fields.waypoint_name) .. "\"?"
		elseif fields.waypoint_name ~= "" then
			label = "Are you sure you want to add waypoint \"" ..
				minetest.formspec_escape(fields.waypoint_name) ..
				"\"\nat x = " .. math.floor(pos.x) .. ", z = " .. math.floor(pos.z) .. "?"
			colours = "dropdown[3,2;2;colour;Red,Orange,Yellow,Green," ..
				"Blue,Purple,Pink,Brown,Black,White;1]"
		else
			return
		end
		player:set_attribute("lottmisc:tmp_waypoint_name", fields.waypoint_name)
		minetest.show_formspec(player:get_player_name(), "lottmisc:waypoint_confirm", "size[8,4]" ..
			"label[0.5,0.75;" .. label .. "]" ..
			"button[2,3;2,1;confirm;Confirm]" ..
			"button[4,3;2,1;cancel;Cancel]" ..
			colours)
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lottmisc:waypoint_confirm" then
		return
	end
	local name = player:get_player_name()
	local pos = player:get_pos()
	if fields.confirm then
		local waypoint_name = player:get_attribute("lottmisc:tmp_waypoint_name")
		local waypoints = get_waypoints(player)
		if waypoints[waypoint_name] then
			lottmisc.delete_waypoint(player, waypoint_name)
			minetest.chat_send_player(name, "Deleted waypoint!")
			local formspec = base_map_formspec(player, pos, 2)
			minetest.show_formspec(name, "lottmisc:map", formspec)
		else
			local pos = player:get_pos()
			local colour = "FF0000"
			if fields.colour == "Orange" then
				colour = "FFA500"
			elseif fields.colour == "Yellow" then
				colour = "FFFF00"
			elseif fields.colour == "Green" then
				colour = "008000"
			elseif fields.colour == "Blue" then
				colour = "0000FF"
			elseif fields.colour == "Purple" then
				colour = "800080"
			elseif fields.colour == "Pink" then
				colour = "DA70D6"
			elseif fields.colour == "Brown" then
				colour = "A52A2A"
			elseif fields.colour == "Black" then
				colour = "5E5E5E"
			elseif fields.colour == "White" then
				colour = "FFFFFF"
			end
			local result, message = lottmisc.add_waypoint(player, pos, waypoint_name, colour)
			minetest.chat_send_player(player:get_player_name(), message)
			local formspec = base_map_formspec(player, pos, 2)
			minetest.show_formspec(name, "lottmisc:map", formspec)
		end
	elseif fields.cancel then
		local formspec = base_map_formspec(player, pos, 2)
		minetest.show_formspec(name, "lottmisc:map", formspec)
	end
end)

