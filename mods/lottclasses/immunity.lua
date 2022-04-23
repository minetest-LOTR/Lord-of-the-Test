-- spawn immunity
local immune_spawn_amt = tonumber(minetest.settings:get("immune_spawn")) or 300
minetest.settings:set("immune_spawn", immune_spawn_amt)
local immune_amt = tonumber(minetest.settings:get("immune_spawn"))

-- Starter mob immunity to counter unfavourable spawns
minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	if minetest.settings:get_bool("disable_immune_spawn") then
		return
	end
	if minetest.settings:get_bool("enable_damage") then
		meta:set_string("lott:immunity", immune_amt)
		armor:set_player_armor(player)
		
		minetest.after(5, function()
			if player == nil then return end
			minetest.chat_send_player(name, minetest.colorize("green", "Starter mob immunity granted for "..immune_amt/ 60 .." minutes! Travel to a safe area!"))
		end)
		for i = 1, immune_amt do
			minetest.after(i, function()
				local immunity_c = meta:get_string("lott:immunity")
				if player == nil then return end
				if not tonumber(immunity_c) then return end
				meta:set_string("lott:immunity", tonumber(immunity_c) - 1)
			end)
		end
		minetest.after(immune_amt+1, function()
			meta:set_string("lott:immunity", "")
			minetest.chat_send_player(name, minetest.colorize("orange", "Your starter mob immunity has expired!"))
			armor:set_player_armor(player)
		end)
	end
end)

-- Resume starter mob immunity
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local immunity = meta:get_string("lott:immunity")
	if immunity and immunity ~= "" then
		if not tonumber(immunity) then
			meta:set_string("lott:immunity", "")
			return
		end
		if tonumber(immunity) >= immune_amt then
			return
		end
		minetest.chat_send_player(name, minetest.colorize("green", "Your starter mob immunity has resumed!"))
		minetest.chat_send_player(name, minetest.colorize("green", "You still have "..tonumber(immunity) / 60 .." minutes left!"))
	
		for i = 1, tonumber(immunity) do
			if not tonumber(immunity) then
				meta:set_string("lott:immunity", "")
				return
			end
			minetest.after(i, function()
				local immunity_c = meta:get_string("lott:immunity")
				if player == nil then return end
				if not tonumber(immunity) then return end
				meta:set_string("lott:immunity", tonumber(immunity_c) - 1)
			end)
		end
		minetest.after(immunity+1, function()
			if player == nil then return end
			meta:set_string("lott:immunity", "")
			armor:set_player_armor(player)
		
			minetest.chat_send_player(name, minetest.colorize("orange", "Your starter mob immunity has expired!"))
		end)
	end
end)