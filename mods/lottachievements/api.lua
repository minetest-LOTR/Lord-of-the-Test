-- AWARDS
--
-- Copyright (C) 2013-2015 rubenwardy
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- You should have received a copy of the GNU Lesser General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--

local S = lottachievements.gettext

dofile(minetest.get_modpath("lottachievements").."/api_helpers.lua")

-- Table Save Load Functions
function lottachievements.save()
	local file = io.open(minetest.get_worldpath().."/lottachievements.txt", "w")
	if file then
		file:write(minetest.serialize(lottachievements.players))
		file:close()
	end
end

function lottachievements.init()
	lottachievements.players = lottachievements.load()
	lottachievements.def = {}
	lottachievements.trigger_types = {}
	lottachievements.on = {}
	lottachievements.on_unlock = {}
end

function lottachievements.load()
	local file = io.open(minetest.get_worldpath().."/lottachievements.txt", "r")
	if file then
		local table = minetest.deserialize(file:read("*all"))
		if type(table) == "table" then
			return table
		end
	end
	return {}
end

function lottachievements.register_trigger(name, func)
	lottachievements.trigger_types[name] = func
	lottachievements.on[name] = {}
	lottachievements['register_on_'..name] = function(func)
		table.insert(lottachievements.on[name], func)
	end
end

function lottachievements.run_trigger_callbacks(player, data, trigger, table_func)
	for i = 1, #lottachievements.on[trigger] do
		local res = nil
		local entry = lottachievements.on[trigger][i]
		if type(entry) == "function" then
			res = entry(player, data)
		elseif type(entry) == "table" and entry.award then
			res = table_func(entry)
		end

		if res then
			lottachievements.unlock(player:get_player_name(), res)
		end
	end
end

function lottachievements.increment_item_counter(data, field, itemname, count)
	local name_split = string.split(itemname, ":")
	if #name_split ~= 2 then
		return false
	end
	local mod = name_split[1]
	local item = name_split[2]

	if data and field and mod and item then
		lottachievements.assertPlayer(data)
		lottachievements.tbv(data, field)
		lottachievements.tbv(data[field], mod)
		lottachievements.tbv(data[field][mod], item, 0)

		if data[field][mod][item] + (count or 1) < 0 then
			count = 0
		end
		data[field][mod][item] = data[field][mod][item] + (count or 1)
		return true
	else
		return false
	end
end

function lottachievements.get_item_count(data, field, itemname)
	local name_split = string.split(itemname, ":")
	if #name_split ~= 2 then
		return false
	end
	local mod = name_split[1]
	local item = name_split[2]

	if data and field and mod and item then
		lottachievements.assertPlayer(data)
		lottachievements.tbv(data, field)
		lottachievements.tbv(data[field], mod)
		lottachievements.tbv(data[field][mod], item, 0)
		return data[field][mod][item]
	end
end

function lottachievements.get_total_item_count(data, field)
	local i = 0
	if data and field then
		lottachievements.assertPlayer(data)
		lottachievements.tbv(data, field)
		for mod,_ in pairs(data[field]) do
			lottachievements.tbv(data[field], mod)
			for item,_ in pairs(data[field][mod]) do
				lottachievements.tbv(data[field][mod], item, 0)
				i = i + data[field][mod][item]
			end
		end
	end
	return i
end

function lottachievements.register_on_unlock(func)
	table.insert(lottachievements.on_unlock, func)
end

-- API Functions
function lottachievements._additional_triggers(name, def)
	-- Depreciated!
end

function lottachievements.register_achievement(name, def)
	def.name = name

	-- Add Triggers
	if def.trigger and def.trigger.type then
		local func = lottachievements.trigger_types[def.trigger.type]

		if func then
			func(def)
		else
			lottachievements._additional_triggers(name, def)
		end
	end

	-- Add Award
	lottachievements.def[name] = def

	local tdef = lottachievements.def[name]
	if def.description == nil and tdef.getDefaultDescription then
		def.description = tdef:getDefaultDescription()
	end
end

