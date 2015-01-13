minetest.register_craftitem("lottfarming:cabbage_seed", {
	description = "Cabbage Seed",
	inventory_image = "lottfarming_cabbage_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:cabbage_1")
	end,
})

minetest.register_node("lottfarming:cabbage_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage_3", {
	description = "Cabbage",
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
		drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:cabbage_seed'} },
			{ items = {'lottfarming:cabbage_seed'}, rarity = 2},
			{ items = {'lottfarming:cabbage_seed'}, rarity = 5},
			{ items = {'lottfarming:cabbage'} },
			{ items = {'lottfarming:cabbage'}, rarity = 2 },
			{ items = {'lottfarming:cabbage'}, rarity = 5 }
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage", {
	description = "Cabbage",
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1, salad=1},
	sounds = default.node_sound_wood_defaults(),
     on_use = minetest.item_eat(4)
})

farming:add_plant("lottfarming:cabbage_3", {"lottfarming:cabbage_1", "lottfarming:cabbage_2"}, 80, 20)

minetest.register_craft({
	output = 'lottfarming:salad',
	recipe = {
		{'group:salad', 'group:salad', 'group:salad'},
		{'', 'lottfarming:bowl', ''},
	}
})

minetest.register_craftitem("lottfarming:salad", {
	description = "Salad",
	inventory_image = "lottfarming_salad.png",
	on_use = minetest.item_eat(10),
})