function lottmapgen.register_biome(id, table)
	lottmapgen_biome[id] = table
end

function lottmapgen_biomes(noisy_x, noisy_z)
	if (noisy_x >= -19840 and noisy_x <= 32040
	and noisy_z <= 32040 and noisy_z >= 26080)
	or (noisy_x >= 2520 and noisy_x <= 17280
	and noisy_z <= 26120 and noisy_z >= 21440) then
		return 1
	elseif noisy_x >= -10080 and noisy_x <= 0
	and noisy_z <= 26120 and noisy_z >= 20960 then
		return 2
	elseif noisy_x >= -6160 and noisy_x <= 0
	and noisy_z <= 21000 and noisy_z >= 17600 then
		return 3
	elseif (noisy_x >= -17400 and noisy_x <= -10040
	and noisy_z <= 26120 and noisy_z >= 17200)
	or (noisy_x >= -10080 and noisy_x <= -6120
	and noisy_z <= 21000 and noisy_z >= 17200)
	or (noisy_x >= -7880 and noisy_x <= -6120
	and noisy_z <= 17240 and noisy_z >= 13920) then
		return 4
	elseif noisy_x >= -6160 and noisy_x <= 0
	and noisy_z <= 17640 and noisy_z >= 12040 then
		return 5
	elseif noisy_x >= -12160 and noisy_x <= -7840
	and noisy_z <= 17240 and noisy_z >= 13920 then
		return 6
	elseif noisy_x >= -28760 and noisy_x <= -17360
	and noisy_z <= 26120 and noisy_z >= 5400 then
		return 7
	elseif noisy_x >= -17400 and noisy_x <= -12120
	and noisy_z <= 17240 and noisy_z >= 11720 then
		return 8
	elseif noisy_x >= -17400 and noisy_x <= -12120
	and noisy_z <= 11760 and noisy_z >= 1080 then
		return 9
	elseif noisy_x >= -12160 and noisy_x <= -6120
	and noisy_z <= 13960 and noisy_z >= 6400 then
		return 10
	elseif (noisy_x >= -12160 and noisy_x <= -7880
	and noisy_z <= 6440 and noisy_z >= 800)
	or (noisy_x >= -12160 and noisy_x <= -3720
	and noisy_z <= 840 and noisy_z >= -3480) then
		return 11
	elseif (noisy_x >= -6160 and noisy_x <= -2080
	and noisy_z <= 12080 and noisy_z >= 6400)
	or (noisy_x >= -2160 and noisy_x <= -720
	and noisy_z <= 12080 and noisy_z >= 8920) then
		return 12
	elseif (noisy_x >= -7920 and noisy_x <= -3720
	and noisy_z <= 6440 and noisy_z >= 800)
	or (noisy_x >= -3760 and noisy_x <= -2440
	and noisy_z <= 6440 and noisy_z >= 3920) then
		return 13
	elseif noisy_x >= 5160 and noisy_x <= 11720
	and noisy_z <= 21480 and noisy_z >= 5760 then
		return 14
	elseif noisy_x >= 1320 and noisy_x <= 3720
	and noisy_z <= 8600 and noisy_z >= 6280 then
		return 15
	elseif noisy_x >= -760 and noisy_x <= 2600
	and noisy_z <= 5640 and noisy_z >= 1080 then
		return 16
	elseif (noisy_x >= -3760 and noisy_x <= 2640
	and noisy_z <= 1120 and noisy_z >= -3480)
	or (noisy_x >= 2560 and noisy_x <= 6800
	and noisy_z <= 4400 and noisy_z >= -3480) then
		return 17
	elseif (noisy_x >= -12640 and noisy_x <= -400
	and noisy_z <= -3440 and noisy_z >= -10400)
	or (noisy_x >= -440 and noisy_x <= 12200
	and noisy_z <= -3440 and noisy_z >= -14160) then
		return 18
	elseif noisy_x >= 12160 and noisy_x <= 32040
	and noisy_z <= -680 and noisy_z >= -14160 then
		return 19
	elseif (noisy_x >= -40 and noisy_x <= 2560
	and noisy_z <= 26120 and noisy_z >= 12040)
	or (noisy_x >= -760 and noisy_x <= 2560
	and noisy_z <= 12080 and noisy_z >= 8960)
	or (noisy_x >= -2160 and noisy_x <= 760
	and noisy_z <= 9040 and noisy_z >= 5600)
	or (noisy_x >= -3760 and noisy_x <= -720
	and noisy_z <= 6440 and noisy_z >= 1080) then
		return 20
	elseif noisy_x >= 15320 and noisy_x <= 26320
	and noisy_z <= 20840 and noisy_z >= 17760 then
		return 21
	elseif (noisy_x >= 19680 and noisy_x <= 32040
	and noisy_z <= 26120 and noisy_z >= 20800)
	or (noisy_x >= 26280 and noisy_x <= 32040
	and noisy_z <= 20840 and noisy_z >= 17760)
	or (noisy_x >= 19680 and noisy_x <= 32040
	and noisy_z <= 17800 and noisy_z >= -720) then
		return 22
	elseif noisy_x >= 2200 and noisy_x <= 32040
	and noisy_z <= -14120 and noisy_z >= -21240 then
		return 23
	elseif noisy_x >= -4040 and noisy_x <= 32040
	and noisy_z <= -21200 and noisy_z >= -32040 then
		return 24
	elseif (noisy_x >= 2520 and noisy_x <= 5200
	and noisy_z <= 22200 and noisy_z >= 8960)
	or (noisy_x >= 720 and noisy_x <= 5200
	and noisy_z <= 9000 and noisy_z >= 5600)
	or (noisy_x >= 2560 and noisy_x <= 6800
	and noisy_z <= 5800 and noisy_z >= 4360)
	or (noisy_x >= 6760 and noisy_x <= 12200
	and noisy_z <= 5800 and noisy_z >= -3480)
	or (noisy_x >= 11640 and noisy_x <= 19720
	and noisy_z <= 17800 and noisy_z >= -720)
	or (noisy_x >= 11680 and noisy_x <= 15360
	and noisy_z <= 21480 and noisy_z >= 17720)
	or (noisy_x >= 15280 and noisy_x <= 17280
	and noisy_z <= 21480 and noisy_z >= 20800)
	or (noisy_x >= 17240 and noisy_x <= 19720
	and noisy_z <= 26120 and noisy_z >= 20800) then
		return 25
	else
		return 1337 --sea!
	end
