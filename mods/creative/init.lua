
minetest.register_privilege("creative", {
	description = "Creative Mode",
	give_to_singleplayer= false,
})

creative = {}
creative.players = {}

-- Check for creative mode
function creative.is_enabled_for(name)
	return minetest.settings:get_bool("creative_mode") or
		minetest.check_player_privs(name, {creative = true})
end

local modpath = minetest.get_modpath("creative")
dofile(modpath .. "/functions.lua")
dofile(modpath .. "/inventory.lua")