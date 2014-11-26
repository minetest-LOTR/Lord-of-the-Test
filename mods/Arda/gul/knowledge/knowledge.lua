dofile(minetest.get_modpath("gul").."/knowledge/bags.lua")

--Inventory Plus
inventory_plus = {}

inventory_plus.set_inventory_formspec = function(player, formspec)
	minetest.show_formspec(player:get_player_name(), "custom", formspec)
end

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if fields.main then
		local name = player:get_player_name()
	     local formspec_armor = armor:get_armor_formspec(name)
	     minetest.show_formspec(player:get_player_name(), "armor", formspec_armor)
	end
end)

table_copy = function(table)
	out = {}
	for k,v in pairs(table) do
		out[k] = v
	end
	return out
end

-- Craftguides
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/brewing_craftguide.lua")
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/cooking_craftguide.lua")
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/forbidden_craftguide.lua")
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/master_craftguide.lua")
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/normal_craftguide.lua")
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/potionbrewing_craftguide.lua")
dofile(minetest.get_modpath("gul").."/knowledge/craft_guides/protection_craftguide.lua")

-- Crafting
dofile(minetest.get_modpath("gul").."/knowledge/crafting.lua")