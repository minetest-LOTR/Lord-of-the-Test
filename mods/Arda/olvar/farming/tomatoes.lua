minetest.register_craftitem("olvar:tomatoes_seed", {
	description = "Tomato Seeds",
	inventory_image = "olvar_tomatoes_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:tomatoes_1")
	end,
})

minetest.register_node("olvar:tomatoes_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_tomatoes_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:tomatoes_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_tomatoes_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:tomatoes_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_tomatoes_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:tomatoes_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_tomatoes_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:tomatoes_seed'} },
			{ items = {'olvar:tomatoes_seed'}, rarity = 2},
			{ items = {'olvar:tomatoes_seed'}, rarity = 5},
			{ items = {'olvar:tomatoes'} },
			{ items = {'olvar:tomatoes'}, rarity = 2 },
			{ items = {'olvar:tomatoes'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:tomatoes", {
	description = "Tomato",
	inventory_image = "olvar_tomatoes.png",
	on_use = minetest.item_eat(2),
	groups = {salad=1},
})

farming:add_plant("olvar:tomatoes_4", {"olvar:tomatoes_1", "olvar:tomatoes_2", "olvar:tomatoes_3"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "olvar:tomatoes_cooked",
	recipe = "olvar:tomatoes"
})

minetest.register_craftitem("olvar:tomatoes_cooked", {
	description = "Cooked Tomato",
	inventory_image = "olvar_tomatoes_cooked.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("olvar:tomato_soup", {
	description = "Tomato Soup",
	inventory_image = "olvar_tomato_soup.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craft({
	output = 'olvar:tomato_soup',
	recipe = {
		{'olvar:tomatoes_cooked', 'olvar:tomatoes_cooked', 'olvar:tomatoes_cooked'},
		{'', 'olvar:bowl', ''},
	}
})
