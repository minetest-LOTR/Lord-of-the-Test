local TARGET_RADIUS = 15
local MAX_SPEED = 6

local function get_wield_image(item)
	local wield_image = "npcf_trans.png"
	if minetest.registered_items[item] then
		if minetest.registered_items[item].inventory_image ~= "" then
			wield_image = minetest.registered_items[item].inventory_image
		end
	end
	return wield_image
end

local function get_speed(distance)
	local speed = distance * 0.5
	if speed > MAX_SPEED then
		speed = MAX_SPEED
	end
	return speed
end

local function get_name_in_list(list, name)
	list = list:gsub(",", " ")
	for k,v in ipairs(list:split(" ")) do
		if k ~= "" and v == name then
			return name
		end
	end
end

local function get_armor_texture(self)
	if self.metadata.show_armor == "true" then
		return "npcf_skin_armor.png"
	end
	return "npcf_trans.png"
end

npcf:register_npc("kelvar:rohan_guard" ,{
	description = "Rohan Guard",
	mesh = "npcf_guard.x",
	textures = {"kelvar_rohan_guard.png", "npcf_skin_armor.png", "npcf_trans.png"},
	nametag_color = "red",
	inventory_image = "kelvar_inv_rohanguard.png",
	stepheight = 1,
	metadata = {
		wielditem = "curwe:steel_spear",
		blacklist = "kelvar:balrog kelvar:battle_troll kelvar:dead_men kelvar:dunlending kelvar:half_troll kelvar:nazgul kelvar:orc kelvar:spider kelvar:troll kelvar:uruk_hai kelvar:witch_king kelvar:orc_guard kelvar:uruk_hai_guard",
		whitelist = "",
		attack_players = "false",
		follow_owner = "true",
		show_armor = "false",
	},
	on_activate = function(self, staticdata, dtime_s)
		self.object:setvelocity({x=0, y=0, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		local wield_image = get_wield_image(self.metadata.wielditem)
		local textures = {self.properties.textures[1], get_armor_texture(self), wield_image}
		self.object:set_properties({textures = textures})
	end,
	on_rightclick = function(self, clicker)
		local player_name = clicker:get_player_name()
		if player_name == self.owner then
			local blacklist = minetest.formspec_escape(self.metadata.blacklist)
			local whitelist = minetest.formspec_escape(self.metadata.whitelist)
			local formspec = "size[8,6.5]"
				.."field[0.5,2.5;7.5.0,0.5;blacklist;Blacklist (Mob Entities);"..blacklist.."]"
				.."field[0.5,4.0;7.5.0,0.5;whitelist;Whitelist (Player Names);"..whitelist.."]"
				.."checkbox[0.5,4.5;follow_owner;Follow;"..self.metadata.follow_owner.."]"
				.."button[0.0,6.0;2.0,0.5;origin;Set Origin]"
				.."button_exit[7.0,6.0;1.0,0.5;;Ok]"
			if NPCF_GUARD_ATTACK_PLAYERS == true then
				formspec = formspec.."checkbox[4.0,4.5;attack_players;Attack Players;"
					..self.metadata.attack_players.."]"
			end
			npcf:show_formspec(player_name, self.npc_name, formspec)
		end
	end,
	on_step = function(self, dtime)
		if self.timer > 1 then
			self.timer = 0
			local pos = self.object:getpos()
			local yaw = self.object:getyaw()
			local state = NPCF_ANIM_STAND
			local target = {object=nil, distance=0}
			local min_dist = 1000
			local speed = 0
			local acceleration = {x=0, y=-10, z=0}
			local velocity = self.object:getvelocity()
			local attacking = false
			for _,object in ipairs(minetest.get_objects_inside_radius(pos, TARGET_RADIUS)) do
				local to_target = false
				if object:is_player() then
					if NPCF_GUARD_ATTACK_PLAYERS == true and self.metadata.attack_players == "true" then
						local player_name = object:get_player_name()
						if player_name ~= self.owner then
							if not get_name_in_list(self.metadata.whitelist, player_name) then
								to_target = true
							end
						end
					end
				else 
					local luaentity = object:get_luaentity()
					if luaentity then
						if luaentity.name then
							if get_name_in_list(self.metadata.blacklist, luaentity.name) then
								to_target = true
							end
						end
					end
				end
				if to_target == true then
					local op = object:getpos()
					local dv = vector.subtract(pos, op)
					local dy = math.abs(dv.y - 1)
					if dy < math.abs(dv.x) or dy < math.abs(dv.z) then
						local dist = math.floor(vector.distance(pos, op))
						if dist < min_dist then
							target.object = object
							target.distance = dist
							min_dist = dist
						end
					end
				end
			end
			if target.object then
				yaw = npcf:get_face_direction(pos, target.object:getpos())
				if target.distance < 3 then
					attacking = true
					state = NPCF_ANIM_MINE
				end
				if target.distance > 2 then
					speed = get_speed(target.distance) * 1.1
					state = NPCF_ANIM_WALK
					if attacking == true then
						state = NPCF_ANIM_WALK_MINE
					end
				end
				if attacking == true then
					local tool_caps = {full_punch_interval=1.0, damage_groups={fleshy=1}}
					local item = self.metadata.wielditem
					if item ~= "" and minetest.registered_items[item] then
						if minetest.registered_items[item].tool_capabilities then
							tool_caps = minetest.registered_items[item].tool_capabilities
						end
					end
					target.object:punch(self.object, self.var.timer, tool_caps)
				end
			elseif self.metadata.follow_owner == "true" then
				local player = minetest.get_player_by_name(self.owner)
				if player then
					yaw = npcf:get_face_direction(pos, player:getpos())
					local p = player:getpos()
					local distance = vector.distance(pos, {x=p.x, y=pos.y, z=p.z})
					if distance > 3 then
						speed = get_speed(distance)
						state = NPCF_ANIM_WALK
					end
				end
			elseif vector.equals(pos, self.origin.pos) == false then
				yaw = npcf:get_face_direction(pos, self.origin.pos)
				local distance = vector.distance(pos, self.origin.pos)
				if distance > 1 then
					speed = get_speed(distance)
					state = NPCF_ANIM_WALK
				else
					self.object:setpos(self.origin.pos)
					yaw = self.origin.yaw
				end
			end
			local node = minetest.get_node(pos)
			if string.find(node.name, "^default:water") then
				acceleration = {x=0, y=-4, z=0}
				velocity = {x=0, y=3, z=0}
			elseif minetest.find_node_near(pos, 2, {"group:water"}) then
				acceleration = {x=0, y=-1, z=0}				
			end
			self.object:setvelocity(npcf:get_walk_velocity(speed, velocity.y, yaw))
			self.object:setacceleration(acceleration)
			self.object:setyaw(yaw)
			npcf:set_animation(self, state)
		end
	end,
	on_receive_fields = function(self, fields, sender)
		if self.owner == sender:get_player_name() then
			if fields.wielditem then
				local wield_image = get_wield_image(fields.wielditem)
				local textures = {self.properties.textures[1], get_armor_texture(self), wield_image}
				self.object:set_properties({textures = textures})
			end
			if fields.origin then
				self.origin.pos = self.object:getpos()
				self.origin.yaw = self.object:getyaw()
			end
		end
	end,
})