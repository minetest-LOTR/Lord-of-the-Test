-- This code was derived by sofar from the 'torches' mod by
-- BlockMen (LGPLv2.1+), modified by Amaz
-- The models from Minetest Game were not used, they made from scratch
-- https://forum.minetest.net/viewtopic.php?f=11&t=6099
-- https://github.com/minetest/minetest_game/blob/master/mods/default/torch.lua

local function on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("default:torch 1"))
	return false
end

minetest.register_node("default:torch", {
	description = "Torch",
	drawtype = "mesh",
	mesh = "default_torch_floor.obj",
	inventory_image = "default_torch_on_floor.png",
	wield_image = "default_torch_on_floor.png",
	tiles = {{
			name = "default_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1},
	drop = "default:torch",
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
			fakestack:set_name("default:torch")
		else
			fakestack:set_name("default:torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("default:torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood,
})

minetest.register_node("default:torch_wall", {
	drawtype = "mesh",
	mesh = "default_torch_wall.obj",
	tiles = {{
		    name = "default_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "default:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -5/16, 1/8, 1/8},
	},
	floodable = true,
	on_flood = on_flood,
})

minetest.register_lbm({
	name = "default:3dtorch",
	nodenames = {"default:torch", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 or node.param2 == 1 then
			minetest.set_node(pos, {name = "default:torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "default:torch_wall",
				param2 = node.param2})
		end
	end
})

