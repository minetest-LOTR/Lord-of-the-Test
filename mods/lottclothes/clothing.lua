clothing = {
	formspec = armor.formspec,
	textures = {},
}

clothing.set_player_clothing = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	if not name or not player_inv then
		return
	end
	local clothing_texture = "lottarmor_trans.png"
	local elements = {}
	local textures = {}
	local preview = multiskin:get_skin_name(name) or "clothing_preview"
	preview = preview..".png"
	for i=1, 5 do
		local stack = player_inv:get_stack("clothing", i)
		local item = stack:get_name()
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			if def.groups["clothes"] == 1 then
				local texture = item:gsub("%:", "_")
				table.insert(textures, texture..".png")
				if not def.groups["no_preview"] then
					preview = preview.."^"..texture.."_preview.png"
				end
			end
		end
	end
	if #textures > 0 then
		clothing_texture = table.concat(textures, "^")
	end
	self.textures[name].clothing = clothing_texture
	self.textures[name].preview = preview
	multiskin[name].clothing = clothing_texture
	multiskin:update_player_visuals(player)
end

clothing.update_inventory = function(self, player)
	local name = player:get_player_name()
	if unified_inventory then
		if unified_inventory.current_page[name] == "clothing" then
			unified_inventory.set_inventory_formspec(player, "clothing")
		end
	else
		local formspec = armor.get_armor_formspec(self, name)
		if inventory_plus then
			local page = player:get_inventory_formspec()
			if page:find("detached:"..name.."_clothing") then
				inventory_plus.set_inventory_formspec(player, formspec)
			end
		else
			player:set_inventory_formspec(formspec)
		end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if inventory_plus and fields.clothing then
		local formspec = clothing:get_clothing_formspec(name)
		inventory_plus.set_inventory_formspec(player, formspec)
		return
	end
end)

minetest.register_on_joinplayer(function(player)
	multiskin:init(player)
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	local clothing_inv = minetest.create_detached_inventory(name.."_clothing",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			clothing:set_player_clothing(player)
			clothing:update_inventory(player)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			clothing:set_player_clothing(player)
			clothing:update_inventory(player)
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			local plaver_inv = player:get_inventory()
			local stack = inv:get_stack(to_list, to_index)
			player_inv:set_stack(to_list, to_index, stack)
			player_inv:set_stack(from_list, from_index, nil)
			clothing:set_player_clothing(player)
			clothing:update_inventory(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			return 1
		end,
		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return count
		end,
	})
	clothing_inv:set_size("clothing", 5)
	player_inv:set_size("clothing", 5)
	for i=1, 5 do
		local stack = player_inv:get_stack("clothing", i)
		clothing_inv:set_stack("clothing", i, stack)
	end
	clothing.textures[name] = {
		clthing = "clothing_trans.png",
		preview = "clothing_preview.png",
	}
	for i=1, ARMOR_INIT_TIMES do
		minetest.after(ARMOR_INIT_DELAY * i, function(player)
			clothing:set_player_clothing(player)
			if inventory_plus == nil and unified_inventory == nil then
				clothing:update_inventory(player)
			end
		end, player)
	end
end)