end

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

local c_morstone = minetest.get_content_id("lottmapgen:mordor_stone")
local c_desertsand = minetest.get_content_id("default:desert_sand")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_dirtsnow = minetest.get_content_id("default:dirt_with_snow")
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
local c_minhiriathgrass = minetest.get_content_id("lottmapgen:minhiriath_grass")
local c_cardolangrass = minetest.get_content_id("lottmapgen:cardolan_grass")
local c_enedwaithgrass = minetest.get_content_id("lottmapgen:enedwaith_grass")
local c_arthedaingrass = minetest.get_content_id("lottmapgen:arthedain_grass")
local c_rhudaurgrass = minetest.get_content_id("lottmapgen:rhudaur_grass")
local c_angsnowblock = minetest.get_content_id("lottmapgen:angsnowblock")
local c_snowblock = minetest.get_content_id("default:snowblock")
local c_ithilgrass = minetest.get_content_id("lottmapgen:ithilien_grass")
local c_ice = minetest.get_content_id("default:ice")
local c_frozenstone = minetest.get_content_id("lottmapgen:frozen_stone")
local c_dryshrub = minetest.get_content_id("default:dry_shrub")
local c_melon = minetest.get_content_id("lottplants:melon_wild")
local c_bomordor = minetest.get_content_id("lottplants:brambles_of_mordor")
local c_pilinehtar = minetest.get_content_id("lottplants:pilinehtar")
local c_mallos = minetest.get_content_id("lottplants:mallos")

