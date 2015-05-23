local mapgen_params = minetest.get_mapgen_params()

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < (mapgen_params.water_level-1000) or minp.y > 5000 then
		return
	end

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	--print ("[lottmapgen_checking] chunk minp ("..x0.." "..y0.." "..z0..")")

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

	local c_air = minetest.get_content_id("air")
	local c_mossycobble = minetest.get_content_id("default:mossycobble")
	local c_tomb_1 = minetest.get_content_id("lottblocks:dwarf_bottom")
	local c_tomb_2 = minetest.get_content_id("lottblocks:dwarf_head")
	local c_gold = minetest.get_content_id("default:goldblock")

	local nixz = 1
	for z = z0, z1 do
		for x = x0, x1 do
			for y = y1, y0, -1 do -- working down each column for each node do
				local fimadep = math.floor(6 - y / 512) + math.random(0, 1)
				local vi = area:index(x, y, z)
				local nodid = data[vi]

				if y < (mapgen_params.water_level-500) and nodid == c_mossycobble then
					local vi = area:index(x, y+1, z)
					if data[vi] == c_air and data[area:index(x, y+1, z+1)] == c_air then
						if math.random(1,500) == 10 then
							data[vi] = c_tomb_1
							local vi = area:index(x, y+1, z+1)
							data[vi] = c_tomb_2
							local vi = area:index(x, y, z+1)
							data[vi] = c_mossycobble
							if math.random(1,75) == 7 then
								if math.random(1,2) == 1 then
									for a = -1, 2 do
										local vi = area:index(x+1, y, z+a)
										data[vi] = c_gold
										local vi = area:index(x-1, y, z+a)
										data[vi] = c_gold
									end
									local vi = area:index(x, y, z+2)
									data[vi] = c_gold
									local vi = area:index(x, y, z-1)
									data[vi] = c_gold
								else
									for a = 0, 1 do
										local vi = area:index(x+1, y, z+a)
										data[vi] = c_gold
										local vi = area:index(x-1, y, z+a)
										data[vi] = c_gold
									end
									local vi = area:index(x, y, z+2)
									data[vi] = c_gold
									local vi = area:index(x, y, z-1)
									data[vi] = c_gold
								end
							end
						end
					end
				end
			end
		nixz = nixz + 1
		end
	end
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
end)

-- Buildings
minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:snowblock",
	sidelen = 16,
	fill_ratio = 0.004,
	schematic = minetest.get_modpath("lottmapgen").."/schems/abandoned_fort.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:snowblock",
	sidelen = 16,
	fill_ratio = 0.0045,
	schematic = minetest.get_modpath("lottmapgen").."/schems/abandoned_tower.mts",
	flags = "place_center_x, place_center_z",
})

