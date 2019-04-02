minetest.register_abm({
	label = "Dirt to Grass",
	nodenames = {"lottitems:dirt"},
	neighbors = {"air"},
	interval = 8,
	chance = 20,
	catch_up = true,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local tod = minetest.get_timeofday()
		if tod < 0.225 or tod > 0.775 then
			return
		end
		local node_above = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
		if node_above.name == "air" then
			local node_near = minetest.find_node_near(pos, 1, "group:dirt_with_grass")
			if node_near then
				local p2 = minetest.get_node(node_near).param2
				local _, biome = lottmapgen.get_biome_at_pos(pos)
				biome = biome:lower()
				-- Bit of a mess...
				if biome == "angmar" then
					biome = "snowy"
				end
				minetest.set_node(pos, {
					name = "lottitems:" .. biome .. "_grass",
					param2 = p2,
				})
			end
		end
	end,
})

minetest.register_abm({
	label = "Grass to Dirt",
	nodenames = {"group:dirt_with_grass"},
	interval = 8,
	chance = 10,
	catch_up = true,
	action = function(pos)
		if minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}, 0.5) < 10 then
			minetest.set_node(pos, {name = "lottitems:dirt"})
		end
	end,
})
