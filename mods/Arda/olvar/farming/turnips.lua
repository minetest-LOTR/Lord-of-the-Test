minetest.register_craftitem("olvar:turnips_seed", {
	description = "Turnip Seeds",
	inventory_image = "olvar_turnips_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:turnips_1")
	end,
})

minetest.register_node("olvar:turnips_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_turnips_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:turnips_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_turnips_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:turnips_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_turnips_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:turnips_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"olvar_turnips_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:turnips_seed'} },
			{ items = {'olvar:turnips_seed'}, rarity = 2},
			{ items = {'olvar:turnips_seed'}, rarity = 5},
			{ items = {'olvar:turnips'} },
			{ items = {'olvar:turnips'}, rarity = 2 },
			{ items = {'olvar:turnips'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("olvar:turnips", {
	description = "Turnips",
	inventory_image = "olvar_turnips.png",
	on_use = minetest.item_eat(2),
})

farming:add_plant("olvar:turnips_4", {"olvar:turnips_1", "olvar:turnips_2", "olvar:turnips_3"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "olvar:turnips_cooked",
	recipe = "olvar:turnips"
})

minetest.register_craftitem("olvar:turnips_cooked", {
	description = "Cooked Turnips",
	inventory_image = "olvar_turnips_cooked.png",
	on_use = minetest.item_eat(2),
})
