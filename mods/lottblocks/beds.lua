
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
		groups = {snappy=1,choppy=2,flammable=3},
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
		groups = {snappy=1,choppy=2,flammable=3},
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
		groups = {snappy=1,choppy=2,flammable=3},
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

