local lott_hun = {}
local lott_hun_players = {}

local LOTT_HUNGER = 24 -- default hunger
local LOTT_HUNGER_MAX = 24 -- default max hunger
local LOTT_HUNGER_INTERVAL = 180 -- time before hunger is reduced by 1

local LOTT_HUNGER_PLACED = 99 -- amount of blocks placed before reducing hunger
local LOTT_HUNGER_PLACED_AMT = -1 -- amount of hunger reduced when placing blocks

local LOTT_HUNGER_DUG = 99 -- amount of blocks dug before reducing hunger
local LOTT_HUNGER_DUG_AMT = -1 -- amount of hunger reduced when digging blocks

local LOTT_HUNGER_CRAFTED = 99 -- amount of blocks crafted before reducing hunger
local LOTT_HUNGER_CRAFTED_AMT = -1 -- amount of hunger reduced when crafting blocks

if not minetest.setting_getbool("enable_damage") then
	return
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end
	
	if player:get_attribute("lott:hunger") == nil then
		player:set_attribute("lott:hunger", LOTT_HUNGER)
	end
	if player:get_attribute("lott:hunger_max") == nil then
		player:set_attribute("lott:hunger_max", LOTT_HUNGER_MAX)
	end
	local curhun = tonumber(player:get_attribute("lott:hunger"))
	local maxhun = tonumber(player:get_attribute("lott:hunger_max"))
	
	lott_hun_players[name] = {}
	lott_hun_players[name].placed = 0
	lott_hun_players[name].dug = 0
	lott_hun_players[name].crafted = 0
	lott_hun_players[name].eat = 0
	lott_hun_players[name].eatitem = nil
	
	if maxhun <= 20 then
		lott_hun[name.."_hun_bg"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "bg.png",
			number = maxhun,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = 46, y = -87 },
			direction = 0,
		})
	elseif maxhun > 20 then
		lott_hun[name.."_hun_bg"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "bg.png",
			number = 20,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = 46, y = -87 },
			direction = 0,
		})
	end
	
	if curhun <= 20 then
		lott_hun[name.."_hun"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "hunger.png",
			number = curhun,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = 46, y = -87 },
			direction = 0,
		})
		
	elseif curhun > 20 then
		lott_hun[name.."_hun"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "hunger.png",
			number = 20,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = 46, y = -87 },
			direction = 0,
		})
		
		lott_hun[name.."_hun_2"] = player:hud_add({
			hud_elem_type = "statbar",
			position = LOTT_HUD_POS,
			text = "hunger_2.png",
			number = curhun - 20,
			size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
			offset = { x = 46, y = -87 },
			direction = 0,
		})
	end
end)

