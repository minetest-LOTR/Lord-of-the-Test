doors:register_door("curwe:door_mallorn", {
	description = "Mallorn Door",
	inventory_image = "curwe_door_mallorn.png",
	groups = {choppy=1,flammable=2,door=1},
	tiles_bottom = {"curwe_door_mallorn_b.png", "curwe_edge_mallorn.png"},
	tiles_top = {"curwe_door_mallorn_a.png", "curwe_edge_mallorn.png"},
})
minetest.register_craft({
	output = "curwe:door_mallorn",
	recipe = {
		{"olvar:mallornwood", "olvar:mallornwood"},
		{"olvar:mallornwood", "olvar:mallornwood"},
		{"olvar:mallornwood", "olvar:mallornwood"}
	}
})
doors:register_door("curwe:door_alder", {
	description = "Alder Door",
	inventory_image = "curwe_door_alder.png",
	groups = {choppy=2,flammable=2,door=1},
	tiles_bottom = {"curwe_door_alder_b.png", "curwe_edge_alder.png"},
	tiles_top = {"curwe_door_alder_a.png", "curwe_edge_alder.png"},
})
minetest.register_craft({
	output = "curwe:door_alder",
	recipe = {
		{"olvar:alderwood", "olvar:alderwood"},
		{"olvar:alderwood", "olvar:alderwood"},
		{"olvar:alderwood", "olvar:alderwood"}
	}
})
doors:register_door("curwe:door_lebethron", {
	description = "Lebethron Door",
	inventory_image = "curwe_door_lebethron.png",
	groups = {choppy=1,flammable=2,door=1},
	tiles_bottom = {"curwe_door_lebethron_b.png", "curwe_edge_lebethron.png"},
	tiles_top = {"curwe_door_lebethron_a.png", "curwe_edge_lebethron.png"},
})
minetest.register_craft({
	output = "curwe:door_lebethron",
	recipe = {
		{"olvar:lebethronwood", "olvar:lebethronwood"},
		{"olvar:lebethronwood", "olvar:lebethronwood"},
		{"olvar:lebethronwood", "olvar:lebethronwood"}
	}
})
doors:register_door("curwe:door_birch", {
	description = "Birch Door",
	inventory_image = "curwe_door_birch.png",
	groups = {choppy=3,flammable=2,door=1},
	tiles_bottom = {"curwe_door_birch_b.png", "curwe_edge_birch.png"},
	tiles_top = {"curwe_door_birch_a.png", "curwe_edge_birch.png"},
})
minetest.register_craft({
	output = "curwe:door_birch",
	recipe = {
		{"olvar:birchwood", "olvar:birchwood"},
		{"olvar:birchwood", "olvar:birchwood"},
		{"olvar:birchwood", "olvar:birchwood"}
	}
})

minetest.register_node("curwe:fence_alder", {
	description = "Alder Fence",
	drawtype = "fencelike",
	tiles = {"olvar_alderwood.png"},
	inventory_image = "curwe_alder_fence.png",
	wield_image = "curwe_alder_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,flammable=2},
})

minetest.register_craft({
	output = 'curwe:fence_alder 6',
	recipe = {
		{'olvar:alderwood', 'olvar:alderwood', 'olvar:alderwood'},
		{'olvar:alderwood', 'olvar:alderwood', 'olvar:alderwood'},
	}
})


minetest.register_node("curwe:fence_birch", {
	description = "Birch Fence",
	drawtype = "fencelike",
	tiles = {"olvar_birchwood.png"},
	inventory_image = "curwe_birch_fence.png",
	wield_image = "curwe_birch_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=3,flammable=2},
})

minetest.register_craft({
	output = 'curwe:fence_birch 6',
	recipe = {
		{'olvar:birchwood', 'olvar:birchwood', 'olvar:birchwood'},
		{'olvar:birchwood', 'olvar:birchwood', 'olvar:birchwood'},
	}
})

minetest.register_node("curwe:fence_mallorn", {
	description = "Mallorn Fence",
	drawtype = "fencelike",
	tiles = {"olvar_mallornwood.png"},
	inventory_image = "curwe_mallorn_fence.png",
	wield_image = "curwe_mallorn_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=1,flammable=2},
})

minetest.register_craft({
	output = 'curwe:fence_mallorn 6',
	recipe = {
		{'olvar:mallornwood', 'olvar:mallornwood', 'olvar:mallornwood'},
		{'olvar:mallornwood', 'olvar:mallornwood', 'olvar:mallornwood'},
	}
})

minetest.register_node("curwe:fence_lebethron", {
	description = "Lebethron Fence",
	drawtype = "fencelike",
	tiles = {"olvar_lebethronwood.png"},
	inventory_image = "curwe_lebethron_fence.png",
	wield_image = "curwe_lebethron_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=1,flammable=2},
})

minetest.register_craft({
	output = 'curwe:fence_lebethron 6',
	recipe = {
		{'olvar:lebethronwood', 'olvar:lebethronwood', 'olvar:lebethronwood'},
		{'olvar:lebethronwood', 'olvar:lebethronwood', 'olvar:lebethronwood'},
	}
})

