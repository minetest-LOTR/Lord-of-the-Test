-- Elf torch
local function on_flood_elf(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("lottblocks:elf_torch 1"))
	return false
end

minetest.register_node("lottblocks:elf_torch", {
	description = "Elf Torch",
	drawtype = "mesh",
	mesh = "default_torch_floor.obj",
	inventory_image = "lottblocks_elf_torch_on_floor.png",
	wield_image = "lottblocks_elf_torch_on_floor.png",
	tiles = {{
			name = "lottblocks_elf_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1},
	drop = "lottblocks:elf_torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
		wall_top = {-1/8, -3/16, -1/8, 1/8, 1/2, 1/8},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 or wdir == 1 then
			fakestack:set_name("lottblocks:elf_torch")
		else
			fakestack:set_name("lottblocks:elf_torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("lottblocks:elf_torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood_elf,
})

minetest.register_node("lottblocks:elf_torch_wall", {
	drawtype = "mesh",
	mesh = "default_torch_wall.obj",
	tiles = {{
		    name = "lottblocks_elf_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottblocks:elf_torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -5/16, 1/8, 1/8},
	},
	floodable = true,
	on_flood = on_flood_elf,
})

minetest.register_lbm({
	name = "lottblocks:elftorch",
	nodenames = {"lottblocks:elf_torch"},
	action = function(pos, node)
		if node.param2 == 0 or node.param2 == 1 then
			minetest.set_node(pos, {name = "lottblocks:elf_torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "lottblocks:elf_torch_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_craft({
	output = 'lottblocks:elf_torch 2',
	recipe = {
		{'lottores:rough_rock_lump'},
		{'group:stick'},
	}
})

-- Orc torch
local function on_flood_orc(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("lottblocks:orc_torch 1"))
	return false
end

minetest.register_node("lottblocks:orc_torch", {
	description = "Orc Torch",
	drawtype = "mesh",
	mesh = "default_torch_floor.obj",
	inventory_image = "lottblocks_orc_torch_on_floor.png",
	wield_image = "lottblocks_orc_torch_on_floor.png",
	tiles = {{
			name = "lottblocks_orc_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1},
	drop = "lottblocks:orc_torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
		wall_top = {-1/8, -3/16, -1/8, 1/8, 1/2, 1/8},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 or wdir == 1 then
			fakestack:set_name("lottblocks:orc_torch")
		else
			fakestack:set_name("lottblocks:orc_torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("lottblocks:orc_torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood_orc,
})

minetest.register_node("lottblocks:orc_torch_wall", {
	drawtype = "mesh",
	mesh = "default_torch_wall.obj",
	tiles = {{
		    name = "lottblocks_orc_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottblocks:orc_torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -5/16, 1/8, 1/8},
	},
	floodable = true,
	on_flood = on_flood_orc,
})

minetest.register_lbm({
	name = "lottblocks:orctorch",
	nodenames = {"lottblocks:orc_torch"},
	action = function(pos, node)
		if node.param2 == 0 or node.param2 == 1 then
			minetest.set_node(pos, {name = "lottblocks:orc_torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "lottblocks:orc_torch_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_craft({
	output = 'lottblocks:orc_torch 2',
	recipe = {
		{'bones:bone'},
		{'group:stick'},
	}
})

