ARMOR_INIT_DELAY = 1
ARMOR_INIT_TIMES = 1
ARMOR_BONES_DELAY = 1
ARMOR_UPDATE_TIME = 1
ARMOR_DROP = false
ARMOR_DESTROY = false
ARMOR_LEVEL_MULTIPLIER = 1
ARMOR_HEAL_MULTIPLIER = 1

local time = 0

gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
gui_slots = "listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"

armor = {
	player_hp = {},
	elements = {"head", "torso", "legs", "feet"},
     physics = {"jump","speed","gravity","sneak","sneak_glitch"},
	formspec = "size[8,8.5]" .. gui_bg_img .. gui_slots .."image[0,0;1,1;lottarmor_helmet.png]"
          .."image[3,0;1,1;lottarmor_helmet.png]"
          .."image[0,1;1,1;lottarmor_chestplate.png]"
          .."image[0,2;1,1;lottarmor_leggings.png]"
          .."image[0,3;1,1;lottarmor_boots.png]"
          .."image[3,1;1,1;lottarmor_shirt.png]"
          .."image[3,2;1,1;lottarmor_pants.png]"
          .."image[3,3;1,1;lottarmor_shoes.png]"
          .."list[detached:player_name_armor;armor;0,0;1,4;]"
          .."list[detached:player_name_armor;armor;2,2;1,1;4]"
          .."list[detached:player_name_armor;armor;3,0;1,4;5]"
          .."image[1.16,0.25;2,4;armor_preview]"
          .."image[2,2;1,1;lottarmor_shield.png]"
		.."list[current_player;main;0,4.25;8,1;]"
		.."list[current_player;main;0,5.5;8,3;8]"
          .."image[4.05,0;4.5,1;lottarmor_crafting.png]"
    	     .."list[current_player;craft;4,1;3,3;]"
    	     .."list[current_player;craftpreview;7,2;1,1;]"
          .."image[7,3;1,1;lottarmor_trash.png]"
          .."list[detached:armor_trash;main;7,3;1,1;]"
          .."image_button[7,1;1,1;bags.png;bags;]",
	textures = {},
	default_skin = "character",
}

local get_formspec = function(player,page)
	if page=="bags" then
		return "size[8,7.5]"
			.."list[current_player;main;0,3.5;8,4;]"
			.."button[0,0;2,0.5;main;Back]"
			.."button[0,2;2,0.5;bag1;Bag 1]"
			.."button[2,2;2,0.5;bag2;Bag 2]"
			.."button[4,2;2,0.5;bag3;Bag 3]"
			.."button[6,2;2,0.5;bag4;Bag 4]"
			.."list[detached:"..player:get_player_name().."_bags;bag1;0.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag2;2.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag3;4.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag4;6.5,1;1,1;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
	for i=1,4 do
		if page=="bag"..i then
			local image = player:get_inventory():get_stack("bag"..i, 1):get_definition().inventory_image
			return "size[8,8.5]"
				.."list[current_player;main;0,4.5;8,4;]"
				.."button[0,0;2,0.5;main;Main]"
				.."button[2,0;2,0.5;bags;Bags]"
				.."image[7,0;1,1;"..image.."]"
				.."list[current_player;bag"..i.."contents;0,1;8,3;]"
                    .."background[5,5;1,1;gui_formbg.png;true]"
		end
	end
end

--- Bags
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.bags then
		inventory_plus.set_inventory_formspec(player, get_formspec(player,"bags"))
		return
	end
	for i=1,4 do
		local page = "bag"..i
		if fields[page] then
			if player:get_inventory():get_stack(page, 1):get_definition().groups.bagslots==nil then
				page = "bags"
			end
			inventory_plus.set_inventory_formspec(player, get_formspec(player,page))
			return
		end
	end
end)

