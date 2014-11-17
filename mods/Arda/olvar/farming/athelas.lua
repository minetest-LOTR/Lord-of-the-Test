minetest.register_craftitem("olvar:athelas_seed", {
	description = "Athelas Seeds",
	inventory_image = "olvar_athelas_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:athelas_1")
	end,
})

minetest.register_node("olvar:athelas_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_athelas_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:athelas_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_athelas_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:athelas_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_athelas_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:athelas_seed'} },
			{ items = {'olvar:athelas_seed'}, rarity = 2},
			{ items = {'olvar:athelas_seed'}, rarity = 5},
			{ items = {'olvar:athelas'} },
			{ items = {'olvar:athelas'}, rarity = 2 },
			{ items = {'olvar:athelas'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:athelas", {
	description = "Athelas",
	inventory_image = "olvar_athelas.png",
})

farming:add_plant("olvar:athelas_3", {"olvar:athelas_1", "olvar:athelas_2"}, 50, 20)