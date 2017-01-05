minetest.register_craftitem("lottfarming:corn_seed", {
	description = "Corn Seeds",
	inventory_image = "lottfarming_corn_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:corn_1", 3)
	end,
})
minetest.register_craftitem("lottfarming:corn", {
	description = "Corn",
	inventory_image = "lottfarming_corn.png",
     groups = {salad=1},
	on_use = minetest.item_eat(4),
})
minetest.register_node("lottfarming:corn_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_1.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_3.png"},
	waving = 1,
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_4", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_4.png"},
	waving = 1,
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_21", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_21.png"},
	waving = 1,
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_22", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_22.png"},
	waving = 1,
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_23", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_23.png"},
	waving = 1,
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
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_31", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_31.png"},
	waving = 1,
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_32", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_32.png"},
	waving = 1,
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
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

chance = 20
interval = 45
whereon = "farming:soil_wet"
wherein = "air"

minetest.register_abm({
	nodenames = "lottfarming:corn_1",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			if minetest.get_node(pos).name ~= wherein then
				return
			end
			pos.y=pos.y-1

			minetest.set_node(pos, {name='lottfarming:corn_2', param2 = 3})
		end
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_2",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			minetest.set_node(pos, {name='lottfarming:corn_21', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_3', param2 = 3})
		end
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_3",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			pos.y=pos.y+1
			minetest.set_node(pos, {name='lottfarming:corn_31', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_22', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_4', param2 = 3})
		end
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_22",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			minetest.set_node(pos, {name='lottfarming:corn_32', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_23', param2 = 3})
		end
	end
})
