lottcrafting = {}
lottcrafting.recipes = {}
lottcrafting.recipes.shaped = {}
lottcrafting.recipes.shapeless = {}

-- Handle the craft specified by `def`, removing the source items from the
-- inventory named `src_name` in `inv` and adding them to `dst_name`
lottcrafting.handle_craft = function(def, inv, src_name, dst_name, player)
	if not def then return end
	local can_add = true
	for i, item in ipairs(def.outputs) do
		if inv:room_for_item(dst_name, ItemStack(item)) then
			inv:add_item(dst_name, ItemStack(item))
		else
			-- This is needed to handle recipes with multiple outputs where
			-- some may fit but not all
			for j = 1, i do
				inv:remove_item(dst_name, ItemStack(v))
			end
			can_add = false
			if player then minetest.chat_send_player(player:get_player_name(), "Output inventory full!") end
			break
		end
	end
	if can_add then
		for k, v in ipairs(def.inputs) do
			-- FIXME: Maybe turn shaped recipes into 1D tables when they are
			-- registered so this can be simplified
			if type(v) == "table" then
				for _, item in ipairs(v) do
					inv:remove_item(src_name, ItemStack(item))
				end
			else
				inv:remove_item(src_name, ItemStack(v))
			end
		end
	end
end

-- concatenate a list of item names for use as a hash key
local concat_shaped_table = function(namelist)
	local temp = {}
	for i = 1, #namelist do
		temp[i] = table.concat(namelist[i], " ")
	end
	return table.concat(temp, "/")
end

-- generate the hash key for a shaped recipe based on the names
-- of the items
local get_str_shaped = function(namelist)
	if not namelist or not namelist[1] then return end
	local x1 = #namelist[1]
	local x2 = 0
	local y1 = #namelist
	local y2 = 0
	local last_x = 0
	for i, v1 in ipairs(namelist) do
		last_x = 0
		for j, v2 in ipairs(v1) do
			if v2 ~= "" then
				last_x = j
				if j < x1 then x1 = j end
			end
		end
		if last_x ~= 0 then
			if last_x > x2 then x2 = last_x end
			if i < y1 then y1 = i end
			if i > y2 then y2 = i end
		end
	end

	local t = {}
	for i = 1, y2 - y1 + 1 do
		t[i] = {}
		for j = 1, x2 - x1 + 1 do
			t[i][j] = namelist[i + y1 - 1][j + x1 - 1]
		end
	end
	return concat_shaped_table(t)
end

-- generate the hash key for a shapeless recipe
local get_str_shapeless = function(namelist)
	local temp = {}
	for i, v1 in ipairs(namelist) do
		for j, v2 in ipairs(v1) do
			if v2 ~= "" then
				temp[#temp+1] = v2
			end
		end
	end
	table.sort(temp)
	return table.concat(temp, " ")
end

-- register the craft with definition `def`
-- craft_type can be 'shaped' or 'shapeless'
-- craft_attr can be used to store extra information, for instance
-- that this craft can only be used by certain races
-- FIXME: This currently does not work with recipes that require
-- the same item multiple times on the same stack!
-- -> The hash key should be normalized to just the item names but the
--    original definition should also be stored so the amounts of the
--    items can be checked.
lottcrafting.register_craft = function(craft_type, craft_attr, def)
	if not craft_type or not craft_attr or not def or not def.inputs then return end
	if not lottcrafting.recipes[craft_type][craft_attr] then
		lottcrafting.recipes[craft_type][craft_attr] = {}
	end
	-- Handle aliases
	for i, v in ipairs(def.inputs) do
		def.inputs[i] = ItemStack(v):to_string()
	end
	local str = nil
	if craft_type == "shaped" then
		str = concat_recipe_table(def.inputs)
	elseif craft_type == "shapeless" then
		table.sort(def.inputs)
		str = table.concat(def.inputs, " ")
	end
	if lottcrafting.recipes[craft_type][craft_attr][str] then
		-- Yes, I know this will look really ugly when printed...
		minetest.log("warning", "[lottcrafting] Duplicate registration for recipe \""..str.."\"")
	end
	lottcrafting.recipes[craft_type][craft_attr][str] = def
end

-- convert a 1D itemlist to a 2D table based on the width
local get_namelist = function(itemlist, width)
	local namelist = {}
	for i = 1, (#itemlist / width) do
		namelist[i] = {}
		for j = 1, width do
			namelist[i][j] = itemlist[(i - 1) * width + j]:get_name()
		end
	end
	return namelist
end

-- get the craft result for a given namelist and a set craft_type
local get_craft_result_intern = function(craft_type, craft_attr, namelist)
	local str = nil
	if craft_type == "shaped" then
		str = get_str_shaped(namelist)
	elseif craft_type == "shapeless" then
		str = get_str_shapeless(namelist)
	end
	return lottcrafting.recipes[craft_type][craft_attr][str]
end

-- get the craft result for a given namelist and optionally a craft_type
-- -> if no craft_type is given, all craft types are checked
local get_craft_result_namelist = function(craft_attr, namelist, craft_type)
	if not craft_attr or not namelist then return end
	local def = nil
	if craft_type then
		if not lottcrafting.recipes[craft_type][craft_attr] then return end
		def = get_craft_result_intern(craft_type, craft_attr, namelist)
	else
		if not lottcrafting.recipes["shaped"][craft_attr] and not
			lottcrafting.recipes["shapeless"][craft_attr] then return end
		def = get_craft_result_intern("shapeless", craft_attr, namelist)
		if not def then def = get_craft_result_intern("shaped", craft_attr, namelist) end
	end
	return def
end

-- get the craft result for a given craft_attr, itemlist and inventory list
-- if `craft_type` is nil, all craft types are checked for a match
lottcrafting.get_craft_result = function(craft_attr, width, itemlist, craft_type)
	if not craft_attr or not width or not itemlist then return end
	local namelist = get_namelist(itemlist, width)
	return get_craft_result_namelist(craft_attr, namelist, craft_type)
end

local modpath = minetest.get_modpath("lottcrafting")
dofile(modpath.."/crafting_tables.lua")
dofile(modpath.."/furnaces.lua")
