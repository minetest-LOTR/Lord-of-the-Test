dofile(minetest.get_modpath("lottthrowing").."/arrow.lua")
dofile(minetest.get_modpath("lottthrowing").."/axe.lua")
dofile(minetest.get_modpath("lottthrowing").."/bow.lua")

if minetest.setting_get("log_mods") then
	minetest.log("action", "lottthrowing loaded")
end
