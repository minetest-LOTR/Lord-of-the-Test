minetest.register_node("olvar:asphodel", {
	drawtype = "plantlike",
	tiles = { "olvar_asphodel.png" },
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
    drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:asphodel_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:asphodel_fake", {
	description = "Asphodel",
	drawtype = "plantlike",
	tiles = { "olvar_asphodel.png" },
	inventory_image = "olvar_asphodel.png",
	wield_image = "olvar_asphodel.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:elanor", {
	drawtype = "plantlike",
	tiles = { "olvar_elanor.png" },
	inventory_image = "olvar_elanor.png",
	wield_image = "olvar_elanor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:elanor_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:elanor_fake", {
	description = "Elanor",
	drawtype = "plantlike",
	tiles = { "olvar_elanor.png" },
	inventory_image = "olvar_elanor.png",
	wield_image = "olvar_elanor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:pipeweed_wild", {
	description = "Pipeweed Wild",
	drawtype = "plantlike",
	tiles = { "olvar_pipeweed_wild.png" },
	inventory_image = "olvar_pipeweed_wild.png",
	wield_image = "olvar_pipeweed_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:pipeweed'} },
			{ items = {'olvar:pipeweed_seed'} },
			{ items = {'olvar:pipeweed_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:melon_wild", {
	description = "Melon",
	paramtype2 = "facedir",
	tiles = {"olvar_melon_top.png", "olvar_melon_top.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png", "olvar_melon_side.png"},
	sunlight_propagates = true,
	paramtype = "light",
drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:melon'} },
			{ items = {'olvar:melon_seed'} },
			{ items = {'olvar:melon_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:barley_wild", {
	description = "Barley Wild",
	drawtype = "plantlike",
	tiles = { "olvar_barley_3.png" },
	inventory_image = "olvar_barley_3.png",
	wield_image = "olvar_barley_3.png",
	sunlight_propagates = true,
	paramtype = "light",
drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:barley'} },
			{ items = {'olvar:barley_seed'} },
			{ items = {'olvar:barley_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:mallos", {
	description = "Mallos",
	drawtype = "plantlike",
	tiles = { "olvar_mallos.png" },
	inventory_image = "olvar_mallos.png",
	wield_image = "olvar_mallos.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:mallos_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:mallos_fake", {
	description = "Mallos",
	drawtype = "plantlike",
	tiles = { "olvar_mallos.png" },
	inventory_image = "olvar_mallos.png",
	wield_image = "olvar_mallos.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:anemones", {
	description = "Anemones",
	drawtype = "plantlike",
	tiles = { "olvar_anemones.png" },
	inventory_image = "olvar_anemones.png",
	wield_image = "olvar_anemones.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:anemones_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:anemones_fake", {
	description = "Anemones",
	drawtype = "plantlike",
	tiles = { "olvar_anemones.png" },
	inventory_image = "olvar_anemones.png",
	wield_image = "olvar_anemones.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:athelas", {
	description = "Athelas",
	drawtype = "plantlike",
	tiles = { "olvar_athelas.png" },
	inventory_image = "olvar_athelas.png",
	wield_image = "olvar_athelas.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:athelas'} },
			{ items = {'olvar:athelas_seed'} },
			{ items = {'olvar:athelas_seed'}, rarity = 5},
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:seregon", {
	description = "Seregon",
	drawtype = "plantlike",
	tiles = { "olvar_seregon.png" },
	inventory_image = "olvar_seregon.png",
	wield_image = "olvar_seregon.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:seregon_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:seregon_fake", {
	description = "Seregon",
	drawtype = "plantlike",
	tiles = { "olvar_seregon.png" },
	inventory_image = "olvar_seregon.png",
	wield_image = "olvar_seregon.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:eglantive", {
	description = "Eglantive",
	drawtype = "plantlike",
	tiles = { "olvar_eglantive.png" },
	inventory_image = "olvar_eglantive.png",
	wield_image = "olvar_eglantive.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:eglantive_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:eglantive_fake", {
	description = "Eglantive",
	drawtype = "plantlike",
	tiles = { "olvar_eglantive.png" },
	inventory_image = "olvar_eglantive.png",
	wield_image = "olvar_eglantive.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:iris", {
	description = "Iris",
	drawtype = "plantlike",
	tiles = { "olvar_iris.png" },
	inventory_image = "olvar_iris.png",
	wield_image = "olvar_iris.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:iris_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:iris_fake", {
	description = "Iris",
	drawtype = "plantlike",
	tiles = { "olvar_iris.png" },
	inventory_image = "olvar_iris.png",
	wield_image = "olvar_iris.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:corn_wild", {
	description = "Corn Wild",
	drawtype = "plantlike",
	tiles = { "olvar_corn_wild.png" },
	inventory_image = "olvar_corn_wild.png",
	wield_image = "olvar_corn_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:corn'} },
			{ items = {'olvar:corn_seed'} },
			{ items = {'olvar:corn_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:potato_wild", {
	description = "Potato Wild",
	drawtype = "plantlike",
	tiles = { "olvar_potato_wild.png" },
	inventory_image = "olvar_potato_wild.png",
	wield_image = "olvar_potato_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:potato'} },
			{ items = {'olvar:potato_seed'} },
			{ items = {'olvar:potato_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:mushroom_wild", {
	description = "Mushroom Wild",
	drawtype = "plantlike",
	tiles = { "olvar_mushroom_wild.png" },
	inventory_image = "olvar_mushroom_wild.png",
	wield_image = "olvar_mushroom_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 5,
		items = {
			{ items = {'olvar:brown_mushroom'} },
			{ items = {'olvar:brown_mushroom_spore'} },
			{ items = {'olvar:red_mushroom_spore'}, rarity = 5},
			{ items = {'olvar:blue_mushroom_spore'}, rarity = 10},
			{ items = {'olvar:green_mushroom_spore'}, rarity = 20}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:lissuin", {
	description = "Lissuin",
	drawtype = "plantlike",
	tiles = { "olvar_lissuin.png" },
	inventory_image = "olvar_lissuin.png",
	wield_image = "olvar_lissuin.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:lissuin_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:lissuin_fake", {
	description = "Lissuin",
	drawtype = "plantlike",
	tiles = { "olvar_lissuin.png" },
	inventory_image = "olvar_lissuin.png",
	wield_image = "olvar_lissuin.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:niphredil", {
	description = "Niphredil",
	drawtype = "plantlike",
	tiles = { "olvar_niphredil.png" },
	inventory_image = "olvar_niphredil.png",
	wield_image = "olvar_niphredil.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'olvar:niphredil_fake'} },
			{ items = {'olvar:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_brown=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:niphredil_fake", {
	description = "Niphredil",
	drawtype = "plantlike",
	tiles = { "olvar_niphredil.png" },
	inventory_image = "olvar_niphredil.png",
	wield_image = "olvar_niphredil.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_brown=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:berries_wild", {
	description = "Wild Berries",
	drawtype = "plantlike",
	tiles = { "olvar_berries_wild.png" },
	inventory_image = "olvar_berries_wild.png",
	wield_image = "olvar_berries_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:berries'} },
			{ items = {'olvar:berries_seed'} },
			{ items = {'olvar:berries_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:turnips_wild", {
	description = "Wild Turnips",
	drawtype = "plantlike",
	tiles = { "olvar_turnips_wild.png" },
	inventory_image = "olvar_turnips_wild.png",
	wield_image = "olvar_turnips_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:turnips'} },
			{ items = {'olvar:turnips_seed'} },
			{ items = {'olvar:turnips_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:tomatoes_wild", {
	description = "Wild Tomatoes",
	drawtype = "plantlike",
	tiles = { "olvar_tomatoes_wild.png" },
	inventory_image = "olvar_tomatoes_wild.png",
	wield_image = "olvar_tomatoes_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:tomatoes'} },
			{ items = {'olvar:tomatoes_seed'} },
			{ items = {'olvar:tomatoes_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:cabbage_wild", {
	description = "Wild Cabbage",
	paramtype2 = "facedir",
	tiles = {"olvar_cabbage_top.png", "olvar_cabbage_top.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png"},
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'olvar:cabbage'} },
			{ items = {'olvar:cabbage_seed'} },
			{ items = {'olvar:cabbage_seed'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:brambles_of_mordor", {
	description = "Brambles Of Mordor",
	drawtype = "plantlike",
	tiles = { "olvar_brambles_of_mordor.png" },
	inventory_image = "olvar_brambles_of_mordor.png",
	wield_image = "olvar_brambles_of_mordor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = "olvar:brambles_of_mordor_fake",
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_grey=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:brambles_of_mordor_fake", {
	description = "Brambles Of Mordor",
	drawtype = "plantlike",
	tiles = { "olvar_brambles_of_mordor.png" },
	inventory_image = "olvar_brambles_of_mordor.png",
	wield_image = "olvar_brambles_of_mordor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_grey=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:pilinehtar", {
	description = "Pilinehtar",
	drawtype = "plantlike",
	tiles = { "olvar_pilinehtar.png" },
	inventory_image = "olvar_pilinehtar.png",
	wield_image = "olvar_pilinehtar.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = "olvar:pilinehtar_fake",
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_green=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("olvar:pilinehtar_fake", {
	description = "Pilinehtar",
	drawtype = "plantlike",
	tiles = { "olvar_pilinehtar.png" },
	inventory_image = "olvar_pilinehtar.png",
	wield_image = "olvar_pilinehtar.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_green=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_abm({
	nodenames = {"group:flora"},
	neighbors = {"default:dirt_with_grass", "default:desert_sand"},
	interval = 50,
	chance = 25,
	action = function(pos, node)
		pos.y = pos.y - 1
		local under = minetest.get_node(pos)
		pos.y = pos.y + 1
		if under.name == "default:desert_sand" then
			minetest.set_node(pos, {name="olvar:brambles_of_mordor"})
		elseif under.name ~= "default:dirt_with_grass" then
			return
		end
		
		local light = minetest.get_node_light(pos)
		if not light or light < 13 then
			return
		end
		
		local pos0 = {x=pos.x-4,y=pos.y-4,z=pos.z-4}
		local pos1 = {x=pos.x+4,y=pos.y+4,z=pos.z+4}
		if #minetest.find_nodes_in_area(pos0, pos1, "group:flora_block") > 0 then
			return
		end
		
		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flora")
		if #flowers > 3 then
			return
		end
		
		local seedling = minetest.find_nodes_in_area(pos0, pos1, "default:dirt_with_grass")
		if #seedling > 0 then
			seedling = seedling[math.random(#seedling)]
			seedling.y = seedling.y + 1
			light = minetest.get_node_light(seedling)
			if not light or light < 13 then
				return
			end
			if minetest.get_node(seedling).name == "air" then
				minetest.set_node(seedling, {name=node.name})
			end
		end
	end,
})

minetest.register_craftitem("olvar:honey", {
	description = "Honey",
	inventory_image = "olvar_honey.png",
	on_use = minetest.item_eat(1),
})

