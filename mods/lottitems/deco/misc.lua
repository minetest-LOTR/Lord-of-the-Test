minetest.register_node("lottitems:brick", {
	description = "Brick",
	tiles = {"lottitems_brick.png"},
	groups = {pickaxe = 2, lottitems = 1},
})

minetest.register_node("lottitems:glass", {
	description = "Glass",
	tiles = {"lottitems_glass.png", "lottitems_glass_detail.png"},
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {hand = 1, lottitems = 1},
})

minetest.register_node("lottitems:obsidian_glass", {
	description = "Obsidian Glass",
	tiles = {"lottitems_obsidian_glass.png", "blank.png"},
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {hand = 2, lottitems = 1},
})
