-- Stone Blocks & Bricks

-- Normal
minetest.register_node("lottitems:stone_brick", {
	description = "Stone Brick",
	tiles = {"lottitems_stone_brick.png"},
	groups = {stone = 2, pickaxe = 1},
})

minetest.register_node("lottitems:stone_block", {
	description = "Stone Block",
	tiles = {"lottitems_stone_block.png"},
	groups = {stone = 2, pickaxe = 1},
})

lottshapes:register_shapes("lottitems:stone_brick")
lottshapes:register_shapes("lottitems:stone_block")

-- Red
minetest.register_node("lottitems:red_stone_brick", {
	description = "Red Stone Brick",
	tiles = {"lottitems_red_stone_brick.png"},
	groups = {stone = 2, pickaxe = 1},
})

minetest.register_node("lottitems:red_stone_block", {
	description = "Red Stone Block",
	tiles = {"lottitems_red_stone_block.png"},
	groups = {stone = 2, pickaxe = 1},
})

lottshapes:register_shapes("lottitems:red_stone_brick")
lottshapes:register_shapes("lottitems:red_stone_block")

-- Blue
minetest.register_node("lottitems:blue_stone_brick", {
	description = "Blue Stone Brick",
	tiles = {"lottitems_blue_stone_brick.png"},
	groups = {stone = 2, pickaxe = 1},
})

minetest.register_node("lottitems:blue_stone_block", {
	description = "Blue Stone Block",
	tiles = {"lottitems_blue_stone_block.png"},
	groups = {stone = 2, pickaxe = 1},
})

lottshapes:register_shapes("lottitems:blue_stone_brick")
lottshapes:register_shapes("lottitems:blue_stone_block")

-- Sandstone
minetest.register_node("lottitems:sandstone_brick", {
	description = "Sandstone Brick",
	tiles = {"lottitems_sandstone_brick.png"},
	groups = {stone = 2, sandstone = 2, pickaxe = 1},
})

minetest.register_node("lottitems:sandstone_block", {
	description = "Sandstone Block",
	tiles = {"lottitems_sandstone_block.png"},
	groups = {stone = 2, sandstone = 2, pickaxe = 1},
})

lottshapes:register_shapes("lottitems:sandstone_brick")
lottshapes:register_shapes("lottitems:sandstone_block")

-- Desert Sandstone
minetest.register_node("lottitems:desert_sandstone_brick", {
	description = "Desert Sandstone Brick",
	tiles = {"lottitems_desert_sandstone_brick.png"},
	groups = {stone = 2, sandstone = 2, pickaxe = 1},
})

minetest.register_node("lottitems:desert_sandstone_block", {
	description = "Desert Sandstone Block",
	tiles = {"lottitems_desert_sandstone_block.png"},
	groups = {stone = 2, sandstone = 2, pickaxe = 1},
})

lottshapes:register_shapes("lottitems:desert_sandstone_brick")
lottshapes:register_shapes("lottitems:desert_sandstone_block")

-- Silver Sandstone
minetest.register_node("lottitems:silver_sandstone_brick", {
	description = "Silver Sandstone Brick",
	tiles = {"lottitems_silver_sandstone_brick.png"},
	groups = {stone = 2, sandstone = 2, pickaxe = 1},
})

minetest.register_node("lottitems:silver_sandstone_block", {
	description = "Silver Sandstone Block",
	tiles = {"lottitems_silver_sandstone_block.png"},
	groups = {stone = 2, sandstone = 2, pickaxe = 1},
})

lottshapes:register_shapes("lottitems:silver_sandstone_brick")
lottshapes:register_shapes("lottitems:silver_sandstone_block")
