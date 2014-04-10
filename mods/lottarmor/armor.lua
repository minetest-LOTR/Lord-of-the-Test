local time = 0
local update_time = tonumber(minetest.setting_get("lottarmor_update_time"))
if not update_time then
	update_time = 1
	minetest.setting_set("lottarmor_update_time", tostring(update_time))
end

armor = {
	player_hp = {},
	elements = {"head", "torso", "legs", "feet"},
	physics = {"jump","speed","gravity"},
	formspec = "size[8,8.5]button[0,0;2,0.5;main;Back]"
		.."list[current_player;main;0,4.5;8,4;]"
		.."list[detached:player_name_armor;armor_head;3,0;1,1;]"
		.."list[detached:player_name_armor;armor_torso;3,1;1,1;]"
		.."list[detached:player_name_armor;armor_legs;3,2;1,1;]"
		.."list[detached:player_name_armor;armor_feet;3,3;1,1;]",
	textures = {},
	default_skin = "character.png",
}

-- armor.def - Added by BlockMen for HUD integration

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
	local armor_texture = "lottarmor_trans.png"
	local armor_level = 0
	local state = 0
	local items = 0
	local textures = {}
	local elements = {}	
	local physics_o = {speed=1,gravity=1,jump=1}
	for i, v in ipairs(self.elements) do
		local stack = player_inv:get_stack("armor_"..v, 1)
		local level = stack:get_definition().groups["armor_"..v]
		local item = stack:get_name()
		elements[i] = string.match(item, "%:.+_(.+)$")
		if level then
			table.insert(textures, item:gsub("%:", "_")..".png")
			armor_level = armor_level + level
			state = state + stack:get_wear()
			items = items + 1
		end

		for kk,vv in ipairs(self.physics) do
			local o_value = stack:get_definition().groups["physics_"..vv]
			if ( o_value ~= nil ) then
				physics_o[vv] = physics_o[vv] + o_value
			end
		end
		
	end
	
	player:set_physics_override(physics_o)
	
	if minetest.get_modpath("lottweapons") then
		armor_level = armor_level * 0.9
	end
	if elements[1] == elements[2] and
		elements[1] == elements[3] and
		elements[1] == elements[4] then
		armor_level = armor_level * 1.1
	end
	if #textures > 0 then
		armor_texture = table.concat(textures, "^")
	end
	local armor_groups = {fleshy=100}
	if armor_level > 0 then
		armor_groups.level = math.floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end
	player:set_armor_groups(armor_groups)
	self.textures[name].armor = armor_texture
	self.def[name].state = state
	self.def[name].count = items
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
		local state = 0
		local items = 0
		for _,v in ipairs(self.elements) do
			local stack = armor_inv:get_stack("armor_"..v, 1)
			if stack:get_count() > 0 then
				local use = stack:get_definition().groups["armor_use"] or 0
				local heal = stack:get_definition().groups["armor_heal"] or 0
				local item = stack:get_name()
				stack:add_wear(use)
				armor_inv:set_stack("armor_"..v, 1, stack)
				player_inv:set_stack("armor_"..v, 1, stack)
				state = state + stack:get_wear()
				items = items + 1
				if stack:get_count() == 0 then
					local desc = minetest.registered_items[item].description
					if desc then
						minetest.chat_send_player(name, "Your "..desc.." got destroyed!")
					end
					self:set_player_armor(player)
				end
				heal_max = heal_max + heal
			end
		end
		self.def[name].state = state
		self.def[name].count = items
		if heal_max > math.random(100) then
			player:set_hp(self.player_hp[name])
			return
		end
	end
	self.player_hp[name] = hp
end

-- Register Player Model

default.player_register_model("lottarmor_character.x", {
	animation_speed = 30,
	textures = {
		armor.default_skin,
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
	if fields.armor then
		local formspec = armor.formspec:gsub("player_name", name)
		inventory_plus.set_inventory_formspec(player, formspec)
		return
	end
	for field, _ in pairs(fields) do
		if string.find(field, "^skins_set_") then
			minetest.after(0, function(player)
				armor.textures[name].skin = skins.skins[name]..".png"
				armor:update_player_visuals(player)
			end, player)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	default.player_set_model(player, "lottarmor_character.x")
	inventory_plus.register_button(player,"armor", "Armor")
	local player_inv = player:get_inventory()
	local name = player:get_player_name()
	local armor_inv = minetest.create_detached_inventory(name.."_armor",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			armor:set_player_armor(player)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			armor:set_player_armor(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if inv:is_empty(listname) then
				return 1
			end
			return 0
		end,
		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	})
	for _,v in ipairs(armor.elements) do
		local list = "armor_"..v
		player_inv:set_size(list, 1)
		armor_inv:set_size(list, 1)
		armor_inv:set_stack(list, 1, player_inv:get_stack(list, 1))
	end
	armor.player_hp[name] = 0
	armor.def[name] = {
		state = 0,
		count = 0,
	}
	armor.textures[name] = {
		skin = armor.default_skin,
		armor = "lottarmor_trans.png",
		wielditem = "lottarmor_trans.png",
	}
	if minetest.get_modpath("skins") then
		local skin = skins.skins[name]
		if skin and skins.get_type(skin) == skins.type.MODEL then
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
	minetest.after(1, function(player)
		armor:set_player_armor(player)
	end, player)
end)

if minetest.get_modpath("bones") then
	minetest.register_on_dieplayer(function(player)
		local name = player:get_player_name()
		local pos = player:getpos()
		if name and pos then
			pos = vector.round(pos)
			local drop = {}
			local player_inv = player:get_inventory()
			local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
			for _,v in ipairs(armor.elements) do
				local list = "armor_"..v
				table.insert(drop, player_inv:get_stack(list, 1))
				armor_inv:set_stack(list, 1, nil)
				player_inv:set_stack(list, 1, nil)
			end
			armor:set_player_armor(player)
			minetest.after(1, function() --TODO: Make delay configurable
				local node = minetest.get_node(pos)
				if node.name == "bones:bones" then
					local meta = minetest.get_meta(pos)
					local owner = meta:get_string("owner")
					local inv = meta:get_inventory()
					if name == owner then
						for _,list in ipairs(drop) do
							if inv:room_for_item("main", list) then
								inv:add_item("main", list)
							end
						end
					end
				end
			end)
		end
	end)
end

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > update_time then
		for _,player in ipairs(minetest.get_connected_players()) do
			armor:update_armor(player)
		end
		time = 0
	end
end)

