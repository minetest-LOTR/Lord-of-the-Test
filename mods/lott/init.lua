-- The base of LOTT.
lott = {}

local modpath = minetest.get_modpath("lott")
dofile(modpath .. "/functions.lua")

minetest.set_mapgen_setting("mg_name", "singlenode", true)
