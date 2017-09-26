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

-- Load files
local default_path = minetest.get_modpath("default")

dofile(default_path.."/chatcommands.lua")
dofile(default_path.."/crafting.lua")
dofile(default_path.."/craftitems.lua")
dofile(default_path.."/functions.lua")
dofile(default_path.."/legacy.lua")
dofile(default_path.."/mapgen.lua")
dofile(default_path.."/nodes.lua")
dofile(default_path.."/player.lua")
dofile(default_path.."/tools.lua")
dofile(default_path.."/torch.lua")
dofile(default_path.."/trees.lua")
