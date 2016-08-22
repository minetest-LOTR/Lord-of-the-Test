local node_box = {
			type = "connected",
			fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
			-- connect_bottom =
			connect_front = {{-3/16, -1/2, -1/2,  3/16, 3/8, -1/4}},
			connect_left = {{-1/2, -1/2, -3/16, -1/4, 3/8,  3/16}},
			connect_back = {{-3/16, -1/2,  1/4,  3/16, 3/8,  1/2}},
			connect_right = {{ 1/4, -1/2, -3/16,  1/2, 3/8,  3/16}},
		}

local register_wall = function(base_node)

	local name = base_node .. "_wall"
	local ndef = minetest.registered_nodes[base_node]
	local groups = ndef.groups
	groups["wall"] = 1
	-- inventory node, and pole-type wall start item
	minetest.register_node(name, {
		description = ndef.description .. " Wall",
		drawtype = "nodebox",
		node_box = node_box,
		connects_to = {base_node,"group:wall"},
		paramtype = "light",
		is_ground_content = false,
		tiles = ndef.tiles,
		walkable = true,
		groups = groups,
		sounds = ndef.sounds,
	})

	-- crafting recipe
	minetest.register_craft({
		output = name .. " 6",
		recipe = {
			{ '', '', '' },
			{ base_node, base_node, base_node},
			{ base_node, base_node, base_node},
		}
	})

end

register_wall("darkage:basalt_cobble")
register_wall("darkage:ors_cobble")
register_wall("darkage:slate_cobble")
register_wall("darkage:tuff_bricks")
register_wall("darkage:old_tuff_bricks")
register_wall("darkage:rhyolitic_tuff_bricks")
