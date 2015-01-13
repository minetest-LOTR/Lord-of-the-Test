minetest.register_craftitem("lottfarming:turnips_seed", {
	description = "Turnip Seeds",
	inventory_image = "lottfarming_turnips_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:turnips_1")
	end,
})

minetest.register_node("lottfarming:turnips_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_turnips_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:turnips_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_turnips_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:turnips_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_turnips_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:turnips_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_turnips_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:turnips_seed'} },
			{ items = {'lottfarming:turnips_seed'}, rarity = 2},
			{ items = {'lottfarming:turnips_seed'}, rarity = 5},
			{ items = {'lottfarming:turnips'} },
			{ items = {'lottfarming:turnips'}, rarity = 2 },
			{ items = {'lottfarming:turnips'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:turnips", {
	description = "Turnips",
	inventory_image = "lottfarming_turnips.png",
	on_use = minetest.item_eat(2),
})

farming:add_plant("lottfarming:turnips_4", {"lottfarming:turnips_1", "lottfarming:turnips_2", "lottfarming:turnips_3"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:turnips_cooked",
	recipe = "lottfarming:turnips"
})

minetest.register_craftitem("lottfarming:turnips_cooked", {
	description = "Cooked Turnips",
	inventory_image = "lottfarming_turnips_cooked.png",
	on_use = minetest.item_eat(2),
})
