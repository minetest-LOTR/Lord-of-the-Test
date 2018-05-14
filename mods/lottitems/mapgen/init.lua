local modpath = minetest.get_modpath("lottitems") .. "/mapgen"

dofile(modpath .. "/grasses.lua")
dofile(modpath .. "/ores.lua")

-- Special node that will get converted into ignore by schems.
minetest.register_node("lottitems:ignore", {
	description = "You Hacker You (LOTT Ignore)",
	tiles = {"ignore.png"},
	groups = {hidden = 1},
	drop = "",
})
