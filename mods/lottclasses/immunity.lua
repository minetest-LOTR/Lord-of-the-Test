-- spawn immunity
local immune_spawn_amt = tonumber(minetest.settings:get("immune_spawn")) or 300
minetest.settings:set("immune_spawn", immune_spawn_amt)
local immune_amt = tonumber(minetest.settings:get("immune_spawn"))

local function immunity_timer(name, i, update_armor)
	local player = minetest.get_player_by_name(name)
	if not player then return end

	local meta = player:get_meta()
	if i > 0 then
		i = i - 1
		meta:set_string("lott:immunity", i)

		-- Reduce the immunity in one second
		minetest.after(1, immunity_timer, name, i)
	else
		-- Remove the starter mob immunity and tell the player
		meta:set_string("lott:immunity", "")
		minetest.chat_send_player(name, minetest.colorize("orange", "Your starter mob immunity has expired!"))
		update_armor = true
	end

	-- Update the player's armor if required
	if update_armor then
		armor:set_player_armor(player)
	end
end

-- Starter mob immunity to counter unfavourable spawns
minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	if minetest.settings:get_bool("disable_immune_spawn") or
			not minetest.settings:get_bool("enable_damage") then
		return
	end
	
	minetest.after(0.3, immunity_timer, name, immune_amt, true)
	minetest.after(5, function()
		minetest.chat_send_player(name, minetest.colorize("green", "Starter mob immunity granted for " .. immune_amt / 60 .. " minutes! Travel to a safe area!"))
	end)
end)

-- Resume starter mob immunity
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local immunity = meta:get_string("lott:immunity")
	if immunity and immunity ~= "" then
		immunity = tonumber(immunity)
		if not immunity then
			meta:set_string("lott:immunity", "")
			return
		end
		if immunity >= immune_amt then
			return
		end

		minetest.chat_send_player(name, minetest.colorize("green", "Your starter mob immunity has resumed!"))
		minetest.chat_send_player(name, minetest.colorize("green", "You still have " .. immunity / 60 .. " minutes left!"))

		-- Start counting down the immunity timer again
		minetest.after(1, immunity_timer, name, immunity - 1)
	end
end)
