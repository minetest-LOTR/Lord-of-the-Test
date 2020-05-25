-- The mapgen itself!
-- Also biome definitions, etc...

local modpath = minetest.get_modpath("lottmapgen") .. "/mapgen"

minetest.register_node("lottmapgen:tmp", {
    description = "Tmp node for mapgen caves",
    drawtype = "airlike",
    tiles = {"blank.png"},
    wield_image = "blank.png",
    inventory_image = "unknown_item.png",
    sunlight_propagates = true,
    paramtype = "light",
    digable = false,
    pointable = false,
    walkable = false,
    groups = {not_in_creative_inventory = 1},
})

dofile(modpath .. "/biomes/init.lua")
dofile(modpath .. "/mapgen.lua")
