-- Halloween Special Update!
--Majority of code gotten from PlizAdam's farming plus(https://forum.minetest.net/viewtopic.php?id=2787 )

--Jack 'O' Melon
minetest.register_node("lottspecial:jackomelon", {
	description = "Jack 'O' Melon",
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottspecial_face.png"},
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=2},
	sounds = default.node_sound_wood_defaults(),
     on_punch = function(pos, node)
		node.name = "lottspecial:jackomelon_lighted"
		minetest.set_node(pos, node)
	end
})

minetest.register_node("lottspecial:jackomelon_lighted", {
	description = "Jack 'O' Melon",
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottspecial_face_lighted.png"},
     light_source = LIGHT_MAX-2,
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=2},
	sounds = default.node_sound_wood_defaults(),
     drop = 'lottspecial:jackomelon',
     on_punch = function(pos, node)
		node.name = "lottspecial:jackomelon"
		minetest.set_node(pos, node)
	end
})
local box1 = {
	{-1, -8, -1, 1, 8, 1},
}

local box2 = {
	{-1, -8, -1, 1, 8, 1},
	{-12, -8, -1, 12, -7, 1},
	{-5, -2, -5, 5, 8, 5}
}

for j,list in ipairs(box1) do
	for i,int in ipairs(list) do
		list[i] = int/16
	end
	box1[j] = list
end

for j,list in ipairs(box2) do
	for i,int in ipairs(list) do
		list[i] = int/16
	end
	box2[j] = list
end

minetest.register_node("lottspecial:scarecrow", {
	description = "Jack 'O' Melon Scarecrow",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	tiles = {"lottspecial_scarecrow_top.png", "lottspecial_scarecrow_top.png", "lottspecial_scarecrow_side.png", "lottspecial_scarecrow_side.png", "lottspecial_scarecrow_side.png", "lottspecial_scarecrow_front.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box2
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-12/16, -1.5, -0.5, 12/16, 0.5, 0.5}
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	
	after_place_node = function(pos, placer)
		local node = minetest.get_node(pos)
		local param2 = node.param2
		pos.y = pos.y+1
		if minetest.get_node(pos).name ~= "air" then
			pos.y = pos.y-1
			minetest.remove_node(pos)
			minetest.after(0.1, function(placer)
				local inv = placer:get_inventory()
				local index = placer:get_wield_index()
				inv:set_stack("main", index, ItemStack("lottspecial:scarecrow"))
			end, placer)
			return
		end
		minetest.set_node(pos, node)
		pos.y = pos.y-1
		node.name = "lottspecial:scarecrow_bottom"
		minetest.set_node(pos, node)
	end,
	
	after_destruct = function(pos, oldnode)
		pos.y = pos.y-1
		if minetest.get_node(pos).name == "lottspecial:scarecrow_bottom" then
			minetest.remove_node(pos)
		end
	end,
     on_punch = function(pos, node)
		node.name = "lottspecial:scarecrow_light"
		minetest.set_node(pos, node)
          pos.y = pos.y-1
		node.name = "lottspecial:scarecrow_bottom"
		minetest.set_node(pos, node)
     end
})

minetest.register_node("lottspecial:scarecrow_bottom", {
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box1
	},
	groups = {not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0}
		}
	}
})

minetest.register_craft({
	output = "lottspecial:scarecrow",
	recipe = {
		{"", "lottspecial:jackomelon", "",},
		{"default:stick", "default:stick", "default:stick",},
		{"", "default:stick", "",}
	}
})

minetest.register_node("lottspecial:scarecrow_light", {
	description = "Lighted Jack 'O' Melon Scarecrow",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
     drop = 'lottspecial:scarecrow',
	light_source = LIGHT_MAX-2,
	tiles = {"lottspecial_scarecrow_top.png", "lottspecial_scarecrow_top.png", "lottspecial_scarecrow_side.png", "lottspecial_scarecrow_side.png", "lottspecial_scarecrow_side.png", "lottspecial_scarecrow_front_light.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box2
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-12/16, -1.5, -0.5, 12/16, 0.5, 0.5}
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	
	after_place_node = function(pos, placer)
		local node = minetest.get_node(pos)
		local param2 = node.param2
		pos.y = pos.y+1
		if minetest.get_node(pos).name ~= "air" then
			pos.y = pos.y-1
			minetest.remove_node(pos)
			minetest.after(0.1, function(placer)
				local inv = placer:get_inventory()
				local index = placer:get_wield_index()
				inv:set_stack("main", index, ItemStack("lottspecial:scarecrow_light"))
			end, placer)
			return
		end
		minetest.set_node(pos, node)
		pos.y = pos.y-1
		node.name = "lottspecial:scarecrow_bottom"
		minetest.set_node(pos, node)
	end,
	
	after_destruct = function(pos, oldnode)
		pos.y = pos.y-1
		if minetest.get_node(pos).name == "lottspecial:scarecrow_bottom" then
			minetest.remove_node(pos)
		end
	end,
     on_punch = function(pos, node)
		node.name = "lottspecial:scarecrow"
		minetest.set_node(pos, node)
          pos.y = pos.y-1
		node.name = "lottspecial:scarecrow_bottom"
		minetest.set_node(pos, node)
	end
})