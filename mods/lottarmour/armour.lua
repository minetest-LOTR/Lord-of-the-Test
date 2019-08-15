local is_enabled = function(atype, name)
	local output = string.match(atype, '(.*)'..name..'(.*)')
	if output ~= nil then
		return true
	elseif output == nil then
		return false
	end
end

function lottarmour:register_armour(name, def)
	def = def or {}
	if is_enabled(def.type, "helmet") then
		local r_groups = table.copy(def.helmet_groups)
		r_groups.armour_helmet = 1
		minetest.register_tool("lottarmour:helmet_"..name, {
			description = def.helmet_desc or def.description.." Helmet",
			inventory_image = "armour_inv_helmet_"..name..".png",
			groups = r_groups,
			wear = 0,
		})
	end
	if is_enabled(def.type, "chestplate") then
		local r_groups = table.copy(def.chestplate_groups)
		r_groups.armour_chestplate = 1
		minetest.register_tool("lottarmour:chestplate_"..name, {
			description = def.chestplate_desc or def.description.." Chestplate",
			inventory_image = "armour_inv_chestplate_"..name..".png",
			groups = r_groups,
			wear = 0,
		})
	end
	if is_enabled(def.type, "leggings") then
		local r_groups = table.copy(def.leggings_groups)
		r_groups.armour_leggings = 1
		minetest.register_tool("lottarmour:leggings_"..name, {
			description = def.leggings_desc or def.description.." Leggings",
			inventory_image = "armour_inv_leggings_"..name..".png",
			groups = r_groups,
			wear = 0,
		})
	end
	if is_enabled(def.type, "boots") then
		local r_groups = table.copy(def.boots_groups)
		r_groups.armour_boots = 1
		minetest.register_tool("lottarmour:boots_"..name, {
			description = def.boots_desc or def.description.." Boots",
			inventory_image = "armour_inv_boots_"..name..".png",
			groups = r_groups,
			wear = 0,
		})
	end
	if is_enabled(def.type, "shield") then
		local r_groups = table.copy(def.shield_groups)
		r_groups.armour_shield = 1
		minetest.register_tool("lottarmour:shield_"..name, {
			description = def.shield_desc or def.description.." Shield",
			inventory_image = "armour_inv_shield_"..name..".png",
			groups = r_groups,
			wear = 0,
		})
	end
end

lottarmour:register_armour("wood", {
	type = "helmet, chestplate, leggings, boots, shield",
	description = "Wooden",
	helmet_groups = {armour_wear = 1000, armour_fleshy = 10, armour_pierce = 10, armour_blunt = 10, armour_stab = 10},
	chestplate_groups = {armour_wear = 1000, armour_fleshy = 10, armour_pierce = 10, armour_blunt = 10, armour_stab = 10},
	leggings_groups = {armour_wear = 1000, armour_fleshy = 10, armour_pierce = 10, armour_blunt = 10, armour_stab = 10},
	boots_groups = {armour_wear = 1000, armour_fleshy = 10, armour_pierce = 10, armour_blunt = 10, armour_stab = 10},
	shield_groups = {armour_wear = 1000, armour_block = 70, armour_block_cd = 1, armour_block_dcd = 5},
})

lottarmour_list = {
	physics = {"speed", "jump", "gravity"},
	physics_b = {"sneak", "sneak_glitch"},
	type = {"fleshy", "pierce", "blunt", "stab"},
	atype = {"helmet", "chestplate", "leggings", "boots", "shield"}
}

