function lottplayer.set_physics(player, field, value)
	if not player or not player:is_player() then
		return
	end
	local current_value = player:get_physics_override()[field]
	if not current_value or current_value + value < 0 then
		return
	end
	player:set_physics_override({[field] = current_value + value})
end
