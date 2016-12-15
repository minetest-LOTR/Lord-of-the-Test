-- FLOWERS

minetest.register_node("lottplants:athelas", {
	description = "Athelas",
	drawtype = "plantlike",
	tiles = { "lottplants_athelas.png" },
	inventory_image = "lottplants_athelas.png",
	wield_image = "lottplants_athelas.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 2,
	waving = 1,
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:athelas'} },
			{ items = {'lottfarming:athelas'}, rarity = 5},
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

minetest.register_node("lottplants:anemones", {
	description = "Anemones",
	drawtype = "plantlike",
	tiles = { "lottplants_anemones.png" },
	inventory_image = "lottplants_anemones.png",
	wield_image = "lottplants_anemones.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:anemones'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:asphodel", {
	drawtype = "plantlike",
	tiles = { "lottplants_asphodel.png" },
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:asphodel'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:eglantive'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 10,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:elanor'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:iris'}}
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 41,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:lissuin'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_pink=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 42,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:mallos'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 8,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{ items = {'lottplants:honey'}, rarity = 20},
			{ items = {'lottplants:niphredil'} },
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_brown=1},
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
	paramtype2 = "meshoptions",
	place_param2 = 40,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 2,
		items = {
			{ items = {'lottplants:seregon'} },
			{ items = {'lottplants:honey'}, rarity = 20},
		}
	},
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

local default_flowers = {
	"dandelion_white",
	"dandelion_yellow",
	"geranium",
	"tulip",
	"rose",
	"viola",
}

for _, v in pairs(default_flowers) do
	minetest.override_item("flowers:" .. v, {
		drop = {
			max_items = 1,
			items = {
				{items = {'lottplants:honey'}, rarity = 20},
				{items = {"flowers:" .. v}},
			}
		}
	})
end

minetest.register_alias("lottplants:anemones_fake", "lottplants:anemones")
minetest.register_alias("lottplants:asphodel_fake", "lottplants:asphodel")
minetest.register_alias("lottplants:eglantive_fake", "lottplants:eglantive")
minetest.register_alias("lottplants:elanor_fake", "lottplants:elanor")
minetest.register_alias("lottplants:iris_fake", "lottplants:iris")
minetest.register_alias("lottplants:lissuin_fake", "lottplants:lissuin")
minetest.register_alias("lottplants:mallos_fake", "lottplants:mallos")
minetest.register_alias("lottplants:niphredil_fake", "lottplants:niphredil")
minetest.register_alias("lottplants:seregon_fake", "lottplants:seregon")
