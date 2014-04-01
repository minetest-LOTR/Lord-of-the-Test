minetest.register_craftitem("lottfarming:barley_seed", {
	description = "Barley Seeds",
	inventory_image = "lottfarming_barley_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "lottfarming:barley_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("lottfarming:barley_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_barley_1.png"},
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
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_barley_2.png"},
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
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_barley_3.png"},
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
	on_use = minetest.item_eat(2),
})

farming:add_plant("lottfarming:barley_3", {"lottfarming:barley_1", "lottfarming:barley_2"}, 50, 20)