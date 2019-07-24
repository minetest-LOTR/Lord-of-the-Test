--Aliases:
minetest.register_alias("lottores:blue_gem_ore", "lottother:blue_gem_ore")
minetest.register_alias("lottores:red_gem_ore", "lottother:red_gem_ore")
minetest.register_alias("lottores:white_gem_ore", "lottother:white_gem_ore")

minetest.register_alias("lottores:blue_gem", "lottother:blue_gem")
minetest.register_alias("lottores:red_gem", "lottother:red_gem")
minetest.register_alias("lottores:white_gem", "lottother:white_gem")

minetest.register_alias("lottother:blue_am_ring", "lottother:blue_rr_ring")
minetest.register_alias("lottother:red_am_ring", "lottother:red_rr_ring")
minetest.register_alias("lottother:white_am_ring", "lottother:white_rr_ring")

minetest.register_alias("lottother:purple_gem_mithril_ring", "lottother:purple_am_ring")
minetest.register_alias("lottother:ringsilver_lump", "lottother:ringsilver")
minetest.register_alias("lottother:ringsilver_ingot", "lottother:ringsilver")

minetest.register_privilege("purity", {
	description = "Immunity against corruption effects",
	give_to_singleplayer = false,
})

--ELF RINGS
--FUNCTION = Fast health regeneration + Breathing underwater + Flight / Emits blue particles

minetest.register_craftitem("lottother:vilya", {
	description = minetest.colorize("skyblue", "Vilya\nElven Ring of Air") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_vilya.png",
	stack_max = 1,
	groups = {forbidden=1},
})

--FUNCTION = Makes (good) mobs follow you + deadly attack + Invisibility

minetest.register_craftitem("lottother:narya", {
	description = minetest.colorize("crimson", "Narya\nElven Ring of Fire") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_narya.png",
	stack_max = 1,
	groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 10.00,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.50, [2]=1.30, [3]=0.45}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=50},
	},
})
--In mob def:
--follow = "lottother:narya",

--FUNCTION = Physical-damage immunity / Emits white particles

minetest.register_craftitem("lottother:nenya", {
	description = minetest.colorize("silver", "Nenya\nElven Ring of Immunity") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_nenya_inv.png",
	stack_max = 1,
	groups = {forbidden=1},
})

