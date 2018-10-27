local trash = minetest.create_detached_inventory("creative_trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)


-- Create detached creative inventory after loading all mods
local function creative_inv(player)
	local name = player:get_player_name()
	creative.players[name] = {filter = "", old_filter = "not_done", page = "all", size = 0, start_i = 1}
	local inv = minetest.create_detached_inventory("creative_" .. name, {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			if creative.is_enabled_for(name) then
 				return count
 			else
 				return 0
 			end
 		end,
 		allow_put = function(inv, listname, index, stack, player)
 			return 0
 		end,
 		allow_take = function(inv, listname, index, stack, player)
			if creative.is_enabled_for(name) then
 				return -1
 			else
 				return 0
 			end
 		end,
	}, name)
	creative.update_list(player, minetest.registered_items, false)
	creative.update_formspec(player, "all")
end

creative.update_list = function(player, pageitems, searchcheck)
	local creative_list = {}
	local name = player:get_player_name()
	local player_inv = creative.players[name]
	local filter = player_inv.filter
	
	if searchcheck == true then
		-- dont update if filter remains the same
		if creative.players[name].filter == creative.players[name].old_filter then
			return
		end
	end
	
	-- regenerate creative list
	for name, def in pairs(pageitems) do
		if (not def.groups.not_in_creative_inventory
		or def.groups.not_in_creative_inventory == 0)
		and def.description and def.description ~= "" then
			if filter ~= nil and filter ~= "" then
				if name:find(filter, 1, true) or
				def.description:find(filter, 1, true) then
					table.insert(creative_list, name)
				end
			else
				table.insert(creative_list, name)
			end
		end
	end
	table.sort(creative_list)
	local inv = minetest.get_inventory({type = "detached", name = "creative_" .. name})
	if not inv then
		creative_inv(player)
		return
	end
	player_inv.size = #creative_list
	inv:set_size("main", #creative_list)
	inv:set_list("main", creative_list)
	player_inv.old_filter = filter
end

creative.update_formspec = function(player, pagename)
	local name = player:get_player_name()
	local player_inv = creative.players[name]
	local start_i = player_inv.start_i
	local pagenum = math.floor(start_i / (4*5) + 1)
	local pagemax = math.floor((player_inv.size-1) / (4*5) + 1)
	local filter = player_inv.filter
	
	if pagename == "block" then
		creative.nav_icons =
			"image_button[-0.45,-1.1;0.8,0.8;icon_all.png;creative_tab_all;;true;false;icon_all.png^\\[brighten]"..
			"image_button[0.25,-1.1;0.8,0.8;icon_block.png^\\[brighten;creative_tab_block;;true;false;]"..
			"image_button[0.95,-1.1;0.8,0.8;icon_craftitem.png;creative_tab_craftitem;;true;false;icon_craftitem.png^\\[brighten]"..
			"image_button[1.65,-1.1;0.8,0.8;icon_tool.png;creative_tab_tool;;true;false;icon_tool.png^\\[brighten]"
			--"image_button[2.35,-1.1;0.8,0.8;icon_craft.png;creative_crafting;;true;false;icon_craft.png^\\[brighten]"
	
	elseif pagename == "craftitem" then
		creative.nav_icons =
			"image_button[-0.45,-1.1;0.8,0.8;icon_all.png;creative_tab_all;;true;false;icon_all.png^\\[brighten]"..
			"image_button[0.25,-1.1;0.8,0.8;icon_block.png;creative_tab_block;;true;false;icon_block.png^\\[brighten]"..
			"image_button[0.95,-1.1;0.8,0.8;icon_craftitem.png^\\[brighten;creative_tab_craftitem;;true;false;]"..
			"image_button[1.65,-1.1;0.8,0.8;icon_tool.png;creative_tab_tool;;true;false;icon_tool.png^\\[brighten]"
			--"image_button[2.35,-1.1;0.8,0.8;icon_craft.png;creative_crafting;;true;false;icon_craft.png^\\[brighten]"
	
	elseif pagename == "tool" then
		creative.nav_icons =
			"image_button[-0.45,-1.1;0.8,0.8;icon_all.png;creative_tab_all;;true;false;icon_all.png^\\[brighten]"..
			"image_button[0.25,-1.1;0.8,0.8;icon_block.png;creative_tab_block;;true;false;icon_block.png^\\[brighten]"..
			"image_button[0.95,-1.1;0.8,0.8;icon_craftitem.png;creative_tab_craftitem;;true;false;icon_craftitem.png^\\[brighten]"..
			"image_button[1.65,-1.1;0.8,0.8;icon_tool.png^\\[brighten;creative_tab_tool;;true;false;]"
			--"image_button[2.35,-1.1;0.8,0.8;icon_craft.png;creative_crafting;;true;false;icon_craft.png^\\[brighten]"
			
	else
		if player_inv.page ~= "all" then
			player_inv.page = "all"
		end
		
		creative.nav_icons =
			"image_button[-0.45,-1.1;0.8,0.8;icon_all.png^\\[brighten;creative_tab_all;;true;false;]"..
			"image_button[0.25,-1.1;0.8,0.8;icon_block.png;creative_tab_block;;true;false;icon_block.png^\\[brighten]"..
			"image_button[0.95,-1.1;0.8,0.8;icon_craftitem.png;creative_tab_craftitem;;true;false;icon_craftitem.png^\\[brighten]"..
			"image_button[1.65,-1.1;0.8,0.8;icon_tool.png;creative_tab_tool;;true;false;icon_tool.png^\\[brighten]"
			--"image_button[2.35,-1.1;0.8,0.8;icon_craft.png;creative_crafting;;true;false;icon_craft.png^\\[brighten]"
	end
	
	player:set_inventory_formspec(
		lottplayer.inv_size("4x6")..
		lottplayer.inv(player)..
		
		"list[detached:creative_trash;main;2.8,4.85;1,1;]" ..
		"image[2.86,4.95;0.8,0.8;icon_trash.png]" ..
		"list[detached:creative_" .. name .. ";main;-0.2,-0.15;4,5;" ..
			tostring(start_i) .. "]" ..

		"image_button[-1.15,1.8;1,1;icon_arrow_mini_l.png;creative_prev;;true;false;icon_arrow_mini_l.png^\\[brighten]"..
		"image_button[3.7,1.8;1,1;icon_arrow_mini_r.png;creative_next;;true;false;icon_arrow_mini_r.png^\\[brighten]"..
		
		"image_button[2.25,4.85;0.6,0.6;;creative_search;?;false;true;]"..
		"image_button[2.25,5.3;0.6,0.6;;creative_reset;X;false;true;]"..
		
		"field[0.06,5.4;2.55,0.45;creative_filter;;" ..
			minetest.formspec_escape(filter) .. "]" ..
		"field_close_on_enter[creative_filter;false]" ..
		
		creative.nav_icons..
		
		"image_button[10.35,-0.35;0.6,0.6;;creative_palette_up;^;true;true;]"..
		"image_button[10.35,0.20;0.6,0.6;;creative_clear_row;1;true;true;]"..
		"image_button[10.35,0.75;0.6,0.6;;creative_clear;X;true;true;]"..
		"image_button[10.35,1.30;0.6,0.6;;creative_palette_down;v;true;true;]"..
		
		"tooltip[creative_prev;Previous Page]" ..
		"tooltip[creative_next;Next Page]" ..
		"tooltip[creative_search;Search]" ..
		
		"tooltip[creative_palette_up;Move Row Up]" ..		
		"tooltip[creative_clear_row;Clear First Row]" ..		
		"tooltip[creative_clear;Clear Inventory]" ..		
		"tooltip[creative_palette_down;Move Row Down]" ..		
		
		"image_button[-0.7,5.7.5;2,1;;-;Page "..tostring(pagenum).."/"..tostring(pagemax)..";true;false;]")
end

creative.page = function(player)
	local name = player:get_player_name()
	return creative.players[name].page
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if not minetest.settings:get_bool("creative_mode") then
		return
	end
	
	if fields.creative_tab_all then
		creative.players[name].page = "all"
		creative.players[name].start_i = 1
		creative.update_list(player, minetest.registered_items, false)
	end
	if fields.creative_tab_block then
		creative.players[name].page = "block"
		creative.players[name].start_i = 1
		creative.update_list(player, minetest.registered_nodes, false)
	end
	if fields.creative_tab_craftitem then
		creative.players[name].page = "craftitem"
		creative.players[name].start_i = 1
		creative.update_list(player, minetest.registered_craftitems, false)
	end
	if fields.creative_tab_tool then
		creative.players[name].page = "tool"
		creative.players[name].start_i = 1
		creative.update_list(player, minetest.registered_tools, false)
	end
	
	local current_page = 0
	local formspec = player:get_inventory_formspec()
	local start_i = creative.players[name].start_i
	start_i = tonumber(start_i) or 0
	if fields.creative_prev then
		start_i = start_i - 4*5
	end
	if fields.creative_next then
		start_i = start_i + 4*5
	end
	if fields.creative_clear then
		local inv = minetest.get_inventory({type='player', name=name})
		for i=1,32 do
			local stack = inv:get_stack("main", i)
			if stack ~= nil and not stack:is_empty() then
				inv:set_stack("main", i, nil)
 			end
 		end
	elseif fields.creative_clear_row then
		local inv = minetest.get_inventory({type='player', name=name})
		for i=1,4 do
			local stack = inv:get_stack("main", i)
			if stack ~= nil and not stack:is_empty() then
				inv:set_stack("main", i, nil)
 			end
 		end
	end
	
	if fields.creative_palette_up then
		local inv = minetest.get_inventory({type='player',name=name})
		local items = {}
		for i = 4, 32 do
			local stack = inv:get_stack("main", i)
			items[i - 4] = {name = stack:get_name(), count = stack:get_count()}
		end
		for i = 1, 4 do
			local stack = inv:get_stack("main", i)
			items[i + 28] = {name = stack:get_name(), count = stack:get_count()}
		end
		for i = 1, 32 do
			if items[i].name and items[i].count then
				inv:set_stack("main", i, ItemStack(items[i]))
			else
				inv:set_stack("main", i, nil)
			end
		end
	elseif fields.creative_palette_down then
		local inv = minetest.get_inventory({type='player',name=name})
		local items = {}
		for i = 28, 32 do
			local stack = inv:get_stack("main", i)
			items[i - 28] = {name = stack:get_name(), count = stack:get_count()}
		end
		for i = 1, 28 do
			local stack = inv:get_stack("main", i)
			items[i + 4] = {name = stack:get_name(), count = stack:get_count()}
		end
		for i = 1, 32 do
			if items[i].name and items[i].count then
				inv:set_stack("main", i, ItemStack(items[i]))
			else
				inv:set_stack("main", i, nil)
			end
		end
	end
	

	if start_i < 0 then
		start_i = start_i + 4*5
	end
	if start_i >= creative.players[name].size then
		start_i = start_i - 4*5
	end
	if start_i < 0 or start_i >= creative.players[name].size then
		start_i = 0
 	end
	creative.players[name].start_i = start_i
	
	if fields.creative_reset then
		creative.players[name].filter = ""
		if creative.players[name].page == nil then
			creative.players[name].page = "all"
		end
		
		if creative.players[name].page == "all" then
			creative.update_list(player, minetest.registered_items, false)
		elseif creative.players[name].page == "block" then
			creative.update_list(player, minetest.registered_nodes, false)
		elseif creative.players[name].page == "craftitem" then
			creative.update_list(player, minetest.registered_craftitems, false)
		elseif creative.players[name].page == "tool" then
			creative.update_list(player, minetest.registered_tools, false)
		end
	end
	
	if fields.creative_search or fields.key_enter_field == "creative_filter" then
		creative.players[name].filter = fields.creative_filter
		
		if creative.players[name].page == "all" then
			creative.update_list(player, minetest.registered_items, true)
		elseif creative.players[name].page == "block" then
			creative.update_list(player, minetest.registered_nodes, true)
		elseif creative.players[name].page == "craftitem" then
			creative.update_list(player, minetest.registered_craftitems, true)
		elseif creative.players[name].page == "tool" then
			creative.update_list(player, minetest.registered_tools, true)
		end
	end
	
	if not fields.quit and not fields.bags and not fields.main then
		minetest.after(0, function()
			creative.update_formspec(player, creative.players[name].page)
		end)
	end
end)

minetest.register_on_joinplayer(function(player)
	if minetest.settings:get_bool("creative_mode") then
		creative_inv(player)
	end
end)