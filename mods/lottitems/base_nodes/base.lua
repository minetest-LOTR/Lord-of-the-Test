-- Stones

-- Normal Stone
minetest.register_node("lottitems:stone", {
	description = "Stone",
	tiles = {"lottitems_stone.png"},
	drop = "lottitems:cobble",
	groups = {stone = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:cobble", {
	description = "Cobble",
	tiles = {"lottitems_cobble.png"},
	groups = {stone = 2, cobble = 1, pickaxe = 1},
})

-- Red Stone
minetest.register_node("lottitems:red_stone", {
	description = "Red Stone",
	tiles = {"lottitems_red_stone.png"},
	drop = "lottitems:red_cobble",
	groups = {stone = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:red_cobble", {
	description = "Red Cobble",
	tiles = {"lottitems_red_cobble.png"},
	groups = {stone = 2, cobble = 1, pickaxe = 1},
})

-- Blue Stone
minetest.register_node("lottitems:blue_stone", {
	description = "Blue Stone",
	tiles = {"lottitems_blue_stone.png"},
	drop = "lottitems:blue_cobble",
	groups = {stone = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:blue_cobble", {
	description = "Blue Cobble",
	tiles = {"lottitems_blue_cobble.png"},
	groups = {stone = 2, cobble = 1, pickaxe = 1},
})

-- Mordor Stone

minetest.register_node("lottitems:mordor_stone", {
	description = "Mordor Stone",
	tiles = {"lottitems_mordor_stone.png"},
	groups = {mordor = 1, stone = 1, pickaxe = 2},
})

-- Sandstones

minetest.register_node("lottitems:sandstone", {
	description = "Sandstone",
	tiles = {"lottitems_sandstone.png"},
	groups = {stone = 1, sandstone = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:desert_sandstone", {
	description = "Desert Sandstone",
	tiles = {"lottitems_desert_sandstone.png"},
	groups = {stone = 1, sandstone = 1, pickaxe = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:silver_sandstone", {
	description = "Silver Sandstone",
	tiles = {"lottitems_silver_sandstone.png"},
	groups = {stone = 1, sandstone = 1, pickaxe = 1},
	is_ground_content = true,
})

-- Obsidian

minetest.register_node("lottitems:obsidian", {
	description = "Obsidian",
	tiles = {"lottitems_obsidian.png"},
	groups = {stone = 1, volcanic = 1, pickaxe = 4},
	is_ground_content = true,
})

-- Dirt and sand and stuff

-- Sands
minetest.register_node("lottitems:sand", {
	description = "Sand",
	tiles = {"lottitems_sand.png"},
	groups = {sand = 1, shovel = 1, falling_node = 1, hand = 3},
	is_ground_content = true,
})

minetest.register_node("lottitems:desert_sand", {
	description = "Desert Sand",
	tiles = {"lottitems_desert_sand.png"},
	groups = {sand = 1, shovel = 1, falling_node = 1, hand = 3},
	is_ground_content = true,
})

minetest.register_node("lottitems:silver_sand", {
	description = "Silver Sand",
	tiles = {"lottitems_silver_sand.png"},
	groups = {sand = 1, shovel = 1, falling_node = 1, hand = 3},
	is_ground_content = true,
})

-- Gravel
minetest.register_node("lottitems:gravel", {
	description = "Gravel",
	tiles = {"lottitems_gravel.png"},
	groups = {gravel = 1, shovel = 2, falling_node = 1, hand = 4},
	is_ground_content = true,
})

minetest.register_node("lottitems:dark_gravel", {
	description = "Dark Gravel",
	tiles = {"lottitems_dark_gravel.png"},
	groups = {gravel = 1, shovel = 2, falling_node = 1, hand = 4},
	is_ground_content = true,
})

-- Dirt
minetest.register_node("lottitems:dirt", {
	description = "Dirt",
	tiles = {"lottitems_dirt.png"},
	groups = {dirt = 1, shovel = 1, hand = 3, soil_quality = 2},
	is_ground_content = true,
})

-- Permadirt - doesn't turn into grass, used for mapgen
minetest.register_node("lottitems:perma_dirt", {
	description = "Permanent Dirt",
	tiles = {"lottitems_dirt.png"},
	groups = {dirt = 1, shovel = 1, hand = 3, soil_quality = 1},
	drop = "lottitems:dirt",
	is_ground_content = true,
})

-- Clay
minetest.register_node("lottitems:clay", {
	description = "Clay block",
	tiles = {"lottitems_clay.png"},
	groups = {clay = 1, shovel = 1, hand = 3},
	is_ground_content = true,
})


-- Snow
minetest.register_node("lottitems:snow", {
	description = "Snow",
	tiles = {"lottitems_snow.png"},
	groups = {snow = 1, cold = 1, shovel = 1, hand = 2, slippery = 1, falling_node = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:snow_layer", {
	description = "Snow",
	tiles = {"lottitems_snow.png"},
	drawtype = "nodebox",
	node_box = {
		type = "leveled",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	buildable_to = true,
	paramtype = "light",
	paramtype2 = "leveled",
	leveled = 16,
	groups = {snow = 1, cold = 1, shovel = 1, hand = 3, slippery = 1, falling_node = 1},
	is_ground_content = true,
})

minetest.register_node("lottitems:ice", {
	description = "Ice",
	drawtype = "glasslike",
	tiles = {"lottitems_ice.png"},
	use_texture_alpha = true,
	groups = {cold = 1, axe = 2, slippery = 5},
	is_ground_content = true,
})
