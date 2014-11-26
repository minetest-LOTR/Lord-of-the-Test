minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"group:vessel",
		"group:vessel",
	},
})

minetest.register_craft({
	output = 'gul:cauldron_empty',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'gul:potion_brewer',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'group:stone', 'group:stone', 'group:stone'},
	}
})

minetest.register_craft({
	output = 'gul:brewer',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'default:steel_ingot', 'group:wood'},
	}
})