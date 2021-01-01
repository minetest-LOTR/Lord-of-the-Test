-- For easier editing, each biome has its own file.

-- Chance variables:
TREE1 = 30
TREE2 = 50
TREE3 = 100
TREE4 = 200
TREE5 = 300
TREE6 = 500
TREE7 = 750
TREE8 = 1000
TREE9 = 2000
TREE10 = 5000

PLANT1 = 3
PLANT2 = 5
PLANT3 = 10
PLANT4 = 20
PLANT5 = 50
PLANT6 = 100
PLANT7 = 200
PLANT8 = 500
PLANT9 = 750
PLANT10 = 1000
PLANT11 = 2000
PLANT12 = 5000
PLANT13 = 10000
PLANT14 = 100000
PLANT15 = 500000

BUILDING1 = 50000
BUILDING2 = 100000
BUILDING3 = 250000
BUILDING4 = 500000
BUILDING5 = 1000000

local modpath = minetest.get_modpath("lottmapgen") .. "/mapgen/biomes/"

dofile(modpath .. "angmar.lua")
dofile(modpath .. "arthedain.lua")
dofile(modpath .. "blue_mountains.lua")
dofile(modpath .. "breeland.lua")
dofile(modpath .. "dunland.lua")
dofile(modpath .. "enedwaith.lua")
dofile(modpath .. "eregion.lua")
dofile(modpath .. "ettenmoors.lua")
dofile(modpath .. "fangorn.lua")
dofile(modpath .. "forodwaith.lua")
dofile(modpath .. "gondor.lua")
dofile(modpath .. "iron_hills.lua")
dofile(modpath .. "lindon.lua")
dofile(modpath .. "lorien.lua")
dofile(modpath .. "minhiriath.lua")
dofile(modpath .. "mirkwood.lua")
dofile(modpath .. "misty_mountains.lua")
dofile(modpath .. "mordor.lua")
dofile(modpath .. "near_harad.lua")
dofile(modpath .. "rhun.lua")
dofile(modpath .. "rohan.lua")
dofile(modpath .. "shire.lua")
dofile(modpath .. "white_mountains.lua")
dofile(modpath .. "wilderland.lua")

