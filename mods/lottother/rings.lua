minetest.register_craftitem("lottother:ringsilver_lump", {
	description = "Unrefined Ring Silver",
	inventory_image = "lottother_ringsilver_lump.png",
})

minetest.register_craftitem("lottother:ringsilver_ingot", {
	description = "Refined Ring Silver",
	inventory_image = "lottother_ringsilver_ingot.png",
})

minetest.register_craftitem("lottother:ring", {
	description = "Plain Ring",
	inventory_image = "lottother_ring.png",
})

minetest.register_craftitem("lottother:blue_gem_ring", {
	description = "Blue Gem Ring",
	inventory_image = "lottother_bluegem_ring.png",
})

minetest.register_craftitem("lottother:red_gem_ring", {
	description = "Red Gem Ring",
	inventory_image = "lottother_redgem_ring.png",
})

minetest.register_craftitem("lottother:white_gem_ring", {
	description = "White Gem Ring",
	inventory_image = "lottother_whitegem_ring.png",
})

minetest.register_craft({
	type = "cooking",
	output = "lottother:ringsilver_ingot",
	recipe = "lottother:ringsilver_lump",
	cooktime = 35,
})
minetest.register_craft({
	type = "shapeless",
	output = "lottother:ringsilver_lump",
	recipe = {"lottores:mithril_lump", "default:gold_lump", "lottores:silver_lump", "lottores:silver_lump"},
})
minetest.register_craft({
	output = "lottother:ring",
	recipe = {
	{"lottother:ringsilver_ingot", "lottother:ringsilver_ingot", "lottother:ringsilver_ingot"},
	{"lottother:ringsilver_ingot", "", "lottother:ringsilver_ingot"},
	{"lottother:ringsilver_ingot", "lottother:ringsilver_ingot", "lottother:ringsilver_ingot"},
	},
})

minetest.register_craft({
	output = "lottother:blue_gem_ring",
	recipe = {
	{"lottores:blue_gem"},
	{"lottother:ring"},
	},
})

minetest.register_craft({
	output = "lottother:red_gem_ring",
	recipe = {
	{"lottores:red_gem"},
	{"lottother:ring"},
	},
})

minetest.register_craft({
	output = "lottother:white_gem_ring",
	recipe = {
	{"lottores:white_gem"},
	{"lottother:ring"},
	},
})

