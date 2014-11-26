minetest.register_tool("gul:small_bag", {
	description = "Small Bag",
	inventory_image = "bags_small.png",
	groups = {bagslots=8},
})
minetest.register_tool("gul:medium_bag", {
	description = "Medium Bag",
	inventory_image = "bags_medium.png",
	groups = {bagslots=16},
})
minetest.register_tool("gul:large_bag", {
	description = "Large Bag",
	inventory_image = "bags_large.png",
	groups = {bagslots=24, forbidden=1},
})