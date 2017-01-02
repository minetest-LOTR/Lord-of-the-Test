-- ITEMS and TOOLS

minetest.register_craft({
	output = "lottfarming:bowl",
	recipe = {
		{"default:wood", "", "default:wood"},
		{"", "default:wood", ""},
		{"", "", ""},
	}
})

minetest.register_craftitem("lottfarming:bowl", {
	description = "Bowl",
	inventory_image = "lottfarming_bowl.png",
})

minetest.register_node("lottfarming:decay_tree", {
	description = "Decaying Wood",
	tiles = {'default_tree_top.png^lottfarming_decay_tree.png', 'default_tree.png', 	'default_tree.png'},
     is_ground_content = true,
	groups = {crumbly=3, fungi=3},
	sounds = default.node_sound_dirt_defaults(),
	drop = "default:dirt",
})

local function decaying_wood(pos, inv, p)
	if pos == nil then
		return false
	end
	local node = minetest.get_node(pos)
	local name = node.name
	local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if name == "default:tree" or name == "default:jungletree" then
		if above.name == "air" then
			node.name = "lottfarming:decay_tree"
			minetest.set_node(pos, node)
			return true
		end
	end
	return false
end

minetest.register_tool("lottfarming:bacteria_fertiliser", {
	description = "Bacteria Fertiliser",
	inventory_image = "lottfarming_bacteria_fertiliser.png",
	on_use = function(itemstack, user, pointed_thing)
		if decaying_wood(pointed_thing.under, user:get_inventory(), 10) then
			itemstack:add_wear(65535/80)
			return itemstack
		end
	end
})

minetest.register_craft({
	output = "lottfarming:bacteria_fertiliser",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "bones:bones", "default:glass"},
		{"default:glass", "default:glass", "default:glass"},
	}
})

minetest.register_craft({
	output = 'lottfarming:pipe',
	recipe = {
		{'', '', 'group:stick'},
		{'group:wood', 'group:stick', ''},
		{'group:stick', '', ''},
	}
})

-- SOUPS and SALADS

minetest.register_craft({
	output = 'lottfarming:mushroom_soup',
	recipe = {
		{'group:mushroom', 'group:mushroom', 'group:mushroom'},
		{'', 'lottfarming:bowl', ''},
	}
})

minetest.register_craft({
	output = 'lottfarming:salad',
	recipe = {
		{'group:salad', 'group:salad', 'group:salad'},
		{'', 'lottfarming:bowl', ''},
	}
})

-- SEEDS

minetest.register_craft({
	output = 'lottfarming:athelas_seed 2',
	recipe = {
		{'lottfarming:athelas'},
	}
})

minetest.register_craft({
	output = 'lottfarming:barley_seed 2',
	recipe = {
		{'lottfarming:barley'},
	}
})

minetest.register_craft({
	output = 'lottfarming:berries_seed 2',
	recipe = {
		{'lottfarming:berries'},
	}
})

minetest.register_craft({
	output = 'lottfarming:cabbage_seed 2',
	recipe = {
		{'lottfarming:cabbage'},
	}
})

minetest.register_craft({
	output = 'lottfarming:corn_seed 2',
	recipe = {
		{'lottfarming:corn'},
	}
})

minetest.register_craft({
	output = 'lottfarming:tomatoes_seed 2',
	recipe = {
		{'lottfarming:tomatoes'},
	}
})

minetest.register_craft({
	output = 'lottfarming:melon_seed 2',
	recipe = {
		{'lottfarming:melon'},
	}
})

minetest.register_craft({
	output = 'lottfarming:potato_seed 2',
	recipe = {
		{'lottfarming:potato'},
	}
})

minetest.register_craft({
	output = 'lottfarming:pipeweed_seed 2',
	recipe = {
		{'lottfarming:pipeweed'},
	}
})
minetest.register_craft({
	output = 'lottfarming:turnips_seed 2',
	recipe = {
		{'lottfarming:turnips'},
	}
})

-- FOOD

minetest.register_craft({
	output = 'lottfarming:melon',
	recipe = {
		{'lottfarming:melon_slice', 'lottfarming:melon_slice', 'lottfarming:melon_slice'},
		{'lottfarming:melon_slice', 'lottfarming:melon_slice', 'lottfarming:melon_slice'},
		{'lottfarming:melon_slice', 'lottfarming:melon_slice', 'lottfarming:melon_slice'},
	}
})
