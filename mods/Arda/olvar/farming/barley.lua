minetest.register_craftitem("olvar:barley_seed", {
	description = "Barley Seeds",
	inventory_image = "olvar_barley_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:barley_1")
	end,
})

minetest.register_node("olvar:barley_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_barley_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:barley_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_barley_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:barley_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_barley_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:barley_seed'} },
			{ items = {'olvar:barley_seed'}, rarity = 2},
			{ items = {'olvar:barley_seed'}, rarity = 5},
			{ items = {'olvar:barley'} },
			{ items = {'olvar:barley'}, rarity = 2 },
			{ items = {'olvar:barley'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:barley", {
	description = "Barley",
	inventory_image = "olvar_barley_3.png",
})

farming:add_plant("olvar:barley_3", {"olvar:barley_1", "olvar:barley_2"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "olvar:barley_cooked",
	recipe = "olvar:barley"
})

minetest.register_craftitem("olvar:barley_cooked", {
	description = "Cooked Barley",
	inventory_image = "olvar_barley_cooked.png",
	on_use = minetest.item_eat(2),
})