lottarmour.equip_armour = function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local inv = minetest.get_inventory({type="detached", name=name.."_armour"})
	
	local armour = {}
	for k,v in ipairs(lottarmour_list.type) do
		armour[v] = 0
	end
	local armour_physics = {speed = 0, gravity = 0, jump = 0}
	
	-- Calculate cumulative armour groups / physics
	for i = 1, 5 do
		local stack = inv:get_stack("armour", i)
		local group = stack:get_definition().groups
		
		for k,v in ipairs(lottarmour_list.type) do
			if group["armour_"..v] then
				armour[v] = armour[v] + group["armour_"..v]
			end
		end
		
		for k,v in ipairs(lottarmour_list.physics) do
			if group["armour_"..v] then
				armour_physics[v] = armour_physics[v] + group["armour_"..v]
			end
		end
	end
	
	-- Apply armour groups
	for k,v in ipairs(lottarmour_list.type) do
		meta:set_string("lottarmour:"..v, armour[v])
		
		armour[v] = 100 - armour[v]
		if armour[v] < 0 then
			armour[v] = 0
		end
	end
	
	player:set_armor_groups({fleshy = armour.fleshy, pierce = armour.pierce, blunt = armour.blunt, stab = armour.stab})
	
	-- Apply physics
	for k,v in ipairs(lottarmour_list.physics) do
		lottplayer.clear_physics(player, "lottarmour:"..v)
		lottplayer.physics(player, "lottarmour:"..v, v, armour_physics[v], nil)
	end
	
	-- Apply texture
	local textures = lottplayer.textures[name]
	if not textures then
		return
	end
	
	local armour_texture = {}
	for k,v in ipairs(lottarmour_list.atype) do
		local stack = inv:get_stack("armour", k)
		local iname = stack:get_name()
		if iname ~= "" then
			local iname = string.gsub(iname, "lottarmour:", "")
			armour_texture[v] = "armour_"..iname..".png"
		else
			armour_texture[v] = "blank.png"
		end
	end
	textures[3] = armour_texture.helmet.."^"..armour_texture.chestplate.."^"..armour_texture.boots.."^"..armour_texture.leggings
	textures[1] = armour_texture.shield
	player:set_properties({textures = textures})
end

-- Shield state
lottarmour.shield = {}
controls.register_on_hold(function(player, key, time)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local inv = minetest.get_inventory({type="detached", name=name.."_armour"})
	local shield = inv:get_stack("armour", 5):get_name()
	local shieldn = string.gsub(shield, "lottarmour:", "")
	
	if key == "sneak" then
		if meta:get_string("lott:shield_state") == "" and lottarmour.shield[name.."_hud"] ~= nil then
			player:hud_remove(lottarmour.shield[name.."_hud"])
			lottarmour.shield[name.."_hud"] = nil
		end
		
		if shield ~= "" and lottarmour.shield[name.."_cd"] == nil then
			if meta:get_string("lott:shield_state") == "" then 
				meta:set_string("lott:shield_state", 1)
				lottarmour.shield[name.."_hud"] = player:hud_add({
					hud_elem_type = "image",
					position = {x=0,y=1},
					text = "armour_"..shieldn..".png",
					scale = { x = 50, y = 50 },
					offset = { x = 150, y = -150 },
					direction = 1,
				})
			end
		end
	end
end)

controls.register_on_release(function(player, key, time)
	local name = player:get_player_name()
	local meta = player:get_meta()
	if key == "sneak" then
		if meta:get_string("lott:shield_state") ~= "" then
			meta:set_string("lott:shield_state", "")
			player:hud_remove(lottarmour.shield[name.."_hud"])
			lottarmour.shield[name.."_hud"] = nil
		end
	end
end)

-- Handle wear
lottarmour.on_hit = function(player, damage, shield)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local inv = minetest.get_inventory({type="detached", name=name.."_armour"})
	local player_inv = player:get_inventory()
	
	if damage > 1 then
		damage = damage / 2
	elseif damage < 0 then
		damage = 0
	elseif damage == 0 then
		damage = 1
	end
	
	if shield then
		local stack = inv:get_stack("armour", 5)
		local group = stack:get_definition().groups
		
		if stack:get_name() ~= "" then
			local wear = group["armour_wear"] or 0
			local wear_mod = wear * damage
			stack:add_wear(wear_mod)
			inv:set_stack("armour", 5, stack)
			player_inv:set_stack("armour", 5, stack)
			
			local bwear = stack:get_wear() - wear_mod
			if bwear < 0 then
				minetest.sound_play("tool_breaks", {
					pos = player:get_pos(),
					max_hear_distance = 10,
					gain = 10.0,
				})
				lottarmour.equip_armour(player)
			end
		end
	end
	
	for i = 1, 4 do
		local stack = inv:get_stack("armour", i)
		local group = stack:get_definition().groups
		
		if stack:get_name() ~= "" then
			local wear = group["armour_wear"] or 0
			local wear_mod = wear * damage
			stack:add_wear(wear_mod)
			inv:set_stack("armour", i, stack)
			player_inv:set_stack("armour", i, stack)
			
			local bwear = stack:get_wear() - wear_mod
			if bwear < 0 then
				minetest.sound_play("tool_breaks", {
					pos = player:get_pos(),
					max_hear_distance = 10,
					gain = 10.0,
				})
				lottarmour.equip_armour(player)
			end
		end
	end
