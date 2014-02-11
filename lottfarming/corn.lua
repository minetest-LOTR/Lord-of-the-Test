minetest.register_craftitem("lottfarming:corn_seed", {
	description = "Corn Seeds",
	inventory_image = "lottfarming_corn_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "lottfarming:corn_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})
minetest.register_craftitem("lottfarming:corn", {
	description = "Corn",
	inventory_image = "lottfarming_corn.png",
	on_use = minetest.item_eat(6),
})
minetest.register_node("lottfarming:corn_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_3.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_4.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_21", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_21.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_22", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_22.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_23", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_23.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:corn'} },
			{ items = {'lottfarming:corn'}, rarity = 2},
			{ items = {'lottfarming:corn'}, rarity = 5},
			{ items = {'lottfarming:corn_seed'} },
			{ items = {'lottfarming:corn_seed'}, rarity = 2 },
			{ items = {'lottfarming:corn_seed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_31", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_31.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_32", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_32.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:corn'} },
			{ items = {'lottfarming:corn'}, rarity = 2},
			{ items = {'lottfarming:corn'}, rarity = 5},
			{ items = {'lottfarming:corn_seed'} },
			{ items = {'lottfarming:corn_seed'}, rarity = 2 },
			{ items = {'lottfarming:corn_seed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

chance = 10
interval = 45
whereon = "farming:soil_wet"
wherein = "air"

	minetest.register_abm({
		nodenames = "lottfarming:corn_1",
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
			
			minetest.env:set_node(pos, {name='lottfarming:corn_2'})
		end
}	)
	minetest.register_abm({
		nodenames = "lottfarming:corn_2",
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
			minetest.env:set_node(pos, {name='lottfarming:corn_21'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='lottfarming:corn_3'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "lottfarming:corn_3",
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
			minetest.env:set_node(pos, {name='lottfarming:corn_31'})
			pos.y=pos.y-1
			
			minetest.env:set_node(pos, {name='lottfarming:corn_22'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='lottfarming:corn_4'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "lottfarming:corn_22",
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
			minetest.env:set_node(pos, {name='lottfarming:corn_32'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='lottfarming:corn_23'})
			
		end
}	)