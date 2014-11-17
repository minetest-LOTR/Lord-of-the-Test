minetest.register_craftitem("olvar:potato_seed", {
	description = "Potato Seeds",
	inventory_image = "olvar_potato_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:potato_1")
	end,
})

minetest.register_node("olvar:potato_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_potato_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:potato_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_potato_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:potato_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_potato_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:potato_seed'} },
			{ items = {'olvar:potato_seed'}, rarity = 2},
			{ items = {'olvar:potato_seed'}, rarity = 5},
			{ items = {'olvar:potato'} },
			{ items = {'olvar:potato'}, rarity = 2 },
			{ items = {'olvar:potato'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:potato", {
	description = "Potato",
	inventory_image = "olvar_potato.png",
	on_use = minetest.item_eat(1),
})

farming:add_plant("olvar:potato_3", {"olvar:potato_1", "olvar:potato_2"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "olvar:potato_cooked",
	recipe = "olvar:potato"
})

minetest.register_craftitem("olvar:potato_cooked", {
	description = "Cooked Potato",
	inventory_image = "olvar_potato_cooked.png",
	on_use = minetest.item_eat(5),
})