--Trash
local trash = minetest.create_detached_inventory("armor_trash", {
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)

--Armor Stuff
armor.def = {
	state = 0,
	count = 0,
}

armor.update_player_visuals = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	if self.textures[name] then
		default.player_set_textures(player, {
			self.textures[name].skin,
			self.textures[name].armor,
			self.textures[name].wielditem,
		})
	end
end

armor.set_player_armor = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	if not name or not player_inv then
		return
	end
	local armor_texture = "lottarmor_trans.png"
	local armor_level = 0
	local armor_heal = 0
     local armor_healing = 0
	local state = 0
	local items = 0
	local elements = {}
	local textures = {}
	local physics_o = {speed=1,gravity=1,jump=1,sneak=1,sneak_glitch=0}
	local material = {type=nil, count=1}
	local preview = armor:get_player_skin(name).."_preview.png"
	for _,v in ipairs(self.elements) do
		elements[v] = false
	end
	for i=1, 9 do
		local stack = player_inv:get_stack("armor", i)
		local item = stack:get_name()
		if stack:get_count() == 1 then
			local def = stack:get_definition()
			for k, v in pairs(elements) do
				if v == false then
					local level = def.groups["armor_"..k]
					if level then
						local texture = item:gsub("%:", "_")
						table.insert(textures, texture..".png")
						preview = preview.."^"..texture.."_preview.png"
						armor_level = armor_level + level
						state = state + stack:get_wear()
						items = items + 1
						local heal = def.groups["armor_heal"] or 0
						armor_heal = armor_heal + heal
                              local heal_plus = def.groups["armor_healing"] or 0
						armor_healing = armor_healing + heal_plus
						for kk,vv in ipairs(self.physics) do							
							local o_value = def.groups["physics_"..vv]
							if o_value then
								physics_o[vv] = physics_o[vv] + o_value
							end
						end
						local mat = string.match(item, "%:.+_(.+)$")
						if material.type then
							if material.type == mat then
								material.count = material.count + 1
							end
						else
							material.type = mat
						end
						elements[k] = true
					end
				end
			end
		end
	end
	if minetest.get_modpath("lottweapons") then
		armor_level = armor_level * 0.9
	end
	if material.type and material.count == #self.elements then
		armor_level = armor_level * 1.1
	end
	armor_level = armor_level * ARMOR_LEVEL_MULTIPLIER
	armor_heal = armor_heal * ARMOR_HEAL_MULTIPLIER
     armor_healing = armor_healing
	if #textures > 0 then
		armor_texture = table.concat(textures, "^")
	end
	local armor_groups = {fleshy=100}
	if armor_level > 0 then
		armor_groups.level = math.floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end
	player:set_armor_groups(armor_groups)
     physics_o.sneak = physics_o.sneak > 0
	physics_o.sneak_glitch = physics_o.sneak_glitch > 0
	player:set_physics_override(physics_o)
	self.textures[name].armor = armor_texture
	self.textures[name].preview = preview
	self.def[name].state = state
	self.def[name].count = items
	self.def[name].level = armor_level
	self.def[name].heal = armor_heal
     self.def[name].heal_plus = armor_healing
	self:update_player_visuals(player)
end

armor.update_armor = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	local hp = player:get_hp() or 0
	if hp == 0 or hp == self.player_hp[name] then
		return
	end
	if self.player_hp[name] > hp then
		local player_inv = player:get_inventory()
		local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
		if not armor_inv then
			return
		end
		local heal_max = 0
          local heal_max2 = 0
		local state = 0
		local items = 0
		for i=1, 9 do
			local stack = player_inv:get_stack("armor", i)
			if stack:get_count() > 0 then
				local use = stack:get_definition().groups["armor_use"] or 0
				local heal = stack:get_definition().groups["armor_heal"] or 0
                    local heal_plus = stack:get_definition().groups["armor_healing"] or 0
				local item = stack:get_name()
				stack:add_wear(use)
				armor_inv:set_stack("armor", i, stack)
				player_inv:set_stack("armor", i, stack)
				state = state + stack:get_wear()
				items = items + 1
				if stack:get_count() == 0 then
					local desc = minetest.registered_items[item].description
					if desc then
						minetest.chat_send_player(name, "Your "..desc.." got destroyed!")
					end
					self:set_player_armor(player)
					armor:update_inventory(player)
				end
				heal_max = heal_max + heal
                    heal_max2 = heal_max2 + heal_plus
			end
		end
		self.def[name].state = state
		self.def[name].count = items
		heal_max = heal_max * ARMOR_HEAL_MULTIPLIER
          if heal_max2 < 0 then
			player:set_hp(player:get_hp() + heal_max2)
               player:set_hp(player:get_hp() + 1)
		end
          if heal_max2 > 0 then
			player:set_hp(player:get_hp() + heal_max2)
		end
		if heal_max > math.random(100) then
			player:set_hp(self.player_hp[name])
		end
	end
	self.player_hp[name] = hp
end

armor.get_player_skin = function(self, name)
	local skin = nil
	if skins then
		skin = skins.skins[name]
	elseif u_skins then
		skin = u_skins.u_skins[name]
	end
	return skin or armor.default_skin
end

armor.get_armor_formspec = function(self, name)
	local formspec = armor.formspec:gsub("player_name", name)
	formspec = formspec:gsub("armor_preview", armor.textures[name].preview)
	formspec = formspec:gsub("armor_level", armor.def[name].level)
     formspec = formspec:gsub("armor_healing", armor.def[name].heal)
	return formspec:gsub("armor_heal", armor.def[name].heal)
end
armor.update_inventory = function(self, player)
	local name = player:get_player_name()
	local formspec = armor:get_armor_formspec(name)
	player:set_inventory_formspec(formspec)
end

-- Register Player Model

default.player_register_model("lottarmor_character.x", {
	animation_speed = 30,
	textures = {
		armor.default_skin..".png",
		"lottarmor_trans.png",
		"lottarmor_trans.png",
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

-- Register Callbacks

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	for field, _ in pairs(fields) do
		if string.find(field, "skins_set_") then
			minetest.after(0, function(player)
				local skin = armor:get_player_skin(name)
				armor.textures[name].skin = skin..".png"
				armor:set_player_armor(player)
			end, player)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	default.player_set_model(player, "lottarmor_character.x")
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	local armor_inv = minetest.create_detached_inventory(name.."_armor",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			local plaver_inv = player:get_inventory()
			local stack = inv:get_stack(to_list, to_index)
			player_inv:set_stack(to_list, to_index, stack)
			player_inv:set_stack(from_list, from_index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			return 1
		end,
		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return count
		end,
	})
	armor_inv:set_size("armor", 9)
	player_inv:set_size("armor", 9)
	for i=1, 9 do
		local stack = player_inv:get_stack("armor", i)
		armor_inv:set_stack("armor", i, stack)
	end
     
     
     --Bags
     local bags_inv = minetest.create_detached_inventory(player:get_player_name().."_bags",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			player:get_inventory():set_size(listname.."contents", stack:get_definition().groups.bagslots)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, listname, index, stack, player)
			if player:get_inventory():is_empty(listname.."contents")==true then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	})
	for i=1,4 do
		local bag = "bag"..i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag,1,player_inv:get_stack(bag,1))
	end

	-- Legacy support, import player"s armor from old inventory format
	--[[
	for _,v in pairs(armor.elements) do
		local list = "armor_"..v
		armor_inv:add_item("armor", player_inv:get_stack(list, 1))
		player_inv:set_stack(list, 1, nil)
	end
	--]]

	armor.player_hp[name] = 0
	armor.def[name] = {
		state = 0,
		count = 0,
		level = 0,
		heal = 0,
          heal_plus = 0,
	}
	armor.textures[name] = {
		skin = armor.default_skin..".png",
		armor = "lottarmor_trans.png",
		wielditem = "lottarmor_trans.png",
		preview = armor.default_skin.."_preview.png",
	}
	if minetest.get_modpath("skins") then
		local skin = skins.skins[name]
		if skin and skins.get_type(skin) == skins.type.MODEL then
			armor.textures[name].skin = skin..".png"
		end
	elseif minetest.get_modpath("u_skins") then
		local skin = u_skins.u_skins[name]
		if skin and u_skins.get_type(skin) == u_skins.type.MODEL then
			armor.textures[name].skin = skin..".png"
		end
	end
	if minetest.get_modpath("player_textures") then
		local filename = minetest.get_modpath("player_textures").."/textures/player_"..name
		local f = io.open(filename..".png")
		if f then
			f:close()
			armor.textures[name].skin = "player_"..name..".png"
		end
	end
	for i=1, ARMOR_INIT_TIMES do
		minetest.after(ARMOR_INIT_DELAY * i, function(player)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end, player)
	end
end)

