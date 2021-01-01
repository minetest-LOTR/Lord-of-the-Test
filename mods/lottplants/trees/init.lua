--[[
Young trunk nbs:
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

local leaves_litter_box = {
	{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}
}


local function register_tree_nodes(tree_name, has_young_tree, axe_group, needles)
	minetest.register_node("lottplants:" .. tree_name .. "_trunk", {
		description = lott.str_to_desc(tree_name) .. " Trunk",
		tiles = {
			"lottplants_" .. tree_name .. "_trunk_top.png",
			"lottplants_" .. tree_name .. "_trunk_top.png",
			"lottplants_" .. tree_name .. "_trunk.png"
		},
		paramtype2 = "facedir",
		groups = {tree = 1, wood = 1, plant = 1, axe = axe_group},
	})

	minetest.register_node("lottplants:" .. tree_name .. "_planks", {
		description = lott.str_to_desc(tree_name) .. " Planks",
		tiles = {"lottplants_" .. tree_name .. "_planks.png"},
		paramtype2 = "facedir",
		groups = {wood = 1, axe = axe_group},
	})
	if needles then
		minetest.register_node("lottplants:" .. tree_name .. "_needles", {
			description = lott.str_to_desc(tree_name) .. " Needles",
			drawtype = "allfaces_optional",
			tiles = {"lottplants_" .. tree_name .. "_needles.png"},
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {leaves = 1, plant = 1, hand = 3},
			drop = {
				max_items = 2,
				items = {
					{items = {"lottitems:stick"}, rarity = 16},
					{items = {"lottplants:" .. tree_name .. "_needles"}}
				}
			},
		})
		-- alias for consistency
		minetest.register_alias("lottplants:" .. tree_name .. "_leaves", "lottplants:" .. tree_name .. "_needles")
	else
		minetest.register_node("lottplants:" .. tree_name .. "_leaves", {
			description = lott.str_to_desc(tree_name) .. " Leaves",
			drawtype = "allfaces_optional",
			tiles = {"lottplants_" .. tree_name .. "_leaves.png"},
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {leaves = 1, plant = 1, hand = 3},
			drop = {
				max_items = 2,
				items = {
					{items = {"lottitems:stick"}, rarity = 16},
					{items = {"lottplants:" .. tree_name .. "_leaves"}}
				}
			},
		})
	end
	if has_young_tree then
		minetest.register_node("lottplants:young_" .. tree_name .. "_trunk", {
			description = "Young " .. lott.str_to_desc(tree_name) .. " Trunk",
			drawtype = "nodebox",
			tiles = {
				"lottplants_" .. tree_name .. "_trunk_top.png",
				"lottplants_" .. tree_name .. "_trunk_top.png",
				"lottplants_" .. tree_name .. "_trunk.png"
			},
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
			groups = {tree = 1, wood = 1, plant = 1, axe = axe_group}
		})
	end

	lottshapes:register_shapes("lottplants:" .. tree_name .. "_planks")
	-- TODO: Add shapes for trees? Would need 1 new texture (at least).
end
minetest.register_node("lottplants:oak_leaves_litter", {
	description = "Oak Leaves Litter",
	drawtype = "nodebox",
	tiles = {"lottplants_oak_leaves.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = leaves_litter_box,
	},
	groups = {leaves = 1, plant = 1},
})

-- Alder
register_tree_nodes("alder", false, 3)

-- Apple
register_tree_nodes("apple", false, 2)

-- Ash
register_tree_nodes("ash", false, 1)

-- Beech
register_tree_nodes("beech", false, 3)

-- Birch
register_tree_nodes("birch", false, 3)

-- Cedar
register_tree_nodes("cedar", false, 2)

-- Dark Oak
register_tree_nodes("dark_oak", false, 4)

-- Elm
register_tree_nodes("elm", false, 2)

-- Holly
register_tree_nodes("holly", false, 1)

-- Maple
register_tree_nodes("maple", false, 3)

-- Mallorn
register_tree_nodes("mallorn", true, 4)

-- Oak
register_tree_nodes("oak", false, 1)

-- Pine
register_tree_nodes("pine", false, 1, true)

-- Poplar
register_tree_nodes("poplar", false, 1)

-- Rowan
register_tree_nodes("rowan", false, 2)

-- TODO: Drop berries
minetest.register_node("lottplants:rowan_berries", {
	description = "Rowan Berries",
	drawtype = "allfaces_optional",
	tiles = {"lottplants_rowan_leaves.png^lottplants_rowan_berries.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {leaves = 1, plant = 1, food = 1, red = 1, hand = 3},
})

-- White Tree
register_tree_nodes("white_tree", true, 4)
