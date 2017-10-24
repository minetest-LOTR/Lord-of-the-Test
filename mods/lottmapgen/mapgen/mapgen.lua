local np_temp = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}

local np_humid = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -5500,
	octaves = 3,
	persist = 0.5
}

local np_ter = {
	offset = 0,
	scale = 1,
	spread = {x=128, y=128, z=128},
	seed = 543213,
	octaves = 5,
	persist = 0.6
}

local np_terflat = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 543213,
	octaves = 1,
	persist = 0.5
}

local np_dec = {
	offset = 0,
	scale = 1,
	spread = {x = 92, y = 92, z = 92},
	seed = 345432,
	octaves = 2,
	persist = 0.5,
}

local np_cave = {
	offset = 0,
	scale = 1,
	spread = {x=40, y=18, z=40},
	octaves = 2,
	seed = -11842,
	persist = 0.7,
	flags = "eased",
	eased = true,
}

-- Stuff

local nobj_temp = nil
local nobj_humid = nil
local nobj_ter = nil
local nobj_terflat = nil
local nobj_dec = nil
local nobj_cave = nil
local nbuf_temp = {}
local nbuf_humid = {}
local nbuf_ter = {}
local nbuf_terflat = {}
local nbuf_dec = {}
local nbuf_cave = {}
local dbuf = {}
local p2dbuf = {}

--[[
dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")
dofile(minetest.get_modpath("lottmapgen").."/functions.lua")
dofile(minetest.get_modpath("lottmapgen").."/biomes.lua")
dofile(minetest.get_modpath("lottmapgen").."/schematics.lua")
dofile(minetest.get_modpath("lottmapgen").."/schems.lua")
]]--

local times = {}

