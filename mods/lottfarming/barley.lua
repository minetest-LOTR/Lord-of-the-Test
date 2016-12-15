minetest.register_craftitem("lottfarming:barley_seed", {
	description = "Barley Seeds",
	inventory_image = "lottfarming_barley_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:barley_1", 3)
	end,
})

minetest.register_node("lottfarming:barley_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_barley_1.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:barley_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_barley_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:barley_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_barley_3.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:barley_seed'} },
			{ items = {'lottfarming:barley_seed'}, rarity = 2},
			{ items = {'lottfarming:barley_seed'}, rarity = 5},
			{ items = {'lottfarming:barley'} },
			{ items = {'lottfarming:barley'}, rarity = 2 },
			{ items = {'lottfarming:barley'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:barley", {
	description = "Barley",
	inventory_image = "lottfarming_barley_3.png",
})

farming:add_plant("lottfarming:barley_3", {"lottfarming:barley_1", "lottfarming:barley_2"}, 50, 20, 3)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:barley_cooked",
	recipe = "lottfarming:barley"
})

minetest.register_craftitem("lottfarming:barley_cooked", {
	description = "Cooked Barley",
	inventory_image = "lottfarming_barley_cooked.png",
	on_use = minetest.item_eat(2),
})
