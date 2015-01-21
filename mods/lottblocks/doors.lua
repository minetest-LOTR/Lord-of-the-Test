doors:register_door("lottblocks:door_mallorn", {
	description = "Mallorn Door",
	inventory_image = "lottblocks_door_mallorn.png",
	groups = {choppy=1,flammable=2,door=1},
	tiles_bottom = {"lottblocks_door_mallorn_b.png", "lottblocks_edge_mallorn.png"},
	tiles_top = {"lottblocks_door_mallorn_a.png", "lottblocks_edge_mallorn.png"},
})
minetest.register_craft({
	output = "lottblocks:door_mallorn",
	recipe = {
		{"lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottplants:mallornwood"},
		{"lottplants:mallornwood", "lottplants:mallornwood"}
	}
})

doors:register_door("lottblocks:door_alder", {
	description = "Alder Door",
	inventory_image = "lottblocks_door_alder.png",
	groups = {choppy=2,flammable=2,door=1},
	tiles_bottom = {"lottblocks_door_alder_b.png", "lottblocks_edge_alder.png"},
	tiles_top = {"lottblocks_door_alder_a.png", "lottblocks_edge_alder.png"},
})
minetest.register_craft({
	output = "lottblocks:door_alder",
	recipe = {
		{"lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottplants:alderwood"},
		{"lottplants:alderwood", "lottplants:alderwood"}
	}
})

doors:register_door("lottblocks:door_lebethron", {
	description = "Lebethron Door",
	inventory_image = "lottblocks_door_lebethron.png",
	groups = {choppy=1,flammable=2,door=1},
	tiles_bottom = {"lottblocks_door_lebethron_b.png", "lottblocks_edge_lebethron.png"},
	tiles_top = {"lottblocks_door_lebethron_a.png", "lottblocks_edge_lebethron.png"},
})

minetest.register_craft({
	output = "lottblocks:door_lebethron",
	recipe = {
		{"lottplants:lebethronwood", "lottplants:lebethronwood"},
		{"lottplants:lebethronwood", "lottplants:lebethronwood"},
		{"lottplants:lebethronwood", "lottplants:lebethronwood"}
	}
})

doors:register_door("lottblocks:door_birch", {
	description = "Birch Door",
	inventory_image = "lottblocks_door_birch.png",
	groups = {choppy=3,flammable=2,door=1},
	tiles_bottom = {"lottblocks_door_birch_b.png", "lottblocks_edge_birch.png"},
	tiles_top = {"lottblocks_door_birch_a.png", "lottblocks_edge_birch.png"},
})
minetest.register_craft({
	output = "lottblocks:door_birch",
	recipe = {
		{"lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottplants:birchwood"},
		{"lottplants:birchwood", "lottplants:birchwood"}
	}
})

doors:register_door("lottblocks:door_pine", {
	description = "Pine Door",
	inventory_image = "lottblocks_door_pine.png",
	groups = {choppy=3,flammable=2,door=1},
	tiles_bottom = {"lottblocks_door_pine_b.png", "lottblocks_edge_pine.png"},
	tiles_top = {"lottblocks_door_pine_a.png", "lottblocks_edge_pine.png"},
})
minetest.register_craft({
	output = "lottblocks:door_pine",
	recipe = {
		{"lottplants:pinewood", "lottplants:pinewood"},
		{"lottplants:pinewood", "lottplants:pinewood"},
		{"lottplants:pinewood", "lottplants:pinewood"}
	}
})

doors:register_door("lottblocks:door_junglewood", {
	description = "Junglewood Door",
	inventory_image = "lottblocks_door_junglewood.png",
	groups = {choppy=3,flammable=2,door=1},
	tiles_bottom = {"lottblocks_door_junglewood_b.png", "lottblocks_edge_junglewood.png"},
	tiles_top = {"lottblocks_door_junglewood_a.png", "lottblocks_edge_junglewood.png"},
})
minetest.register_craft({
	output = "lottblocks:door_junglewood",
	recipe = {
		{"default:junglewood", "default:junglewood"},
		{"default:junglewood", "default:junglewood"},
		{"default:junglewood", "default:junglewood"}
	}
})

minetest.register_node("lottblocks:fence_alder", {
	description = "Alder Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_alderwood.png"},
	inventory_image = "lottblocks_alder_fence.png",
	wield_image = "lottblocks_alder_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,flammable=2},
})
minetest.register_craft({
	output = 'lottblocks:fence_alder 6',
	recipe = {
		{'lottplants:alderwood', 'lottplants:alderwood', 'lottplants:alderwood'},
		{'lottplants:alderwood', 'lottplants:alderwood', 'lottplants:alderwood'},
	}
})

minetest.register_node("lottblocks:fence_pine", {
	description = "Pine Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_pinewood.png"},
	inventory_image = "lottblocks_pine_fence.png",
	wield_image = "lottblocks_pine_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=3,flammable=2},
})
minetest.register_craft({
	output = 'lottblocks:fence_pine_6',
	recipe = {
		{'lottplants:pinewood', 'lottplants:pinewood', 'lottplants:pinewood'},
		{'lottplants:pinewood', 'lottplants:pinewood', 'lottplants:pinewood'},
	}
})

minetest.register_node("lottblocks:fence_birch", {
	description = "Birch Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_birchwood.png"},
	inventory_image = "lottblocks_birch_fence.png",
	wield_image = "lottblocks_birch_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=3,flammable=2},
})
minetest.register_craft({
	output = 'lottblocks:fence_birch 6',
	recipe = {
		{'lottplants:birchwood', 'lottplants:birchwood', 'lottplants:birchwood'},
		{'lottplants:birchwood', 'lottplants:birchwood', 'lottplants:birchwood'},
	}
})

minetest.register_node("lottblocks:fence_junglewood", {
	description = "Junglewood Fence",
	drawtype = "fencelike",
	tiles = {"default_junglewood.png"},
	inventory_image = "lottblocks_junglewood_fence.png",
	wield_image = "lottblocks_junglewood_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=3,flammable=2},
})
minetest.register_craft({
	output = 'lottblocks:fence_junglewood_6',
	recipe = {
		{'default:junglewood', 'default:junglewood', 'default:junglewood'},
		{'default:junglewood', 'default:junglewood', 'default:junglewood'},
	}
})

minetest.register_node("lottblocks:fence_mallorn", {
	description = "Mallorn Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_mallornwood.png"},
	inventory_image = "lottblocks_mallorn_fence.png",
	wield_image = "lottblocks_mallorn_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=1,flammable=2},
})
minetest.register_craft({
	output = 'lottblocks:fence_mallorn 6',
	recipe = {
		{'lottplants:mallornwood', 'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'lottplants:mallornwood', 'lottplants:mallornwood', 'lottplants:mallornwood'},
	}
})

minetest.register_node("lottblocks:fence_lebethron", {
	description = "Lebethron Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_lebethronwood.png"},
	inventory_image = "lottblocks_lebethron_fence.png",
	wield_image = "lottblocks_lebethron_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=1,flammable=2},
})
minetest.register_craft({
	output = 'lottblocks:fence_lebethron 6',
	recipe = {
		{'lottplants:lebethronwood', 'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'lottplants:lebethronwood', 'lottplants:lebethronwood', 'lottplants:lebethronwood'},
	}
})
