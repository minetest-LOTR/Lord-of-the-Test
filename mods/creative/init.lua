-- minetest/creative/init.lua

minetest.register_privilege("creative", {
	description = "Creative Mode",
	give_to_singleplayer= false,
})
creative_inventory = {}
creative_inventory.creative_inventory_size = 0

local trash = minetest.create_detached_inventory("creative_trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		if minetest.setting_getbool("creative_mode") then
			return stack:get_count()
		else
			return 0
		end
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)

-- Create detached creative inventory after loading all mods
minetest.after(0, function()
	local inv = minetest.create_detached_inventory("creative", {
 	allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			if minetest.setting_getbool("creative_mode") then
 				return count
 			else
 				return 0
 			end
 		end,
 		allow_put = function(inv, listname, index, stack, player)
 			return 0
 		end,
 		allow_take = function(inv, listname, index, stack, player)
 			if minetest.setting_getbool("creative_mode") then
 				return -1
 			else
 				return 0
 			end
 		end,
 		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
 		end,
 		on_put = function(inv, listname, index, stack, player)
 		end,
 		on_take = function(inv, listname, index, stack, player)
 			--print(player:get_player_name().." takes item from creative inventory; listname="..dump(listname)..", index="..dump(index)..", stack="..dump(stack))
 			if stack then
 				minetest.log("action", player:get_player_name().." takes "..dump(stack:get_name()).." from creative inventory")
				--print("stack:get_name()="..dump(stack:get_name())..", stack:get_count()="..dump(stack:get_count()))
			end
		end,
	})
 	local creative_list = {}
 	for name,def in pairs(minetest.registered_items) do
 		if (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
 				and def.description and def.description ~= "" then
			table.insert(creative_list, name)
		end
	end
 	table.sort(creative_list)
 	inv:set_size("main", #creative_list)
 	for _,itemstring in ipairs(creative_list) do
 		local stack = ItemStack(itemstring)
 		-- Make a stack of the right number of items
 		local stack2 = ItemStack(stack:get_name().." "..(1))
 		inv:add_item("main", stack2)
 
 	end
 	creative_inventory.creative_inventory_size = #creative_list
 	--print("creative inventory size: "..dump(creative_inventory.creative_inventory_size))
end)

--dofile(minetest.get_modpath("lottarmor").."/armor.lua")

creative_inventory.set_creative_formspec = function(player, start_i, pagenum)
	pagenum = math.floor(pagenum)
	local pagemax = math.floor((creative_inventory.creative_inventory_size-1) / (10*6) + 1)
	player:set_inventory_formspec("size[12,9.5]"..
			"list[current_player;main;0,0;8,2;]"..
               "list[current_player;main;10,0;2,8;16]"..
			"button[8,0;2,1;creative_switchpalette;Palette]"..
			"button[8,1;2,1;creative_clear;Clear]"..
               "label[4,2;Trash:]"..
               "list[detached:creative_trash;main;5,2;1,1;]"..
			"button[0,2.3;1,1;creative_prev;<]"..
			"button[1,2.3;1,1;creative_next;>]"..
               "button[10,8.5;2,1;main;Main]"..
               "background[5,5;1,1;gui_formbg.png;true]"..
               "label[2,2.4;"..tostring(pagenum).."/"..tostring(pagemax).."]"..
			"list[detached:creative;main;0,3.3;10,6;"..tostring(start_i).."]")
end

minetest.register_on_joinplayer(function(player)
	-- If in creative mode, modify player's inventory forms
	if minetest.setting_getbool("creative_mode") then
	creative_inventory.set_creative_formspec(player, 0, 1)
end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if not minetest.setting_getbool("creative_mode") then
		return
	end
	-- Figure out current page from formspec
	local current_page = 0
	local formspec = player:get_inventory_formspec()
	local start_i = string.match(formspec, "list%[detached:creative;main;[%d.]+,[%d.]+;[%d.]+,[%d.]+;(%d+)%]")
	start_i = tonumber(start_i) or 0

	if fields.creative_prev then
		start_i = start_i - 10*6
	end
	if fields.creative_next then
		start_i = start_i + 10*6
	end
	if fields.creative_clear then
		local inv = minetest.get_inventory({type='player',name=player:get_player_name()})
		for i=1,32 do
			local stack = inv:get_stack("main", i)
			if stack ~= nil and not stack:is_empty() then
				inv:set_stack("main", i, nil)
 			end
 		end
	end
	if fields.creative_switchpalette then
		local inv = minetest.get_inventory({type='player',name=player:get_player_name()})
 		local items = {}
		for i=1,8 do
			local stack = inv:get_stack("main", i)
			local switchstack =  inv:get_stack("main", (i+8))
			items[i] = {}
			items[i] = {name=switchstack:get_name(),count=switchstack:get_count()}
			items[i+8] = {name=stack:get_name(),count=stack:get_count()}
		end
		for i =1,16 do
			if items[i].name and items[i].count then
				inv:set_stack("main", (i), ItemStack(items[i].name.." "..items[i].count))
			else
				inv:set_stack("main", i, nil)	
			end
		end
	end

	if start_i < 0 then
		start_i = start_i + 10*6
	end
	if start_i >= creative_inventory.creative_inventory_size then
		start_i = start_i - 10*6
	end
		
	if start_i < 0 or start_i >= creative_inventory.creative_inventory_size then
		start_i = 0
 	end
 
	creative_inventory.set_creative_formspec(player, start_i, start_i / (6*10) + 1)
end)

if minetest.setting_getbool("creative_mode") then
	local digtime = 0.5
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x=1,y=1,z=2.5},
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				crumbly = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				cracky = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				snappy = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				choppy = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
				oddly_breakable_by_hand = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
			},
			damage_groups = {fleshy = 10},
		}
	})
	
	minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
		return true
	end)
	
	function minetest.handle_node_drops(pos, drops, digger)
		if not digger or not digger:is_player() then
			return
		end
		local inv = digger:get_inventory()
		if inv then
			for _,item in ipairs(drops) do
				item = ItemStack(item):get_name()
				if not inv:contains_item("main", item) then
					inv:add_item("main", item)
				end
			end
		end
	end
	
end
