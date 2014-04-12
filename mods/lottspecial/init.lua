dofile(minetest.get_modpath("lottspecial").."/tools.lua")
minetest.register_node("lottspecial:cake", {
	description = "LOTT Anniversary Cake",
	groups={crumbly=3},
	tiles = {
		"lottspecial_cake.png",
		"lottspecial_cake.png",
		"lottspecial_cake_side.png",
		"lottspecial_cake_side.png",
		"lottspecial_cake_side.png",
		"lottspecial_cake_side.png"
	},
	walkable = false,
	sunlight_propagates = true,
	drawtype="nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.296880,0.250000,-0.250000,0.312502},
			{-0.309375,-0.500000,-0.250000,0.309375,-0.250000,0.250000},
			{-0.250000,-0.250000,-0.250000,0.250000,-0.200000,0.250000},
		}
	}
})

 

minetest.register_craftitem("lottspecial:cake_slice", {
	description = "LOTT Cake Slice",
	inventory_image = "lottspecial_cake_slice.png",
	on_use = minetest.item_eat(20),
})

minetest.register_tool("lottspecial:cake_knife", {
	description = "Cake Knife",
	inventory_image = "lottspecial_cake_knife.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		local inv = user:get_inventory()
		if not inv:room_for_item("main", ItemStack("lottspecial:cake_slice")) then
			return
		end
		local pos = pointed_thing.under
		if minetest.is_protected(pos, user:get_player_name()) then
			minetest.record_protection_violation(pos, user:get_player_name())
			return
		end
          local node = minetest.get_node(pos)
		local node_name = node.name
		if node_name ~= "lottspecial:cake" then
			return
		end
		node.name = "air"
		node.name = "air"
		inv:add_item("main", ItemStack("lottspecial:cake_slice 4"))
		minetest.swap_node(pos, node)
		local item_wear = tonumber(itemstack:get_wear())
		item_wear = item_wear + 819
		if item_wear > 65535 then
			itemstack:clear()
			return itemstack
		end
		itemstack:set_wear(item_wear)
		return itemstack
	end,
})

minetest.register_node("lottspecial:chest", {
	description = "LOTT Anniversary Chest",
	groups={crumbly=3},
     tiles = {"lottspecial_chest.png",},
     drop = {
		max_items = 8,
		items = {
			{ items = {'lottspecial:cake'} },
			{ items = {'lottspecial:cake_knife'} },
			{ items = {'lottspecial:birthday_paxel'} },
			{ items = {'lottspecial:helmet_birthday'} },
               { items = {'lottspecial:chestplate_birthday'} },
               { items = {'lottspecial:leggings_birthday'} },
               { items = {'lottspecial:boots_birthday'} },
               { items = {'lottspecial:shield_birthday'} },
		}
	},
	walkable = false,
	sunlight_propagates = true,
	drawtype="nodebox",
	paramtype = "light",
})