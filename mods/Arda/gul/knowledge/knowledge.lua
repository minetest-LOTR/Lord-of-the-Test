dofile(minetest.get_modpath("gul").."/knowledge/zcg.lua")
dofile(minetest.get_modpath("gul").."/knowledge/cooking.lua")
dofile(minetest.get_modpath("gul").."/knowledge/forbidden.lua")
dofile(minetest.get_modpath("gul").."/knowledge/protection.lua")
dofile(minetest.get_modpath("gul").."/knowledge/potions.lua")
dofile(minetest.get_modpath("gul").."/knowledge/brewing.lua")
dofile(minetest.get_modpath("gul").."/knowledge/master.lua")

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
minetest.register_tool("gul:small", {
	description = "Small Bag",
	inventory_image = "bags_small.png",
	groups = {bagslots=8},
})
minetest.register_tool("gul:medium", {
	description = "Medium Bag",
	inventory_image = "bags_medium.png",
	groups = {bagslots=16},
})
minetest.register_tool("gul:large", {
	description = "Large Bag",
	inventory_image = "bags_large.png",
	groups = {bagslots=24, forbidden=1},
})

minetest.register_craft({
	output = 'gul:small',
	recipe = {
		{'', 'group:stick', ''},
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'gul:medium',
	recipe = {
		{'', 'group:stick', ''},
		{'group:wood', 'gul:small', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'gul:large',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'group:wood', 'gul:medium', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'gul:crafts_book',
	recipe = {
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', 'default:book', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'gul:cooking_book',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:book', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'gul:protection_book',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'gul:crafts_book', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'gul:brewing_book',
	recipe = {
		{'gul:brewer', 'gul:cooking_book'},
	}
})

minetest.register_craft({
	output = 'gul:potions_book',
	recipe = {
		{'gul:potion_brewer', 'gul:cooking_book'},
	}
})

minetest.register_craft({
	output = 'gul:forbidden_crafts_book',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'gul:protection_book', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'gul:master_book',
	recipe = {
		{'gul:cooking_book', 'gul:potions_book', 'cemen:tilkal_ingot'},
		{'gul:protection_book', 'gul:forbidden_crafts_book', 'cemen:mithril_ingot'},
		{'gul:crafts_book', 'gul:brewing_book', 'cemen:tilkal_ingot'},
	}
})