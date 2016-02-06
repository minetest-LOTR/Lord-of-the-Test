function lottblocks.register_wooden_stuff(name, description, texture, wood_name)
	local wood_groups = minetest.registered_nodes[wood_name].groups
	local node_groups = {}
	for k,v in pairs(wood_groups) do
		if k ~= "wood" then
			node_groups[k] = v
		end
	end

	local groups_door = node_groups
	groups_door.door = 1

	if name ~= "wood" then
		doors:register_door("lottblocks:door_" .. name, {
        		description =  description .. " Door",
        		inventory_image = "lottblocks_door_" .. name .. ".png",
        		groups = groups_door,
			tiles_bottom = {"lottblocks_door_" .. name .."_b.png", "lottblocks_edge_" .. name ..".png"},
			tiles_top = {"lottblocks_door_" .. name .. "_a.png", "lottblocks_edge_" .. name ..".png"},
		})
		minetest.register_craft({
			output = "lottblocks:door_" .. name,
			recipe = {
				{wood_name, wood_name},
				{wood_name, wood_name},
				{wood_name, wood_name}
			}
		})
		node_groups.not_in_creative_inventory = 0
		doors.register_trapdoor("lottblocks:hatch_" .. name, {
			description = description .. " Trapdoor",
			wield_image = "lottblocks_hatch_" .. name ..".png",
			tile_open = "lottblocks_hatch_" .. name .. "_open.png",
			tile_closed = "lottblocks_hatch_" .. name .. ".png",
			tile_side = "door_trapdoor_side.png",
			groups = node_groups,
			sounds = default.node_sound_wood_defaults(),
			sound_open = "door_door_open",
			sound_close = "door_door_close"
		})
		minetest.register_craft({
			output = "lottblocks:hatch_" .. name,
			recipe = {
				{wood_name, wood_name},
				{wood_name, wood_name},
			}
		})
		minetest.register_node("lottblocks:fence_" .. name, {
			description = description .. " Fence",
			drawtype = "fencelike",
			tiles = {texture},
			inventory_image = "lottblocks_" .. name .. "_fence.png",
			wield_image = "lottblocks_" .. name .. "_fence.png",
			paramtype = "light",
			is_ground_content = false,
			selection_box = {
				type = "fixed",
				fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
			},
			groups = node_groups
		})
		minetest.register_craft({
			output = "lottblocks:fence_" .. name .." 6",
			recipe = {
				{wood_name, wood_name, wood_name,},
				{wood_name, wood_name, wood_name,},
			}
		})
	end
	minetest.register_node("lottblocks:" .. name .. "_table", {
		description = description .. "Table",
		tiles = {texture},
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
		groups = node_groups
	})
	minetest.register_node("lottblocks:" .. name .."_chair", {
		description = description .. "Chair",
		tiles = {texture},
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
		groups = node_groups
	})
	minetest.register_craft({
		output = "lottblocks:" .. name .. "_table",
		recipe = {
			{wood_name, wood_name, wood_name},
			{'group:stick', 'group:stick', 'group:stick'},
			{'group:stick', '', 'group:stick'},
		}
	})
	minetest.register_craft({
		output = "lottblocks:" .. name .. "_chair",
		recipe = {
			{'group:stick', ''},
			{wood_name, wood_name},
			{'group:stick', 'group:stick'},
		}
	})
end

lottblocks.register_wooden_stuff("wood", "Wooden", "default_wood.png", "default:wood")
lottblocks.register_wooden_stuff("junglewood", "Junglewood", "default_junglewood.png", "default:junglewood")
lottblocks.register_wooden_stuff("alder", "Alder", "lottplants_alderwood.png", "lottplants:alderwood")
lottblocks.register_wooden_stuff("birch", "Birch", "lottplants_birchwood.png", "lottplants:birchwood")
lottblocks.register_wooden_stuff("pine", "Pine", "lottplants_pinewood.png", "lottplants:pinewood")
lottblocks.register_wooden_stuff("lebethron", "Lebethron", "lottplants_lebethronwood.png", "lottplants:lebethronwood")
lottblocks.register_wooden_stuff("mallorn", "Mallorn", "lottplants_mallornwood.png", "lottplants:mallornwood")
