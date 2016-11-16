--Makes a stratus of rocks
--name of the rock to generate
--c_wherein id of node to replace, for example minetest.get_content_id("default:stone")
--minp, maxp the corners of the map to be generated
--seed random seed
--stratus_chance inverse probability in a given radius 1:2, 1:3 etc
--radius horizontal radius of the stratus
--radius_y vertical radius of the stratus
--deep how deep can be from the ground
local function generate_stratus(data, area, name, c_wherein, ca_ceilin, minp, maxp, seed, stratus_chance, radius, radius_y, deep, y_min, y_max)
	if maxp.y < y_min
	   or minp.y > y_max then
		return
	end

	local c_node = minetest.get_content_id(name)

	-- it will be only generate a stratus for every 100 m of area
	local stratus_per_volume=1
	local area_size = 45
	local y_min = math.max(minp.y, y_min)
	local y_max = math.min(maxp.y, y_max)
	local volume = ((maxp.x-minp.x+1)/area_size)*((y_max-y_min+1)/area_size)*((maxp.z-minp.z+1)/area_size)
	local pr = PseudoRandom(seed)
	local blocks = math.floor(stratus_per_volume*volume)
	if blocks == 0 then
		blocks = 1
	end
	for i = 1,blocks do
		if pr:next(1,stratus_chance) == 1 then
			-- TODO deep
			local y0=y_max-radius_y+1
			if y0 < y_min then
				y0=y_min
			else
				y0=pr:next(y_min, y0)
			end
			local x0 = maxp.x-radius+1
			if x0 < minp.x then
				x0 = minp.x
			else
				x0 = pr:next(minp.x, x0)
			end
			local z0 = maxp.z-radius+1
			if z0 < minp.z then
				x0 = minp.z
			else
				z0 = pr:next(minp.z, z0)
			end
			local n = data[area:index(x0, y0, z0)]
			local i = 0
			--print("	upper node "..n)
			local x
			for _,v in ipairs(ca_ceilin) do
				if n == v then
					x = true
					break
				end
			end
			if x then
				-- search for the node to replace
				--print("	Searching nodes to replace from "..dump(y0-1).." to "..dump(y_min))
				for y1 = y0-1,y_min,-1 do
					if data[area:index(x0, y1, z0)] == c_wherein then
						y0 = y1-deep
						if y0 < y_min then
							y0 = y_min
						end
						break
					end
				end
				local rx=pr:next(radius/2,radius)+1
				local rz=pr:next(radius/2,radius)+1
				local ry=pr:next(radius_y/2,radius_y)+1
				--print("	area of generation ("..dump(rx)..","..dump(rz)..","..dump(ry)..")")
				for x1=0,rx do
					rz = rz + 3 - pr:next(1,6)
					if rz < 1 then
						rz = 1
					end
					for z1=pr:next(1,3),rz do
						local ry0 = ry + pr:next(1,3)
						for y1 = pr:next(1,3),ry0 do
							local p2 = area:index(x0+x1, y0+y1, z0+z1)
							if data[p2] == c_wherein then
								data[p2] = c_node
								i = i +1
							end
						end
					end
				end
			end
		end
	end
	--print("generate_ore done")
end

local function generate_claylike(data, varea, name, minp, maxp, seed, chance, minh, maxh, dirt)
	if maxp.y >= maxh+1 and minp.y <= minh-1 then
		local c_ore = minetest.get_content_id(name)
		local c_sand = minetest.get_content_id("default:sand")
		local c_dirt = minetest.get_content_id("default:dirt")
		local c_lawn = minetest.get_content_id("default:dirt_with_grass")
		local c_water = minetest.get_content_id("default:water_source")
		local c_air = minetest.get_content_id("air")

		local pr = PseudoRandom(seed)
		local divlen = 4
		local divs = (maxp.x-minp.x)/divlen+1;
		for yy=minh,maxh do
			local x = pr:next(1,chance)
			if x == 1 then
				for divx=0+1,divs-1-1 do
					for divz=0+1,divs-1-1 do
						local cx = minp.x + math.floor((divx+0.5)*divlen)
						local cz = minp.z + math.floor((divz+0.5)*divlen)
						local up = data[varea:index(cx,yy,cz)]
						local down = data[varea:index(cx,yy-1,cz)]
						if ( up == c_water or up == c_air ) and ( down == c_sand or (dirt == 1 and (down == c_dirt or down == c_lawn ))) then
							local is_shallow = true
							local num_water_around = 0
							if data[varea:index(cx-divlen*2,yy,cz)] == c_water then
								num_water_around = num_water_around + 1
							end
							if data[varea:index(cx+divlen*2,yy,cz)] == c_water then
								num_water_around = num_water_around + 1
							end
							if data[varea:index(cx,yy,cz-divlen*2)] == c_water then
								num_water_around = num_water_around + 1
							end
							if data[varea:index(cx,yy,cz+divlen*2)] == c_water then
								num_water_around = num_water_around + 1
							end
							if num_water_around >= 3 then
								is_shallow = false
							end
							if is_shallow then
								for x1=-divlen,divlen do
									for z1=-divlen,divlen do
										local p={x=cx+x1,y=yy-1,z=cz+z1}
										down = data[varea:indexp(p)]
										if down == c_sand or (dirt == 1 and (down == c_dirt or down == c_lawn)) then
											data[varea:indexp(p)] = c_ore
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local seed = minetest.get_mapgen_setting("seed")


