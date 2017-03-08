-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.

stairs = {}

-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":stairs:stair_" .. subname.."upside_down", {
		replace_name = "stairs:stair_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'stairs:stair_' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = 'stairs:stair_' .. subname .. ' 4',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.get_node(p0)
			local n1 = minetest.get_node(p1)
			local param2 = 0

			local n0_is_upside_down = (n0.name == "stairs:slab_" .. subname and
					n0.param2 >= 20)

			if n0.name == "stairs:slab_" .. subname and not n0_is_upside_down and p0.y+1 == p1.y then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "stairs:slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				fakestack:set_count(itemstack:get_count())

				pointed_thing.above = slabpos
				local success
				fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if success then
					itemstack:set_count(fakestack:get_count())
				-- Else put old node back
				else
					minetest.set_node(slabpos, slabnode)
				end
				return itemstack
			end

			-- Upside down slabs
			if p0.y-1 == p1.y then
				-- Turn into full block if pointing at a existing slab
				if n0_is_upside_down  then
					-- Remove the slab at the position of the slab
					minetest.remove_node(p0)
					-- Make a fake stack of a single item and try to place it
					local fakestack = ItemStack(recipeitem)
					fakestack:set_count(itemstack:get_count())

					pointed_thing.above = p0
					local success
					fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
					-- If the item was taken from the fake stack, decrement original
					if success then
						itemstack:set_count(fakestack:get_count())
					-- Else put old node back
					else
						minetest.set_node(p0, n0)
					end
					return itemstack
				end

				-- Place upside down slab
				param2 = 20
			end

			-- If pointing at the side of a upside down slab
			if n0_is_upside_down and p0.y+1 ~= p1.y then
				param2 = 20
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node(":stairs:slab_" .. subname.."upside_down", {
		replace_name = "stairs:slab_"..subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'stairs:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Replace old "upside_down" nodes with new param2 versions
minetest.register_abm({
	nodenames = {"group:slabs_replace"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		node.name = minetest.registered_nodes[node.name].replace_name
		node.param2 = node.param2 + 20
		if node.param2 == 21 then
			node.param2 = 23
		elseif node.param2 == 23 then
			node.param2 = 21
		end
		minetest.set_node(pos, node)
	end,
})

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, sounds)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds)
end

stairs.register_stair_and_slab("wood", "default:wood",
		{choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_wood.png"},
		"Wooden Stair",
		"Wooden Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("tree", "default:tree",
		{choppy=2,oddly_breakable_by_hand=1,flammable=2},
		{"default_tree_top.png", "default_tree_top.png", "default_tree.png",
		"default_tree.png", "default_tree.png", "default_tree_stair.png"},
		"Tree Stair",
		"Tree Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("stone", "default:stone",
		{cracky=3},
		{"default_stone.png"},
		"Stone Stair",
		"Stone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("cobble", "default:cobble",
		{cracky=3},
		{"default_cobble.png"},
		"Cobble Stair",
		"Cobble Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("brick", "default:brick",
		{cracky=3},
		{"default_brick.png"},
		"Brick Stair",
		"Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("sandstone", "default:sandstone",
		{crumbly=2,cracky=2},
		{"default_sandstone.png"},
		"Sandstone Stair",
		"Sandstone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_sandstone", "default:desert_sandstone",
		{crumbly=2,cracky=2},
		{"default_desert_sandstone.png"},
		"Desert Sandstone Stair",
		"Desert Sandstone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("silver_sandstone", "default:silver_sandstone",
		{crumbly=2,cracky=2},
		{"default_silver_sandstone.png"},
		"Silver Sandstone Stair",
		"Silver Sandstone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("junglewood", "default:junglewood",
		{choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_junglewood.png"},
		"Junglewood Stair",
		"Junglewood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("jungletree", "default:jungletree",
		{choppy=2,oddly_breakable_by_hand=1,flammable=2},
		{"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png",
		"default_jungletree.png", "default_jungletree.png", "default_jungletree_stair.png"},
		"Jungle Tree Stair",
		"Jungle Tree Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("stonebrick", "default:stonebrick",
		{cracky=3},
		{"default_stone_brick.png"},
		"Stone Brick Stair",
		"Stone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_stonebrick", "default:desert_stonebrick",
		{cracky=3},
		{"default_desert_stone_brick.png"},
		"Desert Stone Brick Stair",
		"Desert Stone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("sandstone_brick", "default:sandstonebrick",
		{cracky=3},
		{"default_sandstone_brick.png"},
		"Sandstone Brick Stair",
		"Sandstone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_sandstone_brick", "default:desert_sandstonebrick",
		{cracky=3},
		{"default_desert_sandstone_brick.png"},
		"Desert Sandstone Brick Stair",
		"Desert Sandstone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("silver_sandstone_brick", "default:silver_sandstonebrick",
		{cracky=3},
		{"default_silver_sandstone_brick.png"},
		"Silver Sandstone Brick Stair",
		"Silver Sandstone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("stone_block", "default:stone_block",
		{cracky=3},
		{"default_stone_block.png"},
		"Stone Block Stair",
		"Stone Block Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_stone_block", "default:desert_stone_block",
		{cracky=3},
		{"default_desert_stone_block.png"},
		"Desert Stone Block Stair",
		"Desert Stone Block Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("sandstone_block", "default:sandstone_block",
		{cracky=3},
		{"default_sandstone_block.png"},
		"Sandstone Block Stair",
		"Sandstone Block Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_sandstone_block", "default:desert_sandstone_block",
		{cracky=3},
		{"default_desert_sandstone_block.png"},
		"Desert Sandstone Block Stair",
		"Desert Sandstone Block Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("silver_sandstone_block", "default:silver_sandstone_block",
		{cracky=3},
		{"default_silver_sandstone_block.png"},
		"Silver Sandstone Block Stair",
		"Silver Sandstone Block Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_stone", "default:desert_stone",
		{cracky=3},
		{"default_desert_stone.png"},
		"Desert Stone Stair",
		"Desert Stone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desert_cobble", "default:desert_cobble",
		{cracky=3},
		{"default_desert_cobble.png"},
		"Desert Cobble Stair",
		"Desert Cobble Slab",
		default.node_sound_stone_defaults())