-- On generated function
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < -31000 or minp.y > 5000 then
		return
	end

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data(dbuf)
	local p2data = vm:get_param2_data(p2dbuf)
	local ores = lottmapgen.ores

	local c_air = minetest.get_content_id("air")
	local c_tmp = minetest.get_content_id("lottmapgen:tmp") -- For caves.
	local c_sand = minetest.get_content_id("lottitems:sand")
	local c_stone = minetest.get_content_id("lottitems:stone")
	local c_water = minetest.get_content_id("lottitems:water_source")
	local c_morwat = minetest.get_content_id("lottitems:mordor_water_source")

	local c_morstone = minetest.get_content_id("lottitems:mordor_stone")
	local c_salt = minetest.get_content_id("lottores:mineral_salt")
	local c_pearl = minetest.get_content_id("lottores:mineral_pearl")

	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxz = {x=x0, y=z0}
	local minposxyz = {x=x0, y=y0, z=z0}
	local border_amp = 128

	nobj_temp = nobj_temp or minetest.get_perlin_map(np_temp, chulens)
	nobj_humid = nobj_humid or minetest.get_perlin_map(np_humid, chulens)
	nobj_ter = nobj_ter or minetest.get_perlin_map(np_ter, chulens)
	nobj_terflat = nobj_terflat or minetest.get_perlin_map(np_terflat, chulens)
	nobj_dec = nobj_dec or minetest.get_perlin_map(np_dec, chulens)
	nobj_cave = nobj_cave or minetest.get_perlin_map(np_cave, chulens)

	local nvals_x = nobj_temp:get2dMap_flat(minposxz, nbuf_temp)
	local nvals_z = nobj_humid:get2dMap_flat(minposxz, nbuf_humid)
	local nvals_ter = nobj_ter:get2dMap_flat(minposxz, nbuf_ter)
	local nvals_terflat = nobj_terflat:get2dMap_flat(minposxz, nbuf_terflat)
	local nvals_dec = nobj_dec:get2dMap_flat(minposxz, nbuf_dec)
	local nvals_cave = nobj_cave:get3dMap_flat(minposxyz, nbuf_cave)

	local offset = math.random(5,20)
	local nixyz = 1
	local nixz = 1

	for z = z0, z1 do
		for y = y0, y1 do -- Caves
			local vi = area:index(x0, y, z)
			for x = x0, x1 do -- for each node do
				local cave_d = 0.6
				if y > 10 then
					cave_d = 1.2
				elseif y <= 10 and y >= -50 then
					cave_d = y/100 + 1.1
				end
				if nvals_cave[nixyz] > cave_d then
					data[vi] = c_tmp
				end
				vi = vi + 1
				nixyz = nixyz + 1
			end
		end
		for x = x0, x1 do -- for each column do
			local n_x = x + math.floor(nvals_x[nixz] * border_amp) -- Biome edge noise.
			local n_z = z + math.floor(nvals_z[nixz] * border_amp)
			local noise_1 = nvals_dec[nixz]
			local biome = lottmapgen.biomes(n_x, n_z - 1)
			local height = lottmapgen.height(n_x, n_z - 1)
			local stone_depth = math.floor(((nvals_ter[nixz] + 1)) *
				(height * math.abs(math.abs(nvals_terflat[nixz] / (height / 20)) - 1.01)))
			local underwater = -math.floor(math.abs(noise_1) * 5) - 7
			for y = y1, y0, -1 do -- working down each column for each node do
				local fimadep = math.floor(6 - y / 512) + math.random(0, 1)
				local vi = area:index(x, y, z)
				local nodid = data[vi]
				local viuu = area:index(x, y - 1, z)
				local nodiduu = data[viuu]
				local via = area:index(x, y + 1, z)
				local nodida = data[via]
				if biome == 99 then
					if y < underwater then
						data[vi] = c_stone
					elseif y == underwater then
						data[vi] = c_sand
					elseif y < 1 then
						data[vi] = c_water
					end
				elseif biome == 98 then
					if y < underwater then
						data[vi] = c_morstone
					elseif y < 1 then
						data[vi] = c_morwat
					end
				elseif data[vi] == c_tmp then
					data[vi] = c_air
					if nvals_dec[nixz] > 0.5 and y < -154 then
						data[vi] = c_lava
					end
				elseif y == stone_depth and y >= 0 then
					if biome and lottmapgen.biome[biome] then
						if lottmapgen.biome[biome].surface then
							lottmapgen.biome[biome].surface(data, vi, y)
						end
						vi = area:index(x, y + 1, z)
						if lottmapgen.biome[biome].deco then
							lottmapgen.biome[biome].deco(data, p2data, vi, area,
								x, y + 1, z, noise_1, nvals_x[nixz])
						end
					end
				elseif y < stone_depth then
					data[vi] = c_stone
					if biome and lottmapgen.biome[biome] then
						if lottmapgen.biome[biome].soil_depth and
							y >= stone_depth - lottmapgen.biome[biome].soil_depth -
							math.abs(nvals_ter[nixz] * 5) and y >= -1 then
							if lottmapgen.biome[biome].soilf then
								lottmapgen.biome[biome].soilf(data, vi, y)
							elseif lottmapgen.biome[biome].soil then
								data[vi] = lottmapgen.biome[biome].soil
							end
						elseif lottmapgen.biome[biome].stone_depth and
							y >= -lottmapgen.biome[biome].stone_depth - nvals_ter[nixz] * 10 then
							if lottmapgen.biome[biome].stone_depth and lottmapgen.biome[biome].stone then
								data[vi] = lottmapgen.biome[biome].stone
							end
						end
					end
				elseif y <= 0 then
					if y == stone_depth then
						data[vi] = c_stone
						if biome and lottmapgen.biome[biome] then
							if lottmapgen.biome[biome].beach then
								data[vi] = lottmapgen.biome[biome].beach
							end
						end
					else
						data[vi] = c_water
						if biome and lottmapgen.biome[biome] then
							if lottmapgen.biome[biome].water then
								data[vi] = lottmapgen.biome[biome].water
							end
						end
					end
				end
			end
		nixz = nixz + 1
		end
	end
	vm:set_data(data)
	vm:set_param2_data(p2data)
	minetest.generate_ores(vm)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:update_liquids()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	minetest.chat_send_all(chugent)	
	table.insert(times, chugent)
end)

minetest.register_on_shutdown(function()
	local t = 0
	for i,v in pairs(times) do
		t = t + v
	end
	t = t / #times
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n" .. t)
end)
