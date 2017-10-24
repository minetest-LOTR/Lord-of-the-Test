minetest.register_node("lottitems:cactus", {
	description = "Cactus",
	tiles = {"lottitems_cactus_top.png", "lottitems_cactus_top.png", "lottitems_cactus.png"},
	groups = {axe = 2},
})

minetest.register_node("lottitems:apple", {
	description = "Apple",
	tiles = {"lottitems_apple.png"},
	groups = {hand = 1, food = 2, plant = 1},
})