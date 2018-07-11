local lott_sta = {}
local lott_sta_players = {}

local LOTT_STAMINA = 20 -- default stamina
local LOTT_STAMINA_MAX = 20 -- default max stamina
local LOTT_STAMINA_REGEN = 2 -- default time before stamina starts regaining

local LOTT_STAMINA_REGEN_AMT = 1 -- stamina regen rate / amount
local LOTT_STAMINA_REGEN_INT = 2 -- stamina regen rate / interval
local LOTT_STAMINA_MULTIPLIER = 1 -- stamina multiplier / amount * multiplier
local LOTT_STAMINA_MOVE_TIMER = 0.5 -- rate of globalstep function that checks for movement

local LOTT_STAMINA_JUMP = 5 -- approx. amount of continuous jumps before reducing stamina
local LOTT_STAMINA_JUMP_AMT = -1 -- amount of stamina reduced when jumping

if not minetest.settings:get_bool("enable_damage") then
	return
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if player:get_attribute("lott:stamina") == nil then
		player:set_attribute("lott:stamina", LOTT_STAMINA)
	end
	if player:get_attribute("lott:stamina_max") == nil then
		player:set_attribute("lott:stamina_max", LOTT_STAMINA_MAX)
	end
	if player:get_attribute("lott:stamina_multi") == nil then
		player:set_attribute("lott:stamina_multi", LOTT_STAMINA_MULTIPLIER)
	end
	if player:get_attribute("lott:stamina_regen") == nil then
		player:set_attribute("lott:stamina_regen", LOTT_STAMINA_REGEN)
	end
	local cursta = tonumber(player:get_attribute("lott:stamina"))
	local maxsta = tonumber(player:get_attribute("lott:stamina_max"))

	lott_sta_players[name] = {}
	lott_sta_players[name].level = 0
	lott_sta_players[name].jump = 0
	minetest.after(0, function()
	lott_sta[name.."_sta_bg"] = player:hud_add({
		hud_elem_type = "statbar",
		position = LOTT_HUD_POS,
		text = "bg.png",
		number = maxsta,
		size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
		offset = { x = -220, y = -110 },
		direction = 0,
	})
	if lott_sta[name .. "_sta_bg"] == 0 then
		minetest.chat_send_all("ID of Stamina BG = 0")
	end
	lott_sta[name.."_sta"] = player:hud_add({
		hud_elem_type = "statbar",
		position = LOTT_HUD_POS,
		text = "stamina.png",
		number = cursta,
		size = { x=LOTT_HUD_SIZE, y=LOTT_HUD_SIZE },
		offset = { x = -220, y = -110 },
		direction = 0,
	})
	end)
end)

lottplayer.add_stamina = function(player, value)
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end

	local cursta = tonumber(player:get_attribute("lott:stamina"))
	local maxsta = tonumber(player:get_attribute("lott:stamina_max"))

	if value == "max" then
		player:set_attribute("lott:stamina", maxsta)
		player:hud_change(lott_sta[name.."_sta"], "number", maxsta)
		return
	end

	if value == "none" then
		player:set_attribute("lott:stamina", 0)
		player:hud_change(lott_sta[name.."_sta"], "number", 0)
		return
	end

	local newsta = cursta + value
	if newsta < 0 then
		player:set_attribute("lott:stamina", 0)
		player:hud_change(lott_sta[name.."_sta"], "number", 0)
		return
	end

	if newsta <= maxsta then
		player:set_attribute("lott:stamina", newsta)
		player:hud_change(lott_sta[name.."_sta"], "number", newsta)

	elseif newsta > maxsta then
		player:set_attribute("lott:stamina", maxsta)
		player:hud_change(lott_sta[name.."_sta"], "number", maxsta)
	end
end

local timer = 0
local regen_timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;

	if timer >= LOTT_STAMINA_REGEN_INT then
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()

			if lottplayer.is_immortal(name) then
				return
			end

			local cursta = tonumber(player:get_attribute("lott:stamina"))
			local curhun = tonumber(player:get_attribute("lott:hunger"))
			if curhun >= 20 then
				stamina_regen_amt = LOTT_STAMINA_REGEN_AMT
			elseif curhun < 20 then
				stamina_regen_amt = (curhun / 20) * LOTT_STAMINA_REGEN_AMT
			end

			local amtsta = stamina_regen_amt * LOTT_STAMINA_MULTIPLIER
			if lott_sta_players[name].level <= 0 then
				lottplayer.add_stamina(player, amtsta)
			end
		end
		timer = 0
	end
end)

local function prevent_sta_regen(player)
	if not player or not player:is_player() then
		return
	end

	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end

	lott_sta_players[name].level = lott_sta_players[name].level + 1

	minetest.after(tonumber(player:get_attribute("lott:stamina_regen")), function()
		if lott_sta_players[name].level ~= 0 then
			lott_sta_players[name].level = lott_sta_players[name].level - 1
		end
	end)
end

lottplayer.regen_stamina_level = function(player, value)
	local name = player:get_player_name()
	lott_sta_players[name].level = value
end

minetest.register_on_placenode(function(pos, newnode, player, oldnode, itemstack, pointed_thing)
	prevent_sta_regen(player)
end)

minetest.register_on_dignode(function(pos, oldnode, player)
	prevent_sta_regen(player)
end)

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	prevent_sta_regen(player)
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	if lottplayer.is_immortal(name) then
		return
	end

	lott_sta_players[name].level = 0
	lott_sta_players[name].jump = 0
	lottplayer.add_stamina(player, "max")
end)

controls.register_on_hold(function(player,key,time)
	prevent_sta_regen(player)
end)

local move_timer = 0
minetest.register_globalstep(function(dtime)
	move_timer = move_timer + dtime;

	if move_timer >= LOTT_STAMINA_MOVE_TIMER then
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()

			if lottplayer.is_immortal(name) then
				return
			end

			--- check for controls
			local controls = player:get_player_control()
			if controls.jump then
				lott_sta_players[name].jump = lott_sta_players[name].jump + 1
				prevent_sta_regen(player)
				if lott_sta_players[name].jump >= LOTT_STAMINA_JUMP then
					lottplayer.add_stamina(player, LOTT_STAMINA_JUMP_AMT)
					lott_sta_players[name].jump = 0
				end
			end

			local cursta = tonumber(player:get_attribute("lott:stamina"))
			local maxsta = tonumber(player:get_attribute("lott:stamina_max"))

			if controls.aux1 and controls.up and cursta > 0 then
				-- sprinting particles -- taken from https://github.com/minetest-mods/stamina
				local pos = player:getpos()
				local node = minetest.get_node({
				x = pos.x, y = pos.y - 1, z = pos.z})

				if node.name ~= "air" then
					minetest.add_particlespawner({
						amount = 5,
						time = 0.01,
						minpos = {x = pos.x - 0.25, y = pos.y + 0.1, z = pos.z - 0.25},
						maxpos = {x = pos.x + 0.25, y = pos.y + 0.1, z = pos.z + 0.25},
						minvel = {x = -0.5, y = 1, z = -0.5},
						maxvel = {x = 0.5, y = 2, z = 0.5},
						minacc = {x = 0, y = -5, z = 0},
						maxacc = {x = 0, y = -12, z = 0},
						minexptime = 0.25,
						maxexptime = 1.0,
						minsize = 0.5,
						maxsize = 1.0,
						vertical = false,
						collisiondetection = false,
						texture = "lottitems_dirt.png",
					})
				end

				if not minetest.check_player_privs(player, {fast = true}) then
					-- sprint function
				end
			end

		end
		move_timer = 0
	end
end)
