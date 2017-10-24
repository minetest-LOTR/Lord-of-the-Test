-- The mapgen itself!
-- Also biome definitions, etc...

local modpath = minetest.get_modpath("lottmapgen") .. "/mapgen"

dofile(modpath .. "/biomes.lua")
dofile(modpath .. "/mapgen.lua")