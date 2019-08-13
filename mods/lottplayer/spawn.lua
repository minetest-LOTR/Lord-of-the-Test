-- Race selection hall decoration nodes
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

-- Race selection formspec
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

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname:sub(1, 21) ~= "lottplayer:race_info_" then
		return
	end
	if fields.accept then
		local race = tonumber(formname:sub(22))
		player:set_attribute("race", race)
		lottmapgen.spawn_player(lottplayer.races[race][8], player)
		lottplayer.set_player_props(race, player)
		player:set_hp(lottplayer.races[race][3])
		minetest.log("action", player:get_player_name() .. 
			" joined the race of " ..
			lott.str_to_desc(lottplayer.races[race][1]))
	end
end)

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

-- Place the race selection hall with the mapgen.
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.x < -33 or minp.x > 47
	or minp.y < 29967 or minp.y > 30047
	or minp.z < -33 or minp.z > 47 then
		return
	end
	minetest.place_schematic({x = -11, y = 30000, z = -8}, minetest.get_modpath("lottplayer") .. "/schems/spawn.mts")
end)

-- Place the player at the race selection hall.
minetest.register_on_newplayer(function(player)
	player:set_pos({x = 0, y = 30003, z = 0})
	local hud = player:hud_add({
		hud_elem_type = "text",
		position = {x = 0.5, y = 0.8},
		scale = {x = 100, y = 100},
		text = "Please choose a race by rightclicking on one of the models!",
		number = 0xFFFFFF,
	})
	player:set_attribute("lottplayer:race_hud", hud)
end)

-- Respawn handler
minetest.register_on_respawnplayer(function(player)
	local race = player:get_attribute("race")
	if not race or race == "" then
		return false
	end
	lottmapgen.spawn_player(lottplayer.races[tonumber(race)][8], player)
	return true
end)

-- Join/leave message handler
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