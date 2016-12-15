-- The wild plants drop food that can be eaten or crafted to get seeds

-- BARLEY

minetest.register_node("lottplants:barley_wild", {
	description = "Wild Barley",
	drawtype = "plantlike",
	tiles = { "lottfarming_barley_3.png" },
	inventory_image = "lottfarming_barley_3.png",
	wield_image = "lottfarming_barley_3.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:barley'} },
			{ items = {'lottfarming:barley'}, rarity = 5},
			{ items = {'lottfarming:barley'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.3, 0.3 },
	},
})

-- BERRIES

minetest.register_node("lottplants:berries_wild", {
	description = "Wild Berries",
	drawtype = "plantlike",
	tiles = { "lottplants_berries_wild.png" },
	inventory_image = "lottplants_berries_wild.png",
	wield_image = "lottplants_berries_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 34,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:berries'} },
			{ items = {'lottfarming:berries'}, rarity = 5},
			{ items = {'lottfarming:berries '}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.2, 0.25 },
	},
})

--CORN

minetest.register_node("lottplants:corn_wild", {
	description = "Wild Corn plant",
	drawtype = "plantlike",
	tiles = { "lottplants_corn_wild.png" },
	inventory_image = "lottplants_corn_wild.png",
	wield_image = "lottplants_corn_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:corn'} },
			{ items = {'lottfarming:corn'}, rarity = 5},
			{ items = {'lottfarming:corn 9'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, 0.3, 0.4 },
	},
})

-- CABBAGE

minetest.register_node("lottplants:cabbage_wild", {
	description = "Wild Cabbage",
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:cabbage'} },
			{ items = {'lottfarming:cabbage'}, rarity = 5},
			{ items = {'lottfarming:cabbage'}, rarity = 10}
		}
	},
	groups = {snappy=3,flammable=2,flora=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- MELON

minetest.register_node("lottplants:melon_wild", {
	description = "Wild Melon",
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:melon 3'} },
			{ items = {'lottfarming:melon 6'}, rarity = 3},
			{ items = {'lottfarming:melon 6'}, rarity = 8}
		}
	},
	groups = {snappy=3,flammable=2,flora=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- MUSHROOMS

minetest.register_node("lottplants:mushroom_wild", {
	description = "Mushroom Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_mushroom_wild.png" },
	inventory_image = "lottplants_mushroom_wild.png",
	wield_image = "lottplants_mushroom_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 9,
	waving = 1,
	drop = {
		max_items = 5,
		items = {
			{ items = {'lottfarming:brown_mushroom'} },
			{ items = {'lottfarming:red_mushroom'}, rarity = 5},
			{ items = {'lottfarming:blue_mushroom'}, rarity = 10},
			{ items = {'lottfarming:green_mushroom'}, rarity = 20},
			{ items = {'lottfarming:white_mushroom'}, rarity = 20},
 			{ items = {'lottfarming:brown_mushroom_spore'}, rarity = 5},
			{ items = {'lottfarming:red_mushroom_spore'}, rarity = 10},
			{ items = {'lottfarming:blue_mushroom_spore'}, rarity = 20},
			{ items = {'lottfarming:green_mushroom_spore'}, rarity = 20},
			{ items = {'lottfarming:white_mushroom_spore'}, rarity = 20}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 },
	},
})

-- PIPEWEED

minetest.register_node("lottplants:pipeweed_wild", {
	description = "Pipeweed Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_pipeweed_wild.png" },
	inventory_image = "lottplants_pipeweed_wild.png",
	wield_image = "lottplants_pipeweed_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 34,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:pipeweed'} },
			{ items = {'lottfarming:pipeweed'}, rarity = 5},
			{ items = {'lottfarming:pipeweed'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
})

-- POTATO

minetest.register_node("lottplants:potato_wild", {
	description = "Potato Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_potato_wild.png" },
	inventory_image = "lottplants_potato_wild.png",
	wield_image = "lottplants_potato_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:potato'} },
			{ items = {'lottfarming:potato'}, rarity = 5},
			{ items = {'lottfarming:potato'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.2, 0.2 },
	},
})

-- TOMATOES

minetest.register_node("lottplants:tomatoes_wild", {
	description = "Wild Tomatoes",
	drawtype = "plantlike",
	tiles = { "lottplants_tomatoes_wild.png" },
	inventory_image = "lottplants_tomatoes_wild.png",
	wield_image = "lottplants_tomatoes_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 10,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:tomatoes'} },
			{ items = {'lottfarming:tomatoes'}, rarity = 5},
			{ items = {'lottfarming:tomatoes'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.35, -0.5, -0.35, 0.35, 0.25, 0.35 },
	},
})

-- TURNIPS

minetest.register_node("lottplants:turnips_wild", {
	description = "Wild Turnips",
	drawtype = "plantlike",
	tiles = { "lottplants_turnips_wild.png" },
	inventory_image = "lottplants_turnips_wild.png",
	wield_image = "lottplants_turnips_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:turnips'} },
			{ items = {'lottfarming:turnips'}, rarity = 10 },
			{ items = {'lottfarming:turnips'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.2, 0.2 },
	},
})