lottplayer.add_hunger = function(player, value)
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end
	
	local curhun = tonumber(player:get_attribute("lott:hunger"))
	local maxhun = tonumber(player:get_attribute("lott:hunger_max"))
	
	if value == "max" then
		player:set_attribute("lott:hunger", maxhun)
		if maxhun <= 20 then
			player:set_attribute("lott:hunger", maxhun)
			player:hud_change(lott_hun[name.."_hun"], "number", maxhun)
		elseif maxhun > 20 then
			player:set_attribute("lott:hunger", maxhun)
			player:hud_change(lott_hun[name.."_hun"], "number", 20)
			player:hud_remove(lott_hun[name.."_hun_2"])
			
			lott_hun[name.."_hun_2"] = player:hud_add({
				hud_elem_type = "statbar",
				position = LOTT_HUD_POS,
				text = "hunger_2.png",
				number = maxhun - 20,
				size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
				offset = { x = 46, y = -87 },
				direction = 0,
			})
			
			player:hud_change(lott_hun[name.."_hun_2"], "number", maxhun - 20)
		end
		return
	end
	
	if value == "none" then
		player:set_attribute("lott:hunger", 0)
		player:hud_remove(lott_hun[name.."_hun_2"])
		player:hud_change(lott_hun[name.."_hun"], "number", 0)
		return
	end
	
	local newhun = curhun + value
	if newhun < 0 then
		player:set_attribute("lott:hunger", 0)
		player:hud_remove(lott_hun[name.."_hun_2"])
		player:hud_change(lott_hun[name.."_hun"], "number", 0)
		return
	end
	
	if maxhun <= 20 then
		if newhun <= maxhun then
			player:set_attribute("lott:hunger", newhun)
			player:hud_change(lott_hun[name.."_hun"], "number", newhun)
		elseif newhun > maxhun then
			player:set_attribute("lott:hunger", maxhun)
			player:hud_change(lott_hun[name.."_hun"], "number", maxhun)
		end

	elseif maxhun > 20 then
		if newhun <= 20 then
			player:set_attribute("lott:hunger", newhun)
			player:hud_remove(lott_hun[name.."_hun_2"])
			player:hud_change(lott_hun[name.."_hun"], "number", newhun)
			
		elseif newhun > 20 then
			if newhun <= maxhun then
				if curhun > 20 then
					player:set_attribute("lott:hunger", newhun)
					player:hud_change(lott_hun[name.."_hun"], "number", 20)
					player:hud_change(lott_hun[name.."_hun_2"], "number", newhun - 20)
				elseif curhun <= 20 then
					player:set_attribute("lott:hunger", newhun)
					player:hud_change(lott_hun[name.."_hun"], "number", 20)
					
					lott_hun[name.."_hun_2"] = player:hud_add({
						hud_elem_type = "statbar",
						position = LOTT_HUD_POS,
						text = "hunger_2.png",
						number = newhun - 20,
						size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
						offset = { x = 46, y = -87 },
						direction = 0,
					})
				end
			elseif newhun > maxhun then
				if curhun > 20 then
					player:set_attribute("lott:hunger", maxhun)
					player:hud_change(lott_hun[name.."_hun"], "number", 20)
					player:hud_change(lott_hun[name.."_hun_2"], "number", maxhun - 20)
				elseif curhun <= 20 then
					player:set_attribute("lott:hunger", maxhun)
					player:hud_change(lott_hun[name.."_hun"], "number", 20)
					
					lott_hun[name.."_hun_2"] = player:hud_add({
						hud_elem_type = "statbar",
						position = LOTT_HUD_POS,
						text = "hunger_2.png",
						number = maxhun - 20,
						size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
						offset = { x = 46, y = -87 },
						direction = 0,
					})
				end
			end
		end
	end
end


core.do_item_eat = function(hp_change, replace_with_item, itemstack, user, pointed_thing)
	local old_itemstack = itemstack
	itemstack = lottplayer.eat(hp_change, replace_with_item, itemstack, user, pointed_thing)
	for _, callback in pairs(core.registered_on_item_eats) do
		local result = callback(hp_change, replace_with_item, itemstack, user, pointed_thing, old_itemstack)
		if result then
			return result
		end
	end
	return itemstack
end

