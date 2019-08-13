-- Customize various messages based on race
minetest.register_on_chat_message(function(name, message)
	local player = minetest.get_player_by_name(name)
	if not player then
		return
	end
	local race = player:get_attribute("race")
	if not race or race == "" then
		return false
	end
	minetest.chat_send_all("<" .. minetest.colorize(lottplayer.races[tonumber(race)][7], name)
		.. "> " .. message)
	minetest.log("action", "CHAT: <" .. name .. "> " .. message)
	return true
end)