if ARMOR_DROP == true or ARMOR_DESTROY == true then
	minetest.register_on_dieplayer(function(player)
		local name = player:get_player_name()
		local pos = player:getpos()
		if name and pos then
			local drop = {}
			local player_inv = player:get_inventory()
			local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
			for i=1, player_inv:get_size("armor") do
				local stack = armor_inv:get_stack("armor", i)
				if stack:get_count() > 0 then
					table.insert(drop, stack)
					armor_inv:set_stack("armor", i, nil)
					player_inv:set_stack("armor", i, nil)
				end
			end
			armor:set_player_armor(player)
			armor:update_inventory(player)
			if ARMOR_DESTROY == false then
				if minetest.get_modpath("bones") then
					minetest.after(ARMOR_BONES_DELAY, function()
						pos = vector.round(pos)
						local node = minetest.get_node(pos)
						if node.name == "bones:bones" then
						local meta = minetest.get_meta(pos)
						local owner = meta:get_string("owner")
						local inv = meta:get_inventory()
						if name == owner then
							for _,stack in ipairs(drop) do
								if inv:room_for_item("main", stack) then
									inv:add_item("main", stack)
								end
							end
						end
					end
				end)
			else
				for _,stack in ipairs(drop) do
					local obj = minetest.add_item(pos, stack)
					if obj then
						local x = math.random(1, 5)
						if math.random(1,2) == 1 then
							x = -x
						end
						local z = math.random(1, 5)
						if math.random(1,2) == 1 then
							z = -z
						end
						obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})
					end
				end
			end
		end
	end
end)
end

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > ARMOR_UPDATE_TIME then
		for _,player in ipairs(minetest.get_connected_players()) do
			armor:update_armor(player)
		end
		time = 0
	end
end)