function lottachievements.enable(name)
	local data = lottachievements.player(name)
	if data then
		data.disabled = nil
	end
end

function lottachievements.disable(name)
	local data = lottachievements.player(name)
	if data then
		data.disabled = true
	end
end

function lottachievements.clear_player(name)
	lottachievements.players[name] = {}
end

-- This function is called whenever a target condition is met.
-- It checks if a player already has that achievement, and if they do not,
-- it gives it to them
----------------------------------------------
--lottachievements.unlock(name, award)
-- name - the name of the player
-- award - the name of the award to give
function lottachievements.unlock(name, award)
	-- Access Player Data
	local data  = lottachievements.players[name]
	local awdef = lottachievements.def[award]

	-- Perform checks
	if not data then
		return
	end
	if not awdef then
		return
	end
	if data.disabled then
		return
	end
	lottachievements.tbv(data,"unlocked")

	-- Don't give the achievement if it has already been given
	if data.unlocked[award] and data.unlocked[award] == award then
		return
	end

	-- Unlock Award
	minetest.log("action", name.." has unlocked award "..name)
	data.unlocked[award] = award
	lottachievements.save()

	-- Give Prizes
	if awdef and awdef.prizes then
		for i = 1, #awdef.prizes do
			local itemstack = ItemStack(awdef.prizes[i])
			if not itemstack:is_empty() then
				local receiverref = minetest.get_player_by_name(name)
				if receiverref then
					receiverref:get_inventory():add_item("main", itemstack)
				end
			end
		end
	end

	-- Run callbacks
	if awdef.on_unlock and awdef.on_unlock(name, awdef) then
		return
	end
	for _, callback in pairs(lottachievements.on_unlock) do
		if callback(name, awdef) then
			return
		end
	end

	-- Get Notification Settings
	local title = awdef.title or award
	local desc = awdef.description or ""
	local background = awdef.background or "lottachievements_bg_default.png"
	local icon = awdef.icon or "lottachievements_unknown.png"
	local sound = awdef.sound
	if sound == nil then
		-- Explicit check for nil because sound could be `false` to disable it
		sound = {name="lottachievements_got_generic", gain=0.25}
	end
	local custom_announce = awdef.custom_announce
	if not custom_announce then
		if awdef.secret then
			custom_announce = S("Secret Achievement Unlocked:")
		else
			custom_announce = S("Achievement Unlocked:")
		end
	end

	-- Do Notification
	if sound then
		-- Enforce sound delay to prevent sound spamming
		local lastsound = lottachievements.players[name].lastsound
		if lastsound == nil or os.difftime(os.time(), lastsound) >= 1 then
			minetest.sound_play(sound, {to_player=name})
			lottachievements.players[name].lastsound = os.time()
		end
	end

	if lottachievements.show_mode == "formspec" then
		-- use a formspec to send it
		minetest.show_formspec(name, "achievements:unlocked", "size[6,2]"..
				"image_button_exit[0,0;6,2;"..background..";close1; ]"..
				"image_button_exit[0.2,0.8;1,1;"..icon..";close2; ]"..
				"label[1.1,1;"..title.."]"..
				"label[0.3,0.1;"..custom_announce.."]")
	elseif lottachievements.show_mode == "chat" then
		local chat_announce
		if awdef.secret == true then
			chat_announce = S("Secret Achievement Unlocked: %s")
		else
			chat_announce = S("Achievement Unlocked: %s")
		end
		-- use the chat console to send it
		minetest.chat_send_player(name, string.format(chat_announce, title))
		if desc~="" then
			minetest.chat_send_player(name, desc)
		end
	else
		local player = minetest.get_player_by_name(name)
		local one = player:hud_add({
			hud_elem_type = "image",
			name = "award_bg",
			scale = {x = 2, y = 1},
			text = background,
			position = {x = 0.5, y = 0},
			offset = {x = 0, y = 138},
			alignment = {x = 0, y = -1}
		})
		local hud_announce
		if awdef.secret == true then
			hud_announce = S("Secret Achievement Unlocked!")
		else
			hud_announce = S("Achievement Unlocked!")
		end
		local two = player:hud_add({
			hud_elem_type = "text",
			name = "award_au",
			number = 0xFFFFFF,
			scale = {x = 100, y = 20},
			text = hud_announce,
			position = {x = 0.5, y = 0},
			offset = {x = 0, y = 40},
			alignment = {x = 0, y = -1}
		})
		local three = player:hud_add({
			hud_elem_type = "text",
			name = "award_title",
			number = 0xFFFFFF,
			scale = {x = 100, y = 20},
			text = title,
			position = {x = 0.5, y = 0},
			offset = {x = 30, y = 100},
			alignment = {x = 0, y = -1}
		})
		local four = player:hud_add({
			hud_elem_type = "image",
			name = "award_icon",
			scale = {x = 4, y = 4},
			text = icon,
			position = {x = 0.4, y = 0},
			offset = {x = -81.5, y = 126},
			alignment = {x = 0, y = -1}
		})
		minetest.after(4, function()
			player:hud_remove(one)
			player:hud_remove(two)
			player:hud_remove(three)
			player:hud_remove(four)
		end)
	end
