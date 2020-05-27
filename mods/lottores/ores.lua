minetest.register_node("lottores:coal_ore", {
	description = "Coal Ore",
	tiles = {"lottitems_stone.png^lottores_coal_in_stone.png"},
	groups = {stone = 1, ore = 1, coal = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottores:iron_ore", {
	description = "Iron Ore",
	tiles = {"lottitems_stone.png^lottores_iron_in_stone.png"},
	groups = {stone = 1, ore = 1, iron = 1, pickaxe = 2},
	is_ground_content = true,
})

minetest.register_node("lottores:red_stone_with_iron", {
	description = "Red Stone Iron Ore",
	tiles = {"lottitems_red_stone.png^lottores_iron_in_stone.png"},
	groups = {stone = 1, ore = 1, iron = 1, pickaxe = 2},
	is_ground_content = true,
})

minetest.register_node("lottores:blue_stone_with_iron", {
	description = "Blue Stone Iron Ore",
	tiles = {"lottitems_blue_stone.png^lottores_iron_in_stone.png"},
	groups = {stone = 1, ore = 1, iron = 1, pickaxe = 2},
	is_ground_content = true,
})

minetest.register_node("lottores:gold_ore", {
	description = "Gold Ore",
	tiles = {"lottitems_stone.png^lottores_gold_in_stone.png"},
	groups = {stone = 1, ore = 1, gold = 1, pickaxe = 3},
	is_ground_content = true,
})

minetest.register_node("lottores:copper_ore", {
	description = "Copper Ore",
	tiles = {"lottitems_stone.png^lottores_copper_in_stone.png"},
	groups = {stone = 1, ore = 1, copper = 1, pickaxe = 2},
	is_ground_content = true,
})

minetest.register_node("lottores:tin_ore", {
	description = "Tin Ore",
	tiles = {"lottitems_stone.png^lottores_tin_in_stone.png"},
	groups = {stone = 1, ore = 1, tin = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottores:silver_ore", {
	description = "Silver Ore",
	tiles = {"lottitems_stone.png^lottores_silver_in_stone.png"},
	groups = {stone = 1, ore = 1, silver = 1, pickaxe = 3},
	is_ground_content = true,
})

minetest.register_node("lottores:lead_ore", {
	description = "Lead Ore",
	tiles = {"lottitems_stone.png^lottores_lead_in_stone.png"},
	groups = {stone = 1, ore = 1, lead = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottores:mithril_ore", {
	description = "Mithril Ore",
	tiles = {
		{name = "lottores_mithril_in_stone.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 10,
			}
		},
	},
	groups = {stone = 1, ore = 1, mithril = 1, pickaxe = 4},
	is_ground_content = true,
})