local time = 0
lottother = {}
lottother.corrupt = {}
minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 1 then
		time = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local wield = player:get_inventory():get_stack("main", player:get_wield_index()):get_name()
			
			if lottother.corrupt == nil then
				lottother.corrupt = {}
			end
			
			if lottother.corrupt[name] == nil or not tonumber(lottother.corrupt[name]) then
				lottother.corrupt[name] = 0
			end
			
			-- corruption effect
			if wield == "lottother:nenya" or wield == "lottother:vilya" or wield == "lottother:narya" or wield == "lottother:dwarf_ring" then
				
				lottother.corrupt[name] = lottother.corrupt[name] + 1
				local corruption = tonumber(lottother.corrupt[name])
				
				if corruption > 29 and minetest.get_player_privs(name).GAMEwizard == nil and minetest.get_player_privs(name).purity == nil then
				if corruption == 30 then
					lottother.corrupt[name.."_1"] = player:hud_add({
						hud_elem_type = "image",
						position = {x=0.5, y=0.5},
						scale = {x=-100, y=-100},
						text = "lottother_corruption.png",
						offset = {x=0, y=0},
					})
				elseif corruption == 60 then
					lottother.corrupt[name.."_2"] = player:hud_add({
						hud_elem_type = "image",
						position = {x=0.5, y=0.5},
						scale = {x=-100, y=-100},
						text = "lottother_corruption.png",
						offset = {x=0, y=0},
					})
				elseif corruption == 90 then
					lottother.corrupt[name.."_3"] = player:hud_add({
						hud_elem_type = "image",
						position = {x=0.5, y=0.5},
						scale = {x=-100, y=-100},
						text = "lottother_corruption.png",
						offset = {x=0, y=0},
					})
				elseif corruption == 120 then
					lottother.corrupt[name.."_4"] = player:hud_add({
						hud_elem_type = "image",
						position = {x=0.5, y=0.5},
						scale = {x=-100, y=-100},
						text = "lottother_corruption_eye.png",
						offset = {x=0, y=0},
					})
				elseif corruption > 135 then
					player:set_hp(player:get_hp()-0.5)
				end
				end
				
			elseif tonumber(lottother.corrupt[name]) > 0 then
				lottother.corrupt[name] = lottother.corrupt[name] - 1
				local corruption = tonumber(lottother.corrupt[name])
				
				if corruption < 30 then
					player:hud_remove(lottother.corrupt[name.."_1"])
				elseif corruption < 60 then
					player:hud_remove(lottother.corrupt[name.."_2"])
				elseif corruption < 90 then
					player:hud_remove(lottother.corrupt[name.."_3"])
				elseif corruption < 120 then
					player:hud_remove(lottother.corrupt[name.."_4"])
				end
			end
			
			-- nenya ring
			if wield == "lottother:nenya" then
				if player:get_attribute("lott:immunity") == nil then
					player:set_attribute("lott:immunity", "ring")
					armor:set_player_armor(player)
				end
			end
			
			if player:get_attribute("lott:immunity") == "ring" then
				if wield ~= "lottother:nenya" then
					player:set_attribute("lott:immunity", nil)
					armor:set_player_armor(player)
				end
			end
			
			-- vilya ring
			if wield == "lottother:vilya" then
				-- handle hp
				if player:get_hp() < 20 and player:get_hp() > 0 then
					if tonumber(lottother.corrupt[name]) then
						if lottother.corrupt[name] < 120 then
							player:set_hp(player:get_hp()+2)
						end
					end
				end
				-- handle breath
				if player:get_breath() < 10 then
					player:set_breath(10)
				end
				-- handle flight
				if player:get_attribute("lott:vilya") == nil and minetest.get_player_privs(name).fly == nil then
					local privs = minetest.get_player_privs(name)
					privs.fly = true
					minetest.set_player_privs(name, privs)
					player:set_attribute("lott:vilya", "ring")
				end
			end
			
			-- remove flight
			if player:get_attribute("lott:vilya") == "ring" then
				if wield ~= "lottother:vilya" then
					local privs = minetest.get_player_privs(name)
					privs.fly = nil
					minetest.set_player_privs(name, privs)
					player:set_attribute("lott:vilya", nil)
				end
			end
			
			-- narya ring
			if player:get_attribute("lott:narya") == nil and wield == "lottother:narya" then
				player:set_properties({visual_size = {x = 0, y = 0}})
				player:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b = 255}})
				player:set_attribute("lott:narya", "ring")
			end
			
			if player:get_attribute("lott:narya") == "ring" then
				if wield ~= "lottother:narya" then
					player:set_properties({visual_size = {x = 1, y = 1}})
					player:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
					player:set_attribute("lott:narya", nil)
				end
			end
		end
	end
end)

-- remove ring corruption upon death
minetest.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	if tonumber(lottother.corrupt[name]) then
		lottother.corrupt[name] = nil
		player:hud_remove(lottother.corrupt[name.."_1"])
		player:hud_remove(lottother.corrupt[name.."_2"])
		player:hud_remove(lottother.corrupt[name.."_3"])
		player:hud_remove(lottother.corrupt[name.."_4"])
	end
end)

-- Ring Particles Trail
local time2 = 0
minetest.register_globalstep(function(dtime)
	time2 = time2 + dtime
	if time2 > 0.3 then
		time2 = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local pos = player:getpos()
		
			-- nenya ring particles
			if player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:nenya" then
				minetest.add_particlespawner({
					amount = 5,
					time = 0.01,
					minpos = {x = pos.x - 0.25, y = pos.y + 0.5, z = pos.z - 0.25},
					maxpos = {x = pos.x + 0.25, y = pos.y + 1, z = pos.z + 0.25},
					minvel = {x = -0.5, y = 0, z = -0.5},
					maxvel = {x = 0.5, y = 0.1, z = 0.5},
					minacc = {x = 0, y = 0, z = 0},
					maxacc = {x = 0, y = -0.1, z = 0},
					minexptime = 0.25,
					maxexptime = 3.0,
					minsize = 0.5,
					maxsize = 1.0,
					vertical = false,
					collisiondetection = false,
					texture = "lottother_orb_white.png",
					glow = 12
				})
			-- vilya ring particles
			elseif player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:vilya" then
				minetest.add_particlespawner({
					amount = 5,
					time = 0.01,
					minpos = {x = pos.x - 0.25, y = pos.y + 0.5, z = pos.z - 0.25},
					maxpos = {x = pos.x + 0.25, y = pos.y + 1, z = pos.z + 0.25},
					minvel = {x = -0.5, y = 0, z = -0.5},
					maxvel = {x = 0.5, y = 0.1, z = 0.5},
					minacc = {x = 0, y = 0, z = 0},
					maxacc = {x = 0, y = -0.1, z = 0},
					minexptime = 0.25,
					maxexptime = 3.0,
					minsize = 0.5,
					maxsize = 1.0,
					vertical = false,
					collisiondetection = false,
					texture = "lottother_orb_blue.png",
					glow = 12
				})
			-- dwarven ring particles
			elseif player:get_inventory():get_stack("main", player:get_wield_index()):get_name() == "lottother:dwarf_ring" then
				minetest.add_particlespawner({
					amount = 5,
					time = 0.01,
					minpos = {x = pos.x - 0.25, y = pos.y + 0.5, z = pos.z - 0.25},
					maxpos = {x = pos.x + 0.25, y = pos.y + 1, z = pos.z + 0.25},
					minvel = {x = -0.5, y = 0, z = -0.5},
					maxvel = {x = 0.5, y = 0.1, z = 0.5},
					minacc = {x = 0, y = 0, z = 0},
					maxacc = {x = 0, y = -0.1, z = 0},
					minexptime = 0.25,
					maxexptime = 3.0,
					minsize = 0.5,
					maxsize = 1.0,
					vertical = false,
					collisiondetection = false,
					texture = "lottother_orb_purple.png",
					glow = 12
				})
			end
		end
	end
end)


