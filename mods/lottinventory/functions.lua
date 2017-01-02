lottinventory = {}

function lottinventory.items_in_group(group)
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

function lottinventory.table_copy(table)
	local out = {}
	for k,v in pairs(table) do
		out[k] = v
	end
	return out
end

function lottinventory.add_craft(input, output, needed_groups, forbidden_groups,
	output_table, type, not_type, groups)
	local has_groups = true
	if needed_groups and #needed_groups ~= 0 then
		has_groups = false
		for _, group in pairs(needed_groups) do
			if type then
				if minetest.get_item_group(output, group) > 0 or type == input.type then
					has_groups = true
				end
			else
				if minetest.get_item_group(output, group) > 0 then
					has_groups = true
				end
			end
		end
	end
	local not_groups = true
	if forbidden_groups and #forbidden_groups ~= 0 then
		for _, group in pairs(forbidden_groups) do
	    	if minetest.get_item_group(output, group) ~= 0 then
				not_groups = false
			end
		end
	end
	if not not_groups or not has_groups
	or (not_type and not_type == input.type) then
		return
	end
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type = input.type
	c.items = input.items
	c.output = input.output
	if c.items == nil then return end
	for i, item in pairs(c.items) do
		if item:sub(0,6) == "group:" then
			local groupname = item:sub(7)
			if groups[groupname] ~= nil then
				c.items[i] = groups[groupname]
			else
				for _, gi in ipairs(lottinventory.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					lottinventory.add_craft({
						width = c.width,
						type = c.type,
						items = lottinventory.table_copy(c.items),
						output = c.output
					},
					output, needed_groups, forbidden_groups,
					output_table, type, not_type, g2)
				end
				return
			end
		end
	end
	if c.width == 0 then c.width = 3 end
	table.insert(output_table.crafts[output], c)
end

function lottinventory.load_crafts(name, ctable, needed_groups,
	forbidden_groups, type, not_type)
	ctable.crafts[name] = {}
	local _recipes = minetest.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				lottinventory.add_craft(recipe, name, needed_groups,
					forbidden_groups, ctable, type, not_type)
			end
		end
	end
	if ctable.crafts[name] == nil or #ctable.crafts[name] == 0 then
		ctable.crafts[name] = nil
	else
		table.insert(ctable.itemlist, name)
	end
end

function lottinventory.load_all(ctable, needed_groups, forbidden_groups,
	type, not_type)
	print("Loading all crafts, this may take some time...")
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			lottinventory.load_crafts(name, ctable, needed_groups,
				forbidden_groups, type, not_type)
		end
	end
	table.sort(ctable.itemlist)
	ctable.need_load_all = false
	print("All crafts loaded !")
end

function lottinventory.formspec(pn, ctable, fname, master)
	local page = ctable.users[pn].page
	local alt = ctable.users[pn].alt
	local current_item = ctable.users[pn].current_item
	local formspec = "size[8,7.5]"
	.. "button_exit[6,7;2,0.5;;Exit]"
	if ctable.users[pn].history.index > 1 then
		formspec = formspec .. "image_button[0,1;1,1;zcg_previous.png;craftguide_previous;;false;false;zcg_previous_press.png]"
	else
		formspec = formspec .. "image[0,1;1,1;zcg_previous_inactive.png]"
	end
	if ctable.users[pn].history.index < #ctable.users[pn].history.list then
		formspec = formspec .. "image_button[1,1;1,1;zcg_next.png;craftguide_next;;false;false;zcg_next_press.png]"
	else
		formspec = formspec .. "image[1,1;1,1;zcg_next_inactive.png]"
	end
	-- Show craft recipe
	if current_item ~= "" then
		if ctable.crafts[current_item] then
			if alt > #ctable.crafts[current_item] then
				alt = #ctable.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;craftguide_alt:"..(alt-1)..";^]"
			end
			if alt < #ctable.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;craftguide_alt:"..(alt+1)..";v]"
			end
			local c = ctable.crafts[current_item][alt]
			if c then
				local x = 3
				local y = 0
				for i, item in pairs(c.items) do
					formspec = formspec .. "item_image_button[" .. ((i-1)%c.width+x) ..
						"," .. (math.floor((i - 1) / c.width + y)) ..
						";1,1;" .. item .. ";craftguide:" .. item .. ";]"
				end
				if c.type == "normal" or c.type == "cooking" then
					formspec = formspec .. "image[6,2;1,1;zcg_method_"..c.type..".png]"
				else -- we don't have an image for other types of crafting
					formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				end
				formspec = formspec .. "image[6,1;1,1;zcg_craft_arrow.png]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..c.output..";;]"
			end
		end
	end

	-- Node list
	local npp = 8*3 -- nodes per page
	local i = 0 -- for positionning buttons
	local s = 0 -- for skipping pages
	for _, name in ipairs(ctable.itemlist) do
		if s < page*npp then s = s+1 else
			if i >= npp then break end
			formspec = formspec .. "item_image_button[" .. (i % 8) .. "," ..
			(math.floor(i / 8) + 3.5) .. ";1,1;" .. name .. ";craftguide:" ..name.. ";]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;craftguide_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7;1,.5;craftguide_page:"..(page+1)..";>>]"
	end
	formspec = formspec .. "label[2,6.85;Page " .. (page + 1) .. "/" ..
		(math.floor(#ctable.itemlist / npp + 1)) .. "]"
		-- This Y is approximatively the good one to have it centered vertically.
	formspec = formspec .. "label[0,0;" .. fname:gsub("^%l", string.upper) .. " Book]"
	formspec = formspec .. "background[5,5;1,1;craft_formbg.png;true]"
	if master then
		formspec = formspec .. "button[0,2.8;2,0.5;potions;Potions]"
		formspec = formspec .. "button[0,2.1;2,0.5;brews;Brewing]"
	end
	return formspec
end

function lottinventory.receive_fields(ctable, fname, master)
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		if formname ~= fname then
			return
		end
		local pn = player:get_player_name()
		if ctable.users[pn] == nil then
			ctable.users[pn] = {current_item = "", alt = 1, page = 0, history={index=0,list={}}}
		end
		if fields.craftguide then
			minetest.show_formspec(pn, fname, lottinventory.formspec(pn, ctable, fname, master))
			return
		elseif fields.craftguide_previous then
			if ctable.users[pn].history.index > 1 then
				ctable.users[pn].history.index = ctable.users[pn].history.index - 1
				ctable.users[pn].current_item = ctable.users[pn].history.list[ctable.users[pn].history.index]
				minetest.show_formspec(pn, fname, lottinventory.formspec(pn, ctable, fname, master))
			end
		elseif fields.craftguide_next then
			if ctable.users[pn].history.index < #ctable.users[pn].history.list then
				ctable.users[pn].history.index = ctable.users[pn].history.index + 1
				ctable.users[pn].current_item = ctable.users[pn].history.list[ctable.users[pn].history.index]
				minetest.show_formspec(pn, fname, lottinventory.formspec(pn, ctable, fname, master))
			end
		end
		for k, v in pairs(fields) do
			if k:sub(0, 11) == "craftguide:" then
				local ni = k:sub(12)
				if ctable.crafts[ni] then
					ctable.users[pn].current_item = ni
					table.insert(ctable.users[pn].history.list, ni)
					ctable.users[pn].history.index = #ctable.users[pn].history.list
					minetest.show_formspec(pn, fname, lottinventory.formspec(pn, ctable, fname, master))
				end
			elseif k:sub(0, 16) == "craftguide_page:" then
				ctable.users[pn].page = tonumber(k:sub(17))
				minetest.show_formspec(pn, fname, lottinventory.formspec(pn, ctable, fname, master))
			elseif k:sub(0, 15)=="craftguide_alt:" then
				ctable.users[pn].alt = tonumber(k:sub(16))
				minetest.show_formspec(pn, fname, lottinventory.formspec(pn, ctable, fname, master))
			end
		end
		if master then
			if fields.brews then
				minetest.show_formspec(pn, "brews",
					lottinventory.get_brewing_formspec(player, "brews"))
			elseif fields.potions then
				minetest.show_formspec(pn, "potion",
					lottinventory.get_potion_formspec(player, "potions"))
			end
		end
	end)
end

function lottinventory.on_use(player, ctable, formname, needed_groups,
	forbidden_groups, type, not_type, master)
	if ctable.need_load_all then
		lottinventory.load_all(ctable, needed_groups, forbidden_groups,
			type, not_type)
	end
	local pn = player:get_player_name()
	if ctable.users[pn] == nil then
		ctable.users[pn] = {current_item = "", alt = 1, page = 0, history = {index = 0, list = {}}}
	end
	minetest.show_formspec(pn, formname, lottinventory.formspec(pn, ctable, formname, master))
end
