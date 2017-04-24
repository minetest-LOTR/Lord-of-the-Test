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

minetest.register_chatcommand("achievements", {
	params = S("[c|clear|disable|enable]"),
	description = S("Show, clear, disable or enable your achievements"),
	func = function(name, param)
		if param == "clear" then
			lottachievements.clear_player(name)
			minetest.chat_send_player(name,
			S("All your achievements and statistics have been cleared. You can now start again."))
		elseif param == "disable" then
			lottachievements.disable(name)
			minetest.chat_send_player(name, S("You have disabled your achievements."))
		elseif param == "enable" then
			lottachievements.enable(name)
			minetest.chat_send_player(name, S("You have enabled your achievements."))
		elseif param == "c" then
			lottachievements.show_to(name, name, nil, true)
		else
			lottachievements.show_to(name, name, nil, false)
		end
	end
})

minetest.register_chatcommand("achievement-info", {
	params = S("<achievement ID>"),
	description = S("Show details of an achievement"),
	func = function(name, param)
		local def = lottachievements.def[param]
		if def then
			minetest.chat_send_player(name, string.format(S("%s: %s"), def.title, def.description))
		else
			minetest.chat_send_player(name, S("Achievement not found."))
		end
	end
})

minetest.register_chatcommand("achievement-stats", {
	privs = {
		server = true
	},
	params = S("<name>"),
	description = S("Get the achievements statistics for the given player or yourself"),
	func = function(name, param)
		if not param or param == "" then
			param = name
		end
		minetest.chat_send_player(name, param)
		local player = lottachievements.player(param)
		minetest.chat_send_player(name, dump(player))
	end
})
