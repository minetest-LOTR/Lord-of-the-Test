-- ZCG mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

zcg = {}
zcg.users = {}
zcg.crafts = {}
zcg.itemlist = {}

zcg.items_in_group = function(group)
	local items = {}
	local ok = true
	for name, item in pairs(minetest.registered_items) do
		-- the node should be in all groups
		ok = true
		for _, g in ipairs(group:split(',')) do
			if not item.groups[g] then
				ok = false
			end
		end
		if ok then table.insert(items,name) end
	end
	return items
end

local table_copy = function(table)
	out = {}
	for k,v in pairs(table) do
		out[k] = v
	end
	return out
end

zcg.add_craft = function(input, output, groups)
	if minetest.get_item_group(output, "forbidden") > 0 then
		return
	end
     if minetest.get_item_group(output, "armor_use") > 0 then
		return
	end
     if minetest.get_item_group(output, "armor_crafts") > 0 then
		return
	end
     if minetest.get_item_group(output, "cook_crafts") > 0 then
		return
	end
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type = input.type
	c.items = input.items
	if c.items == nil then return end
	for i, item in pairs(c.items) do
		if item:sub(0,6) == "group:" then
			local groupname = item:sub(7)
			if groups[groupname] ~= nil then
				c.items[i] = groups[groupname]
			else
				for _, gi in ipairs(zcg.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					zcg.add_craft({
						width = c.width,
						type = c.type,
						items = table_copy(c.items)
					}, output, g2) -- it is needed to copy the table, else groups won't work right
				end
				return
			end
		end
	end
     if c.type == "cooking" then
          return
     end
	if c.width == 0 then c.width = 3 end
	table.insert(zcg.crafts[output],c)
end

zcg.load_crafts = function(name)
     local c = {}
     if c.type == "cooking" then
          return
     end
	zcg.crafts[name] = {}
	local _recipes = minetest.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				zcg.add_craft(recipe, name)
			end
		end
	end
	if zcg.crafts[name] == nil or #zcg.crafts[name] == 0 then
		zcg.crafts[name] = nil
	else
		table.insert(zcg.itemlist,name)
	end
end

zcg.need_load_all = true

zcg.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			zcg.load_crafts(name)
		end
		i = i+1
	end
	table.sort(zcg.itemlist)
	zcg.need_load_all = false
	print("All crafts loaded !")
end

zcg.formspec = function(pn)
	if zcg.need_load_all then zcg.load_all() end
	page = zcg.users[pn].page
	alt = zcg.users[pn].alt
	current_item = zcg.users[pn].current_item
	local formspec = "size[8,7.5]"
	.. "button_exit[6,7;2,0.5;;Exit]"
	if zcg.users[pn].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;zcg_previous.png;zcg_previous;;false;false;zcg_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;zcg_previous_inactive.png]"
	end
	if zcg.users[pn].history.index < #zcg.users[pn].history.list then
		formspec = formspec .. "image_button[1,1;1,1;zcg_next.png;zcg_next;;false;false;zcg_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;zcg_next_inactive.png]"
	end
	-- Show craft recipe
	if current_item ~= "" then
		if zcg.crafts[current_item] then
			if alt > #zcg.crafts[current_item] then
				alt = #zcg.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;zcg_alt:"..(alt-1)..";^]"
			end
			if alt < #zcg.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;zcg_alt:"..(alt+1)..";v]"
			end
			local c = zcg.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec .. "item_image_button["..((i-1)%c.width+x)..","..(math.floor((i-1)/c.width+y))..";1,1;"..item..";zcg:"..item..";]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;zcg_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;zcg_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..zcg.users[pn].current_item..";;]"
			end
		end
	end
	
	-- Node list
	local npp = 8*3 -- nodes per page
	local i = 0 -- for positionning buttons
	local s = 0 -- for skipping pages
	for _, name in ipairs(zcg.itemlist) do
		if s < page*npp then s = s+1 else
			if i >= npp then break end
			formspec = formspec .. "item_image_button["..(i%8)..","..(math.floor(i/8)+3.5)..";1,1;"..name..";zcg:"..name..";]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;zcg_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7;1,.5;zcg_page:"..(page+1)..";>>]"
	end
	formspec = formspec .. "label[2,6.85;Page "..(page+1).."/"..(math.floor(#zcg.itemlist/npp+1)).."]" -- The Y is approximatively the good one to have it centered vertically...
     formspec = formspec .. "background[5,5;1,1;gui_formbg.png;true]"
     formspec = formspec .. "label[0,0;Book of Crafts]"
	return formspec
end

minetest.register_on_player_receive_fields(function(player,formname,fields)
	pn = player:get_player_name();
	if zcg.users[pn] == nil then zcg.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}} end
	if fields.zcg then
		inventory_plus.set_inventory_formspec(player, zcg.formspec(pn))
		return
	elseif fields.zcg_previous then
		if zcg.users[pn].history.index > 1 then
			zcg.users[pn].history.index = zcg.users[pn].history.index - 1
			zcg.users[pn].current_item = zcg.users[pn].history.list[zcg.users[pn].history.index]
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		end
	elseif fields.zcg_next then
		if zcg.users[pn].history.index < #zcg.users[pn].history.list then
			zcg.users[pn].history.index = zcg.users[pn].history.index + 1
			zcg.users[pn].current_item = zcg.users[pn].history.list[zcg.users[pn].history.index]
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		end
	end
	for k, v in pairs(fields) do
		if (k:sub(0,4)=="zcg:") then
			local ni = k:sub(5)
			if zcg.crafts[ni] then
				zcg.users[pn].current_item = ni
				table.insert(zcg.users[pn].history.list, ni)
				zcg.users[pn].history.index = #zcg.users[pn].history.list
				inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
			end
		elseif (k:sub(0,9)=="zcg_page:") then
			zcg.users[pn].page = tonumber(k:sub(10))
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		elseif (k:sub(0,8)=="zcg_alt:") then
			zcg.users[pn].alt = tonumber(k:sub(9))
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		end
	end
end)

minetest.register_tool("lottinventory:crafts_book",{
    description = "Book of Crafts",
    groups = {}, 
    inventory_image = "lottinventory_crafts_book.png",
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1, 
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            fleshy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            choppy={times={[3]=0.90}, maxwear=0.05, maxlevel=0}
        }
    },
    on_place = function(itemstack, player, pointed_thing)
	     inventory_plus.set_inventory_formspec(player, zcg.formspec(pn))
    end,
    on_use = function(itemstack, player, pointed_thing)
	     inventory_plus.set_inventory_formspec(player, zcg.formspec(pn))
    end,
})
