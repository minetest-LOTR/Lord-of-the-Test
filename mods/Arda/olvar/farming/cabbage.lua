minetest.register_craftitem("olvar:cabbage_seed", {
	description = "Cabbage Seed",
	inventory_image = "olvar_cabbage_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:cabbage_1")
	end,
})

minetest.register_node("olvar:cabbage_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"olvar_cabbage_top.png", "olvar_cabbage_top.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png"},
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

minetest.register_node("olvar:cabbage_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"olvar_cabbage_top.png", "olvar_cabbage_top.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png"},
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

minetest.register_node("olvar:cabbage_3", {
	description = "Cabbage",
	paramtype2 = "facedir",
	tiles = {"olvar_cabbage_top.png", "olvar_cabbage_top.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png"},
		drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:cabbage_seed'} },
			{ items = {'olvar:cabbage_seed'}, rarity = 2},
			{ items = {'olvar:cabbage_seed'}, rarity = 5},
			{ items = {'olvar:cabbage'} },
			{ items = {'olvar:cabbage'}, rarity = 2 },
			{ items = {'olvar:cabbage'}, rarity = 5 }
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("olvar:cabbage", {
	description = "Cabbage",
	paramtype2 = "facedir",
	tiles = {"olvar_cabbage_top.png", "olvar_cabbage_top.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png", "olvar_cabbage_side.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1, salad=1},
	sounds = default.node_sound_wood_defaults(),
     on_use = minetest.item_eat(4)
})

farming:add_plant("olvar:cabbage_3", {"olvar:cabbage_1", "olvar:cabbage_2"}, 80, 20)

minetest.register_craft({
	output = 'olvar:salad',
	recipe = {
		{'group:salad', 'group:salad', 'group:salad'},
		{'', 'olvar:bowl', ''},
	}
})

minetest.register_craftitem("olvar:salad", {
	description = "Salad",
	inventory_image = "olvar_salad.png",
	on_use = minetest.item_eat(10),
})