-- Generate desert stone with iron in derset.
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "darkage:desert_stone_with_iron",
	wherein        = "default:desert_stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -1,
	y_max          = 200,
})

-- Generate chalk inside mountains
minetest.register_ore({
	ore_type        	= "sheet",
	ore             	= "darkage:chalk",
	wherein         	= {"default:stone"},
	column_height_max = 30,
	column_height_min = 20,
	y_min            = -20,
	y_max            = 100,
	noise_threshold = 0.45,
	noise_params     = {
		offset = 0.35,
		scale = 0.2,
		spread = {x = 30, y = 30, z = 30},
		octaves = 1,
		persistence = 0.6
	},
})

minetest.register_ore({
	ore_type        	= "sheet",
	ore             	= "darkage:tuff",
	wherein         	= {"default:stone", "default:dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 20,
	column_height_min = 15,
	y_min            = -400,
	y_max            = -20,
	noise_threshold = 0.5,
	noise_params     = {
		offset = 0.35,
		scale = 0.19,
		seed = seed+12,
		spread = {x = 45, y = 45, z = 45},
		octaves = 1,
		persistence = 0.6
	},
})

minetest.register_ore({
	ore_type        	= "sheet",
	ore             	= "darkage:rhyolitic_tuff",
	wherein         	= {"default:stone", "default:dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 20,
	column_height_min = 15,
	y_min            = -2000,
	y_max            = -20,
	noise_threshold = 0.53,
	noise_params     = {
		offset = 0.35,
		scale = 0.2,
		seed = seed+13,
		spread = {x = 100, y = 100, z = 100},
		octaves = 1,
		persistence = 0.6
	},
})

-- Generate strati
local function generate_strati(minp, maxp, seed)

	local t1 = os.clock()

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	local data = vm:get_data()

	local c_air = minetest.get_content_id("air")
	local c_stone = minetest.get_content_id("default:stone")
	local c_water = minetest.get_content_id("default:water_source")


	generate_claylike(data, area, "darkage:mud", minp, maxp, seed+1, 4, 0, 2, 0)
	generate_claylike(data, area, "darkage:silt", minp, maxp, seed+2, 4, -1, 1, 1)

	-- TODO: Maybe realize the following stuff with register ore. somehow.
	generate_stratus(data, area, "darkage:ors",
					c_stone,
					{c_stone, c_air, c_water},
					minp, maxp, seed+4, 4, 25, 7, 50, -200,  500)

	generate_stratus(data, area, "darkage:shale",
					c_stone,
					{c_stone, c_air},
					minp, maxp, seed+5, 4, 23, 7, 50, -50,  20)

	generate_stratus(data, area, "darkage:slate",
					c_stone,
					{c_stone, c_air},
					minp, maxp, seed+6, 6, 23, 5, 50, -500, 0)

	generate_stratus(data, area, "darkage:schist",
					c_stone,
					{c_stone, c_air},
					minp, maxp, seed+7, 6, 19, 6, 50, -31000, -10)

	generate_stratus(data, area, "darkage:basalt",
					c_stone,
					{c_stone, c_air},
					minp, maxp, seed+8, 5, 20, 5, 20, -31000, -50)

	generate_stratus(data, area, "darkage:gneiss",
					c_stone,
					{c_stone, c_air},
					minp, maxp, seed+11, 4, 15, 5, 50, -31000, -250)

	vm:set_data(data)
	vm:write_to_map()
end

minetest.register_on_generated(generate_strati)
