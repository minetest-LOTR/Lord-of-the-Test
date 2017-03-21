lottblocks.palantiri = {}
local tmp
local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/palantiri", "r")
if file then
	tmp = minetest.deserialize(file:read("*all"))
	file:close()
end

if tmp ~= nil then
	lottblocks.palantiri = tmp[1]
end

local function save_palantiri()
        minetest.mkdir(minetest.get_worldpath().."/"..SAVEDIR)
	local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/palantiri", "w")
	if file then
		file:write(minetest.serialize({lottblocks.palantiri}))
		file:close()
	end
end

local function check_blocks(pos)
	local minp = {x = pos.x - 2, y = pos.y - 2, z = pos.z - 2}
	local maxp = {x = pos.x + 2, y = pos.y + 2, z = pos.z + 2}
	local _, tilkal = minetest.find_nodes_in_area(minp, maxp, "lottores:tilkal")
	local _, mithril = minetest.find_nodes_in_area(minp, maxp, "lottores:mithril_block")
	if tilkal["lottores:tilkal"] < 6 or mithril["lottores:mithril_block"] < 16 then
		return false
	end
	return true
end

minetest.register_on_shutdown(function()
	save_palantiri()
end)

local purple = "#6d54dd"

local function formspec_update(meta)
	local network = meta:get_string("network")
	local palantir = meta:get_string("name")
	local form = "size[6,5]" ..
		"background[5,5;1,1;gui_elfbg.png;true]"..
		"label[1.5,1;Network Name: " .. network .. "]" ..
		"label[1.5,1.5;Palantir Name: " .. palantir .. "]" ..
		"dropdown[1.5,2.5;3;teleports;Teleport to..."
	for i,v in pairs(lottblocks.palantiri[network]) do
		if i ~= palantir and i ~= "options" and i ~= "owner" then
			form = form .. "," .. i
		end
	end
	form = form .. ";1]"
	local n = 1
	local h = 3.5
	for i,v in pairs(lottblocks.palantiri[network]["options"]) do
		local c = "red"
		if v == "true" then
			c = "green"
		end
		form = form .. "label[" .. n .. "," .. h .. ";" .. minetest.colorize(c, i) .. "]"
		n = n + 1.5
		if n == 5.5 then
			n = 1
			h = 4
		end
	end
	return form
end

local races = {
	{"dwarves", "GAMEdwarf"},
	{"elves", "GAMEelf"},
	{"men", "GAMEman"},
	{"orcs", "GAMEorc"},
	{"hobbits", "GAMEhobbit"}
}

local function options_form(network)
	local checkbox_pos = 1
	local options = "size[5,5]" ..
		"background[5,5;1,1;gui_elfbg.png;true]" ..
		"label[1,0.5;Allowed races:]" ..
		"button[1,4;2,1;exit;Proceed]"
	for _, race in pairs(races) do
		options = options .. "checkbox[1," .. checkbox_pos .. ";" .. race[1] ..
		";" .. race[1]:gsub("^%l", string.upper) .. ";" ..
		tostring(lottblocks.palantiri[network].options[race[1]]) .. "]"
		checkbox_pos = checkbox_pos + 0.5
	end
	return options
end

minetest.register_privilege("palantiri", {
	description = "Allows editing palantiri",
	give_to_singleplayer = false,
})