end


minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local inv = minetest.get_inventory({type="detached", name=name.."_armour"})
	local shield = inv:get_stack("armour", 5):get_definition().groups
	
	-- Shield blocking
	if meta:get_string("lott:shield_state") ~= "" then
		if tonumber(shield["armour_block"]) then 
			
			meta:set_string("lott:shield_state", "")
			minetest.after(0.1, function()
				player:hud_remove(lottarmour.shield[name.."_hud"])
				lottarmour.shield[name.."_hud"] = nil
			end)
			
			lottarmour.on_hit(player, damage, true)
			
			-- Determine whether successful block or disarm
			if math.random(1,100) <= shield["armour_block"] then
				minetest.sound_play("shield", {
					pos = player:get_pos(),
					max_hear_distance = 10,
					gain = 10.0,
				})
				
				lottarmour.shield[name.."_cd"] = shield["armour_block_cd"]
				minetest.after(shield["armour_block_cd"], function()
					lottarmour.shield[name.."_cd"] = nil
				end)
				return true
			else
				minetest.sound_play("shield_disarm", {
					pos = player:get_pos(),
					max_hear_distance = 10,
					gain = 10.0,
				})
				lottarmour.shield[name.."_cd"] = shield["armour_block_dcd"]
				minetest.after(shield["armour_block_dcd"], function()
					lottarmour.shield[name.."_cd"] = nil
				end)
				lottarmour.on_hit(player, damage)
			end
		end
	else
		lottarmour.on_hit(player, damage)
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local player_inv = player:get_inventory()
	
	if player:get_armor_groups().blunt == nil then
		player:set_armor_groups({fleshy = 100, pierce = 100, blunt = 100, stab = 100})
	end
	
	if meta:get_string("lottarmour:fleshy") == "" then
		meta:set_string("lottarmour:fleshy", 0)
		meta:set_string("lottarmour:pierce", 0)
		meta:set_string("lottarmour:blunt", 0)
		meta:set_string("lottarmour:stab", 0)
	end
	
	-- Create armour inventory
	local armour = minetest.create_detached_inventory(name.."_armour", {
		on_put = function(inv, listname, index, stack, player)
			player_inv:set_stack(listname, index, stack)
			lottarmour.equip_armour(player)
		end,
		on_take = function(inv, listname, index, stack, player)
			player_inv:set_stack(listname, index, nil)
			lottarmour.equip_armour(player)
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			player_inv:set_stack(listname, index, stack)
			lottarmour.equip_armour(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if index == 1 then
				if stack:get_definition().groups.armour_helmet == nil then return 0 else return 1 end
			elseif index == 2 then
				if stack:get_definition().groups.armour_chestplate == nil then return 0 else return 1 end
			elseif index == 3 then
				if stack:get_definition().groups.armour_leggings == nil then return 0 else return 1 end
			elseif index == 4 then
				if stack:get_definition().groups.armour_boots == nil then return 0 else return 1 end
			elseif index == 5 then
				if stack:get_definition().groups.armour_shield == nil then return 0 else return 1 end
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	}, name)

	armour:set_size("armour", 5)
	-- Save armour inventory
	player_inv:set_size("armour", 5)
	for i = 1,5 do
		local stack = player_inv:get_stack("armour", i)
		armour:set_stack("armour", i, stack)
	end
	
	lottarmour.equip_armour(player)	
end)