-- Craftguides

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

-- Bags

minetest.register_craft({
	output = 'gul:small_bag',
	recipe = {
		{'', 'group:stick', ''},
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'gul:medium_bag',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'group:wood', 'gul:small_bag', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'gul:large_bag',
	recipe = {
		{'', 'default:mese_crystal_fragment', ''},
		{'group:wood', 'gul:medium_bag', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})