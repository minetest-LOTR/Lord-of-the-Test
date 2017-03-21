-- paragenv7 0.3.1 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- Licenses: code WTFPL, textures CC BY-SA

-- new in 0.3.1:
-- ice varies thickness with temp
-- dirt as papyrus bed, check for water below papyrus
-- clay at mid-temp
-- 'is ground content' false for leaves only

-- TODO
-- fog

-- Parameters

local HITET = 0.4 -- High temperature threshold
local LOTET = -0.4 -- Low ..
local ICETET = -0.8 -- Ice ..
local HIHUT = 0.4 -- High humidity threshold
local LOHUT = -0.4 -- Low ..
local HIRAN = 0.4
local LORAN = -0.4
local PAPCHA = 3 -- Papyrus
local DUGCHA = 5 -- Dune grass
local biome_blend = minetest.setting_getbool("biome_blend")

--Rarity for Trees

local TREE1 = 30
local TREE2 = 50
local TREE3 = 100
local TREE4 = 200
local TREE5 = 300
local TREE6 = 500
local TREE7 = 750
local TREE8 = 1000
local TREE9 = 2000
local TREE10 = 5000

--Rarity for Plants

local PLANT1 = 3
local PLANT2 = 5
local PLANT3 = 10
local PLANT4 = 20
local PLANT5 = 50
local PLANT6 = 100
local PLANT7 = 200
local PLANT8 = 500
local PLANT9 = 750
local PLANT10 = 1000
local PLANT11 = 2000
local PLANT12 = 5000
local PLANT13 = 10000
local PLANT14 = 100000
local PLANT15 = 500000

-- 2D noise for temperature

local np_temp = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 3,
	persist = 0.5
}

-- 2D noise for humidity

local np_humid = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -5500,
	octaves = 3,
	persist = 0.5
}

-- Stuff
lottmapgen = {}
lottmapgen_biome = {}

local nobj_temp = nil
local nobj_humid = nil
local nbuf_temp
local nbuf_humid
local dbuf
local p2dbuf

local water_level = tonumber(minetest.get_mapgen_setting("water_level"))

dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")
dofile(minetest.get_modpath("lottmapgen").."/functions.lua")
dofile(minetest.get_modpath("lottmapgen").."/biomes.lua")
dofile(minetest.get_modpath("lottmapgen").."/schematics.lua")

