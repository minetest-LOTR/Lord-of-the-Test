-- Weather:
-- * rain
-- * snow
-- * wind (not implemented)

assert(minetest.add_particlespawner, "I told you to run the latest GitHub!")
assert(minetest.get_heat, "I told you to run the latest GitHub!")

addvectors = function (v1, v2)
	return {x=v1.x+v2.x, y=v1.y+v2.y, z=v1.z+v2.z}
end

local cloud_height = tonumber(minetest.setting_get("cloud_height"));

get_snow = function (p)
	if not p then return 0 end
	if p.y > cloud_height then return 0 end
	local heat = minetest.get_heat(p)
	if heat >= 0 then return 0 end
	local humidity = minetest.get_humidity(p)
	if humidity < 60 then return 0 end
	--print('S h='..minetest.get_heat(p)..' h='..minetest.get_humidity(p))
	return 100/humidity
end

get_rain = function (p)
	if not p then return 0 end
	if p.y > cloud_height then return 0 end
	local heat = minetest.get_heat(p)
	if heat <= 0 then return 0 end
	if heat > 50 then return 0 end
	local humidity = minetest.get_humidity(p)
	if humidity < 60 then return 0 end
	--print('R h='..minetest.get_heat(p)..' h='..minetest.get_humidity(p))
	return 100/humidity
end

if minetest.setting_getbool("weather") then
	if minetest.setting_getbool("weather") and minetest.setting_getbool("liquid_finite") then
		dofile(minetest.get_modpath("weather").."/rain.lua")
	end
	dofile(minetest.get_modpath("weather").."/snow.lua")
end
