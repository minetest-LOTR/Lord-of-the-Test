minetest.register_node("lottitems:coal_ore", {
	description = "Coal Ore",
	tiles = {"lottitems_stone.png^lottitems_coal_ore.png"},
	drop = "lottitems:coal",
	groups = {stone = 1, ore = 1, coal = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:tin_ore", {
	description = "Tin Ore",
	tiles = {"lottitems_stone.png^lottitems_tin_ore.png"},
	drop = "lottitems:tin",
	groups = {stone = 1, ore = 1, tin = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:copper_ore", {
	description = "Copper Ore",
	tiles = {"lottitems_stone.png^lottitems_copper_ore.png"},
	drop = "lottitems:copper",
	groups = {stone = 1, ore = 1, copper = 1, pickaxe = 2},
	is_ground_content = true,
})

minetest.register_node("lottitems:iron_ore", {
	description = "Iron Ore",
	tiles = {"lottitems_stone.png^lottitems_iron_ore.png"},
	drop = "lottitems:iron",
	groups = {stone = 1, ore = 1, iron = 1, pickaxe = 2},
	is_ground_content = true,
})

minetest.register_node("lottitems:silver_ore", {
	description = "Silver Ore",
	tiles = {"lottitems_stone.png^lottitems_silver_ore.png"},
	drop = "lottitems:silver",
	groups = {stone = 1, ore = 1, silver = 1, pickaxe = 3},
	is_ground_content = true,
})

minetest.register_node("lottitems:gold_ore", {
	description = "Gold Ore",
	tiles = {"lottitems_stone.png^lottitems_gold_ore.png"},
	drop = "lottitems:gold",
	groups = {stone = 1, ore = 1, gold = 1, pickaxe = 3},
	is_ground_content = true,
})

minetest.register_node("lottitems:mithril_ore", {
	description = "Mithril Ore",
	tiles = {"lottitems_stone.png^lottitems_mithril_ore.png"},
	drop = "lottitems:mithril",
	groups = {stone = 1, ore = 1, mithril = 1, pickaxe = 4},
	is_ground_content = true,
})