-- On generated function
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < (water_level-1000) or minp.y > 5000 then
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
	local data = vm:get_data(dbuf)
	local p2data = vm:get_param2_data(p2dbuf)

	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_sand = minetest.get_content_id("default:sand")
	local c_desertsand = minetest.get_content_id("default:desert_sand")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_snow = minetest.get_content_id("default:snow")
	local c_ice = minetest.get_content_id("default:ice")
	local c_dirtsnow = minetest.get_content_id("default:dirt_with_snow")
	local c_dirtgrass = minetest.get_content_id("default:dirt_with_grass")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_dryshrub = minetest.get_content_id("default:dry_shrub")
	local c_clay = minetest.get_content_id("default:clay")
	local c_stone = minetest.get_content_id("default:stone")
	local c_desertstone = minetest.get_content_id("default:desert_stone")
	local c_sandstone = minetest.get_content_id("default:sandstone")
	local c_silsandstone = minetest.get_content_id("default:silver_sandstone")
	local c_dessandstone = minetest.get_content_id("default:desert_sandstone")
	local c_stonecopper = minetest.get_content_id("default:stone_with_copper")
	local c_stoneiron = minetest.get_content_id("default:stone_with_iron")
	local c_stonecoal = minetest.get_content_id("default:stone_with_coal")
	local c_chalk = minetest.get_content_id("darkage:chalk")
	local c_mapgen_stone = minetest.get_content_id("default:mapgen_stone")
	local c_water = minetest.get_content_id("default:water_source")
	local c_river_water = minetest.get_content_id("default:river_water_source")
	local c_morwat = minetest.get_content_id("lottmapgen:blacksource")
	local c_morrivwat = minetest.get_content_id("lottmapgen:black_river_source")

	local c_morstone = minetest.get_content_id("lottmapgen:mordor_stone")
	local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
	local c_dungrass = minetest.get_content_id("lottmapgen:dunland_grass")
	local c_gondorgrass = minetest.get_content_id("lottmapgen:gondor_grass")
	local c_loriengrass = minetest.get_content_id("lottmapgen:lorien_grass")
	local c_fangorngrass = minetest.get_content_id("lottmapgen:fangorn_grass")
	local c_mirkwoodgrass = minetest.get_content_id("lottmapgen:mirkwood_grass")
	local c_rohangrass = minetest.get_content_id("lottmapgen:rohan_grass")
	local c_shiregrass = minetest.get_content_id("lottmapgen:shire_grass")
	local c_junglegrass = minetest.get_content_id("lottmapgen:jungle_grass")
	local c_ironhillgrass = minetest.get_content_id("lottmapgen:ironhill_grass")
	local c_rhungrass = minetest.get_content_id("lottmapgen:rhun_grass")
	local c_ettenmoorgrass = minetest.get_content_id("lottmapgen:ettenmoors_grass")
	local c_lindongrass = minetest.get_content_id("lottmapgen:lindon_grass")
	local c_breelandgrass = minetest.get_content_id("lottmapgen:breeland_grass")
	local c_eregiongrass = minetest.get_content_id("lottmapgen:eregion_grass")
	local c_wildergrass = minetest.get_content_id("lottmapgen:wilderland_grass")
	local c_salt = minetest.get_content_id("lottores:mineral_salt")
	local c_pearl = minetest.get_content_id("lottores:mineral_pearl")
	local c_angsnowblock = minetest.get_content_id("lottmapgen:angsnowblock")
	local c_mallos = minetest.get_content_id("lottplants:mallos")
	local c_seregon = minetest.get_content_id("lottplants:seregon")
	local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
	local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
	local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
	local c_melon = minetest.get_content_id("lottplants:melon_wild")

	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxz = {x=x0, y=z0}
	local border_amp = 256

	nobj_temp = nobj_temp or minetest.get_perlin_map(np_temp, chulens)
	nobj_humid = nobj_humid or minetest.get_perlin_map(np_humid, chulens)

	local nvals_x = nobj_temp:get2dMap_flat(minposxz, nbuf_temp)
	local nvals_z = nobj_humid:get2dMap_flat(minposxz, nbuf_humid)

	local offset = math.random(5,20)
	--[[if biome_blend == true then
		chulens = {x=sidelen+2*offset, y=sidelen+2*offset, z=sidelen+2*offset}
		minposxz = {x=x0-offset, y=z0-offset }
		nvals_temp = nobj_temp:get2dMap(minposxz)
		nvals_humid = nobj_humid:get2dMap(minposxz)
		nvals_random = nobj_random:get2dMap(minposxz)
	end]]

	local nixz = 1
	for z = z0, z1 do
		for x = x0, x1 do -- for each column do
			local n_x = x + nvals_x[nixz] * border_amp -- select biome
			local n_z = z + nvals_z[nixz] * border_amp
			local stone_depth = nvals_x[nixz] * 32

			local biome = false

			if biome_blend ~= true then
				-- Needs math.floor to avoid decimals...!
				biome = lottmapgen_biomes(math.floor(n_x), math.floor(n_z))
			end

			local sandy = (water_level+2) + math.random(-1, 1) -- sandline
			local sandmin = (water_level-15) + math.random(-5, 0) -- lowest sand
			local open = true -- open to sky?
			local solid = true -- solid node above?
			local water = false -- water node above?
			local surfy = y1 + 80 -- y of last surface detected
			for y = y1, y0, -1 do -- working down each column for each node do
				--[[if biome_blend == true then
					local offsetpos = {x = (x-x0) + offset + math.random(-offset, offset) + 1, z = (z - z0) + offset + math.random(-offset, offset) + 1}
					n_temp = nvals_temp[offsetpos.z][offsetpos.x] -- select biome
					n_humid = nvals_humid[offsetpos.z][offsetpos.x]
					n_ran = nvals_random[offsetpos.z][offsetpos.x]
					biome = lottmapgen_biomes(biome, n_temp, n_humid, n_ran)
				end]]
				local fimadep = math.floor(6 - y / 512) + math.random(0, 1)
				local vi = area:index(x, y, z)
				local nodid = data[vi]
				local viuu = area:index(x, y - 1, z)
				local nodiduu = data[viuu]
				local via = area:index(x, y + 1, z)
				local nodida = data[via]
				if biome == 99 then -- If sea!
					if y > water_level then
						data[vi] = c_air
					else
						data[vi] = c_water
					end
				elseif nodid == c_stone -- if stone
				or nodid == c_mapgen_stone
				or nodid == c_stonecopper
				or nodid == c_chalk
				or nodid == c_stoneiron
				or nodid == c_stonecoal then
					if y > water_level - (32 + stone_depth) then
						if biome == 12 or biome == 17 then
							data[vi] = c_desertstone
						elseif biome == 19 then
							data[vi] = c_morstone
						elseif biome == 18 then
							data[vi] = c_silsandstone
						elseif biome == 23 then
							data[vi] = c_dessandstone
						elseif biome == 21 then
							if math.random(3) == 1 then
								data[vi] = c_stoneiron
							end
						end
					end
					if y > - 40 and y < -5 and biome == 11 then
						if math.random(PLANT15) == 1 then
							lottmapgen.enqueue_building("Dwarf House", {x=x, y=y, z=z}) -- data[vi] = c_dwahous
						end
					end
					if y > - 100 and y < -50 and biome == 7 then
						if math.random(PLANT15) == 1 then
							lottmapgen_elf_workshop(x, y, z, area, data, p2data)
						end
					end
					if not solid then -- if surface
						surfy = y
						if nodiduu ~= c_air and nodiduu ~= c_water and fimadep >= 1 then -- if supported by 2 stone nodes
							if nodida == c_river_water or data[area:index(x + 1, y, z)] == c_river_water
							or data[area:index(x, y, z + 1)] == c_river_water or data[area:index(x - 1, y, z)] == c_river_water
							or data[area:index(x, y, z - 1)] == c_river_water then
								if biome == 8 then
									data[vi] = c_morstone
								else
									data[vi] = c_sand
								end
							elseif y <= sandy and y >= sandmin then -- sand
								if biome ~= 8 then
									if open and water and y == (water_level-1) and biome > 4
									and math.random(PAPCHA) == 2 then -- papyrus
										lottmapgen_papyrus(x, (water_level+1), z, area, data, p2data)
										data[vi] = c_dirt
									elseif math.abs(n_x) < 0.05 and y == (water_level-1) then -- clay
										data[vi] = c_clay
									elseif math.abs(n_x) < 0.05 and y == (water_level-5) then -- salt
										data[vi] = c_salt
									elseif math.abs(n_x) < 0.05 and y == (water_level-20) then -- pearl
										data[vi] = c_pearl
									else
										data[vi] = c_sand
									end
								end
								if open and y > (water_level + 4) + math.random(0, 1) and math.random(DUGCHA) == 2 and biome ~= 8 and biome ~= 7 then -- dune grass
									local vi = area:index(x, y + 1, z)
									data[vi] = c_dryshrub
									p2data[vi] = 42
								end
							elseif y <= sandmin then
								data[vi] = c_stone
							else -- above sandline
								if open then
									if biome and lottmapgen_biome[biome] then
										if lottmapgen_biome[biome].surface then
											lottmapgen_biome[biome].surface(data, vi)
										end
										local y = surfy + 1
										local vi = area:index(x, y, z)
										if lottmapgen_biome[biome].deco then
											lottmapgen_biome[biome].deco(data, p2data, vi, area, x, y, z)
										end
									end
								end
							end
						end
					else -- underground
						if nodiduu ~= c_air and nodiduu ~= c_water and surfy - y + 1 <= fimadep then
							if y <= sandy and y >= sandmin then
								if biome ~= 8 and biome ~= 14 then
									data[vi] = c_sand
								end
							elseif y > sandy and y >= surfy - 2 then
								if biome ~= 8 and biome ~= 14 then
									data[vi] = c_dirt
								elseif biome == 14 then
									data[vi] = c_desertsand
								end
							end
						end
					end
				open = false
				solid = true
				elseif nodid == c_air or nodid == c_water or nodid == c_river_water then
					solid = false
					if nodid == c_water or nodid == c_river_water then
						water = true
						if biome == 8 then
							if nodid == c_river_water then
								data[vi] = c_morrivwat
							else
								data[vi] = c_morwat
							end
						end
						if biome < 4 then --ice
							data[vi] = c_ice
						end
					end
				end
			end
		nixz = nixz + 1
		end
	end
	vm:set_data(data)
	vm:set_param2_data(p2data)
	--vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	print(chugent)
end)

dofile(minetest.get_modpath("lottmapgen").."/deco.lua")
dofile(minetest.get_modpath("lottmapgen").."/chests.lua")