lottmapgen.register_biome(1, {
	name = "Forodwaith",
	surface = function(data, vi)
		if math.random(250) == 2 then
			data[vi] = c_ice
		elseif math.random(25) == 2 then
			data[vi] = c_frozenstone
		else
			data[vi] = c_angsnowblock
		end
	end,
})

lottmapgen.register_biome(2, {
	name = "Angmar",
	surface = function(data, vi)
		data[vi] = c_dirtsnow
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(PLANT3) == 2 then
			data[vi] = c_dryshrub
			p2data[vi] = 42
		elseif math.random(TREE10) == 2 then
			lottmapgen_beechtree(x, y, z, area, data)
		elseif math.random(TREE4) == 3 then
			lottmapgen_pinetree(x, y, z, area, data)
		elseif math.random(TREE3) == 4 then
			lottmapgen_firtree(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(3, {
	name = "Ettenmoors",
	surface = function(data, vi)
		data[vi] = c_ettenmoorgrass
	end,
})

lottmapgen.register_biome(4, {
	name = "Arthedain",
	surface = function(data, vi)
		data[vi] = c_arthedaingrass
	end,
})

lottmapgen.register_biome(5, {
	name = "Rhudaur",
	surface = function(data, vi)
		data[vi] = c_rhudaurgrass
	end,
})

lottmapgen.register_biome(6, {
	name = "Breeland",
	surface = function(data, vi)
		data[vi] = c_breelandgrass
	end,
})

lottmapgen.register_biome(7, {
	name = "Lindon",
	surface = function(data, vi)
		data[vi] = c_lindongrass
	end,
})

lottmapgen.register_biome(8, {
	name = "Shire",
	surface = function(data, vi)
		data[vi] = c_shiregrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random(TREE7) == 4 then
			lottmapgen_plumtree(x, y, z, area, data)
		elseif math.random(TREE7) == 9 then
			lottmapgen_oaktree(x, y, z, area, data)
		elseif math.random(PLANT7) == 7 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT9) == 8 then
			data[vi] = c_melon
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Hobbit Hole", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(9, {
	name = "Minhiriath",
	surface = function(data, vi)
		data[vi] = c_minhiriathgrass
	end,
})

lottmapgen.register_biome(10, {
	name = "Cardolan",
	surface = function(data, vi)
		data[vi] = c_cardolangrass
	end,
})

lottmapgen.register_biome(11, {
	name = "Enedwaith",
	surface = function(data, vi)
		data[vi] = c_enedwaithgrass
	end,
})

lottmapgen.register_biome(12, {
	name = "Eregion",
	surface = function(data, vi)
		data[vi] = c_eregiongrass
	end,
})

lottmapgen.register_biome(13, {
	name = "Dunland",
	surface = function(data, vi)
		data[vi] = c_dungrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE5) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random (PLANT3) == 4 then
			lottmapgen_grass(data, vi, p2data)
		end
	end,
})

lottmapgen.register_biome(14, {
	name = "Mirkwood",
	surface = function(data, vi)
		data[vi] = c_mirkwoodgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE2) == 2 then
			lottmapgen_mirktree(x, y, z, area, data)
		elseif math.random(TREE2) == 3 then
			lottmapgen_mirktree2(x, y, z, area, data)
		elseif math.random(PLANT13) == 13 then
			data[vi] = lottmapgen.enqueue_building("Mirkwood House", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(15, {
	name = "Lorien",
	surface = function(data, vi)
		data[vi] = c_loriengrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE3) == 2 then
			lottmapgen_mallornsmalltree(x, y, z, area, data)
		elseif math.random(TREE2) == 2 then
			lottmapgen_young_mallorn(x, y, z, area, data)
		elseif math.random(PLANT1) == 2 then
			lottmapgen_lorien_grass(data, vi, p2data)
		elseif math.random(TREE5) == 3 then
			lottmapgen_mallorntree(x, y, z, area, data)
		elseif math.random(PLANT4) == 11 then
			lottmapgen_lorienplants(data, vi, p2data)
		elseif math.random(PLANT13) == 13 then
			if math.random(1, 2) == 1 then
				lottmapgen.enqueue_building("Mallorn House", {x=x, y=y, z=z})
			else
				lottmapgen.enqueue_building("Lorien House", {x=x, y=y, z=z})
			end
		end
	end,
})

lottmapgen.register_biome(16, {
	name = "Fangorn",
	surface = function(data, vi)
		data[vi] = c_fangorngrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
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
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT9) == 8 then
			data[vi] = c_melon
		end
	end,
})

lottmapgen.register_biome(17, {
	name = "Rohan",
	surface = function(data, vi)
		data[vi] = c_rohangrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE7) == 2 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE7) == 3 then
			lottmapgen_appletree(x, y, z, area, data)
		elseif math.random(TREE8) == 4 then
			lottmapgen_plumtree(x, y, z, area, data)
		elseif math.random(TREE10) == 9 then
			lottmapgen_elmtree(x, y, z, area, data)
		elseif math.random(PLANT2) == 5 then
			lottmapgen_grass(data, vi, p2data)
		elseif math.random(PLANT8) == 6 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT13) == 7 then
			data[vi] = c_melon
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_pilinehtar
			p2data[vi] = 2
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Rohan Fort", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(18, {
	name = "Gondor",
	surface = function(data, vi)
		data[vi] = c_gondorgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
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
			lottmapgen_grass(data, vi, p2data)
		elseif math.random(PLANT8) == 7 then
			lottmapgen_farmingplants(data, vi, p2data)
		elseif math.random(PLANT13) == 8 then
			lottmapgen_farmingrareplants(data, vi, p2data)
		elseif math.random(PLANT6) == 2 then
			data[vi] = c_mallos
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Gondor Fort", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(19, {
	name = "Mordor",
	surface = function(data, vi)
		data[vi] = c_morstone
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE10) == 2 then
			lottmapgen_burnedtree(x, y, z, area, data)
		elseif math.random(PLANT4) == 2 then
			data[vi] = c_bomordor
			p2data[vi] = 42
		elseif math.random(PLANT13) == 13 then
			lottmapgen.enqueue_building("Orc Fort", {x=x, y=y, z=z})
		end
	end,
})

