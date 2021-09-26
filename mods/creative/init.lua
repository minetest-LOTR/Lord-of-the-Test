-- minetest/creative/init.lua

minetest.register_privilege("creative", {
	description = "Creative Mode",
	give_to_singleplayer= false,
})
creative = {}
creative.players = {}

local trash = minetest.create_detached_inventory("creative_trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		if minetest.settings:get_bool("creative_mode") then
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
local function new_inv(player)
	local name = player:get_player_name()
	creative.players[name] = {filter = "",  old_filter = "not_done", size = 0, start_i = 1}
	local inv = minetest.create_detached_inventory("creative_" .. name, {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			if minetest.settings:get_bool("creative_mode") then
 				return count
 			else
 				return 0
 			end
 		end,
 		allow_put = function(inv, listname, index, stack, player)
 			return 0
 		end,
 		allow_take = function(inv, listname, index, stack, player)
 			if minetest.settings:get_bool("creative_mode") then
 				return -1
 			else
 				return 0
 			end
 		end,
	}, name)
	creative.set_creative_formspec(player)
end

creative.set_creative_formspec = function(player)
	local creative_list = {}
	local name = player:get_player_name()
	local player_inv = creative.players[name]
	local filter = player_inv.filter
	if filter ~= player_inv.old_filter then
		for name, def in pairs(minetest.registered_items) do
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
			new_inv(player)
			return
		end
		player_inv.size = #creative_list
		inv:set_size("main", #creative_list)
		inv:set_list("main", creative_list)
		player_inv.start_i = 0
		player_inv.old_filter = filter
	end
	local start_i = player_inv.start_i
	local pagenum = math.floor(start_i / (10*4) + 1)
	local pagemax = math.floor((player_inv.size-1) / (10*4) + 1)
	player:set_inventory_formspec("size[10,8.75]" ..
		"listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"  ..
		"background[5,5;1,1;gui_formbg.png;true]" ..
		"tabheader[-0.12,-0.12;creative_tabs;Main,Creative;2;true;false]" ..
		"list[current_player;main;0,0;8,4;]" ..
		"image[8.5,2;1,1;lottarmor_trash.png]" ..
		"list[detached:creative_trash;main;8.5,2;1,1;]" ..
		"list[detached:creative_" .. name .. ";main;0,5;10,4;" ..
			tostring(start_i) .. "]" ..
		"listring[current_player;main]" ..
		"listring[detached:creative_trash;main]" ..
		"listring[current_player;main]" ..
		"listring[detached:creative_" .. name .. ";main]" ..
		"button[8,0;2,1;creative_switchpalette;Cycle rows]" ..
		"button[8,1;2,1;creative_clear;Clear]" ..
		"button[0,4;1,1;creative_prev;<]" ..
		"button[7,4;1,1;creative_next;>]" ..
		"button[6,4;1,1;creative_search;?]" ..
		"tooltip[creative_prev;Previous Page]" ..
		"tooltip[creative_next;Next Page]" ..
		"tooltip[creative_search;Search]" ..
		"field[1.28,4.33;5,1;creative_filter;;" ..
			minetest.formspec_escape(filter) .. "]" ..
		"field_close_on_enter[creative_filter;false]" ..
		"label[8,4.22;" .. minetest.colorize("#A52A2A", "Page " ..
			tostring(pagenum) .. "/" .. tostring(pagemax)) .. "]")
end

minetest.register_on_joinplayer(function(player)
	if minetest.settings:get_bool("creative_mode") then
		new_inv(player)
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if not minetest.settings:get_bool("creative_mode") then
		return
	end
	if fields.creative_tabs then
		if fields.creative_tabs == "1" then
			local name = player:get_player_name()
			local formspec_armor = armor:get_armor_formspec(name)
			if formspec_armor ~= nil then
				player:set_inventory_formspec(formspec_armor)
			end
		elseif fields.creative_tabs == "2" then
			creative.set_creative_formspec(player)
		end
	end
	local name = player:get_player_name()
	local current_page = 0
	local formspec = player:get_inventory_formspec()
	local start_i = creative.players[name].start_i
	start_i = tonumber(start_i) or 0
	if fields.creative_prev then
		start_i = start_i - 10*4
	end
	if fields.creative_next then
		start_i = start_i + 10*4
	end
	if fields.creative_search or fields.key_enter_field == "creative_filter" then
		creative.players[name].filter = fields.creative_filter
	end
	if fields.creative_clear then
		local inv = minetest.get_inventory({type='player', name=name})
		for i=1,32 do
			local stack = inv:get_stack("main", i)
			if stack ~= nil and not stack:is_empty() then
				inv:set_stack("main", i, nil)
 			end
 		end
	end
	if fields.creative_switchpalette then
		local inv = minetest.get_inventory({type='player',name=name})
 		local items = {}
		for i = 8, 32 do
			local stack = inv:get_stack("main", i)
			items[i - 8] = {name = stack:get_name(), count = stack:get_count()}
		end
		for i = 1, 8 do
			local stack = inv:get_stack("main", i)
			items[i + 24] = {name = stack:get_name(), count = stack:get_count()}
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
		start_i = start_i + 10*4
	end
	if start_i >= creative.players[name].size then
		start_i = start_i - 10*4
	end
	if start_i < 0 or start_i >= creative.players[name].size then
		start_i = 0
 	end
	creative.players[name].start_i = start_i
	if fields.creative_tabs ~= "1" and not fields.quit and
	not fields.bags and not fields.main then
		creative.set_creative_formspec(player)
	end
end)

if minetest.settings:get_bool("creative_mode") then
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
				creative = {times={[1]=digtime, [2]=digtime, [3]=digtime}, uses=0, maxlevel=3},
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
