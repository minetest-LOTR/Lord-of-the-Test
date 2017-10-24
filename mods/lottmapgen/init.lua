local modpath = minetest.get_modpath("lottmapgen")

lottmapgen = {}
lottmapgen.biome = {}
lottmapgen.ores = {}
lottmapgen.schematics = {}
lottmapgen.buildings = {enqueue_building = function() end} -- REMOVE THIS LINE!!!

dofile(modpath .. "/technical/init.lua")
dofile(modpath .. "/mapgen/init.lua")