lottmapgen.register_biome(20, {
	name = "Misty Mountains",
	surface = function(data, vi)
		data[vi] = c_snowblock
	end,
})

lottmapgen.register_biome(21, {
	name = "Iron Hills",
	surface = function(data, vi)
		data[vi] = c_ironhillgrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(TREE10) == 2 then
			lottmapgen_beechtree(x, y, z, area, data)
		elseif math.random(TREE4) == 3 then
			lottmapgen_pinetree(x, y, z, area, data)
		elseif math.random(TREE6) == 4 then
			lottmapgen_firtree(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(22, {
	name = "Rhun",
	surface = function(data, vi)
		data[vi] = c_rhungrass
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random (PLANT3) == 4 then
			lottmapgen_grass(data, vi, p2data)
		elseif math.random(TREE9) == 1 then
			lottmapgen_defaulttree(x, y, z, area, data)
		elseif math.random(TREE10) == 1 then
			lottmapgen_appletree(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(23, {
	name = "Near Harad",
	surface = function(data, vi)
		data[vi] = c_desertsand
	end,
	deco = function(data, p2data, vi, area, x, y, z)
		if math.random(PLANT6) == 2 then
			data[vi] = c_dryshrub
		elseif math.random(TREE8) == 2 then
			lottmapgen_cactus(x, y, z, area, data)
		end
	end,
})

lottmapgen.register_biome(24, {
	name = "Far Harad",
	surface = function(data, vi)
		data[vi] = c_junglegrass
	end,
})

lottmapgen.register_biome(25, {
	name = "Wilderland",
	surface = function(data, vi)
		data[vi] = c_wildergrass
	end,
})
