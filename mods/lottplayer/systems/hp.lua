-- TODO for systems
-- **(Depends on a proper effects api)
-- 0 stamina == no jump
-- < hunger == < speed / 0 hunger == slow crawl
-- add sprinting


local lott_hp = {}

LOTT_HUD_SIZE = 18
LOTT_HUD_POS = { x = 0.5, y = 1 }

minetest.register_on_joinplayer(function(player)
	local hud_flags = player:hud_get_flags()
	hud_flags.healthbar = false
	player:hud_set_flags(hud_flags)
end)

minetest.hud_replace_builtin("breath",	{
	hud_elem_type = "statbar",
	position = LOTT_HUD_POS,
	text = "bubble.png",
	number = 20,
	direction = 0,
	size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
	offset = { x = 46, y = -123 },
})

minetest.hud_replace_builtin("health",	{
	hud_elem_type = "statbar",
	position = LOTT_HUD_POS,
	text = "blank.png",
	number = 0,
	direction = 0,
	size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
	offset = { x = 46, y = -123 },
})

if not minetest.settings:get_bool("enable_damage") then
	return
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local maxhp = tonumber(player:get_properties().hp_max)
	local curhp = tonumber(player:get_hp())
	
	minetest.after(0, function()
	if maxhp > 20 then
		lott_hp[name.."_hp_bg"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "bg.png",
			number = 20,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = -220, y = -87 },
			direction = 0,
		})
	elseif maxhp <= 20 then
		lott_hp[name.."_hp_bg"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "bg.png",
			number = maxhp,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = -220, y = -87 },
			direction = 0,
		})
	end

	if maxhp <= 20 then
		lott_hp[name.."_hp"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "heart.png",
			number = curhp,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = -220, y = -87 },
			direction = 0,
		})
	end

	if maxhp > 20 then
		if curhp > 20 then
			lott_hp[name.."_hp"] = player:hud_add({
				hud_elem_type = "statbar",
				position = LOTT_HUD_POS,
				text = "heart.png",
				number = 20,
				size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
				offset = { x = -220, y = -87 },
				direction = 0,
			})

			lott_hp[name.."_hp_2"] = player:hud_add({
				hud_elem_type = "statbar",
				position = LOTT_HUD_POS,
				text = "heart_2.png",
				number = curhp - 20,
				size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
				offset = { x = -220, y = -102 },
				direction = 0,
			})
		elseif curhp <= 20 then
			lott_hp[name.."_hp"] = player:hud_add({
				hud_elem_type = "statbar",
				position = LOTT_HUD_POS,
				text = "heart.png",
				number = curhp,
				size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
				offset = { x = -220, y = -87 },
				direction = 0,
			})
		end
	end
	end)
end)

minetest.register_on_player_hpchange(function(player, hp_change)
	local name = player:get_player_name()
	local maxhp = tonumber(player:get_properties().hp_max)
	local curhp = tonumber(player:get_hp() + hp_change)

	if maxhp <= 20 then
		minetest.after(0.01, function()
			player:hud_change(lott_hp[name.."_hp"], "number", player:get_hp())
		end)
	elseif maxhp > 20 then
		if player:get_hp() > 20 then
			if lott_hp[name.."_hp_2"] == nil then
				lott_hp[name.."_hp_2"] = player:hud_add({
					hud_elem_type = "statbar",
					position = LOTT_HUD_POS,
					text = "heart_2.png",
					number = curhp - 20,
					size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
					offset = { x = -220, y = -102 },
					direction = 0,
				})
			end
		
			if curhp <= 20 then
				player:hud_remove(lott_hp[name.."_hp_2"])

				minetest.after(0.01, function()
					player:hud_change(lott_hp[name.."_hp"], "number", player:get_hp())
				end)
			elseif curhp > 20 then
				minetest.after(0.01, function()
					player:hud_change(lott_hp[name.."_hp_2"], "number", player:get_hp() - 20)
				end)
			end

		elseif player:get_hp() <= 20 then
			if curhp >= 20 then
				minetest.after(0.01, function()
					player:hud_change(lott_hp[name.."_hp"], "number", 20)
					lott_hp[name.."_hp_2"] = player:hud_add({
						hud_elem_type = "statbar",
						position = LOTT_HUD_POS,
						text = "heart_2.png",
						number = curhp - 20,
						size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
						offset = { x = -220, y = -102 },
						direction = 0,
					})
				end)
			elseif curhp < 20 then
				minetest.after(0.01, function()
					player:hud_change(lott_hp[name.."_hp"], "number", player:get_hp())
				end)
			end
		end
	end
end)
