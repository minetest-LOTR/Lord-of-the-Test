lottstairs = {}

local modpath = minetest.get_modpath("lottstairs")
dofile(modpath .. "/shapes.lua")
dofile(modpath .. "/circular_saw.lua")
--dofile(modpath .. "/definitions.lua")

lottstairs.register_shapes("stone", {
	description = "Stone",
	tiles = {"lottitems_stone.png"},
	texture = "lottitems_stone.png",
	groups = {cracky = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("red_stone", {
	description = "Red Stone",
	tiles = {"lottitems_red_stone.png"},
	texture = "lottitems_red_stone.png",
	groups = {cracky = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("blue_stone", {
	description = "Stone",
	tiles = {"lottitems_blue_stone.png"},
	texture = "lottitems_blue_stone.png",
	groups = {cracky = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("alder_planks", 	{
	description = "Alder Planks",
	tiles = {"lottplants_alder_planks.png"},
	texture = "lottplants_alder_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("apple_planks", 	{
	description = "Apple Planks",
	tiles = {"lottplants_apple_planks.png"},
	texture = "lottplants_apple_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("ash_planks", 	{
	description = "Ash Planks",
	tiles = {"lottplants_ash_planks.png"},
	texture = "lottplants_ash_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("beech_planks", 	{
	description = "Beech Planks",
	tiles = {"lottplants_beech_planks.png"},
	texture = "lottplants_beech_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("birch_planks", 	{
	description = "Birch Planks",
	tiles = {"lottplants_birch_planks.png"},
	texture = "lottplants_birch_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("cedar_planks", 	{
	description = "Cedar Planks",
	tiles = {"lottplants_cedar_planks.png"},
	texture = "lottplants_cedar_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("dark_oak_planks", 	{
	description = "Dark Oak Planks",
	tiles = {"lottplants_dark_oak_planks.png"},
	texture = "lottplants_dark_oak_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("elm_planks", 	{
	description = "Elm Planks",
	tiles = {"lottplants_elm_planks.png"},
	texture = "lottplants_elm_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("holly_planks", 	{
	description = "Holly Planks",
	tiles = {"lottplants_holly_planks.png"},
	texture = "lottplants_holly_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("mallorn_planks", 	{
	description = "Mallorn Planks",
	tiles = {"lottplants_mallorn_planks.png"},
	texture = "lottplants_mallorn_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("maple_planks", 	{
	description = "Maple Planks",
	tiles = {"lottplants_maple_planks.png"},
	texture = "lottplants_maple_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("oak_planks", 	{
	description = "Oak Planks",
	tiles = {"lottplants_oak_planks.png"},
	texture = "lottplants_oak_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("pine_planks", 	{
	description = "Pine Planks",
	tiles = {"lottplants_pine_planks.png"},
	texture = "lottplants_pine_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("poplar_planks", 	{
	description = "Poplar Planks",
	tiles = {"lottplants_poplar_planks.png"},
	texture = "lottplants_poplar_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

lottstairs.register_shapes("rowan_planks", 	{
	description = "Rowan Planks",
	tiles = {"lottplants_rowan_planks.png"},
	texture = "lottplants_rowan_planks.png",
	groups = {axe = 3},
	--sounds = default.node_sound_stone_defaults(),
})

--[[
shapes:register_shapes("tree", {
	description = "Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	cube_tiles = {"default_tree_top.png","default_tree.png^[transformFXR90", "default_tree_top.png", "default_tree.png", "default_tree.png", "default_tree_top.png"},
	step_tiles = {"default_tree_top.png","default_tree_top.png", "default_tree.png", "default_tree.png", "default_tree.png", "shapes_tree_2.png^[transformFY"},
	halfstair_tiles = {"default_tree_top.png","default_tree_top.png", "shapes_tree_2.png", "default_tree.png", "default_tree.png", "shapes_tree.png"},
	stair_tiles = {"default_tree_top.png","default_tree_top.png", "default_tree.png", "default_tree.png", "default_tree.png", "shapes_tree.png"},
	outerstair_tiles = {"default_tree_top.png","default_tree_top.png", "shapes_tree.png", "default_tree.png", "default_tree.png", "shapes_tree.png"},
	innerstair_tiles = {"default_tree_top.png","default_tree_top.png", "shapes_tree_3.png^[transformFX", "default_tree.png", "default_tree.png", "shapes_tree_3.png"},
	texture = "default_tree.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})]]
