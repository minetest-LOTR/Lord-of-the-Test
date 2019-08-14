lottplayer = {}
lottplayer.textures = {}

local modpath = minetest.get_modpath("lottplayer")
dofile(modpath .. "/controls.lua")

minetest.register_privilege("immortal", {
	description = "Not affected by most effects.",
	give_to_singleplayer= false,
})

lottplayer.is_immortal = function(name)
	return minetest.check_player_privs(name, {immortal = true})
end

local cb_d = {-0.35, 0.0, -0.35, 0.35, 1.35, 0.35}
local cb_h = {-0.25, 0.0, -0.25, 0.25, 1.05, 0.25}
local cb_m = {-0.4, 0.0, -0.4, 0.4, 1.77, 0.4}
local cb_e = {-0.4, 0.0, -0.4, 0.4, 2.05, 0.4}

local vs_d = {x = 0.9, y = 0.8}
local vs_h = {x = 0.6, y = 0.6}
local vs_m = {x = 1, y = 1}
local vs_e = {x = 1.1, y = 1.2}

lottplayer.races = {
	{"dwarf_blue_mountains", 	0.08, 22, 1.2, false, cb_d, "mediumslateblue", {x = -24000, y = 60, z = 12000}, vs_d},
	{"dwarf_iron_hills", 		0.08, 20, 1.2, false, cb_d, "darksalmon", {x = 18400, y = 30, z = 7500}, vs_d},
	{"dwarf_misty_mountains",	0.08, 24, 1.2, false, cb_d, "wheat", {x = -1600, y = 30, z = -1200}, vs_d},
	{"elf_lindon", 				0.11, 22, 1.8, true, cb_e, "mediumspringgreen", {x = -25200, y = 30, z = 4700}, vs_e},
	{"elf_lorien", 				0.11, 24, 1.8, true, cb_e, "goldenrod", {x = 475, y = 30, z = -4175}, vs_e},
	{"elf_mirkwood", 			0.11, 26, 1.8, true, cb_e, "olive", {x = 7500, y = 30, z = 7000}, vs_e},
	{"hobbit_bree", 			0.06, 20, 0.95, false, cb_h, "limegreen", {x = -11680, y = 30, z = 2400}, vs_h},
	{"hobbit_shire", 			0.06, 20, 0.95, false, cb_h, "lawngreen", {x = -15400, y = 30, z = 2000}, vs_h},
	{"man_bree", 				0.1, 22, 1.625, false, cb_m, "forestgreen", {x = -11680, y = 30, z = 2400}, vs_m},
	{"man_dunland", 			0.1, 24, 1.625, false, cb_m, "yellowgreen", {x = -8000, y = 30, z = -8000}, vs_m},
	{"man_gondor", 				0.1, 26, 1.625, false, cb_m, "seagreen", {x = 4800, y = 30, z = -20800}, vs_m},
	{"man_harad", 				0.1, 26, 1.625, false, cb_m, "darkorange", {x = 20800, y = 30, z = -28800}, vs_m},
	{"man_rhun", 				0.1, 22, 1.625, false, cb_m, "darkred", {x = 27200, y = 30, z = 2200}, vs_m},
	{"man_rohan",				0.1, 24, 1.625, false, cb_m, "darkgoldenrod", {x = 900, y = 30, z = -12200}, vs_m},
	{"orc_angmar", 				0.1, 28, 1.625, false, cb_m, "darkslategrey", {x = -5000, y = 30, z = 10000}, vs_m},
	{"orc_misty_mountains", 	0.1, 28, 1.625, false, cb_m, "dimgrey", {x = 0, y = 30, z = 4000}, vs_m},
	{"orc_mordor", 				0.1, 30, 1.625, false, cb_m, "black", {x = 16000, y = 30, z = -16000}, vs_m},
}

minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			hand = {times={[1]=0, [2]=0.25, [3]=0.5}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	}
})

lottplayer.player_exists = function(player)
	if player == nil or player:get_player_name() == "" or player:get_player_name() == nil then
		return true
	end
end

dofile(modpath .. "/systems/hunger.lua")
dofile(modpath .. "/systems/stamina.lua")
dofile(modpath .. "/effects/physics.lua")
dofile(modpath .. "/handlers/helpers.lua")
dofile(modpath .. "/handlers/player.lua")
dofile(modpath .. "/systems/hp.lua")
dofile(modpath .. "/effects/hud.lua")
dofile(modpath .. "/handlers/others.lua")
dofile(modpath .. "/race_texts.lua")
dofile(modpath .. "/spawn.lua")