function lottplayer.eat(hp_change, replace_with_item, itemstack, user, pointed_thing)
	if not itemstack then
		return itemstack
	end

	if not user then
		return itemstack
	end
	
	local name = user:get_player_name()
	lott_hun_players[name].eat = os.clock()
	lott_hun_players[name].eatparticles = os.clock()
	lott_hun_players[name].eatitem = user:get_wielded_item():get_name()
	print(user:get_attribute("lott:hunger"))
	
	if user:get_attribute("lott:hunger") == user:get_attribute("lott:hunger_max") then
		return
	end
	
	controls.register_on_hold(function(player, key, time)
		if key == "LMB" and lott_hun_players[name].eatitem ~= nil then
			if player:get_attribute("lott:hunger") == player:get_attribute("lott:hunger_max") then
				return
			end
			
			local wielditem = player:get_wielded_item()
			local name = player:get_player_name()
			if wielditem:get_name() == lott_hun_players[name].eatitem then
				if os.clock() - lott_hun_players[name].eatparticles >= 1 then
					lott_hun_players[name].eatparticles = os.clock()
					minetest.sound_play("stamina_eat", {to_player = name, gain = 0.1})
					
					local pos = player:getpos()
					pos.y = pos.y + 1.5
					local dir = player:get_look_dir()
					
					minetest.add_particlespawner({
						amount = 8,
						time = 1.5,
						minpos = pos,
						maxpos = pos,
						minvel = {x = dir.x - 0.5, y = dir.y, z = dir.z - 0.5},
						maxvel = {x = dir.x + 0.5, y = dir.y, z = dir.z + 0.5},
						minacc = {x = 0, y = -2, z = 0},
						maxacc = {x = 0, y = -6, z = 0},
						minexptime = 0.1,
						maxexptime = 0.5,
						minsize = 1,
						maxsize = 2,
						texture = minetest.registered_items[wielditem:get_name()].inventory_image,
					})
				end
					
				if os.clock() - lott_hun_players[name].eat >= hp_change then
					print(user:get_attribute("lott:hunger"))
					minetest.sound_play("stamina_eat", {to_player = name, gain = 0.1})
					lott_hun_players[name].eat = 0
					lott_hun_players[name].eatparticles = 0
					lott_hun_players[name].eatitem = nil
					lottplayer.add_hunger(player, hp_change)
					if not creative.is_enabled_for(name) then
						player:set_wielded_item(wielditem:get_name().." "..wielditem:get_count()-1)
					end
				end
			end
		end
	end)
	
	controls.register_on_release(function(player, key, time)
		if key == "LMB" then
			lott_hun_players[name].eat = 0
			lott_hun_players[name].eatitem = nil
		end
	end)

	if replace_with_item then
		if itemstack:is_empty() then
			itemstack:add_item(replace_with_item)
		else
			local inv = user:get_inventory()
			if inv:room_for_item("main", {name=replace_with_item}) then
				inv:add_item("main", replace_with_item)
			else
				pos.y = math.floor(pos.y - 1.0)
				core.add_item(pos, replace_with_item)
			end
		end
	end
	
	return itemstack
end

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	
	if timer >= LOTT_HUNGER_INTERVAL then
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if lottplayer.is_immortal(name) then
				return
			end

			lottplayer.add_hunger(player, -1)
		end
		timer = 0
	end
end)

minetest.register_on_placenode(function(pos, newnode, player, oldnode, itemstack, pointed_thing)
	if not player or not player:is_player() then
		return
	end
	
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end
	
	lott_hun_players[name].placed = lott_hun_players[name].placed + 1
	
	if lott_hun_players[name].placed >= LOTT_HUNGER_PLACED then
		lott_hun_players[name].placed = 0
		lottplayer.add_hunger(player, LOTT_HUNGER_PLACED_AMT)
	end
end)

minetest.register_on_dignode(function(pos, oldnode, player)
	if not player or not player:is_player() then
		return
	end
	
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end
	
	lott_hun_players[name].dug = lott_hun_players[name].dug + 1
	
	if lott_hun_players[name].dug >= LOTT_HUNGER_DUG then
		lott_hun_players[name].dug = 0
		lottplayer.add_hunger(player, LOTT_HUNGER_DUG_AMT)
	end
end)

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if not player or not player:is_player() then
		return
	end
	
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end
	
	lott_hun_players[name].crafted = lott_hun_players[name].crafted + 1
	
	if lott_hun_players[name].crafted >= LOTT_HUNGER_CRAFTED then
		lott_hun_players[name].crafted = 0
		lottplayer.add_hunger(player, LOTT_HUNGER_CRAFTED_AMT)
	end
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end
	
	lott_hun_players[name].placed = 0
	lott_hun_players[name].dug = 0
	lott_hun_players[name].crafted = 0
	lott_hun_players[name].eat = 0
	lott_hun_players[name].eatitem = nil
	
	lottplayer.add_hunger(player, "max")
end)