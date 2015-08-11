MULTISKIN_DEFAULT_SKIN = "character.png"
MULTISKIN_TRANS = "lottarmor_trans.png"

multiskin = {}

local skin_mod = nil
if minetest.get_modpath("skins") then
	skin_mod = "skins"
elseif minetest.get_modpath("simple_skins") then
	skin_mod = "simple_skins"
elseif minetest.get_modpath("u_skins") then
	skin_mod = "u_skins"
elseif minetest.get_modpath("wardrobe") then
	skin_mod = "wardrobe"
end

function multiskin:init(player)
	default.player_set_model(player, "lottarmor_character.b3d")
	local name = player:get_player_name()
	multiskin[name] = {
		skin = MULTISKIN_DEFAULT_SKIN,
		armor = MULTISKIN_TRANS,
		wielditem = MULTISKIN_TRANS,
		clothing = MULTISKIN_TRANS,
	}
	if skin_mod == "skins" then
		local skin = skins.skins[name]
		if skin and skins.get_type(skin) == skins.type.MODEL then
			multiskin[name].skin = skin..".png"
		end
	elseif skin_mod == "simple_skins" then
		local skin = skins.skins[name]
		if skin then
		    multiskin[name].skin = skin..".png"
		end
	elseif skin_mod == "u_skins" then
		local skin = u_skins.u_skins[name]
		if skin and u_skins.get_type(skin) == u_skins.type.MODEL then
			multiskin[name].skin = skin..".png"
		end
	elseif skin_mod == "wardrobe" then
		local skin = wardrobe.playerSkins[name]
		if skin then
			multiskin[name].skin = skin
		end
	end
	if minetest.get_modpath("player_textures") then
		local filename = minetest.get_modpath("player_textures").."/textures/player_"..name
		local f = io.open(filename..".png")
		if f then
			f:close()
			multiskin[name].skin = "player_"..name..".png"
		end
	end
end

function multiskin:update_player_visuals(player)
	if not player then
		return
	end
	local name = player:get_player_name()
	if multiskin[name] then
		default.player_set_textures(player, {
			multiskin[name].skin,
			multiskin[name].armor,
			multiskin[name].wielditem,
			multiskin[name].clothing,
		})
	end
end

function multiskin:get_skin_name(name)
	local skin = nil
	if skin_mod == "skins" or skin_mod == "simple_skins" then
		skin = skins.skins[name]
	elseif skin_mod == "u_skins" then
		skin = u_skins.u_skins[name]
	elseif skin_mod == "wardrobe" then
		skin = string.gsub(wardrobe.playerSkins[name], "%.png$","")
	end
	return skin or MULTISKIN_DEFAULT_SKIN
end

function multiskin:get_preview(name)
	if skin_mod == "u_skins" then
		return multiskin:get_skin_name(name).."_preview.png"
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	for field, _ in pairs(fields) do
		if string.find(field, "skins_set") then
			minetest.after(0, function(player)
				local skin = multiskin:get_skin_name(name)
				if skin then
					multiskin[name].skin = skin..".png"
					multiskin:update_player_visuals(player)
				end
			end, player)
		end
	end
end)

default.player_register_model("lottarmor_character.b3d", {
	animation_speed = 30,
	textures = {
		MULTISKIN_DEFAULT_SKIN,
		MULTISKIN_TRANS,
		MULTISKIN_TRANS,
		MULTISKIN_TRANS,
	},
	animations = {
		stand = {x=0, y=79},
		lay = {x=162, y=166},
		walk = {x=168, y=187},
		mine = {x=189, y=198},
		walk_mine = {x=200, y=219},
		sit = {x=81, y=160},
	},
})
