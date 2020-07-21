-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into doc/lua_api.txt

WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14
SAVEDIR = "LOTT"

-- Definitions made by this mod that other mods can use too
default = {}
default.gui_bg     = ""
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots  = "listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"

-- Load files
dofile(minetest.get_modpath("default").."/chatcommands.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/legacy.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/torches.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
