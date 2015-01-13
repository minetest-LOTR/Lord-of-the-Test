NPCF_MODPATH = minetest.get_modpath(minetest.get_current_modname())
NPCF_DATADIR = minetest.get_worldpath().."/npc_data"
dofile(NPCF_MODPATH.."/npcf.lua")
dofile(NPCF_MODPATH.."/chatcommands.lua")