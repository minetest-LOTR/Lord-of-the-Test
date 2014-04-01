--Lottmapgen originally paragenv7 by paramat, modification by fishyWET

local ONGEN = true -- (true/false) Enable biome generation.
local PROG = false -- Print generation progress to terminal.

local SANDY = 0
local SANDA = 4
local SANDR = 2
local FMAV = 3
local FMAMP = 2

local HITET = 0.25
local LOTET = -0.55
local HIWET = 0.25
local LOWET = -0.55

local TGRAD = 160
local HGRAD = 160
local FMGRAD = 40

local TUNGRACHA = 121
local TAIPINCHA = 64
local DRYGRACHA = 3
local DECGRACHA = 9
local DECAPPCHA = 10000
local ULTRAPLAT = 100000
local RAREPLANT = 10000
local NORMPLANT = 300
local COMNPLANT = 60
local BIGTRECHA = 200
local WETGRACHA = 3
local DESCACCHA = 529
local DESGRACHA = 289
local SAVGRACHA = 3
local SAVTRECHA = 361
local RAIJUNCHA = 16
local DUNGRACHA = 9
local PAPCHA = 3

-- 2D Perlin5 fine material depth and sandline
local perl5 = {
	SEED5 = 7028411255342,
	OCTA5 = 3, -- 
	PERS5 = 0.6, -- 
	SCAL5 = 128, -- 
}

-- 2D Perlin6 for temperature
local perl6 = {
	SEED6 = 72,
	OCTA6 = 3, -- 
	PERS6 = 0.5, -- 
	SCAL6 = 512, -- 
}

-- 2D Perlin7 for humidity
local perl7 = {
	SEED7 = 900011676,
	OCTA7 = 3, -- 
	PERS7 = 0.5, -- 
	SCAL7 = 512, -- 
}

-- Stuff

lottmapgen = {}
  
dofile(minetest.get_modpath("lottmapgen").."/trees.lua")
dofile(minetest.get_modpath("lottmapgen").."/nodes.lua")

local sandy
local fimadep2d
local noise
local noise6
local noise7
local temp
local hum

-- On generated function