minetest.register_node("lottblocks:palantir", {
	description = "Palantir",
	tiles = {"default_obsidian.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "lottblocks_palantir.obj",
	node_placement_prediction = "",
	on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("configured") == 2 then
			meta:set_string("formspec", formspec_update(meta))
		end
	end,
	on_rightclick = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("configured") == 2 then
			meta:set_string("formspec", formspec_update(meta))
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		if check_blocks(pointed_thing.above) == false then
			minetest.chat_send_player(placer:get_player_name(),
			minetest.colorize(purple, "One does not simply set down a palantir..."))
			return
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_int("configured", 0)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("formspec", "size[8,5]" ..
		"background[8,5;1,1;gui_elfbg.png;true]"..
		"button[2.75,3.5;3,1;exit;Proceed]" ..
		"field[3,1;3,1;network;Network Name;]" ..
		"field[3,2.5;3,1;palantir;Palantir Name;]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local configured = meta:get_int("configured")
		local player_name = sender:get_player_name()
		if configured == 0 then
			if not fields.network or not fields.palantir
			or fields.network == "" or fields.palantir == "" then
				minetest.chat_send_player(player_name,
				minetest.colorize("red", "Both the network and the palantir must have a name!!"))
				return
			end
			if fields.palantir == "owner" or fields.palantir == "options" then
				minetest.chat_send_player(player_name,
				minetest.colorize("red", "Palantir cannot use reserved name!"))
				return
			end
			if not lottblocks.palantiri[fields.network] then
				lottblocks.palantiri[fields.network] = {}
				lottblocks.palantiri[fields.network].owner = player_name
			else
				if lottblocks.palantiri[fields.network].owner ~= player_name
				and not minetest.check_player_privs(sender, "palantiri") then
					minetest.chat_send_player(player_name,
					minetest.colorize("red", "Someone else has a network with this name!"))
					return
				end
			end
			if not lottblocks.palantiri[fields.network][fields.palantir] then
				lottblocks.palantiri[fields.network][fields.palantir] = pos
			else
				minetest.chat_send_player(player_name,
				minetest.colorize("red", "A palantir already exists on this network with the same name!"))
				return
			end
			if not lottblocks.palantiri[fields.network].options then
				lottblocks.palantiri[fields.network].options = {}
				local options = lottblocks.palantiri[fields.network].options
				for _, race in pairs(races) do
					options[race[1]] = "true"
				end
			end
			meta:set_string("network", fields.network)
			meta:set_string("name", fields.palantir)
			meta:set_string("formspec", options_form(fields.network))
			save_palantiri()
			meta:set_int("configured", 1)
		elseif meta:get_int("configured") == 1 then
			local network = meta:get_string("network")
			if player_name == meta:get_string("owner") then
				for _, race in pairs(races) do
					if fields[race[1]] ~= nil then
						lottblocks.palantiri[network].options[race[1]] = tostring(fields[race[1]])
					end
				end
			end
			if fields.exit then
				meta:set_string("formspec", formspec_update(meta))
				meta:set_int("configured", 2)
			end
		else
			if check_blocks(pos) == false then
				minetest.chat_send_player(player_name,
					minetest.colorize(purple, "The palantiri is no longer anchored to the world!"))
				minetest.remove_node(pos)
				minetest.add_item(pos, "lottblocks:palantir")
				return
			end
			local can_tp = true
			local network = meta:get_string("network")
			local allowed_races = {}
			for race, allowed in pairs(lottblocks.palantiri[network].options) do
				if allowed == "true" then
					allowed_races[race] = true
				end
			end
			if player_name ~= meta:get_string("owner") and
			minetest.check_player_privs(player_name, {palantiri = true}) ~= true then
				for _, race in pairs(races) do
					if allowed_races[race[1]] == true then
						can_tp = minetest.check_player_privs(player_name, {[race[2]] = true})
						if can_tp == true then
							break
						end
					end
				end
				local c = 0
				for i,v in pairs(allowed_races) do c = c + 1 end
				if c == 0 then
					can_tp = false
				end
			end
			if can_tp == true then
				if fields.teleports == "Teleport to..." then
					sender:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
					return
				elseif fields.teleports == nil or
				lottblocks.palantiri[meta:get_string("network")][fields.teleports] == nil then
					return
				end
				local p = lottblocks.palantiri[meta:get_string("network")][fields.teleports]
				sender:setpos({x = p.x, y = p.y + 1, z = p.z})
			elseif can_tp == false then
				if not fields.teleports == "Teleport to..." then
					sender:setpos({
						x = pos.x + math.random(-50, 50),
						y = pos.y + math.random(20, 50),
						z = pos.z + math.random(-50, 50)
					})
					sender:set_hp(math.random(1,10))
				end
			end
		end
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("configured") >= 1 then
			lottblocks.palantiri[meta:get_string("network")][meta:get_string("name")] = nil
		end
	end,
	groups = {forbidden = 1, very_hard = 1},
})

minetest.register_craft({
	output = "lottblocks:palantir",
	recipe = {
		{"default:obsidian", "lottores:tilkal", "default:obsidian"},
		{"lottores:tilkal", "default:obsidian", "lottores:tilkal"},
		{"default:obsidian", "lottores:tilkal", "default:obsidian"}
	}
})