--------------------------------------------------------

--Dwarf Ring = Punching an ore will destroy it in a puff of smoke and multiply the resource drops

local dwarf_ring_multiply = {
	-- ore block, ore drop, min drop, max drop
	{ "lottores:rough_rock", "lottores:rough_rock_lump", 1, 2 },
	{ "lottores:silver_ore", "lottores:silver_lump", 1, 3 },
	{ "lottores:tin_ore", "lottores:tin_lump", 2, 4 },
	{ "lottores:lead_ore", "lottores:lead_lump", 2, 3 },
	{ "lottores:mithril_ore", "lottores:mithril_lump", 1, 2 },
	{ "lottores:orc_ore", "lottores:orc_lump", 2, 4 },
	{ "lottores:limestone", "lottores:marble", 5, 13 },
	{ "lottores:mineral_pearl", "lottores:pearl", 1, 3 },
	{ "lottores:mineral_salt", "lottores:salt", 5, 7 },
	{ "default:stone_with_coal", "default:coal_lump", 3, 6 },
	{ "default:stone_with_iron", "default:iron_lump", 2, 4 },
	{ "darkage:desert_stone_with_iron", "default:iron_lump", 2, 4 },
	{ "default:stone_with_copper", "default:copper_lump", 2, 3 },
	{ "default:stone_with_mese", "default:mese_crystal", 1, 2 },
	{ "default:stone_with_gold", "default:gold_lump", 1, 3 },
}

minetest.register_craftitem("lottother:dwarf_ring", {
	description = minetest.colorize("darkviolet", "Dwarven Ring of Power") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottother_dwarf_ring.png",
	stack_max = 1,
	groups = {forbidden=1},
	
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		if pointed_thing.type == "node" then
			local pos = pointed_thing.under
			
			if minetest.is_protected(pos, name) then return end
			local nn = minetest.get_node(pos).name
			for i in ipairs(dwarf_ring_multiply) do
				local name = dwarf_ring_multiply[i][1]
				local drop = dwarf_ring_multiply[i][2]
				local mind = dwarf_ring_multiply[i][3]
				local maxd = dwarf_ring_multiply[i][4]
				
				if nn == name then
					minetest.dig_node(pos)
					minetest.add_particlespawner({
						amount = 5,
						time = 0.01,
						minpos = {x = pos.x - 0.25, y = pos.y, z = pos.z - 0.25},
						maxpos = {x = pos.x + 0.25, y = pos.y, z = pos.z + 0.25},
						minvel = {x = -0.5, y = 0, z = -0.5},
						maxvel = {x = 0.5, y = 0.1, z = 0.5},
						minacc = {x = 0, y = 0.5, z = 0},
						maxacc = {x = 0, y = 1, z = 0},
						minexptime = 0.25,
						maxexptime = 2.0,
						minsize = 2.0,
						maxsize = 5.0,
						vertical = false,
						collisiondetection = true,
						texture = "smoke_puff.png",
					})
					minetest.add_item(pos, drop.." "..math.random(mind, maxd))
				end
			end
		end
	end
})
