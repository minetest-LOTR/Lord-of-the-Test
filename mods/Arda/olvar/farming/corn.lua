minetest.register_craftitem("olvar:corn_seed", {
	description = "Corn Seeds",
	inventory_image = "olvar_corn_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "olvar:corn_1")
	end,
})
minetest.register_craftitem("olvar:corn", {
	description = "Corn",
	inventory_image = "olvar_corn.png",
     groups = {salad=1},
	on_use = minetest.item_eat(4),
})
minetest.register_node("olvar:corn_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_3.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_4.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_21", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_21.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_22", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_22.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_23", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_23.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:corn'} },
			{ items = {'olvar:corn'}, rarity = 2},
			{ items = {'olvar:corn'}, rarity = 5},
			{ items = {'olvar:corn_seed'} },
			{ items = {'olvar:corn_seed'}, rarity = 2 },
			{ items = {'olvar:corn_seed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_31", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_31.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("olvar:corn_32", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"olvar_corn_32.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'olvar:corn'} },
			{ items = {'olvar:corn'}, rarity = 2},
			{ items = {'olvar:corn'}, rarity = 5},
			{ items = {'olvar:corn_seed'} },
			{ items = {'olvar:corn_seed'}, rarity = 2 },
			{ items = {'olvar:corn_seed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

chance = 10
interval = 45
whereon = "farming:soil_wet"
wherein = "air"

	minetest.register_abm({
		nodenames = "olvar:corn_1",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			if minetest.env:get_node(pos).name ~= wherein then
				return
			end
			pos.y=pos.y-1
			
			minetest.env:set_node(pos, {name='olvar:corn_2'})
		end
}	)
	minetest.register_abm({
		nodenames = "olvar:corn_2",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='olvar:corn_21'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='olvar:corn_3'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "olvar:corn_3",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='olvar:corn_31'})
			pos.y=pos.y-1
			
			minetest.env:set_node(pos, {name='olvar:corn_22'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='olvar:corn_4'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "olvar:corn_22",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='olvar:corn_32'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='olvar:corn_23'})
			
		end
}	)