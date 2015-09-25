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

local np_random = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 4510,
	octaves = 3,
	persist = 0.5
}

-- Stuff
lottmapgen = {}
local mapgen_params = minetest.get_mapgen_params()

dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")
dofile(minetest.get_modpath("lottmapgen").."/functions.lua")

-- On generated function
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
	local c_stonecopper = minetest.get_content_id("default:stone_with_copper")
	local c_stoneiron = minetest.get_content_id("default:stone_with_iron")
	local c_stonecoal = minetest.get_content_id("default:stone_with_coal")
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
	local c_ironhillgrass = minetest.get_content_id("lottmapgen:ironhill_grass")
	local c_salt = minetest.get_content_id("lottores:mineral_salt")
	local c_pearl = minetest.get_content_id("lottores:mineral_pearl")
	local c_mallorngen = minetest.get_content_id("lottmapgen:mallorngen")
	local c_beechgen = minetest.get_content_id("lottmapgen:beechgen")
	local c_mirktreegen = minetest.get_content_id("lottmapgen:mirktreegen")
	local c_angsnowblock = minetest.get_content_id("lottmapgen:angsnowblock")
	local c_mallos = minetest.get_content_id("lottplants:mallos")
	local c_seregon = minetest.get_content_id("lottplants:seregon")
	local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
	local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
	local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
	local c_melon = minetest.get_content_id("lottplants:melon_wild")
	local c_angfort = minetest.get_content_id("lottmapgen:angmarfort")
	local c_gonfort = minetest.get_content_id("lottmapgen:gondorfort")
	local c_hobhole = minetest.get_content_id("lottmapgen:hobbithole")
	local c_orcfort = minetest.get_content_id("lottmapgen:orcfort")
	local c_malltre = minetest.get_content_id("lottmapgen:mallornhouse")
	local c_lorhous = minetest.get_content_id("lottmapgen:lorienhouse")
	local c_mirktre = minetest.get_content_id("lottmapgen:mirkhouse")
	local c_rohfort = minetest.get_content_id("lottmapgen:rohanfort")

	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxz = {x=x0, y=z0}

	local nvals_temp = minetest.get_perlin_map(np_temp, chulens):get2dMap_flat(minposxz)
	local nvals_humid = minetest.get_perlin_map(np_humid, chulens):get2dMap_flat(minposxz)
	local nvals_random = minetest.get_perlin_map(np_random, chulens):get2dMap_flat(minposxz)

	local nixz = 1
	for z = z0, z1 do
		for x = x0, x1 do -- for each column do
			local n_temp = nvals_temp[nixz] -- select biome
			local n_humid = nvals_humid[nixz]
			local n_ran = nvals_random[nixz]
			local biome = false
			if n_temp < LOTET then
				if n_humid < LOHUT then
					biome = 1 -- (Angmar)
				elseif n_humid > HIHUT then
					biome = 3 -- (Trollshaws)
				else
					biome = 2 -- (Snowplains)
				end
			elseif n_temp > HITET then
				if n_humid < LOHUT then
					biome = 7 -- (Lorien)
				elseif n_humid > HIHUT then
					biome = 9 -- (Fangorn)
				elseif n_ran < LORAN then
					biome = 10 -- (Mirkwood)
				elseif n_ran > HIRAN then
					biome = 11 -- (Iron Hills)
				else
					biome = 4 -- (Dunlands)
				end
			else
				if n_humid < LOHUT then
					biome = 8 -- (Mordor)
				elseif n_humid > HIHUT then
					biome = 6 -- (Ithilien)
				elseif n_ran < LORAN then
					biome = 13 -- (Shire)
				elseif n_ran > HIRAN then
					biome = 12 -- (Rohan)
				else
					biome = 5 -- (Gondor)
				end
			end

			local sandy = (mapgen_params.water_level+2) + math.random(-1, 1) -- sandline
			local sandmin = (mapgen_params.water_level-15) + math.random(-5, 0) -- lowest sand
			local open = true -- open to sky?
			local solid = true -- solid node above?
			local water = false -- water node above?
			local surfy = y1 + 80 -- y of last surface detected
			for y = y1, y0, -1 do -- working down each column for each node do
				local fimadep = math.floor(6 - y / 512) + math.random(0, 1)
				local vi = area:index(x, y, z)
				local nodid = data[vi]
				local viuu = area:index(x, y - 2, z)
				local nodiduu = data[viuu]
				local via = area:index(x, y + 1, z)
				local nodida = data[via]
				if nodid == c_stone -- if stone
				or nodid == c_stonecopper
				or nodid == c_stoneiron
				or nodid == c_stonecoal then
					if y > mapgen_params.water_level-32 then
						if biome == 4 or biome == 12 then
							data[vi] = c_desertstone
						elseif biome == 8 then
							data[vi] = c_morstone
						elseif biome == 11 then
							if math.random(3) == 1 then
								data[vi] = c_stoneiron
							end
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
									if open and water and y == (mapgen_params.water_level-1) and biome > 4 and math.random(PAPCHA) == 2 then -- papyrus
										lottmapgen_papyrus(x, (mapgen_params.water_level+1), z, area, data)
										data[vi] = c_dirt
									elseif math.abs(n_temp) < 0.05 and y == (mapgen_params.water_level-1) then -- clay
										data[vi] = c_clay
									elseif math.abs(n_temp) < 0.05 and y == (mapgen_params.water_level-5) then -- salt
										data[vi] = c_salt
									elseif math.abs(n_temp) < 0.05 and y == (mapgen_params.water_level-20) then -- pearl
										data[vi] = c_pearl
									else
										data[vi] = c_sand
									end
								end
								if open and y > (mapgen_params.water_level + 4) + math.random(0, 1) and math.random(DUGCHA) == 2 and biome ~= 8 and biome ~= 7 then -- dune grass
									local vi = area:index(x, y + 1, z)
										data[vi] = c_dryshrub
									end
								elseif y <= sandmin then
									data[vi] = c_stone
								else -- above sandline
									if biome == 1 then
										if math.random(121) == 2 then
											data[vi] = c_ice
										elseif math.random(25) == 2 then
											data[vi] = c_frozenstone
										else
											data[vi] = c_angsnowblock
										end
									elseif biome == 2 then
										data[vi] = c_dirtsnow
									elseif biome == 3 then
										data[vi] = c_dirtsnow
									elseif biome == 4 then
										data[vi] = c_dungrass
									elseif biome == 5 then
										data[vi] = c_gondorgrass
									elseif biome == 6 then
										data[vi] = c_ithilgrass
									elseif biome == 7 then
										data[vi] = c_loriengrass
									elseif biome == 8 then
										data[vi] = c_morstone
									elseif biome == 9 then
										data[vi] = c_fangorngrass
									elseif biome == 10 then
										data[vi] = c_mirkwoodgrass
									elseif biome == 11 then
										data[vi] = c_ironhillgrass
									elseif biome == 12 then
										data[vi] = c_rohangrass
									elseif biome == 13 then
										data[vi] = c_shiregrass
									end
								if open then -- if open to sky then flora
									local y = surfy + 1
									local vi = area:index(x, y, z)
									if biome == 1 then
										if math.random(PLANT3) == 2 then
											data[vi] = c_dryshrub
										elseif math.random(TREE10) == 2 then
											data[vi] = c_beechgen
										elseif math.random(TREE7) == 3 then
											lottmapgen_pinetree(x, y, z, area, data)
										elseif math.random(TREE8) == 4 then
											lottmapgen_firtree(x, y, z, area, data)
										elseif math.random(PLANT6) == 2 then
											data[vi] = c_seregon
										elseif math.random(PLANT13) == 13 then
											data[vi] = c_angfort
										end
									elseif biome == 2 then
										data[vi] = c_snowblock
									elseif biome == 3 then
										if math.random(PLANT3) == 2 then
											data[vi] = c_dryshrub
										elseif math.random(TREE10) == 2 then
											data[vi] = c_beechgen
										elseif math.random(TREE4) == 3 then
											lottmapgen_pinetree(x, y, z, area, data)
										elseif math.random(TREE3) == 4 then
											lottmapgen_firtree(x, y, z, area, data)
										end
									elseif biome == 4 then
										if math.random(TREE5) == 2 then
											lottmapgen_defaulttree(x, y, z, area, data)
										elseif math.random(TREE7) == 3 then
											lottmapgen_appletree(x, y, z, area, data)
										elseif math.random (PLANT3) == 4 then
											lottmapgen_grass(data, vi)
										end
									elseif biome == 5 then
										if math.random(TREE7) == 2 then
											lottmapgen_defaulttree(x, y, z, area, data)
										elseif math.random(TREE8) == 6 then
											lottmapgen_aldertree(x, y, z, area, data)
										elseif math.random(TREE9) == 3 then
											lottmapgen_appletree(x, y, z, area, data)
										elseif math.random(TREE8) == 4 then
											lottmapgen_plumtree(x, y, z, area, data)
										elseif math.random(TREE10) == 9 then
											lottmapgen_elmtree(x, y, z, area, data)
										elseif math.random(PLANT13) == 10 then
											lottmapgen_whitetree(x, y, z, area, data)
										elseif math.random(PLANT3) == 5 then
											lottmapgen_grass(data, vi)
										elseif math.random(PLANT8) == 7 then
											lottmapgen_farmingplants(data, vi)
										elseif math.random(PLANT13) == 8 then
											lottmapgen_farmingrareplants(data, vi)
										elseif math.random(PLANT6) == 2 then
											data[vi] = c_mallos
										elseif math.random(PLANT13) == 13 then
											data[vi] = c_gonfort
										end
									elseif biome == 6 then
										if math.random(TREE3) == 2 then
											lottmapgen_defaulttree(x, y, z, area, data)
										elseif math.random(TREE6) == 6 then
											lottmapgen_lebethrontree(x, y, z, area, data)
										elseif math.random(TREE3) == 3 then
											lottmapgen_appletree(x, y, z, area, data)
										elseif math.random(TREE5) == 10 then
											lottmapgen_culumaldatree(x, y, z, area, data)
										elseif math.random(TREE5) == 4 then
											lottmapgen_plumtree(x, y, z, area, data)
										elseif math.random(TREE9) == 9 then
											lottmapgen_elmtree(x, y, z, area, data)
										elseif math.random(PLANT8) == 7 then
											lottmapgen_farmingplants(data, vi)
										elseif math.random(PLANT13) == 8 then
											data[vi] = c_melon
										elseif math.random(PLANT5) == 11 then
											lottmapgen_ithildinplants(data, vi)
										end
									elseif biome == 7 then
										if math.random(TREE3) == 2 then
											lottmapgen_mallornsmalltree(x, y, z, area, data)
										elseif math.random(TREE2) == 2 then
											lottmapgen_young_mallorn(x, y, z, area, data)
										elseif math.random(PLANT1) == 2 then
											lottmapgen_lorien_grass(data, vi)
										elseif math.random(TREE5) == 3 then
											data[vi] = c_mallorngen
										elseif math.random(PLANT4) == 11 then
											lottmapgen_lorienplants(data, vi)
										elseif math.random(PLANT13) == 13 then
											if math.random(1, 2) == 1 then
												data[vi] = c_malltre
											else
												data[vi] = c_lorhous
											end
										end
									elseif biome == 8 then
										if math.random(TREE10) == 2 then
											lottmapgen_burnedtree(x, y, z, area, data)
										elseif math.random(PLANT4) == 2 then
											data[vi] = c_bomordor
										elseif math.random(PLANT13) == 13 then
											data[vi] = c_orcfort
										end
									elseif biome == 9 then
										if math.random(TREE3) == 2 then
											lottmapgen_defaulttree(x, y, z, area, data)
										elseif math.random(TREE4) == 6 then
											lottmapgen_rowantree(x, y, z, area, data)
										elseif math.random(TREE4) == 3 then
											lottmapgen_appletree(x, y, z, area, data)
										elseif math.random(TREE5) == 10 then
											lottmapgen_birchtree(x, y, z, area, data)
										elseif math.random(TREE5) == 4 then
											lottmapgen_plumtree(x, y, z, area, data)
										elseif math.random(TREE7) == 9 then
											lottmapgen_elmtree(x, y, z, area, data)
										elseif math.random(TREE6) == 11 then
											lottmapgen_oaktree(x, y, z, area, data)
										elseif math.random(PLANT4) == 7 then
											lottmapgen_farmingplants(data, vi)
										elseif math.random(PLANT9) == 8 then
											data[vi] = c_melon
										end
									elseif biome == 10 then
										if math.random(TREE2) == 2 then
											data[vi] = c_mirktreegen
										elseif math.random(TREE4) == 3 then
											lottmapgen_jungletree2(x, y, z, area, data)
										elseif math.random(PLANT13) == 13 then
											data[vi] = c_mirktre
										end
									elseif biome == 11 then
										if math.random(TREE10) == 2 then
											data[vi] = c_beechgen
										elseif math.random(TREE4) == 3 then
											lottmapgen_pinetree(x, y, z, area, data)
										elseif math.random(TREE6) == 4 then
											lottmapgen_firtree(x, y, z, area, data)
										end
									elseif biome == 12 then
										if math.random(TREE7) == 2 then
											lottmapgen_defaulttree(x, y, z, area, data)
										elseif math.random(TREE7) == 3 then
											lottmapgen_appletree(x, y, z, area, data)
										elseif math.random(TREE8) == 4 then
											lottmapgen_plumtree(x, y, z, area, data)
										elseif math.random(TREE10) == 9 then
											lottmapgen_elmtree(x, y, z, area, data)
										elseif math.random(PLANT2) == 5 then
											lottmapgen_grass(data, vi)
										elseif math.random(PLANT8) == 6 then
											lottmapgen_farmingplants(data, vi)
										elseif math.random(PLANT13) == 7 then
											data[vi] = c_melon
										elseif math.random(PLANT6) == 2 then
											data[vi] = c_pilinehtar
										elseif math.random(PLANT13) == 13 then
											data[vi] = c_rohfort
										end
									elseif biome == 13 then
										if math.random(TREE7) == 2 then
											lottmapgen_defaulttree(x, y, z, area, data)
										elseif math.random(TREE7) == 3 then
											lottmapgen_appletree(x, y, z, area, data)
										elseif math.random(TREE7) == 4 then
											lottmapgen_plumtree(x, y, z, area, data)
										elseif math.random(TREE7) == 9 then
											lottmapgen_oaktree(x, y, z, area, data)
										elseif math.random(PLANT7) == 7 then
											lottmapgen_farmingplants(data, vi)
										elseif math.random(PLANT9) == 8 then
											data[vi] = c_melon
										elseif math.random(PLANT13) == 13 then
											data[vi] = c_hobhole
										end
									end
								end
							end
						end
					else -- underground
						if nodiduu ~= c_air and nodiduu ~= c_water and surfy - y + 1 <= fimadep then
							if y <= sandy and y >= sandmin then
								if biome ~= 8 then
									data[vi] = c_sand
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
						if n_temp < ICETET and y >= mapgen_params.water_level - math.floor((ICETET - n_temp) * 10) then --ice
							data[vi] = c_ice
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
	local chugent = math.ceil((os.clock() - t1) * 1000)
end)

dofile(minetest.get_modpath("lottmapgen").."/schematics.lua")
dofile(minetest.get_modpath("lottmapgen").."/deco.lua")
dofile(minetest.get_modpath("lottmapgen").."/chests.lua")
