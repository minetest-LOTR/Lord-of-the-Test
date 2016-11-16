local time = 0
local update_time = 2
local node_tiles = true

lottarmor = {
	wielded_item = {},
	transform = {},
}

dofile(minetest.get_modpath(minetest.get_current_modname()).."/transform.lua")

lottarmor.get_item_texture = function(self, item)
	local texture = "lottarmor_trans.png"
	if item ~= "" then
		if minetest.registered_items[item] then
			if minetest.registered_items[item].inventory_image ~= "" then
				texture = minetest.registered_items[item].inventory_image
			elseif node_tiles == true and minetest.registered_items[item].tiles
					and type(minetest.registered_items[item].tiles[1]) == "string"
					and minetest.registered_items[item].tiles[1] ~= "" then
				texture = minetest.inventorycube(minetest.registered_items[item].tiles[1])
			end
		end
		if lottarmor.transform[item] then
			texture = texture.."^[transform"..lottarmor.transform[item]
		end
	end
	return texture
end

lottarmor.update_wielded_item = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local stack = player:get_wielded_item()
	local item = stack:get_name()
	if not item then
		return
	end
	if self.wielded_item[name] then
		if self.wielded_item[name] == item then
			return
		end
		multiskin[name].wielditem = self:get_item_texture(item)
		multiskin:update_player_visuals(player)
	end
	self.wielded_item[name] = item
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	lottarmor.wielded_item[name] = ""
	minetest.after(0, function(player)
		lottarmor:update_wielded_item(player)
	end, player)
end)

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > update_time then
		for _,player in ipairs(minetest.get_connected_players()) do
			lottarmor:update_wielded_item(player)
		end
		time = 0
	end
end)
