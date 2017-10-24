-- Lorien Grass

minetest.register_node("lottplants:lorien_grass_1", {
	description = "Lorien Grass",
	drawtype = "plantlike",
	tiles = {"lottplants_lorien_grass_1.png"},
	inventory_image = "lottplants_lorien_grass_1.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	buildable_to = true,
	walkable = false,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
	groups = {green = 1, grass = 1, plant = 1, lorien = 1}
})

minetest.register_node("lottplants:lorien_grass_2", {
	description = "Lorien Grass",
	drawtype = "plantlike",
	tiles = {"lottplants_lorien_grass_2.png"},
	inventory_image = "lottplants_lorien_grass_2.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	buildable_to = true,
	walkable = false,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
	groups = {green = 1, grass = 1, plant = 1, lorien = 1}
})

minetest.register_node("lottplants:lorien_grass_3", {
	description = "Lorien Grass",
	drawtype = "plantlike",
	tiles = {"lottplants_lorien_grass_3.png"},
	inventory_image = "lottplants_lorien_grass_3.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	buildable_to = true,
	walkable = false,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
	groups = {green = 1, grass = 1, plant = 1, lorien = 1}
})
