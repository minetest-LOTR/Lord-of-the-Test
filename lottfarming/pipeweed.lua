minetest.register_craftitem("lottfarming:pipeweed_seed", {
	description = "Pipeweed Seeds",
	inventory_image = "lottfarming_pipeweed_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "lottfarming:pipeweed_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("lottfarming:pipeweed_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_pipeweed_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_pipeweed_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_pipeweed_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:pipeweed_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_pipeweed_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:pipeweed_seed'} },
			{ items = {'lottfarming:pipeweed_seed'}, rarity = 2},
			{ items = {'lottfarming:pipeweed_seed'}, rarity = 5},
			{ items = {'lottfarming:pipeweed'} },
			{ items = {'lottfarming:pipeweed'}, rarity = 2 },
			{ items = {'lottfarming:pipeweed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:pipeweed", {
	description = "Pipeweed",
	inventory_image = "lottfarming_pipeweed.png",
	on_use = minetest.item_eat(4),
})

farming:add_plant("lottfarming:pipeweed_4", {"lottfarming:pipeweed_1", "lottfarming:pipeweed_2", "lottfarming:pipeweed_3"}, 50, 20)