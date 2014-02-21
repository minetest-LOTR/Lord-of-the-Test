minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= 2 and minp.y <= 0 then
		-- Generate lottplants
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
			-- Determine lottplants amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 9)
			-- Find random positions for lottplants based on this random
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
							local flower_choice = pr:next(1, 19)
							local flower
							if flower_choice == 1 then
								flower = "lottplants:asphodel"
							elseif flower_choice == 2 then
								flower = "lottplants:elanor"
							elseif flower_choice == 3 then
								flower = "lottplants:mallos"
							elseif flower_choice == 4 then
								flower = "lottplants:anemones"
							elseif flower_choice == 5 then
								flower = "lottplants:athelas"
							elseif flower_choice == 6 then
								flower = "lottplants:seregon"
							elseif flower_choice == 7 then
								flower = "lottplants:eglantive"
							elseif flower_choice == 8 then
								flower = "lottplants:iris"
							elseif flower_choice == 9 then
								flower = "lottplants:pipeweed_wild"
							elseif flower_choice == 10 then
								flower = "lottplants:potato_wild"
							elseif flower_choice == 11 then
								flower = "lottplants:corn_wild"
							elseif flower_choice == 12 then
								flower = "lottplants:mushroom_wild"
							elseif flower_choice == 13 then
								flower = "lottplants:lissuin"
							elseif flower_choice == 14 then
								flower = "lottplants:nipherdil"
							elseif flower_choice == 15 then
								flower = "lottplants:berries_wild"
							elseif flower_choice == 16 then
								flower = "lottplants:turnips_wild"
							elseif flower_choice == 17 then
								flower = "lottplants:tomatoes_wild"
							elseif flower_choice == 18 then
								flower = "lottplants:cabbage_wild"
							elseif flower_choice == 19 then
								flower = "lottplants:pilinehtar"
							end
							minetest.set_node(p, {name=flower})
						end
					end
				end
				
			end
		end
		end
	end
end)

minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= 2 and minp.y <= 0 then
		-- Generate lottplants
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
			-- Determine lottplants amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 9)
			-- Find random positions for lottplants based on this random
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
						if nn == "default:desert_sand" then
							local flower_choice = pr:next(1, 2)
							local flower
							if flower_choice == 1 then
								flower = "lottplants:brambles_of_mordor"
							elseif flower_choice == 2 then
								flower = "default:dry_shrub"
							end
							minetest.set_node(p, {name=flower})
						end
					end
				end
				
			end
		end
		end
	end
end)


