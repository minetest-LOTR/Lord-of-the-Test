local modpath = minetest.get_modpath("lottitems") .. "/base_nodes"

dofile(modpath .. "/base.lua")
dofile(modpath .. "/base_shapes.lua")
dofile(modpath .. "/liquids.lua")
dofile(modpath .. "/torches.lua")

minetest.register_alias("mapgen_stone", "lottitems:stone")
