local water_level = minetest.get_mapgen_setting("water_level")

minetest.set_gen_notify("dungeon")

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < (water_level-1250)
	or minp.y > (water_level-250) then
		return
	end

	local c_air = minetest.get_content_id("air")
	local c_mossycobble = minetest.get_content_id("default:mossycobble")
	local c_tomb_1 = minetest.get_content_id("lottblocks:dwarf_tomb_bottom")
	local c_tomb_2 = minetest.get_content_id("lottblocks:dwarf_tomb_top")
	local c_gold = minetest.get_content_id("default:goldblock")


	local notify = minetest.get_mapgen_object("gennotify")
	if notify ~= nil then
		if notify.dungeon ~= nil then
			local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
			local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
			local data = vm:get_data()
			local c = 0
			for k,v in pairs(notify.dungeon) do
				local center = {x=v.x,y=v.y,z=v.z}

				local ycheck = {x=center.x,y=center.y,z=center.z}
				local i = area:indexp(ycheck)
				c = 0
				while data[i] == d_air and c < 25 do
					ycheck.y = ycheck.y + 1
					i = area:indexp(ycheck)
					c = c + 1
				end
				ycheck.y = ycheck.y - 1
				local height = ( ycheck.y - center.y )

				local xcheck = {x=center.x,y=center.y,z=center.z}
				local i = area:indexp(xcheck)
				c = 0
				while data[i] == d_air and c < 25 do
					xcheck.x = xcheck.x + 1
					i = area:indexp(xcheck)
					c = c + 1
				end
				xcheck.x = xcheck.x - 1

				local zcheck = {x=center.x,y=center.y,z=center.z}
				local i = area:indexp(zcheck)
				c = 0
				while data[i] == d_air and c < 25 do
					zcheck.z = zcheck.z + 1
					i = area:indexp(zcheck)
					c = c + 1
				end
				zcheck.z = zcheck.z - 1

				local xsize = ( xcheck.x - center.x )
				local zsize = ( zcheck.z - center.z )

				if math.random(50) == 1 then
					local vi = area:indexp({x=zcheck.x,y=(zcheck.y),z=(zcheck.z+1)})
					data[vi] = c_tomb_1
					vi = area:indexp({x=zcheck.x,y=(zcheck.y),z=(zcheck.z+2)})
					data[vi] = c_tomb_2
					vi = area:indexp({x=zcheck.x,y=(zcheck.y-1),z=(zcheck.z+1)})
					data[vi] = c_gold
					vi = area:indexp({x=zcheck.x,y=(zcheck.y-1),z=(zcheck.z+2)})
					data[vi] = c_gold
				end
			end

			vm:set_data(data)
			vm:calc_lighting()
			vm:write_to_map(data)
		end
	end
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