end

-- Backwards compatibility
lottachievements.give_achievement = lottachievements.unlock

--[[minetest.register_chatcommand("gawd", {
	params = "award name",
	description = "gawd: give award to self",
	func = function(name, param)
		lottachievements.unlock(name,param)
	end
})]]--

function lottachievements.getFormspec(name, to, sid)
	local formspec = ""
	local listoflottachievements = lottachievements._order_lottachievements(name)
	local completed = lottachievements.completed_achievements(name)
	local playerdata = lottachievements.players[name]

	if #listoflottachievements == 0 then
		formspec = formspec .. "label[3.9,1.5;"..minetest.formspec_escape(S("Error: No lottachievements available.")).."]"
		formspec = formspec .. "button_exit[4.2,2.3;3,1;close;"..minetest.formspec_escape(S("OK")).."]"
		return formspec
	end

	-- Sidebar
	if sid then
		local item = listoflottachievements[sid+0]
		local def = lottachievements.def[item.name]

		if def and def.secret and not item.got then
			formspec = formspec .. "label[0.64,2.75;"..
							minetest.formspec_escape(minetest.colorize("black", S("(Secret Achievement)"))).."]"..
							"image[1,0;3,3;lottachievements_unknown.png]"
			if def and def.description then
				formspec = formspec	.. "textarea[0.25,3.25;4.8,1.7;;"..
					minetest.formspec_escape(minetest.colorize("black", S("Unlock this achievement to find out what it is.")))..";]"
			end
		elseif def and def.requires and not item.got and not completed[def.requires] then
			formspec = formspec .. "label[0.56,2.75;"..
							minetest.formspec_escape(minetest.colorize("black", S("(Hidden Achievement)"))).."]"..
							"image[1,0;3,3;lottachievements_unknown.png]"
			if def and def.description and lottachievements.def[def.requires] then
				if lottachievements.def[def.requires].requires and
				not completed[lottachievements.def[def.requires].requires] then
					formspec = formspec	.. "textarea[0.25,3.25;4.8,2;;"..
						minetest.formspec_escape(minetest.colorize("black",
						S("To see this achievement you need to complete more achievements!"))) .. ";]"
				else
					formspec = formspec	.. "textarea[0.25,3.25;4.8,2;;"..
						minetest.formspec_escape(minetest.colorize("black",
						S("To see this achievement, complete \"")
						 .. lottachievements.def[def.requires].title .. "\""))..";]"
				end
			end
		else
			local title = item.name
			if def and def.title then
				title = def.title
			end
			local status = ""
			if item.got then
				status = minetest.colorize("green", S("(completed)"))
			end

			formspec = formspec .. "textarea[0.5,2.7;4.8,1.45;;" ..
				minetest.formspec_escape(minetest.colorize("black", title)) .. "\n" .. status .. ";]"

			if def and def.icon then
				formspec = formspec .. "image[1,0;3,3;" .. def.icon .. "]"
			end
			local barwidth = 4.6
			local perc = nil
			local label = nil
			if def.getProgress and playerdata then
				local res = def:getProgress(playerdata)
				perc = res.perc
				label = res.label
			end
			if perc then
				if perc > 1 then
					perc = 1
				end
				formspec = formspec .. "background[0,4.675;" .. barwidth ..",0.425;lottachievements_progress_gray.png;false]"
				formspec = formspec .. "background[0,4.675;" .. (barwidth * perc) ..",0.425;lottachievements_progress_green.png;false]"
				if label then
					formspec = formspec .. "label[1.75,4.63;" .. minetest.formspec_escape(label) .. "]"
				end
			end
			if def and def.description then
				formspec = formspec	.. "textarea[0.25,3.75;4.8,1.7;;"..
					minetest.formspec_escape(minetest.colorize("black", def.description))..";]"
			end
		end
	end

	-- Create list box
	formspec = formspec .. "textlist[4.75,0;6,5;lottachievements;"
	local first = true
	for _,award in pairs(listoflottachievements) do
		local def = lottachievements.def[award.name]
		if def then
			if not first then
				formspec = formspec .. ","
			end
			first = false

			if def.secret and not award.got then
				formspec = formspec .. "#808080" ..minetest.formspec_escape(S("(Secret Achievement)"))
			elseif def.requires and not award.got and not completed[def.requires] then
				formspec = formspec .. "#ACACAC" ..minetest.formspec_escape(S("(Hidden Achievement)"))
			else
				local title = award.name
				if def and def.title then
					title = def.title
				end
				if award.got then
					formspec = formspec .. "#00CC00" ..minetest.formspec_escape(title)
				else
					formspec = formspec .. minetest.formspec_escape(title)
				end
			end
		end
	end
	return formspec .. ";"..sid.."]"
