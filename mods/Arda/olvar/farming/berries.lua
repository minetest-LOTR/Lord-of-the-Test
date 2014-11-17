minetest.register_craftitem("olvar:berries_seed", {
	description = "Berries Seeds",
	inventory_image = "olvar_berries_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:berries_1")
	end,
})

minetest.register_node("olvar:berries_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_berries_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:berries_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_berries_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:berries_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_berries_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:berries_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_berries_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:berries_seed'} },
			{ items = {'olvar:berries_seed'}, rarity = 2},
			{ items = {'olvar:berries_seed'}, rarity = 5},
			{ items = {'olvar:berries'} },
			{ items = {'olvar:berries'}, rarity = 2 },
			{ items = {'olvar:berries'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:berries", {
	description = "Berries",
	inventory_image = "olvar_berries.png",
	on_use = minetest.item_eat(1),
})

farming:add_plant("olvar:berries_4", {"olvar:berries_1", "olvar:berries_2", "olvar:berries_3"}, 50, 20)