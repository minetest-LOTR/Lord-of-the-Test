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

lottmapgen.register_biome(1, {
	name = "Forodwaith",
	surface = function(data, vi)
		data[vi] = c_angsnowblock
	end,
})

lottmapgen.register_biome(2, {
	name = "Angmar",
	surface = function(data, vi)
		data[vi] = c_dirtsnow
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
})

lottmapgen.register_biome(14, {
	name = "Mirkwood",
	surface = function(data, vi)
		data[vi] = c_mirkwoodgrass
	end,
})

lottmapgen.register_biome(15, {
	name = "Lorien",
	surface = function(data, vi)
		data[vi] = c_loriengrass
	end,
})

lottmapgen.register_biome(16, {
	name = "Fangorn",
	surface = function(data, vi)
		data[vi] = c_fangorngrass
	end,
})

lottmapgen.register_biome(17, {
	name = "Rohan",
	surface = function(data, vi)
		data[vi] = c_rohangrass
	end,
})

lottmapgen.register_biome(18, {
	name = "Gondor",
	surface = function(data, vi)
		data[vi] = c_gondorgrass
	end,
})

lottmapgen.register_biome(19, {
	name = "Mordor",
	surface = function(data, vi)
		data[vi] = c_morstone
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
})

lottmapgen.register_biome(22, {
	name = "Rhun",
	surface = function(data, vi)
		data[vi] = c_rhungrass
	end,
})

lottmapgen.register_biome(23, {
	name = "Near Harad",
	surface = function(data, vi)
		data[vi] = c_desertsand
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
