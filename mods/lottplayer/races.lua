local modpath = minetest.get_modpath("lottplayer")

-- Function to set a player's skin, texture, etc. based on their race.
local function set_player_props(race, player)
	local name = player:get_player_name()
	lottplayer.player_attached[name] = false
	lottplayer.textures[name] = {
		"lottplayer_" .. lottplayer.races[race][1] .. ".png",
		"blank.png", "blank.png", "blank.png"
	},
	player:set_properties({
		physical = true,
		collides_with_objects = true,
		mesh = "lottplayer_" .. lottplayer.races[race][2] .. ".b3d",
		textures = {
			"lottplayer_" .. lottplayer.races[race][1] .. ".png", 
			"blank.png", "blank.png", "blank.png"
		},
		visual = "mesh",
		visual_size = {x = 1, y = 1},
		hp_max = lottplayer.races[race][3],
		eye_height = lottplayer.races[race][4],
		can_zoom = lottplayer.races[race][5],
		collisionbox = lottplayer.races[race][6],
		nametag_color = lottplayer.races[race][7],
		is_visible = true,
	})
	player:set_local_animation(
		{x = 0,   y = 79},
		{x = 168, y = 187},
		{x = 189, y = 198},
		{x = 200, y = 219},
		30)
end

-- Formspec function
local function race_form(tab)
	return "size[10,7]" ..
		"label[0.5,1;" .. minetest.colorize(tab[7], 
			lott.str_to_desc(tab[1])) .. "]" ..
		"textarea[0.5,1.5;5.25,5;;;" ..
		minetest.formspec_escape(lottplayer.race_texts[tab[1]]) .. "]" ..
		"image[5.75,1;4.8,2.85;lottplayer_" ..
		tab[1] .. "_screenshot.png]" ..
		"label[5.75,4;Stats:]" ..
		"label[5.75,4.5;Max HP:    " .. tab[3] .. "]" ..
		"label[5.75,5;Zoom:     " .. tostring(tab[5]) .. "]" ..
		"button_exit[0.5,6;2,1;accept;Select Race]" ..
		"button_exit[2.5,6;2,1;exit;Exit]"
end

-- Some nodes for the race selection hall.
minetest.register_node("lottplayer:pedestal", {
	description = "1.5 node slab (for under player models)",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1, 0.5}
	},
	tiles = {"lottitems_stone_brick.png"},
})

for i = 1, 5 do
	minetest.register_node("lottplayer:banner_" .. i, {
		description = "Banner " .. i,
		tiles = {"lottplayer_banner.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "signlike",
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		pointable = false,
	})
end

for i, v in pairs(lottplayer.races) do
	minetest.register_node("lottplayer:" .. v[1], {
		description = lott.str_to_desc(v[1]),
		tiles = {"lottplayer_" .. v[1] .. ".png", "blank.png", "blank.png", "blank.png"},
		drawtype = "mesh",
		paramtype = "light",
		collision_box = {
			type = "fixed",
			fixed = v[6],
		},
		selection_box = {
			type = "fixed",
			fixed = v[6],
		},
		mesh = "lottplayer_" .. v[2] .. ".b3d",
		visual_scale = 0.1,
		on_rightclick = function(pos, node, clicker)
			local hud = clicker:get_attribute("lottplayer:race_hud")
			if hud and hud ~= "" and tonumber(hud) then
				clicker:hud_remove(hud)
			end
			minetest.show_formspec(clicker:get_player_name(),
				"lottplayer:race_info_" .. i, 
				race_form(v))
		end,
		groups = {},
	})
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname:sub(1, 21) ~= "lottplayer:race_info_" then
		return
	end
	if fields.accept then
		local race = tonumber(formname:sub(22))
		player:set_attribute("race", race)
		lottmapgen.spawn_player(lottplayer.races[race][8], player)
		set_player_props(race, player)
		player:set_hp(lottplayer.races[race][3])
		minetest.log("action", player:get_player_name() .. 
			" joined the race of " ..
			lott.str_to_desc(lottplayer.races[race][1]))
	end
end)

-- Place the race selection hall with the mapgen.
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.x < -33 or minp.x > 47
	or minp.y < 29967 or minp.y > 30047
	or minp.z < -33 or minp.z > 47 then
		return
	end
	minetest.place_schematic({x = -11, y = 30000, z = -8}, modpath .. "/schems/spawn.mts")
end)

-- Place the player at the race selection hall.
minetest.register_on_newplayer(function(player)
	player:set_pos({x = 0, y = 30003, z = 0})
	local hud = player:hud_add({
		hud_elem_type = "text",
		position = {x = 0.5, y = 0.8},
		scale = {x = 100, y = 100},
		text = "Please choose a race by rickclicking on one of the models!",
		number = 0xFFFFFF,
	})
	player:set_attribute("lottplayer:race_hud", hud)
end)

-- Set the player's apperance and charictaristics on join
minetest.register_on_joinplayer(function(player)
	player:set_attribute("lottplayer:clouds_changing", "false")
	local race = player:get_attribute("race")
	if not race or race == "" then
		player:set_properties({
			textures = {"blank.png", "blank.png"},
			is_visible = false
		})
		return
	end
	race = tonumber(race)
	set_player_props(race, player)
end)

-- Customise various messages based on race
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

minetest.register_on_respawnplayer(function(player)
	local race = player:get_attribute("race")
	if not race or race == "" then
		return false
	end
	lottmapgen.spawn_player(lottplayer.races[tonumber(race)][8], player)
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

