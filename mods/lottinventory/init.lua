dofile(minetest.get_modpath(minetest.get_current_modname()).."/zcg.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/cooking.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/forbidden.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/protection.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/potions.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/brewing.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/master.lua")

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

--Bags
minetest.register_tool("lottinventory:small", {
	description = "Small Bag",
	inventory_image = "bags_small.png",
	groups = {bagslots=8},
})
minetest.register_tool("lottinventory:medium", {
	description = "Medium Bag",
	inventory_image = "bags_medium.png",
	groups = {bagslots=16},
})
minetest.register_tool("lottinventory:large", {
	description = "Large Bag",
	inventory_image = "bags_large.png",
	groups = {bagslots=24, forbidden=1},
})

minetest.register_craft({
	output = 'lottinventory:small',
	recipe = {
		{'', 'group:stick', ''},
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'lottinventory:medium',
	recipe = {
		{'', 'group:stick', ''},
		{'group:wood', 'lottinventory:small', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'lottinventory:large',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'group:wood', 'lottinventory:medium', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'lottinventory:crafts_book',
	recipe = {
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', 'default:book', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottinventory:cooking_book',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:book', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'lottinventory:protection_book',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'lottinventory:crafts_book', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'lottinventory:brewing_book',
	recipe = {
		{'lottpotion:brewer', 'lottinventory:cooking_book'},
	}
})

minetest.register_craft({
	output = 'lottinventory:potions_book',
	recipe = {
		{'lottpotion:potion_brewer', 'lottinventory:cooking_book'},
	}
})

minetest.register_craft({
	output = 'lottinventory:forbidden_crafts_book',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'lottinventory:protection_book', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'lottinventory:master_book',
	recipe = {
		{'lottinventory:cooking_book', 'lottinventory:potions_book', 'lottores:tilkal_ingot'},
		{'lottinventory:protection_book', 'lottinventory:forbidden_crafts_book', 'lottores:mithril_ingot'},
		{'lottinventory:crafts_book', 'lottinventory:brewing_book', 'lottores:tilkal_ingot'},
	}
})