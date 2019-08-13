
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	
	local armour = minetest.create_detached_inventory(name.."_armour", {}, name)
	armour:set_size("armour", 5)
end)