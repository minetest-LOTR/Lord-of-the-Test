-- Trees, and related things

--[[
Young tree nbs:
1:
	{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
	{-0.0625, -0.5, -0.1875, 0.0625, 0.5, -0.125}, -- NodeBox2
	{0.125, -0.5, -0.0625, 0.1875, 0.5, 0.0625}, -- NodeBox3
	{-0.0625, -0.5, 0.125, 0.0625, 0.5, 0.1875}, -- NodeBox4
	{-0.1875, -0.5, -0.0625, -0.125, 0.5, 0.0625}, -- NodeBox5
2:
	{-0.125, -0.5, -0.1875, 0.125, 0.5, 0.1875},
	{-0.1875, -0.5, -0.125, 0.1875, 0.5, 0.125},
]]--


-- Normal
minetest.register_node("lottplants:oak_tree", {
	description = "Oak Trunk",
	tiles = {"lottplants_oak_tree_top.png", "lottplants_oak_tree_top.png", "lottplants_oak_tree.png"},
	paramtype2 = "facedir",
	groups = {tree = 1, wood = 1, plant = 1, axe = 1},
})

minetest.register_node("lottplants:oak_planks", {
	description = "Oak Planks",
	tiles = {"lottplants_oak_planks.png"},
	paramtype2 = "facedir",
	groups = {wood = 1, axe = 1},
})

minetest.register_node("lottplants:oak_leaves", {
	description = "Oak Leaves",
	drawtype = "allfaces_optional",
	tiles = {"lottplants_oak_leaves.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {leaves = 1, plant = 1},
})

-- Mallorn
minetest.register_node("lottplants:mallorn_tree", {
	description = "Mallorn Trunk",
	tiles = {"lottplants_mallorn_tree_top.png", "lottplants_mallorn_tree_top.png", "lottplants_mallorn_tree.png"},
	paramtype2 = "facedir",
	groups = {tree = 1, wood = 1, plant = 1, axe = 4}
})

minetest.register_node("lottplants:young_mallorn_tree", {
	description = "Young Mallorn Trunk",
	drawtype = "nodebox",
	tiles = {"lottplants_mallorn_tree_top.png", "lottplants_mallorn_tree_top.png", "lottplants_mallorn_tree.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			{-0.0625, -0.5, -0.1875, 0.0625, 0.5, -0.125}, -- NodeBox2
			{0.125, -0.5, -0.0625, 0.1875, 0.5, 0.0625}, -- NodeBox3
			{-0.0625, -0.5, 0.125, 0.0625, 0.5, 0.1875}, -- NodeBox4
			{-0.1875, -0.5, -0.0625, -0.125, 0.5, 0.0625}, -- NodeBox5
		},
	},
	paramtype2 = "facedir",
	groups = {tree = 1, wood = 1, plant = 1, axe = 4}
})

minetest.register_node("lottplants:mallorn_leaves", {
	description = "Mallorn Leaves",
	drawtype = "allfaces_optional",
	tiles = {"lottplants_mallorn_leaves.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {leaves = 1, plant = 1},
})
