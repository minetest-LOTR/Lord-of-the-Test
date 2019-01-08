lottplayer.inv = function(player, force)
	local meta = player:get_meta()
	if meta:get_string("lottplayer:inv") == "" then
		meta:set_string("lottplayer:inv", 1)
	end
	
	if tonumber(meta:get_string("lottplayer:inv")) then
		if force == true then
			return lottplayer.inv_list[tonumber(meta:get_string("lottplayer:inv"))][2]
		else
			return lottplayer.inv_list[tonumber(meta:get_string("lottplayer:inv"))][1]
		end
	else meta:set_string("lottplayer:inv", 1)
	end
end

lottplayer.inv_update = function(player, fields, formname)
	local inv_max = 0
	for _ in pairs(lottplayer.inv_list)
		do inv_max = inv_max + 1
	end
	
	local name = player:get_player_name()
	local meta = player:get_meta()
	if fields.lottplayer_inv_up or fields.lottplayer_inv_down or fields.lottplayer_inv_up_force or fields.lottplayer_inv_down_force then
		if tonumber(meta:get_string("lottplayer:inv")) then
			local inv_no = tonumber(meta:get_string("lottplayer:inv"))
			
			-- change inventory number
			if fields.lottplayer_inv_up or fields.lottplayer_inv_up_force then
				if inv_no + 1 > inv_max then
					meta:set_string("lottplayer:inv", 1)
				else
					meta:set_string("lottplayer:inv", inv_no + 1)
				end
			elseif fields.lottplayer_inv_down or fields.lottplayer_inv_down_force then
				if inv_no - 1 < 1 then
					meta:set_string("lottplayer:inv", inv_max)
				else
					meta:set_string("lottplayer:inv", inv_no - 1)
				end
			end
			
			-- set inventory
			if fields.lottplayer_inv_up_force or fields.lottplayer_inv_down_force then
				if formname ~= nil then
					player:set_inventory_formspec(
						lottplayer.inv_size("4x4")..
						formname..
						lottplayer.inv(player, true)
					)
				end
			end
		else
			meta:set_string("lottplayer:inv", 1)
		end
	end
end

lottplayer.inv_update_force = function(player, formname)
	player:set_inventory_formspec(
		formname..
		lottplayer.inv(player, true)
	)
end

lottplayer.inv_left = function(player)
	local meta = player:get_meta()
	if meta:get_string("lottplayer:inv_left") == "" then
		meta:set_string("lottplayer:inv_left", 1)
	end
	
	if tonumber(meta:get_string("lottplayer:inv_left")) then
		return lottplayer.inv_list_left[tonumber(meta:get_string("lottplayer:inv_left"))][1]
	else meta:set_string("lottplayer:inv_left", 1)
	end
end

lottplayer.inv_left_update = function(player, fields)
	local inv_max_left = 0
	for _ in pairs(lottplayer.inv_list_left)
		do inv_max_left = inv_max_left + 1
	end
	
	local name = player:get_player_name()
	local meta = player:get_meta()
	if fields.lottplayer_inv_up_left or fields.lottplayer_inv_down_left then
		
		if tonumber(meta:get_string("lottplayer:inv_left")) then
			local inv_no = tonumber(meta:get_string("lottplayer:inv_left"))
			if fields.lottplayer_inv_up_left then
				if inv_no + 1 > inv_max_left then
					meta:set_string("lottplayer:inv_left", 1)
				else
					meta:set_string("lottplayer:inv_left", inv_no + 1)
				end
			elseif fields.lottplayer_inv_down_left then
				if inv_no - 1 < 1 then
					meta:set_string("lottplayer:inv_left", inv_max_left)
				else
					meta:set_string("lottplayer:inv_left", inv_no - 1)
				end
			end
		end
		
		player:set_inventory_formspec(
			lottplayer.inv_size("4x4")..
			lottplayer.inv(player, true)..
			lottplayer.inv_left(player)
		)
	end
end

lottplayer.inv_quit = function(sender)
	if minetest.settings:get_bool("creative_mode") then
		creative.update_formspec(sender, creative.page(sender))
	else lottplayer.inv_update_force(sender, lottplayer.inv_size("4x4")..lottplayer.inv_left(sender))
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	lottplayer.inv_update(player, fields, lottplayer.inv_left(player))
	lottplayer.inv_left_update(player, fields)
end)
--

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	if meta:get_string("lottplayer:inv") == nil then
		meta:set_string("lottplayer:inv", 1)
	end
	if meta:get_string("lottplayer:inv_left") == nil then
		meta:set_string("lottplayer:inv_left", 1)
	end
	
	player:set_inventory_formspec(
		lottplayer.inv_size("4x4")..
		lottplayer.inv(player, true)..
		lottplayer.inv_left(player)
	)
end)