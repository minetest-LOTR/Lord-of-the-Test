lottplayer = {}
lottplayer.textures = {}

local modpath = minetest.get_modpath("lottplayer")
dofile(modpath .. "/physics.lua")
dofile(modpath .. "/controls.lua")

dofile(modpath .. "/inv/inventory.lua")
dofile(modpath .. "/inv/inventory_left.lua")
dofile(modpath .. "/inv/list.lua")
dofile(modpath .. "/inv/helpers.lua")

minetest.register_privilege("immortal", {
	description = "Not affected by most effects.",
	give_to_singleplayer= false,
})

lottplayer.is_immortal = function(name)
	return minetest.check_player_privs(name, {immortal = true})
end

-- Player stats and animations
local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}
lottplayer.player_attached = {}

-- Standard animations.
local animations = {
	stand     = {x = 0,   y = 79},
	lay       = {x = 162, y = 166},
	walk      = {x = 168, y = 187},
	mine      = {x = 189, y = 198},
	walk_mine = {x = 200, y = 219},
	sit       = {x = 81,  y = 160},
}

function lottplayer.get_animation(player)
	local name = player:get_player_name()
	return {
		model = player_model[name],
		textures = player_textures[name],
		animation = player_anim[name],
	}
end

function lottplayer.set_animation(player, anim_name, speed)
	local name = player:get_player_name()
	if player_anim[name] == anim_name then
		return
	end
	player_anim[name] = anim_name
	player:set_animation(animations[anim_name], speed or 30, 0)
end

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_model[name] = nil
	player_anim[name] = nil
	player_textures[name] = nil
end)

-- Localize for better performance.
local player_set_animation = lottplayer.set_animation
local player_attached = lottplayer.player_attached

-- Check each player and apply animations
minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		if not player_attached[name] then
			local controls = player:get_player_control()
			local walking = false
			local animation_speed_mod = 30

			-- Determine if the player is walking
			if controls.up or controls.down or controls.left or controls.right then
				walking = true
			end

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 2
			end

			-- Apply animations based on what the player is doing
			if player:get_hp() == 0 then
				player_set_animation(player, "lay")
			elseif walking then
				if player_sneak[name] ~= controls.sneak then
					player_anim[name] = nil
					player_sneak[name] = controls.sneak
				end
				if controls.LMB then
					player_set_animation(player, "walk_mine", animation_speed_mod)
				else
					player_set_animation(player, "walk", animation_speed_mod)
				end
			elseif controls.LMB then
				player_set_animation(player, "mine")
			else
				player_set_animation(player, "stand", animation_speed_mod)
			end
		end
	end
end)

local cb_d = {-0.35, 0.0, -0.35, 0.35, 1.35, 0.35}
local cb_h = {-0.25, 0.0, -0.25, 0.25, 1.05, 0.25}
local cb_m = {-0.4, 0.0, -0.4, 0.4, 1.77, 0.4}
local cb_e = {-0.4, 0.0, -0.4, 0.4, 2.05, 0.4}

lottplayer.races = {
	{"dwarf_blue_mountains", "dwarf_character", 22, 1.2, false, cb_d,
		"mediumslateblue", {x = -24000, y = 60, z = 12000}},
	{"dwarf_iron_hills", "dwarf_character", 20, 1.2, false, cb_d,
		"darksalmon", {x = 18400, y = 30, z = 7500}},
	{"dwarf_misty_mountains", "dwarf_character", 24, 1.2, false, cb_d,
		"wheat", {x = -1600, y = 30, z = -1200}},
	{"elf_lindon", "elf_character", 22, 1.8, true, cb_e,
		"mediumspringgreen", {x = -25200, y = 30, z = 4700}},
	{"elf_lorien", "elf_character", 24, 1.8, true, cb_e,
		"goldenrod", {x = 475, y = 30, z = -4175}},
	{"elf_mirkwood", "elf_character", 26, 1.8, true, cb_e,
		"olive", {x = 7500, y = 30, z = 7000}},
	{"hobbit_bree", "hobbit_character", 20, 0.95, false, cb_h,
		"limegreen", {x = -11680, y = 30, z = 2400}},
	{"hobbit_shire", "hobbit_character", 20, 0.95, false, cb_h,
		"lawngreen", {x = -15400, y = 30, z = 2000}},
	{"man_bree", "human_character", 22, 1.625, false, cb_m,
		"forestgreen", {x = -11680, y = 30, z = 2400}},
	{"man_dunland", "human_character", 24, 1.625, false, cb_m,
		"yellowgreen", {x = -8000, y = 30, z = -8000}},
	{"man_gondor", "human_character", 26, 1.625, false, cb_m,
		"seagreen", {x = 4800, y = 30, z = -20800}},
	{"man_harad", "human_character", 26, 1.625, false, cb_m,
		"darkorange", {x = 20800, y = 30, z = -28800}},
	{"man_rhun", "human_character", 22, 1.625, false, cb_m,
		"darkred", {x = 27200, y = 30, z = 2200}},
	{"man_rohan", "human_character", 24, 1.625, false, cb_m,
		"darkgoldenrod", {x = 900, y = 30, z = -12200}},
	{"orc_angmar", "human_character", 28, 1.625, false, cb_m,
		"darkslategrey", {x = -5000, y = 30, z = 10000}},
	{"orc_misty_mountains", "human_character", 28, 1.625, false, cb_m,
		"dimgrey", {x = 0, y = 30, z = 4000}},
	{"orc_mordor", "human_character", 30, 1.625, false, cb_m,
		"black", {x = 16000, y = 30, z = -16000}},
}

minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			hand = {times = {[1] = 0, [2] = 0.25, [3] = 0.5}, uses = 0, maxlevel = 0},
			axe = {times = {[1] = 3}, uses = 0, maxlevel = 0},
		},
		damage_groups = {fleshy=1},
	}
})

--minetest.PLAYER_MAX_HP_DEFAULT = 30
local function change_clouds(player, cloud_def)
	local clouds_changing = player:get_attribute("lottplayer:clouds_changing")
	if clouds_changing == "true" then
		return false
	end
	local current_clouds = player:get_clouds()
	for i = 0, 40, 2 do
		minetest.after(i, function()
			if not player then
				return
			end
			local clouds = {}
			if cloud_def.density then
				local d = current_clouds.density +
					(cloud_def.density - current_clouds.density) * (i / 40)
				clouds.density = d
			end
			if cloud_def.thickness then
				local t = current_clouds.thickness +
					(cloud_def.thickness - current_clouds.thickness) * (i / 40)
				clouds.thickness = t
			end
			if cloud_def.height then
				local h = current_clouds.height +
					(cloud_def.height - current_clouds.height) * (i / 40)
				clouds.height = h
			end
			if cloud_def.color then
				local parts = {"r", "g", "b", "a"}
				local new_color = {}
				for _, c in pairs(parts) do
					local nc = current_clouds.color[c] +
						(cloud_def.color[c] - current_clouds.color[c]) * (i / 40)
					new_color[c] = nc
				end
				clouds.color = new_color
			end
			player:set_clouds(clouds)
			if i == 40 then
				player:set_attribute("lottplayer:clouds_changing", "false")
				local new_biome = player:get_attribute("lottplayer:cloud_change")
				if new_biome ~= "" then
					new_biome = tonumber(new_biome)
					if lottmapgen.biome[new_biome]
					and lottmapgen.biome[new_biome].clouds then
						change_clouds(player, lottmapgen.biome[new_biome].clouds)
					end
					player:set_attribute("lottplayer:cloud_change", "")
				end
			end
		end)
	end
	player:set_attribute("lottplayer:clouds_changing", "true")
	return true
end

local huds = {}
local biomes = {}

local t = 0
local t2 = 0
minetest.register_globalstep(function(dtime)
	t = t + dtime
	t2 = t2 + dtime
	if t > 5 then
		t = 0
		for _, player in pairs(minetest.get_connected_players()) do
			local id, biome = lottmapgen.get_biome_at_pos(player:get_pos())
			if not id or not biome then
				return
			end
			local name = player:get_player_name()
			if not biomes[name] then
				biomes[name] = id
			end
			if biomes[name] ~= id and huds[name] then
				biomes[name] = id
				player:hud_change(huds[name], "text", "Current Biome: " .. biome)
				if lottmapgen.biome[id] and lottmapgen.biome[id].clouds then
					local res = change_clouds(player, lottmapgen.biome[id].clouds)
					if not res then
						player:set_attribute("lottplayer:cloud_change", id)
					end
				else
					change_clouds(player, {density = 0.4, thickness = 16, color = {
						r = 255,
						g = 240,
						b = 240,
						a = 229}, height = 120
					})
				end
			end
			if not huds[name] then
				huds[name] = player:hud_add({
					hud_elem_type = "text",
					position = {x=0.13, y=0.9},
					name = "biome",
					text = "Current Biome: " .. biome,
					number = 0xFFFFFF,
				})
			end
		end
	end
end)

dofile(modpath .. "/race_texts.lua")
dofile(modpath .. "/races.lua")
dofile(modpath .. "/systems/hp.lua")
dofile(modpath .. "/systems/hunger.lua")
dofile(modpath .. "/systems/stamina.lua")
