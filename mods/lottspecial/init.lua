dofile(minetest.get_modpath("lottspecial").."/anniversary.lua")

minetest.register_node("egg:egg",{
	drawtype="nodebox",
	tiles = {"egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=2,dig_immediate=2},
	on_use = minetest.item_eat(4),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125,-0.5,-0.0625,0.125,-0.375,0.1875}, 
			{-0.1875,-0.375,-0.125,0.1875,-0.25,0.25}, --NodeBox2
			{-0.25,-0.25,-0.25,0.25,-0.125,0.375}, --NodeBox3
			{-0.1875,-0.125,-0.1875,0.1875,0,0.3125}, --NodeBox4
			{-0.125,0,-0.125,0.125,0.125,0.25}, --NodeBox5
			{-0.0625,0.125,-0.0625,0.0625,0.25,0.1875}, --NodeBox6
		}
	}
})
minetest.register_node("egg:egg1",{
	drawtype="nodebox",
	tiles = {"egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=2,dig_immediate=2},
	on_use = minetest.item_eat(8),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125,-0.5,-0.0625,0.125,-0.375,0.1875}, --NodeBox1
			{-0.1875,-0.375,-0.125,0.1875,-0.25,0.25}, --NodeBox2
			{-0.25,-0.25,-0.25,0.25,-0.125,0.375}, --NodeBox3
			{-0.1875,-0.125,-0.1875,0.1875,0,0.3125}, --NodeBox4
			{-0.125,0,-0.125,0.125,0.125,0.25}, --NodeBox5
			{-0.0625,0.125,-0.0625,0.0625,0.25,0.1875}, --NodeBox6
		}
	}
})
minetest.register_node("egg:egg2",{
	drawtype="nodebox",
	tiles = {"egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=2,dig_immediate=2},
	on_use = minetest.item_eat(12),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125,-0.5,-0.0625,0.125,-0.375,0.1875}, --NodeBox1
			{-0.1875,-0.375,-0.125,0.1875,-0.25,0.25}, --NodeBox2
			{-0.25,-0.25,-0.25,0.25,-0.125,0.375}, --NodeBox3
			{-0.1875,-0.125,-0.1875,0.1875,0,0.3125}, --NodeBox4
			{-0.125,0,-0.125,0.125,0.125,0.25}, --NodeBox5
			{-0.0625,0.125,-0.0625,0.0625,0.25,0.1875}, --NodeBox6
		}
	}
})
minetest.register_node("egg:egg3",{
	drawtype="nodebox",
	tiles = {"egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=2,dig_immediate=2},
	on_use = minetest.item_eat(16),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125,-0.5,-0.0625,0.125,-0.375,0.1875}, --NodeBox1
			{-0.1875,-0.375,-0.125,0.1875,-0.25,0.25}, --NodeBox2
			{-0.25,-0.25,-0.25,0.25,-0.125,0.375}, --NodeBox3
			{-0.1875,-0.125,-0.1875,0.1875,0,0.3125}, --NodeBox4
			{-0.125,0,-0.125,0.125,0.125,0.25}, --NodeBox5
			{-0.0625,0.125,-0.0625,0.0625,0.25,0.1875}, --NodeBox6
		}
	}
})
minetest.register_node("egg:egg4",{
	drawtype="nodebox",
	tiles = {"egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=2,dig_immediate=2},
	on_use = minetest.item_eat(20),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125,-0.5,-0.0625,0.125,-0.375,0.1875}, --NodeBox1
			{-0.1875,-0.375,-0.125,0.1875,-0.25,0.25}, --NodeBox2
			{-0.25,-0.25,-0.25,0.25,-0.125,0.375}, --NodeBox3
			{-0.1875,-0.125,-0.1875,0.1875,0,0.3125}, --NodeBox4
			{-0.125,0,-0.125,0.125,0.125,0.25}, --NodeBox5
			{-0.0625,0.125,-0.0625,0.0625,0.25,0.1875}, --NodeBox6
		}
	}
})

minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= 2 and minp.y <= 0 then
		-- Generate flowers
		local perlin1 = minetest.get_perlin(436, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0,divs-1 do
		for divz=0,divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine flowers amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 3)
			-- Find random positions for flowers based on this random
			local pr = PseudoRandom(seed+456)
			for i=0,grass_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=30,0,-1 do
					if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end
				
				if ground_y then
					local p = {x=x,y=ground_y+1,z=z}
					local nn = minetest.get_node(p).name
					-- Check if the node can be replaced
					if minetest.registered_nodes[nn] and
						minetest.registered_nodes[nn].buildable_to then
						nn = minetest.get_node({x=x,y=ground_y,z=z}).name
						if nn == "default:dirt_with_grass" then
							local egg_choice = pr:next(1, 5)
							local egg
							if egg_choice == 1 then
								egg = "egg:egg"
							elseif egg_choice == 2 then
								egg = "egg:egg1"
							elseif egg_choice == 3 then
								egg = "egg:egg2"
							elseif egg_choice == 4 then
								egg = "egg:egg3"
							elseif egg_choice == 5 then
								egg = "egg:egg4"
							end
							minetest.set_node(p, {name=egg})
						end
					end
				end
				
			end
		end
		end
	end
end)