end

function lottachievements.show_to(name, to, sid, text)
	if name == "" or name == nil then
		name = to
	end
	if name == to and lottachievements.player(to).disabled then
		minetest.chat_send_player(S("You've disabled lottachievements. Type /lottachievements enable to reenable."))
		return
	end
	if text then
		local listoflottachievements = lottachievements._order_lottachievements(name)
		if #listoflottachievements == 0 then
			minetest.chat_send_player(to, S("Error: No lottachievements available."))
			return
		elseif not lottachievements.players[name] or not lottachievements.players[name].unlocked  then
			minetest.chat_send_player(to, S("You have not unlocked any lottachievements."))
			return
		end
		minetest.chat_send_player(to, string.format(S("%s’s lottachievements:"), name))

		for _, str in pairs(lottachievements.players[name].unlocked) do
			local def = lottachievements.def[str]
			if def then
				if def.title then
					if def.description then
						minetest.chat_send_player(to, string.format(S("%s: %s"), def.title, def.description))
					else
						minetest.chat_send_player(to, def.title)
					end
				else
					minetest.chat_send_player(to, str)
				end
			end
		end
	else
		if sid == nil or sid < 1 then
			sid = 1
		end
		-- Show formspec to user
		minetest.show_formspec(to,"lottachievements:lottachievements",
			"size[11,5]" ..
			"background[5,5;1,1;gui_formbg.png;true]" ..
			lottachievements.getFormspec(name, to, sid))
	end
end
lottachievements.showto = lottachievements.show_to

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lottachievements:lottachievements" then
		return false
	end
	if fields.quit then
		return true
	end
	local name = player:get_player_name()
	if fields.lottachievements then
		local event = minetest.explode_textlist_event(fields.lottachievements)
		if event.type == "CHG" then
			lottachievements.show_to(name, name, event.index, false)
		end
	end

	return true
end)

lottachievements.init()

minetest.register_on_newplayer(function(player)
	local playern = player:get_player_name()
	lottachievements.assertPlayer(playern)
end)

minetest.register_on_shutdown(function()
	lottachievements.save()
end)
