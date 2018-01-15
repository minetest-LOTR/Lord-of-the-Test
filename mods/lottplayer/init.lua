lottplayer = {}
lottplayer.textures = {}

local modpath = minetest.get_modpath("lottplayer")
dofile(modpath .. "/physics.lua")
dofile(modpath .. "/controls.lua")

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

local n_ter = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 543213,
	octaves = 4,
	persist = 0.7
}

local n_terflat = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 543213,
	octaves = 1,
	persist = 0.5
}

local n_x = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 3,
	persist = 0.
}

local n_z = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -5500,
	octaves = 3,
	persist = 0.5
}

local function spawn_player(pos, player)
	pos.x = pos.x + math.random(-100, 100)
	pos.z = pos.z + math.random(-100, 100)
	local nx = math.floor(minetest.get_perlin(n_x):get2d({x=pos.x,y=pos.z}) * 128) + pos.x
	local nz = math.floor(minetest.get_perlin(n_z):get2d({x=pos.x,y=pos.z}) * 128) + pos.z
	local height = lottmapgen.height(nx, nz)
	local t = minetest.get_perlin(n_ter):get2d({x=pos.x,y=pos.z})
	local tf = minetest.get_perlin(n_terflat):get2d({x=pos.x,y=pos.z})
	local y = math.floor(((t + 1)) *
		(height * math.abs(math.abs(tf / (height / 20)) - 1.01)))
	player:set_pos({x = pos.x, y = y + 2, z = pos.z})
end

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
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
})

-- Set the player's apperance and charictaristics on join
minetest.register_on_joinplayer(function(player)
	local first = false
	if not player:get_attribute("race") or player:get_attribute("race") == "" then
		local r = math.random(#lottplayer.races)
		player:set_attribute("race", r)
		first = true
	end
	local name = player:get_player_name()
	local race = tonumber(player:get_attribute("race"))
	lottplayer.player_attached[name] = false
	lottplayer.textures[name] = {lottplayer.races[race][1] .. ".png",
		"blank.png", "blank.png", "blank.png"},
	player:set_properties({
		physical = true,
		collides_with_objects = true,
		mesh = "lottplayer_" .. lottplayer.races[race][2] .. ".b3d",
		textures = {lottplayer.races[race][1] .. ".png", "blank.png", "blank.png", "blank.png"},
		visual = "mesh",
		visual_size = {x = 1, y = 1},
		hp_max = lottplayer.races[race][3],
		eye_height = lottplayer.races[race][4],
		can_zoom = lottplayer.races[race][5],
		collisionbox = lottplayer.races[race][6],
		nametag_color = lottplayer.races[race][7],
	})
	if first == true then
		spawn_player(lottplayer.races[race][8], player)
		player:set_hp(lottplayer.races[race][3])
	end
	player:set_local_animation(
		{x = 0,   y = 79},
		{x = 168, y = 187},
		{x = 189, y = 198},
		{x = 200, y = 219},
		30
	)
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)
--[[
minetest.after(3, function()
	for i,v in pairs(races) do
		minetest.chat_send_all(minetest.colorize(v[7], v[1]))
	end
end)]]

minetest.register_on_respawnplayer(function(player)
	local race = player:get_attribute("race")
	if not race or race == "" then
		return false
	end
	spawn_player(lottplayer.races[tonumber(race)][8], player)
	return true
end)

function minetest.send_join_message(name)
	if not minetest.is_singleplayer() then
		minetest.chat_send_all("*** " .. name .. " entered Middle Earth.")
	end
end

function minetest.send_leave_message(name, timed_out)
	if not minetest.is_singleplayer() then
		minetest.chat_send_all("*** " .. name .. " left Middle Earth.")
	end
end

minetest.register_on_chat_message(function(name, message)
	local player = minetest.get_player_by_name(name)
	if not player then
		return
	end
	local race = player:get_attribute("race")
	if not race or race == "" then
		return false
	end
	minetest.chat_send_all("<" .. minetest.colorize(lottplayer.races[tonumber(race)][7], name)
		.. "> " .. message)
	minetest.log("action", "CHAT: <" .. name .. "> " .. message)
	return true
end)

--minetest.PLAYER_MAX_HP_DEFAULT = 30

local huds = {}
local biomes = {}

local t = 0
minetest.register_globalstep(function(dtime)
	t = t + dtime
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

dofile(modpath .. "/systems/hp.lua")
dofile(modpath .. "/systems/hunger.lua")
dofile(modpath .. "/systems/stamina.lua")
