dofile(minetest.get_modpath("lottplants").."/nodes.lua")
dofile(minetest.get_modpath("lottplants").."/functions.lua")

-- ===== GROWING TIME =====

local ALDINT = 67
local ALDCHA = 11

local APPINT = 67
local APPCHA = 11

local BIRINT = 67
local BIRCHA = 11

local BEEINT = 67
local BEECHA = 11

local CULINT = 67
local CULCHA = 11

local ELMINT = 67
local ELMCHA = 11

local FIRINT = 67
local FIRCHA = 11

local LEBINT = 67
local LEBCHA = 11

local MALINT = 67
local MALCHA = 11

local PININT = 67
local PINCHA = 11

local PLUINT = 67
local PLUCHA = 11

local ROWINT = 67
local ROWCHA = 11

local WHIINT = 67
local WHICHA = 11

local YAVINT = 67
local YAVCHA = 11

minetest.register_node("lottplants:asphodel", {
	drawtype = "plantlike",
	tiles = { "lottplants_asphodel.png" },
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
    drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:asphodel_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:asphodel_fake", {
	description = "Asphodel",
	drawtype = "plantlike",
	tiles = { "lottplants_asphodel.png" },
	inventory_image = "lottplants_asphodel.png",
	wield_image = "lottplants_asphodel.png",
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

minetest.register_node("lottplants:elanor", {
	drawtype = "plantlike",
	tiles = { "lottplants_elanor.png" },
	inventory_image = "lottplants_elanor.png",
	wield_image = "lottplants_elanor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:elanor_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:elanor_fake", {
	description = "Elanor",
	drawtype = "plantlike",
	tiles = { "lottplants_elanor.png" },
	inventory_image = "lottplants_elanor.png",
	wield_image = "lottplants_elanor.png",
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

minetest.register_node("lottplants:pipeweed_wild", {
	description = "Pipeweed Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_pipeweed_wild.png" },
	inventory_image = "lottplants_pipeweed_wild.png",
	wield_image = "lottplants_pipeweed_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:pipeweed'} },
			{ items = {'lottfarming:pipeweed_seed'} },
			{ items = {'lottfarming:pipeweed_seed'}, rarity = 5}
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

minetest.register_node("lottplants:melon_wild", {
	description = "Melon",
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
	sunlight_propagates = true,
	paramtype = "light",
drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:melon'} },
			{ items = {'lottfarming:melon_seed'} },
			{ items = {'lottfarming:melon_seed'}, rarity = 5}
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

minetest.register_node("lottplants:barley_wild", {
	description = "Barley Wild",
	drawtype = "plantlike",
	tiles = { "lottfarming_barley_3.png" },
	inventory_image = "lottfarming_barley_3.png",
	wield_image = "lottfarming_barley_3.png",
	sunlight_propagates = true,
	paramtype = "light",
drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:barley'} },
			{ items = {'lottfarming:barley_seed'} },
			{ items = {'lottfarming:barley_seed'}, rarity = 5}
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

minetest.register_node("lottplants:mallos", {
	description = "Mallos",
	drawtype = "plantlike",
	tiles = { "lottplants_mallos.png" },
	inventory_image = "lottplants_mallos.png",
	wield_image = "lottplants_mallos.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:mallos_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:mallos_fake", {
	description = "Mallos",
	drawtype = "plantlike",
	tiles = { "lottplants_mallos.png" },
	inventory_image = "lottplants_mallos.png",
	wield_image = "lottplants_mallos.png",
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

minetest.register_node("lottplants:anemones", {
	description = "Anemones",
	drawtype = "plantlike",
	tiles = { "lottplants_anemones.png" },
	inventory_image = "lottplants_anemones.png",
	wield_image = "lottplants_anemones.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:anemones_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:anemones_fake", {
	description = "Anemones",
	drawtype = "plantlike",
	tiles = { "lottplants_anemones.png" },
	inventory_image = "lottplants_anemones.png",
	wield_image = "lottplants_anemones.png",
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

minetest.register_node("lottplants:athelas", {
	description = "Athelas",
	drawtype = "plantlike",
	tiles = { "lottplants_athelas.png" },
	inventory_image = "lottplants_athelas.png",
	wield_image = "lottplants_athelas.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:athelas'} },
			{ items = {'lottfarming:athelas_seed'} },
			{ items = {'lottfarming:athelas_seed'}, rarity = 5},
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

minetest.register_node("lottplants:seregon", {
	description = "Seregon",
	drawtype = "plantlike",
	tiles = { "lottplants_seregon.png" },
	inventory_image = "lottplants_seregon.png",
	wield_image = "lottplants_seregon.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:seregon_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:seregon_fake", {
	description = "Seregon",
	drawtype = "plantlike",
	tiles = { "lottplants_seregon.png" },
	inventory_image = "lottplants_seregon.png",
	wield_image = "lottplants_seregon.png",
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

minetest.register_node("lottplants:eglantive", {
	description = "Eglantive",
	drawtype = "plantlike",
	tiles = { "lottplants_eglantive.png" },
	inventory_image = "lottplants_eglantive.png",
	wield_image = "lottplants_eglantive.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:eglantive_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:eglantive_fake", {
	description = "Eglantive",
	drawtype = "plantlike",
	tiles = { "lottplants_eglantive.png" },
	inventory_image = "lottplants_eglantive.png",
	wield_image = "lottplants_eglantive.png",
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

minetest.register_node("lottplants:iris", {
	description = "Iris",
	drawtype = "plantlike",
	tiles = { "lottplants_iris.png" },
	inventory_image = "lottplants_iris.png",
	wield_image = "lottplants_iris.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:iris_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:iris_fake", {
	description = "Iris",
	drawtype = "plantlike",
	tiles = { "lottplants_iris.png" },
	inventory_image = "lottplants_iris.png",
	wield_image = "lottplants_iris.png",
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

minetest.register_node("lottplants:corn_wild", {
	description = "Corn Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_corn_wild.png" },
	inventory_image = "lottplants_corn_wild.png",
	wield_image = "lottplants_corn_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:corn'} },
			{ items = {'lottfarming:corn_seed'} },
			{ items = {'lottfarming:corn_seed'}, rarity = 5}
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

minetest.register_node("lottplants:potato_wild", {
	description = "Potato Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_potato_wild.png" },
	inventory_image = "lottplants_potato_wild.png",
	wield_image = "lottplants_potato_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:potato'} },
			{ items = {'lottfarming:potato_seed'} },
			{ items = {'lottfarming:potato_seed'}, rarity = 5}
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

minetest.register_node("lottplants:mushroom_wild", {
	description = "Mushroom Wild",
	drawtype = "plantlike",
	tiles = { "lottplants_mushroom_wild.png" },
	inventory_image = "lottplants_mushroom_wild.png",
	wield_image = "lottplants_mushroom_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 5,
		items = {
			{ items = {'lottfarming:brown_mushroom'} },
			{ items = {'lottfarming:brown_mushroom_spore'} },
			{ items = {'lottfarming:red_mushroom_spore'}, rarity = 5},
			{ items = {'lottfarming:blue_mushroom_spore'}, rarity = 10},
			{ items = {'lottfarming:green_mushroom_spore'}, rarity = 20}
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

minetest.register_node("lottplants:lissuin", {
	description = "Lissuin",
	drawtype = "plantlike",
	tiles = { "lottplants_lissuin.png" },
	inventory_image = "lottplants_lissuin.png",
	wield_image = "lottplants_lissuin.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:lissuin_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:lissuin_fake", {
	description = "Lissuin",
	drawtype = "plantlike",
	tiles = { "lottplants_lissuin.png" },
	inventory_image = "lottplants_lissuin.png",
	wield_image = "lottplants_lissuin.png",
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

minetest.register_node("lottplants:niphredil", {
	description = "Niphredil",
	drawtype = "plantlike",
	tiles = { "lottplants_niphredil.png" },
	inventory_image = "lottplants_niphredil.png",
	wield_image = "lottplants_niphredil.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:niphredil_fake'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_brown=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:niphredil_fake", {
	description = "Niphredil",
	drawtype = "plantlike",
	tiles = { "lottplants_niphredil.png" },
	inventory_image = "lottplants_niphredil.png",
	wield_image = "lottplants_niphredil.png",
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

minetest.register_node("lottplants:berries_wild", {
	description = "Wild Berries",
	drawtype = "plantlike",
	tiles = { "lottplants_berries_wild.png" },
	inventory_image = "lottplants_berries_wild.png",
	wield_image = "lottplants_berries_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:berries'} },
			{ items = {'lottfarming:berries_seed'} },
			{ items = {'lottfarming:berries_seed'}, rarity = 5}
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

minetest.register_node("lottplants:turnips_wild", {
	description = "Wild Turnips",
	drawtype = "plantlike",
	tiles = { "lottplants_turnips_wild.png" },
	inventory_image = "lottplants_turnips_wild.png",
	wield_image = "lottplants_turnips_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:turnips'} },
			{ items = {'lottfarming:turnips_seed'} },
			{ items = {'lottfarming:turnips_seed'}, rarity = 5}
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

minetest.register_node("lottplants:tomatoes_wild", {
	description = "Wild Tomatoes",
	drawtype = "plantlike",
	tiles = { "lottplants_tomatoes_wild.png" },
	inventory_image = "lottplants_tomatoes_wild.png",
	wield_image = "lottplants_tomatoes_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:tomatoes'} },
			{ items = {'lottfarming:tomatoes_seed'} },
			{ items = {'lottfarming:tomatoes_seed'}, rarity = 5}
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
			{ items = {'lottfarming:cabbage_seed'} },
			{ items = {'lottfarming:cabbage_seed'}, rarity = 5}
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

minetest.register_node("lottplants:brambles_of_mordor", {
	description = "Brambles Of Mordor",
	drawtype = "plantlike",
	tiles = { "lottplants_brambles_of_mordor.png" },
	inventory_image = "lottplants_brambles_of_mordor.png",
	wield_image = "lottplants_brambles_of_mordor.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = "lottplants:brambles_of_mordor_fake",
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_grey=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:brambles_of_mordor_fake", {
	description = "Brambles Of Mordor",
	drawtype = "plantlike",
	tiles = { "lottplants_brambles_of_mordor.png" },
	inventory_image = "lottplants_brambles_of_mordor.png",
	wield_image = "lottplants_brambles_of_mordor.png",
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

minetest.register_node("lottplants:pilinehtar", {
	description = "Pilinehtar",
	drawtype = "plantlike",
	tiles = { "lottplants_pilinehtar.png" },
	inventory_image = "lottplants_pilinehtar.png",
	wield_image = "lottplants_pilinehtar.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drop = "lottplants:pilinehtar_fake",
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_green=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:pilinehtar_fake", {
	description = "Pilinehtar",
	drawtype = "plantlike",
	tiles = { "lottplants_pilinehtar.png" },
	inventory_image = "lottplants_pilinehtar.png",
	wield_image = "lottplants_pilinehtar.png",
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
			minetest.set_node(pos, {name="lottplants:brambles_of_mordor"})
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

minetest.register_craftitem("lottplants:honey", {
	description = "Honey",
	inventory_image = "lottplants_honey.png",
	on_use = minetest.item_eat(1),
})

