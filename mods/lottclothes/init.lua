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
dofile(minetest.get_modpath(minetest.get_current_modname()).."/fabrics.lua")

-- clothing types
dofile(minetest.get_modpath(minetest.get_current_modname()).."/midgewater.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/chetwood.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/hobbit.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/brandybuck.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/ettenmoor.lua")
