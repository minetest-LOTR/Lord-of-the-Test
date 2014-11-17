local time = 0
local update_time = tonumber(minetest.setting_get("curwe_update_time"))
if not update_time then
	update_time = 2
	minetest.setting_set("curwe_update_time", tostring(update_time))
end
local node_tiles = minetest.setting_getbool("curwe_node_tiles")
if not node_tiles then
	node_tiles = false
	minetest.setting_set("curwe_node_tiles", "true")
end

curwe = {
	wielded_item = {},
	transform = {},
}

dofile(minetest.get_modpath("curwe").."/armor/transform.lua")

curwe.get_item_texture = function(self, item)
	local texture = "curwe_trans.png"
	if item ~= "" then
		if minetest.registered_items[item] then
			if minetest.registered_items[item].inventory_image ~= "" then
				texture = minetest.registered_items[item].inventory_image
			elseif node_tiles == true and minetest.registered_items[item].tiles then
				texture = minetest.registered_items[item].tiles[1]
			end
		end
		if curwe.transform[item] then
			texture = texture.."^[transform"..curwe.transform[item]
		end
	end
	return texture
end

curwe.update_wielded_item = function(self, player)
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
		armor.textures[name].wielditem = self:get_item_texture(item)
		armor:update_player_visuals(player)
	end
	self.wielded_item[name] = item
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	curwe.wielded_item[name] = ""
	minetest.after(0, function(player)
		curwe:update_wielded_item(player)
	end, player)
end)

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > update_time then
		for _,player in ipairs(minetest.get_connected_players()) do
			curwe:update_wielded_item(player)
		end
		time = 0
	end
end)

