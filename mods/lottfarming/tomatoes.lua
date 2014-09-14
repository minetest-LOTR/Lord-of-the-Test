minetest.register_craftitem("lottfarming:tomatoes_seed", {
	description = "Tomato Seeds",
	inventory_image = "lottfarming_tomatoes_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:tomatoes_1")
	end,
})

minetest.register_node("lottfarming:tomatoes_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_tomatoes_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:tomatoes_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_tomatoes_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:tomatoes_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_tomatoes_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:tomatoes_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_tomatoes_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:tomatoes_seed'} },
			{ items = {'lottfarming:tomatoes_seed'}, rarity = 2},
			{ items = {'lottfarming:tomatoes_seed'}, rarity = 5},
			{ items = {'lottfarming:tomatoes'} },
			{ items = {'lottfarming:tomatoes'}, rarity = 2 },
			{ items = {'lottfarming:tomatoes'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:tomatoes", {
	description = "Tomato",
	inventory_image = "lottfarming_tomatoes.png",
	on_use = minetest.item_eat(2),
	groups = {salad=1},
})

farming:add_plant("lottfarming:tomatoes_4", {"lottfarming:tomatoes_1", "lottfarming:tomatoes_2", "lottfarming:tomatoes_3"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:tomatoes_cooked",
	recipe = "lottfarming:tomatoes"
})

minetest.register_craftitem("lottfarming:tomatoes_cooked", {
	description = "Cooked Tomato",
	inventory_image = "lottfarming_tomatoes_cooked.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:tomato_soup", {
	description = "Tomato Soup",
	inventory_image = "lottfarming_tomato_soup.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craft({
	output = 'lottfarming:tomato_soup',
	recipe = {
		{'lottfarming:tomatoes_cooked', 'lottfarming:tomatoes_cooked', 'lottfarming:tomatoes_cooked'},
		{'', 'lottfarming:bowl', ''},
	}
})
