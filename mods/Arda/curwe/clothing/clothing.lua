--------------------------------------------------------------------------------
-- clothes mod: brings additional clothing to the LOTT game
--------------------------------------------------------------------------------
-- HRtV 2014
-- version: 1.0
-- basics
--------------------------------------------------------------------------------

-- WEAR_BASE sets basic wear. Per level the decrease factor is substrated. 
-- armor_use=(WEAR_BASE-WEAR_DECREASE*level)
-- This makes developing clothes a little easier: You ony have to set the level
WEAR_BASE_HEAD  = 4000
WEAR_BASE_TORSO = 5000
WEAR_BASE_LEGS  = 4500
WEAR_BASE_FEET  = 3500
WEAR_DECREASE   = 500

-- crafting ingredients
dofile(minetest.get_modpath("curwe").."/clothing/fabrics.lua")

-- clothing types
dofile(minetest.get_modpath("curwe").."/clothing/midgewater.lua")
dofile(minetest.get_modpath("curwe").."/clothing/chetwood.lua")
dofile(minetest.get_modpath("curwe").."/clothing/hobbit.lua")
dofile(minetest.get_modpath("curwe").."/clothing/brandybuck.lua")
dofile(minetest.get_modpath("curwe").."/clothing/ettenmoor.lua")
