minetest.register_node("lottblocks:snowycobble", {
	description = "Snowy Cobblestone",
	tiles = {"lottblocks_snowycobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})

minetest.register_node("lottblocks:orc_brick", {
	description = "Orc Brick",
	tiles = {"lottblocks_orc_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("orc_brick", "lottblocks:orc_brick",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"lottblocks_orc_brick.png"},
		"Orc Brick",
		"Orc Brick"
)

minetest.register_node("lottblocks:fence_alder", {
	description = "Alder Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_alderwood.png"},
	inventory_image = "lottblocks_alder_fence.png",
	wield_image = "lottblocks_alder_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
})

minetest.register_craft({
	output = 'lottblocks:fence_alder 6',
	recipe = {
		{'lottplants:alderwood', 'lottplants:alderwood', 'lottplants:alderwood'},
		{'lottplants:alderwood', 'lottplants:alderwood', 'lottplants:alderwood'},
	}
})


minetest.register_node("lottblocks:fence_birch", {
	description = "Birch Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_birchwood.png"},
	inventory_image = "lottblocks_birch_fence.png",
	wield_image = "lottblocks_birch_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
})

minetest.register_craft({
	output = 'lottblocks:fence_birch 6',
	recipe = {
		{'lottplants:birchwood', 'lottplants:birchwood', 'lottplants:birchwood'},
		{'lottplants:birchwood', 'lottplants:birchwood', 'lottplants:birchwood'},
	}
})

minetest.register_node("lottblocks:fence_mallorn", {
	description = "Mallorn Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_mallornwood.png"},
	inventory_image = "lottblocks_mallorn_fence.png",
	wield_image = "lottblocks_mallorn_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
})

minetest.register_craft({
	output = 'lottblocks:fence_mallorn 6',
	recipe = {
		{'lottplants:mallornwood', 'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'lottplants:mallornwood', 'lottplants:mallornwood', 'lottplants:mallornwood'},
	}
})

minetest.register_node("lottblocks:fence_lebethron", {
	description = "Lebethron Fence",
	drawtype = "fencelike",
	tiles = {"lottplants_lebethronwood.png"},
	inventory_image = "lottblocks_lebethron_fence.png",
	wield_image = "lottblocks_lebethron_fence.png",
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
})

minetest.register_craft({
	output = 'lottblocks:fence_lebethron 6',
	recipe = {
		{'lottplants:lebethronwood', 'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'lottplants:lebethronwood', 'lottplants:lebethronwood', 'lottplants:lebethronwood'},
	}
})

minetest.register_node("lottblocks:bedside_table",
	{description = 'Bedside Table',
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.1,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.1,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.1,0.4},
			{0.3,-0.5,0.3, 0.4,0.1,0.4},
			{-0.5,0.2,-0.5, 0.5,0.1,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.3,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.4,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.4,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.4,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 



minetest.register_node("lottblocks:wood_table",
	{description = 'Wooden Table',
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:wood_table',
	recipe = {
		{'group:stick', ''},
		{'default:wood', 'default:wood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:wood_chair",
	{ description = 'Wooden Chair',
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_node("lottblocks:alder_table",
	{description = 'Alder Table',
	tiles = {"lottplants_alderwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:alder_table',
	recipe = {
		{'lottplants:alderwood', 'lottplants:alderwood', 'lottplants:alderwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:alder_chair",
	{ description = 'Alder Chair',
	tiles = {"lottplants_alderwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:alder_table',
	recipe = {
		{'group:stick', ''},
		{'lottplants:alderwood', 'lottplants:alderwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:birch_table",
	{description = 'Birch Table',
	tiles = {"lottplants_birchwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:birch_table',
	recipe = {
		{'lottplants:birchwood', 'lottplants:birchwood', 'lottplants:birchwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:birch_chair",
	{ description = 'Birch Chair',
	tiles = {"lottplants_birchwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:birch_table',
	recipe = {
		{'group:stick', ''},
		{'lottplants:birchwood', 'lottplants:birchwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:lebethron_table",
	{description = 'Lebethron Table',
	tiles = {"lottplants_lebethronwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:lebethron_table',
	recipe = {
		{'lottplants:lebethronwood', 'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:lebethron_chair",
	{ description = 'Lebethron Chair',
	tiles = {"lottplants_lebethronwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:lebethron_chair',
	recipe = {
		{'group:stick', ''},
		{'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:mallorn_table",
	{description = 'Mallorn Table',
	tiles = {"lottplants_mallornwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:mallorn_table',
	recipe = {
		{'lottplants:mallornwood', 'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:mallorn_chair",
	{ description = 'Mallorn Chair',
	tiles = {"lottplants_mallornwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:mallorn_chair',
	recipe = {
		{'group:stick', ''},
		{'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'group:stick', 'group:stick'},
	}
})
local lottblocks_list = {
	{ "Red Bed", "red"},	
	{ "Blue Bed", "blue"},
	{ "Green Bed", "green"},
}

for i in ipairs(lottblocks_list) do
	local beddesc = lottblocks_list[i][1]
	local colour = lottblocks_list[i][2]

	minetest.register_node("lottblocks:bed_bottom_"..colour, {
		description = beddesc,
		drawtype = "nodebox",
		tiles = {"lottblocks_bed_top_bottom_"..colour..".png", "default_wood.png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, 0.0, -0.5, 0.5, 0.3125, 0.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.4, 0.0, -0.4},
						{0.4, 0.0, -0.4, 0.5, -0.5, -0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.3125, 1.5},
					}
		},

		after_place_node = function(pos, placer, itemstack)
			local node = minetest.env:get_node(pos)
			local p = {x=pos.x, y=pos.y, z=pos.z}
			local param2 = node.param2
			node.name = "lottblocks:bed_top_"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
				minetest.env:set_node(pos, node)
			else
				minetest.env:remove_node(p)
				return true
			end
		end,
			
		on_destruct = function(pos)
			local node = minetest.env:get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "lottblocks:bed_top_"..colour ) then
				if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.env:remove_node(pos)
				end	
			end
		end
	})
end

for i in ipairs(lottblocks_list) do
	local beddesc = lottblocks_list[i][1]
	local colour = lottblocks_list[i][2]

	minetest.register_node("lottblocks:bed_bottom_"..colour, {
		description = beddesc,
		drawtype = "nodebox",
		tiles = {"lottblocks_bed_top_bottom_"..colour..".png", "default_wood.png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png",  "lottblocks_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, 0.0, -0.5, 0.5, 0.3125, 0.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.4, 0.0, -0.4},
						{0.4, 0.0, -0.4, 0.5, -0.5, -0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.3125, 1.5},
					}
		},

		after_place_node = function(pos, placer, itemstack)
			local node = minetest.env:get_node(pos)
			local p = {x=pos.x, y=pos.y, z=pos.z}
			local param2 = node.param2
			node.name = "lottblocks:bed_top_"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
				minetest.env:set_node(pos, node)
			else
				minetest.env:remove_node(p)
				return true
			end
		end,
			
		on_destruct = function(pos)
			local node = minetest.env:get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "lottblocks:bed_top_"..colour ) then
				if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.env:remove_node(pos)
				end	
			end
		end,
	})
	
	minetest.register_node("lottblocks:bed_top_"..colour, {
		drawtype = "nodebox",
		tiles = {"lottblocks_bed_top_top_"..colour..".png", "default_wood.png",  "lottblocks_bed_side_top_r_"..colour..".png",  "lottblocks_bed_side_top_l_"..colour..".png",  "lottblocks_bed_top_front.png",  "lottblocks_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, 0.0, -0.5, 0.5, 0.3125, 0.5},
						{-0.4375, 0.3125, 0.1, 0.4375, 0.4375, 0.5},
						
						-- legs
						{-0.4, 0.0, 0.4, -0.5, -0.5, 0.5},
						{0.5, -0.5, 0.5, 0.4, 0.0, 0.4},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})
	minetest.register_alias("lottblocks:bed_"..colour, "lottblocks:bed_bottom_"..colour)
	
	minetest.register_craft({
		output = "lottblocks:bed_"..colour,
		recipe = {
			{"wool:white", "wool:"..colour, "wool:"..colour },
			{"default:stick", "", "default:stick", }
		}
	})
end

minetest.register_alias("lottblocks:bed_bottom", "lottblocks:bed_bottom_blue")
minetest.register_alias("lottblocks:bed_top", "lottblocks:bed_top_blue")
minetest.register_alias("lottblocks:bed", "lottblocks:bed_bottom_blue")

