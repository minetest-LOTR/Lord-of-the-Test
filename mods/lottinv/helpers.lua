lottinv.inv = function(player, force)
	local meta = player:get_meta()
	if meta:get_string("lottinv:inv") == "" then
		meta:set_string("lottinv:inv", 1)
	end
	
	if tonumber(meta:get_string("lottinv:inv")) then
		if force == true then
			return lottinv.inv_list(player)[tonumber(meta:get_string("lottinv:inv"))][2]
		else
			return lottinv.inv_list(player)[tonumber(meta:get_string("lottinv:inv"))][1]
		end
	else meta:set_string("lottinv:inv", 1)
	end
end

lottinv.inv_update = function(player, fields, formname)
	local inv_max = 0
	for _ in pairs(lottinv.inv_list(player))
		do inv_max = inv_max + 1
	end
	
	local name = player:get_player_name()
	local meta = player:get_meta()
	if fields.lottinv_inv_up or fields.lottinv_inv_down or fields.lottinv_inv_up_force or fields.lottinv_inv_down_force then
		if tonumber(meta:get_string("lottinv:inv")) then
			local inv_no = tonumber(meta:get_string("lottinv:inv"))
			
			-- change inventory number
			if fields.lottinv_inv_up or fields.lottinv_inv_up_force then
				if inv_no + 1 > inv_max then
					meta:set_string("lottinv:inv", 1)
				else
					meta:set_string("lottinv:inv", inv_no + 1)
				end
			elseif fields.lottinv_inv_down or fields.lottinv_inv_down_force then
				if inv_no - 1 < 1 then
					meta:set_string("lottinv:inv", inv_max)
				else
					meta:set_string("lottinv:inv", inv_no - 1)
				end
			end
			
			-- set inventory
			if fields.lottinv_inv_up_force or fields.lottinv_inv_down_force then
				if formname ~= nil then
					player:set_inventory_formspec(
						lottinv.inv_size("4x4")..
						formname..
						lottinv.inv(player, true)
					)
				end
			end
		else
			meta:set_string("lottinv:inv", 1)
		end
	end
end

lottinv.inv_update_force = function(player, formname)
	player:set_inventory_formspec(
		formname..
		lottinv.inv(player, true)
	)
end

lottinv.inv_left = function(player)
	local meta = player:get_meta()
	if meta:get_string("lottinv:inv_left") == "" then
		meta:set_string("lottinv:inv_left", 1)
	end
	
	if tonumber(meta:get_string("lottinv:inv_left")) then
		return lottinv.inv_list_left(player)[tonumber(meta:get_string("lottinv:inv_left"))][1]
	else meta:set_string("lottinv:inv_left", 1)
	end
end

lottinv.inv_left_update = function(player, fields)
	local inv_max_left = 0
	for _ in pairs(lottinv.inv_list_left(player))
		do inv_max_left = inv_max_left + 1
	end
	
	local name = player:get_player_name()
	local meta = player:get_meta()
	if fields.lottinv_inv_up_left or fields.lottinv_inv_down_left then
		
		if tonumber(meta:get_string("lottinv:inv_left")) then
			local inv_no = tonumber(meta:get_string("lottinv:inv_left"))
			if fields.lottinv_inv_up_left then
				if inv_no + 1 > inv_max_left then
					meta:set_string("lottinv:inv_left", 1)
				else
					meta:set_string("lottinv:inv_left", inv_no + 1)
				end
			elseif fields.lottinv_inv_down_left then
				if inv_no - 1 < 1 then
					meta:set_string("lottinv:inv_left", inv_max_left)
				else
					meta:set_string("lottinv:inv_left", inv_no - 1)
				end
			end
		end
		
		player:set_inventory_formspec(
			lottinv.inv_size("4x4")..
			lottinv.inv(player, true)..
			lottinv.inv_left(player)
		)
	end
end

lottinv.inv_quit = function(sender)
	if minetest.settings:get_bool("creative_mode") then
		creative.update_formspec(sender, creative.page(sender))
	else lottinv.inv_update_force(sender, lottinv.inv_size("4x4")..lottinv.inv_left(sender))
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	lottinv.inv_update(player, fields, lottinv.inv_left(player))
	lottinv.inv_left_update(player, fields)
end)
--

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	if meta:get_string("lottinv:inv") == nil then
		meta:set_string("lottinv:inv", 1)
	end
	if meta:get_string("lottinv:inv_left") == nil then
		meta:set_string("lottinv:inv_left", 1)
	end
	
	player:set_inventory_formspec(
		lottinv.inv_size("4x4")..
		lottinv.inv(player, true)..
		lottinv.inv_left(player)
	)
end)