if ONGEN then
	minetest.register_on_generated(function(minp, maxp, seed)
		if minp.y >= -32 and minp.y <= 208 then
			local perlin5 = minetest.get_perlin(perl5.SEED5, perl5.OCTA5, perl5.PERS5, perl5.SCAL5)
			local perlin6 = minetest.get_perlin(perl6.SEED6, perl6.OCTA6, perl6.PERS6, perl6.SCAL6)
			local perlin7 = minetest.get_perlin(perl7.SEED7, perl7.OCTA7, perl7.PERS7, perl7.SCAL7)
			local x1 = maxp.x
			local y1 = maxp.y
			local z1 = maxp.z
			local x0 = minp.x
			local y0 = minp.y
			local z0 = minp.z
			for x = x0, x1 do
				if PROG then
					print ("[lottmapgen] "..(x - x0 + 1).." ("..minp.x.." "..minp.y.." "..minp.z..")")
				end
				for z = z0, z1 do
					local surfy = 1024
					local sol = true
					local col = false
					local notre = false
					local tre = true
					local wat = false
					local mor = false
					local mot = false
					local fot = false
					local elf = false
					local moc = false
					local gra = false
					local mou = false
					local sno = false
					for y = y1, y0, -1 do
						local nodename = minetest.get_node({x=x,y=y,z=z}).name
						if nodename == "default:stone"
						or nodename == "default:stone_with_coal"
						or nodename == "default:stone_with_iron"
						or nodename == "default:stone_with_copper" then
							local unodename = minetest.get_node({x=x,y=y-1,z=z}).name
							local stable = true
							if unodename == "air" then
								stable = false
							end
							if not col then
								local noise5c = perlin5:get2d({x=x-777,y=z-777})
								sandy = SANDY + noise5c * SANDA + math.random(0,SANDR)
								local noise5b = perlin5:get2d({x=x,y=z})
								fimadep2d = FMAV + noise5b * FMAMP
								noise6 = perlin6:get2d({x=x,y=z})
								noise7 = perlin7:get2d({x=x,y=z})
								col = true
								notre = true
							end
							local fimadep = fimadep2d - y / FMGRAD
							if not sol then
								surfy = y
								temp = noise6 - y / TGRAD
								hum = noise7 - y / HGRAD
								if temp > HITET + math.random() / 10 then
									if hum > HIWET + math.random() / 10 then
										fot = true
									elseif hum < LOWET + math.random() / 10 then
										mor = true
									else
										mot = true
									end
								elseif temp < LOTET + math.random() / 10 then
									if hum < LOWET + math.random() / 10 then
										mou = true
									else
										sno = true
									end
								elseif hum > HIWET + math.random() / 10 then
									elf = true
								elseif hum < LOWET + math.random() / 10 then
									moc = true
								else
									gra = true
								end
							end
							if surfy - y < fimadep and stable then
								if y <= sandy then
									if y == -1 and math.abs(noise6) < 0.1 then
										minetest.add_node({x=x,y=y,z=z},{name="default:clay"})
									elseif y == -5 and math.abs(noise6) < 0.1 then
										minetest.add_node({x=x,y=y,z=z},{name="lottores:mineral_salt"})
									elseif y == -10 and math.abs(noise6) < 0.1 then
										minetest.add_node({x=x,y=y,z=z},{name="lottores:mineral_pearl"})
                                    else
										minetest.add_node({x=x,y=y,z=z},{name="default:sand"})
									end
									if not sol then
										if y > 3 and tre and math.random(DUNGRACHA) == 2 then
											minetest.add_node({x=x,y=y+1,z=z},{name="default:dry_shrub"})
										elseif sno and y > 0 then
											minetest.add_node({x=x,y=y+1,z=z},{name="default:snowblock"})
										elseif mou and y > 0 then
											minetest.add_node({x=x,y=y+1,z=z},{name="default:snow"})
										end
									end
								elseif mor then
									minetest.add_node({x=x,y=y,z=z},{name="lottmapgen:mordor_stone"})
									if not sol and tre and y > 8 then
										if math.random(TUNGRACHA) == 2 then
											minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:brambles_of_mordor"})
										end
									end
								elseif mou then
									minetest.add_node({x=x,y=y,z=z},{name="lottmapgen:frozen_stone"})
									if not sol and y > 0 then
										if tre and math.random(TUNGRACHA) == 2 then
											minetest.add_node({x=x,y=y+1,z=z},{name="default:dry_shrub"})
										elseif tre and math.random(NORMPLANT) == 2 then
											minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:seregon"})
										else
											minetest.add_node({x=x,y=y+1,z=z},{name="default:snow"})
										end
									end
								elseif moc or mot then
									if not sol then
										if y >= 1 then
											minetest.add_node({x=x,y=y,z=z},{name="lottmapgen:mordor_stone"})
										else
											minetest.add_node({x=x,y=y,z=z},{name="lottmapgen:mordor_stone"})
										if math.random(TUNGRACHA) == 2 then
										    minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:brambles_of_mordor"})
										end
										end
										if moc and tre and y > 2 and math.random(TUNGRACHA) == 2 then
											minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:brambles_of_mordor"})
										elseif sav then 
											if y >= 3 and tre and math.random(TUNGRACHA) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:brambles_of_mordor"})
											elseif y == 0 and wat then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottmapgen:blacksource"})
											end
										end
									else
										minetest.add_node({x=x,y=y,z=z},{name="lottmapgen:mordor_stone"})
									end
								else
									if not sol then
										if y >= 1 then
											minetest.add_node({x=x,y=y,z=z},{name="default:dirt_with_grass"})
										else
											minetest.add_node({x=x,y=y,z=z},{name="default:dirt"})
										end
										if elf and tre and y > 0 and math.random(WETGRACHA) == 2 then
											if math.random(BIGTRECHA) == 2 then
												lottplants_mallorntree({x=x,y=y+1,z=z})
											elseif math.random(RAIJUNCHA) == 2 then
												lottplants_mallornsmalltree({x=x,y=y+1,z=z})
											elseif math.random(RAIJUNCHA) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:elanor"})
											elseif math.random(RAIJUNCHA) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:niphredil"})
											elseif math.random(NORMPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:lissuin"})
											end
										elseif gra and tre and y >= 3 then
										    if math.random(DECGRACHA) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="default:grass_"..math.random(1,5)})
											elseif math.random(DECAPPCHA) == 2 then
												lottplants_aldertree({x=x,y=y+1,z=z})
											elseif math.random(DECAPPCHA) == 2 then
												lottplants_plumtree({x=x,y=y+1,z=z})
											elseif math.random(DECAPPCHA) == 2 then
												lottplants_appletree({x=x,y=y+1,z=z})
											elseif math.random(DECAPPCHA) == 2 then
												lottplants_lebethrontree({x=x,y=y+1,z=z})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:mallos"})
											elseif math.random(ULTRAPLAT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:athelas"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:pipeweed_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:corn_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:potato_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:mushroom_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:berries_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:turnips_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:tomatoes_wild"})
											elseif math.random(RAREPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:cabbage_wild"})
											elseif math.random(NORMPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:pilinehtar"})
											end
										elseif sno and y >= 1 then
										    minetest.add_node({x=x,y=y+1,z=z},{name="default:snowblock"})
											if tre and math.random(DECAPPCHA) == 2 then
												lottplants_beechtree({x=x,y=y+1,z=z})
											elseif tre and math.random(SAVTRECHA) == 2 then
												lottplants_firtree({x=x,y=y+1,z=z})
											elseif tre and math.random(BIGTRECHA) == 2 then
												lottplants_pinetree({x=x,y=y+1,z=z})
											end
										elseif fot then
											if y >= -1 and tre and math.random(BIGTRECHA) == 2 then
												lottplants_birchtree({x=x,y=y+1,z=z})
											elseif y >= -1 and tre and math.random(TAIPINCHA) == 2 then
												lottplants_rowantree({x=x,y=y+1,z=z})
											elseif y >= -1 and tre and math.random(SAVTRECHA) == 2 then
												lottplants_elmtree({x=x,y=y+1,z=z})
											elseif y >= -1 and tre and math.random(TAIPINCHA) == 2 then
												lottplants_hugedefaulttree({x=x,y=y+1,z=z})
											elseif math.random(NORMPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:asphodel"})
											elseif math.random(NORMPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:anemones"})
											elseif math.random(NORMPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:eglantive"})
											elseif math.random(NORMPLANT) == 2 then
												minetest.add_node({x=x,y=y+1,z=z},{name="lottplants:iris"})
											elseif y == 0 and wat then
												minetest.add_node({x=x,y=y+1,z=z},{name="default:water_source"})
											end
										end
									else
										minetest.add_node({x=x,y=y,z=z},{name="default:dirt"})
									end
								end
								if y == 0 and wat and y > sandy and (fot)
								and tre and math.random(PAPCHA) == 2 then
									local nodename = minetest.get_node({x=x,y=y+2,z=z}).name
									if nodename == "air" then
										minetest.add_node({x=x,y=y+1,z=z},{name="default:water_source"})
										for j = 2, math.random(2,4) do
											minetest.add_node({x=x,y=y+j,z=z},{name="default:papyrus"})
										end
									end
								end
							elseif not sol and y > 0 then
								if sno then
									minetest.add_node({x=x,y=y+1,z=z},{name="default:snowblock"})
								elseif mou then
									minetest.add_node({x=x,y=y+1,z=z},{name="default:snow"})
								end
							end
							sol = true
							if notre then
								tre = false
							end
						else
							sol = false
							if y == 1 then
								local nodename = minetest.get_node({x=x,y=y,z=z}).name
								if nodename == "default:water_source" then
									wat = true
									local temp = perlin6:get2d({x=x,y=z})
									if temp < LOTET + math.random() / 10 then
										minetest.add_node({x=x,y=y,z=z},{name="default:ice"})
									end
								end
							end
						end
					end
				end	
			end		
		end			
	end)				
end