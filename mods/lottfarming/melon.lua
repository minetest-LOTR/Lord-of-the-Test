minetest.register_craftitem("lottfarming:melon_seed", {
	description = "Melon Seed",
	inventory_image = "lottfarming_melon_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "lottfarming:melon_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("lottfarming:melon_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
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

minetest.register_node("lottfarming:melon_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
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

minetest.register_node("lottfarming:melon_3", {
	description = "Melon",
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
		drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:melon_seed'} },
			{ items = {'lottfarming:melon_seed'}, rarity = 2},
			{ items = {'lottfarming:melon_seed'}, rarity = 5},
			{ items = {'lottfarming:melon'} },
			{ items = {'lottfarming:melon'}, rarity = 2 },
			{ items = {'lottfarming:melon'}, rarity = 5 }
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craftitem("lottfarming:melon", {
	description = "Melon",
	inventory_image = "lottfarming_melon_side.png",
	on_use = minetest.item_eat(2),
})

farming:add_plant("lottfarming:melon_3", {"lottfarming:melon_1", "lottfarming:melon_2"}, 80, 20)