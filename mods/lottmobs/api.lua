lottmobs = {}
function lottmobs:register_mob(name, def)
	minetest.register_entity(name, {
		hp_max = def.hp_max,
		physical = true,
		collisionbox = def.collisionbox,
		visual = def.visual,
		visual_size = def.visual_size,
		mesh = def.mesh,
		textures = def.textures,
		makes_footstep_sound = def.makes_footstep_sound,
		view_range = def.view_range,
		walk_velocity = def.walk_velocity,
		run_velocity = def.run_velocity,
		damage = def.damage,
		light_damage = def.light_damage,
		water_damage = def.water_damage,
		lava_damage = def.lava_damage,
		disable_fall_damage = def.disable_fall_damage,
		drops = def.drops,
		armor = def.armor,
		drawtype = def.drawtype,
		on_rightclick = def.on_rightclick,
		type = def.type,
		attack_type = def.attack_type,
		arrow = def.arrow,
		shoot_interval = def.shoot_interval,
		sounds = def.sounds,
		animation = def.animation,
		follow = def.follow,
		jump = def.jump or true,
		
		timer = 0,
		env_damage_timer = 0, -- only if state = "attack"
		attack = {player=nil, dist=nil},
		state = "stand",
		v_start = false,
		old_y = nil,
		lifetimer = 600,
		tamed = false,
		
		set_velocity = function(self, v)
			local yaw = self.object:getyaw()
			if self.drawtype == "side" then
				yaw = yaw+(math.pi/2)
			end
			local x = math.sin(yaw) * -v
			local z = math.cos(yaw) * v
			self.object:setvelocity({x=x, y=self.object:getvelocity().y, z=z})
		end,
		
		get_velocity = function(self)
			local v = self.object:getvelocity()
			return (v.x^2 + v.z^2)^(0.5)
		end,
		
		set_animation = function(self, type)
			if not self.animation then
				return
			end
			if not self.animation.current then
				self.animation.current = ""
			end
			if type == "stand" and self.animation.current ~= "stand" then
				if
					self.animation.stand_start
					and self.animation.stand_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.stand_start,y=self.animation.stand_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "stand"
				end
			elseif type == "walk" and self.animation.current ~= "walk"  then
				if
					self.animation.walk_start
					and self.animation.walk_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.walk_start,y=self.animation.walk_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "walk"
				end
			elseif type == "run" and self.animation.current ~= "run"  then
				if
					self.animation.run_start
					and self.animation.run_end
					and self.animation.speed_run
				then
					self.object:set_animation(
						{x=self.animation.run_start,y=self.animation.run_end},
						self.animation.speed_run, 0
					)
					self.animation.current = "run"
				end
			elseif type == "punch" and self.animation.current ~= "punch"  then
				if
					self.animation.punch_start
					and self.animation.punch_end
					and self.animation.speed_normal
				then
					self.object:set_animation(
						{x=self.animation.punch_start,y=self.animation.punch_end},
						self.animation.speed_normal, 0
					)
					self.animation.current = "punch"
				end
			end
		end,
		
		on_step = function(self, dtime)
			if self.type == "monster" and minetest.setting_getbool("only_peaceful_lottmobs") then
				self.object:remove()
			end
			
			self.lifetimer = self.lifetimer - dtime
			if self.lifetimer <= 0 and not self.tamed then
				local player_count = 0
				for _,obj in ipairs(minetest.env:get_objects_inside_radius(self.object:getpos(), 20)) do
					if obj:is_player() then
						player_count = player_count+1
					end
				end
				if player_count == 0 and self.state ~= "attack" then
					self.object:remove()
					return
				end
			end
			
			if self.object:getvelocity().y > 0.1 then
				local yaw = self.object:getyaw()
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				local x = math.sin(yaw) * -2
				local z = math.cos(yaw) * 2
				self.object:setacceleration({x=x, y=-10, z=z})
			else
				self.object:setacceleration({x=0, y=-10, z=0})
			end
			
			if self.disable_fall_damage and self.object:getvelocity().y == 0 then
				if not self.old_y then
					self.old_y = self.object:getpos().y
				else
					local d = self.old_y - self.object:getpos().y
					if d > 5 then
						local damage = d-5
						self.object:set_hp(self.object:get_hp()-damage)
						if self.object:get_hp() == 0 then
							self.object:remove()
						end
					end
					self.old_y = self.object:getpos().y
				end
			end
			
			self.timer = self.timer+dtime
			if self.state ~= "attack" then
				if self.timer < 1 then
					return
				end
				self.timer = 0
			end
			
			if self.sounds and self.sounds.random and math.random(1, 100) <= 1 then
				minetest.sound_play(self.sounds.random, {object = self.object})
			end
			
			local do_env_damage = function(self)
				local pos = self.object:getpos()
				local n = minetest.env:get_node(pos)
				
				if self.light_damage and self.light_damage ~= 0
					and pos.y>0
					and minetest.env:get_node_light(pos)
					and minetest.env:get_node_light(pos) > 4
					and minetest.env:get_timeofday() > 0.2
					and minetest.env:get_timeofday() < 0.8
				then
					self.object:set_hp(self.object:get_hp()-self.light_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
					end
				end
				
				if self.water_damage and self.water_damage ~= 0 and
					minetest.get_item_group(n.name, "water") ~= 0
				then
					self.object:set_hp(self.object:get_hp()-self.water_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
					end
				end
				
				if self.lava_damage and self.lava_damage ~= 0 and
					minetest.get_item_group(n.name, "lava") ~= 0
				then
					self.object:set_hp(self.object:get_hp()-self.lava_damage)
					if self.object:get_hp() == 0 then
						self.object:remove()
					end
				end
			end
			
			self.env_damage_timer = self.env_damage_timer + dtime
			if self.state == "attack" and self.env_damage_timer > 1 then
				self.env_damage_timer = 0
				do_env_damage(self)
			elseif self.state ~= "attack" then
				do_env_damage(self)
			end
			
			if self.type == "monster" and minetest.setting_getbool("enable_damage") then
				for _,player in pairs(minetest.get_connected_players()) do
					local s = self.object:getpos()
					local p = player:getpos()
					local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
					if dist < self.view_range then
						if self.attack.dist then
							if self.attack.dist < dist then
								self.state = "attack"
								self.attack.player = player
								self.attack.dist = dist
							end
						else
							self.state = "attack"
							self.attack.player = player
							self.attack.dist = dist
						end
					end
				end
			end
			
			if self.follow ~= "" and not self.following then
				for _,player in pairs(minetest.get_connected_players()) do
					local s = self.object:getpos()
					local p = player:getpos()
					local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
					if self.view_range and dist < self.view_range then
						self.following = player
					end
				end
			end
			
			if self.following and self.following:is_player() then
				if self.following:get_wielded_item():get_name() ~= self.follow then
					self.following = nil
					self.v_start = false
				else
					local s = self.object:getpos()
					local p = self.following:getpos()
					local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
					if dist > self.view_range then
						self.following = nil
						self.v_start = false
					else
						local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
						local yaw = math.atan(vec.z/vec.x)+math.pi/2
						if self.drawtype == "side" then
							yaw = yaw+(math.pi/2)
						end
						if p.x > s.x then
							yaw = yaw+math.pi
						end
						self.object:setyaw(yaw)
						if dist > 2 then
							if not self.v_start then
								self.v_start = true
								self.set_velocity(self, self.walk_velocity)
							else
								if self.jump and self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
									local v = self.object:getvelocity()
									v.y = 5
									self.object:setvelocity(v)
								end
								self.set_velocity(self, self.walk_velocity)
							end
							self:set_animation("walk")
						else
							self.v_start = false
							self.set_velocity(self, 0)
							self:set_animation("stand")
						end
						return
					end
				end
			end
			
			if self.state == "stand" then
				if math.random(1, 4) == 1 then
					self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
				end
				self.set_velocity(self, 0)
				self.set_animation(self, "stand")
				if math.random(1, 100) <= 50 then
					self.set_velocity(self, self.walk_velocity)
					self.state = "walk"
					self.set_animation(self, "walk")
				end
			elseif self.state == "walk" then
				if math.random(1, 100) <= 30 then
					self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
				end
				if self.jump and self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
					local v = self.object:getvelocity()
					v.y = 5
					self.object:setvelocity(v)
				end
				self:set_animation("walk")
				self.set_velocity(self, self.walk_velocity)
				if math.random(1, 100) <= 10 then
					self.set_velocity(self, 0)
					self.state = "stand"
					self:set_animation("stand")
				end
			elseif self.state == "attack" and self.attack_type == "dogfight" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end
				
				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local yaw = math.atan(vec.z/vec.x)+math.pi/2
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				if p.x > s.x then
					yaw = yaw+math.pi
				end
				self.object:setyaw(yaw)
				if self.attack.dist > 2 then
					if not self.v_start then
						self.v_start = true
						self.set_velocity(self, self.run_velocity)
					else
						if self.jump and self.get_velocity(self) <= 0.5 and self.object:getvelocity().y == 0 then
							local v = self.object:getvelocity()
							v.y = 5
							self.object:setvelocity(v)
						end
						self.set_velocity(self, self.run_velocity)
					end
					self:set_animation("run")
				else
					self.set_velocity(self, 0)
					self:set_animation("punch")
					self.v_start = false
					if self.timer > 1 then
						self.timer = 0
						if self.sounds and self.sounds.attack then
							minetest.sound_play(self.sounds.attack, {object = self.object})
						end
						self.attack.player:punch(self.object, 1.0,  {
							full_punch_interval=1.0,
							damage_groups = {fleshy=self.damage}
						}, vec)
					end
				end
			elseif self.state == "attack" and self.attack_type == "shoot" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end
				
				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local yaw = math.atan(vec.z/vec.x)+math.pi/2
				if self.drawtype == "side" then
					yaw = yaw+(math.pi/2)
				end
				if p.x > s.x then
					yaw = yaw+math.pi
				end
				self.object:setyaw(yaw)
				self.set_velocity(self, 0)
				
				if self.timer > self.shoot_interval and math.random(1, 100) <= 60 then
					self.timer = 0
					
					self:set_animation("punch")
					
					if self.sounds and self.sounds.attack then
						minetest.sound_play(self.sounds.attack, {object = self.object})
					end
					
					local p = self.object:getpos()
					p.y = p.y + (self.collisionbox[2]+self.collisionbox[5])/2
					local obj = minetest.env:add_entity(p, self.arrow)
					local amount = (vec.x^2+vec.y^2+vec.z^2)^0.5
					local v = obj:get_luaentity().velocity
					vec.y = vec.y+1
					vec.x = vec.x*v/amount
					vec.y = vec.y*v/amount
					vec.z = vec.z*v/amount
					obj:setvelocity(vec)
				end
			end
		end,
		
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups({fleshy=self.armor})
			self.object:setacceleration({x=0, y=-10, z=0})
			self.state = "stand"
			self.object:setvelocity({x=0, y=self.object:getvelocity().y, z=0})
			self.object:setyaw(math.random(1, 360)/180*math.pi)
			if self.type == "monster" and minetest.setting_getbool("only_peaceful_lottmobs") then
				self.object:remove()
			end
			self.lifetimer = 600 - dtime_s
			if staticdata then
				local tmp = minetest.deserialize(staticdata)
				if tmp and tmp.lifetimer then
					self.lifetimer = tmp.lifetimer - dtime_s
				end
				if tmp and tmp.tamed then
					self.tamed = tmp.tamed
				end
			end
			if self.lifetimer <= 0 and not self.tamed then
				self.object:remove()
			end
		end,
		
		get_staticdata = function(self)
			local tmp = {
				lifetimer = self.lifetimer,
				tamed = self.tamed,
			}
			return minetest.serialize(tmp)
		end,
		
		on_punch = function(self, hitter)
			local weapon = hitter:get_wielded_item()
				if weapon:get_definition().tool_capabilities ~= nil then
					local wear = ( weapon:get_definition().tool_capabilities.full_punch_interval / 75 ) * 65535
					weapon:add_wear(wear)
					hitter:set_wielded_item(weapon)
				end
			if self.object:get_hp() <= 0 then
				if hitter and hitter:is_player() and hitter:get_inventory() then
					for _,drop in ipairs(self.drops) do
						if math.random(1, drop.chance) == 1 then
							hitter:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
						end
					end
				end
			end
		end,
		
	})
end

lottmobs.spawning_lottmobs = {}
function lottmobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height, spawn_func)
	lottmobs.spawning_lottmobs[name] = true
	minetest.register_abm({
		nodenames = nodes,
		neighbors = {"air"},
		interval = 30,
		chance = chance,
		action = function(pos, node, _, active_object_count_wider)
			if active_object_count_wider > active_object_count then
				return
			end
			if not lottmobs.spawning_lottmobs[name] then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) > max_light then
				return
			end
			if minetest.env:get_node_light(pos) < min_light then
				return
			end
			if pos.y > max_height then
				return
			end
			if minetest.env:get_node(pos).name ~= "air" then
				return
			end
			pos.y = pos.y+1
			if minetest.env:get_node(pos).name ~= "air" then
				return
			end
			if spawn_func and not spawn_func(pos, node) then
				return
			end
			
			if minetest.setting_getbool("display_mob_spawn") then
				minetest.chat_send_all("[lottmobs] Add "..name.." at "..minetest.pos_to_string(pos))
			end
			minetest.env:add_entity(pos, name)
		end
	})
end

function lottmobs:register_arrow(name, def)
	minetest.register_entity(name, {
		physical = false,
		visual = def.visual,
		visual_size = def.visual_size,
		textures = def.textures,
		velocity = def.velocity,
		hit_player = def.hit_player,
		hit_node = def.hit_node,
		
		on_step = function(self, dtime)
			local pos = self.object:getpos()
			if minetest.env:get_node(self.object:getpos()).name ~= "air" then
				self.hit_node(self, pos, node)
				self.object:remove()
				return
			end
			pos.y = pos.y-1
			for _,player in pairs(minetest.env:get_objects_inside_radius(pos, 1)) do
				if player:is_player() then
					self.hit_player(self, player)
					self.object:remove()
					return
				end
			end
		end
	})
end
