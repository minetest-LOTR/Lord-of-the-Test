-- Mobs Api (17th September 2015)
mobs = {}
mobs.mod = "redo"

-- Load settings
local damage_enabled = minetest.setting_getbool("enable_damage")
local peaceful_only = minetest.setting_getbool("only_peaceful_mobs")
local disable_blood = minetest.setting_getbool("mobs_disable_blood")
mobs.protected = tonumber(minetest.setting_get("mobs_spawn_protected")) or 1
mobs.remove = minetest.setting_getbool("remove_far_mobs")

function mobs:register_mob(name, def)
	minetest.register_entity(name, {
		stepheight = def.stepheight or 0.6,
		name = name,
		fly = def.fly,
		fly_in = def.fly_in or "air",
		owner = def.owner or "",
		order = def.order or "",
		on_die = def.on_die,
		do_custom = def.do_custom,
		jump_height = def.jump_height or 6,
		jump_chance = def.jump_chance or 0,
		rotate = math.rad(def.rotate or 0), --  0=front, 90=side, 180=back, 270=side2
		lifetimer = def.lifetimer or 180, -- 3 minutes
		hp_min = def.hp_min or 5,
		hp_max = def.hp_max or 10,
		physical = true,
		collisionbox = def.collisionbox,
		visual = def.visual,
		visual_size = def.visual_size or {x = 1, y = 1},
		mesh = def.mesh,
		makes_footstep_sound = def.makes_footstep_sound or false,
		view_range = def.view_range or 5,
		walk_velocity = def.walk_velocity or 1,
		run_velocity = def.run_velocity or 2,
		damage = def.damage,
		light_damage = def.light_damage or 0,
		water_damage = def.water_damage or 0,
		lava_damage = def.lava_damage or 0,
		fall_damage = def.fall_damage or 1,
		fall_speed = def.fall_speed or -10, -- must be lower than -2 (default: -10)
		drops = def.drops or {},
		armor = def.armor,
		on_rightclick = def.on_rightclick,
		type = def.type,
		attack_type = def.attack_type,
		arrow = def.arrow,
		shoot_interval = def.shoot_interval,
		sounds = def.sounds or {},
		animation = def.animation,
		follow = def.follow, -- or "",
		jump = def.jump or true,
		walk_chance = def.walk_chance or 50,
		attacks_monsters = def.attacks_monsters or false,
		group_attack = def.group_attack or false,
		--fov = def.fov or 120,
		passive = def.passive or false,
		recovery_time = def.recovery_time or 0.5,
		knock_back = def.knock_back or 3,
		blood_amount = def.blood_amount or 5,
		blood_texture = def.blood_texture or "mobs_blood.png",
		shoot_offset = def.shoot_offset or 0,
		floats = def.floats or 1, -- floats in water by default
		replace_rate = def.replace_rate,
		replace_what = def.replace_what,
		replace_with = def.replace_with,
		replace_offset = def.replace_offset or 0,
		timer = 0,
		env_damage_timer = 0, -- only if state = "attack"
		attack = {player = nil, dist = nil},
		state = "stand",
		tamed = false,
		pause_timer = 0,
		horny = false,
		hornytimer = 0,
		child = false,
		gotten = false,
		health = 0,
		id = (math.random(1, 1000) * math.random(1, 10000)) .. name .. (math.random(1, 1000) ^ 2),

		do_attack = function(self, player, dist)
			if self.state ~= "attack" then
				if math.random(0,100) < 90
				and self.sounds.war_cry then
					minetest.sound_play(self.sounds.war_cry,{
						object = self.object,
						max_hear_distance = self.sounds.distance
					})
				end
				self.state = "attack"
				self.attack.player = player
				self.attack.dist = dist
			end
		end,

		set_velocity = function(self, v)
			v = (v or 0)
			if def.drawtype
			and def.drawtype == "side" then
				self.rotate = math.rad(90)
			end
			local yaw = self.object:getyaw() + self.rotate
			local x = math.sin(yaw) * -v
			local z = math.cos(yaw) * v
			self.object:setvelocity({x = x, y = self.object:getvelocity().y, z = z})
		end,

		get_velocity = function(self)
			local v = self.object:getvelocity()
			return (v.x ^ 2 + v.z ^ 2) ^ (0.5)
		end,
--[[
		in_fov = function(self, pos)
			-- checks if POS is in self's FOV
			local yaw = self.object:getyaw() + self.rotate
			local vx = math.sin(yaw)
			local vz = math.cos(yaw)
			local ds = math.sqrt(vx ^ 2 + vz ^ 2)
			local ps = math.sqrt(pos.x ^ 2 + pos.z ^ 2)
			local d = {x = vx / ds, z = vz / ds}
			local p = {x = pos.x / ps, z = pos.z / ps}
			local an = (d.x * p.x) + (d.z * p.z)

			if math.deg(math.acos(an)) > (self.fov / 2) then
				return false
			end
			return true
		end,
]]
		set_animation = function(self, type)
			if not self.animation then
				return
			end
			if not self.animation.current then
				self.animation.current = ""
			end
			if type == "stand"
			and self.animation.current ~= "stand" then
				if self.animation.stand_start
				and self.animation.stand_end
				and self.animation.speed_normal then
					self.object:set_animation({
						x = self.animation.stand_start,
						y = self.animation.stand_end},
						self.animation.speed_normal, 0)
					self.animation.current = "stand"
				end
			elseif type == "walk"
			and self.animation.current ~= "walk"  then
				if self.animation.walk_start
				and self.animation.walk_end
				and self.animation.speed_normal then
					self.object:set_animation({
						x = self.animation.walk_start,
						y = self.animation.walk_end},
						self.animation.speed_normal, 0)
					self.animation.current = "walk"
				end
			elseif type == "run"
			and self.animation.current ~= "run"  then
				if self.animation.run_start
				and self.animation.run_end
				and self.animation.speed_run then
					self.object:set_animation({
						x = self.animation.run_start,
						y = self.animation.run_end},
						self.animation.speed_run, 0)
					self.animation.current = "run"
				end
			elseif type == "punch"
			and self.animation.current ~= "punch"  then
				if self.animation.punch_start
				and self.animation.punch_end
				and self.animation.speed_normal then
					self.object:set_animation({
						x = self.animation.punch_start,
						y = self.animation.punch_end},
						self.animation.speed_normal, 0)
					self.animation.current = "punch"
				end
			end
		end,

		on_step = function(self, dtime)

			if (self.type == "monster" and peaceful_only)
			or not within_limits(self.object:getpos(), 0) then
				self.object:remove()
				return
			end

			-- if lifetimer run out and not npc; tamed or attacking then remove mob
			if self.type ~= "npc"
			and not self.tamed then
				self.lifetimer = self.lifetimer - dtime
				if self.lifetimer <= 0
				and self.state ~= "attack" then
					minetest.log("action",
						"lifetimer expired, removed "..self.name)
					effect(self.object:getpos(), 15, "tnt_smoke.png")
					self.object:remove()
					return
				end
			end

			-- check for mob drop/replace (used for chicken egg and sheep eating grass/wheat)
			if self.replace_rate
			and self.child == false
			and math.random(1,self.replace_rate) == 1 then
				local pos = self.object:getpos()
				pos.y = pos.y + self.replace_offset
				-- print ("replace node = ".. minetest.get_node(pos).name, pos.y)
				if self.replace_what
				and self.object:getvelocity().y == 0
				and #minetest.find_nodes_in_area(pos, pos, self.replace_what) > 0 then
				--and self.state == "stand" then
					minetest.set_node(pos, {name = self.replace_with})
				end
			end

			local yaw = 0

			if not self.fly then
				-- floating in water (or falling)
				local pos = self.object:getpos()
				local nod = minetest.get_node_or_nil(pos)
				if nod then nod = nod.name else nod = "default:dirt" end
				local nodef = minetest.registered_nodes[nod]

				local v = self.object:getvelocity()
				if v.y > 0.1 then
					self.object:setacceleration({
						x = 0,
						y = self.fall_speed,
						z = 0
					})
				end
				if nodef.groups.water then
					if self.floats == 1 then
						self.object:setacceleration({
							x = 0,
							y = -self.fall_speed / (math.max(1, v.y) ^ 2),
							z = 0
						})
					end
				else
					self.object:setacceleration({
						x = 0,
						y = self.fall_speed,
						z = 0
					})

					-- fall damage
					if self.fall_damage == 1
					and self.object:getvelocity().y == 0 then
						local d = (self.old_y or 0) - self.object:getpos().y
						if d > 5 then
							self.object:set_hp(self.object:get_hp() - math.floor(d - 5))
							effect(self.object:getpos(), 5, "tnt_smoke.png")
							check_for_death(self)
						end
						self.old_y = self.object:getpos().y
					end
				end
			end

			-- knockback timer
			if self.pause_timer > 0 then
				self.pause_timer = self.pause_timer - dtime
				if self.pause_timer < 1 then
					self.pause_timer = 0
				end
				return
			end

			-- attack timer
			self.timer = self.timer + dtime
			if self.state ~= "attack" then
				if self.timer < 1 then
					return
				end
				self.timer = 0
			end

			if self.sounds.random
			and math.random(1, 100) <= 1 then
				minetest.sound_play(self.sounds.random, {
					object = self.object,
					max_hear_distance = self.sounds.distance
				})
			end

			local do_env_damage = function(self)

				local pos = self.object:getpos()
				local tod = minetest.get_timeofday()

				-- daylight above ground
				if self.light_damage ~= 0
				and pos.y > 0
				and tod > 0.2
				and tod < 0.8
				and (minetest.get_node_light(pos) or 0) > 12 then
					self.object:set_hp(self.object:get_hp() - self.light_damage)
					effect(pos, 5, "tnt_smoke.png")
					if check_for_death(self) then return end
				end

				pos.y = pos.y + self.collisionbox[2] -- foot level
				local nod = minetest.get_node_or_nil(pos)
				if not nod then return end ;  -- print ("standing in "..nod.name)
				local nodef = minetest.registered_nodes[nod.name]
				pos.y = pos.y + 1

				-- water
				if self.water_damage ~= 0
				and nodef.groups.water then
					self.object:set_hp(self.object:get_hp() - self.water_damage)
					effect(pos, 5, "bubble.png")
					if check_for_death(self) then return end
				end

				-- lava or fire
				if self.lava_damage ~= 0
				and (nodef.groups.lava
					or nod.name == "fire:basic_flame"
					or nod.name == "xanadu:safe_fire") then
					self.object:set_hp(self.object:get_hp() - self.lava_damage)
					effect(pos, 5, "fire_basic_flame.png")
					if check_for_death(self) then return end
				end

			end

			local do_jump = function(self)
				if self.fly then
					return
				end

				self.jumptimer = (self.jumptimer or 0) + 1
				if self.jumptimer < 3 then
					local pos = self.object:getpos()
					pos.y = (pos.y + self.collisionbox[2]) - 0.2
					local nod = minetest.get_node_or_nil(pos)
--print ("standing on:", nod.name, pos.y)
					if not nod
					or not minetest.registered_nodes[nod.name]
					or minetest.registered_nodes[nod.name].walkable == false then
						return
					end
					if self.direction then
						pos.y = pos.y + 0.5
						local nod = minetest.get_node_or_nil({
							x = pos.x + self.direction.x,
							y = pos.y,
							z = pos.z + self.direction.z
						})
--print ("in front:", nod.name, pos.y)
						if nod and nod.name and
						(nod.name ~= "air"
						or self.walk_chance == 0) then
							local def = minetest.registered_items[nod.name]
							if (def
							and def.walkable
							and not nod.name:find("fence"))
							or self.walk_chance == 0 then
								local v = self.object:getvelocity()
								v.y = self.jump_height + 1
								v.x = v.x * 2.2
								v.z = v.z * 2.2
								self.object:setvelocity(v)
								if self.sounds.jump then
									minetest.sound_play(self.sounds.jump, {
										object = self.object,
										max_hear_distance = self.sounds.distance
									})
								end
							end
						end
					end
				else
					self.jumptimer = 0
				end
			end

			-- environmental damage timer (every 1 second)
			self.env_damage_timer = self.env_damage_timer + dtime
			if self.state == "attack"
			and self.env_damage_timer > 1 then
				self.env_damage_timer = 0
				do_env_damage(self)
				-- custom function (defined in mob lua file)
				if self.do_custom then
					self.do_custom(self)
				end
			elseif self.state ~= "attack" then
				do_env_damage(self)
				-- custom function
				if self.do_custom then
					self.do_custom(self)
				end
			end

			-- find someone to attack
			if self.type == "monster"
			and damage_enabled
			and self.state ~= "attack" then

				local s = self.object:getpos()
				local p, sp, dist
				local player = nil
				local type = nil
				local obj = nil
				local min_dist = self.view_range + 1
				local min_player = nil

				for _,oir in ipairs(minetest.get_objects_inside_radius(s, self.view_range)) do

					if oir:is_player() then
						player = oir
						type = "player"
					else
						obj = oir:get_luaentity()
						if obj then
							player = obj.object
							type = obj.type
						end
					end

					if type == "player"
					or type == "npc" then
						s = self.object:getpos()
						p = player:getpos()
						sp = s
						p.y = p.y + 1
						sp.y = sp.y + 1 -- aim higher to make looking up hills more realistic
						dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5
						if dist < self.view_range then
						-- and self.in_fov(self,p) then
							-- choose closest player to attack
							if minetest.line_of_sight(sp, p, 2) == true
							and dist < min_dist then
								min_dist = dist
								min_player = player
							end
						end
					end
				end
				-- attack player
				if min_player then
					self.do_attack(self, min_player, min_dist)
				end
			end

			-- npc, find closest monster to attack
			local min_dist = self.view_range + 1
			local min_player = nil

			if self.type == "npc"
			and self.attacks_monsters
			and self.state ~= "attack" then
				local s = self.object:getpos()
				local obj = nil
				for _, oir in pairs(minetest.get_objects_inside_radius(s,self.view_range)) do
					obj = oir:get_luaentity()
					if obj
					and obj.type == "monster" then
						-- attack monster
						p = obj.object:getpos()
						dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5
						if dist < min_dist then
							min_dist = dist
							min_player = obj.object
						end
					end
				end
				if min_player then
					self.do_attack(self, min_player, min_dist)
				end
			end

			-- horny animal can mate for 40 seconds, afterwards horny animal cannot mate again for 200 seconds
			if self.horny == true
			and self.hornytimer < 240
			and self.child == false then
				self.hornytimer = self.hornytimer + 1
				if self.hornytimer >= 240 then
					self.hornytimer = 0
					self.horny = false
				end
			end

			-- if animal is child take 240 seconds before growing into adult
			if self.child == true then
				self.hornytimer = self.hornytimer + 1
				if self.hornytimer > 240 then
					self.child = false
					self.hornytimer = 0
					self.object:set_properties({
						textures = self.base_texture,
						mesh = self.base_mesh,
						visual_size = self.base_size,
						collisionbox = self.base_colbox,
					})
					-- jump when grown to now fall into ground
					local v = self.object:getvelocity()
					v.y = self.jump_height
					v.x = 0 ; v.z = 0
					self.object:setvelocity(v)
				end
			end

			-- if animal is horny, find another same animal who is horny and mate
			if self.horny == true
			and self.hornytimer <= 40 then
				local pos = self.object:getpos()
				effect({x = pos.x, y = pos.y + 1, z = pos.z}, 4, "heart.png")
				local ents = minetest.get_objects_inside_radius(pos, self.view_range)
				local num = 0
				local ent = nil
				for i,obj in ipairs(ents) do
					ent = obj:get_luaentity()

					-- check for same animal with different colour
					local canmate = false
					if ent then
						if ent.name == self.name then
							canmate = true
						else
							local entname = string.split(ent.name,":")
							local selfname = string.split(self.name,":")
							if entname[1] == selfname[1] then
								entname = string.split(entname[2],"_")
								selfname = string.split(selfname[2],"_")
								if entname[1] == selfname[1] then
									canmate = true
								end
							end
						end
					end

					if ent
					and canmate == true
					and ent.horny == true
					and ent.hornytimer <= 40 then
						num = num + 1
					end
					if num > 1 then
						self.hornytimer = 41
						ent.hornytimer = 41
						minetest.after(7, function(dtime)
							local mob = minetest.add_entity(pos, self.name)
							local ent2 = mob:get_luaentity()
							local textures = self.base_texture
							if def.child_texture then
								textures = def.child_texture[1]
							end
							mob:set_properties({
								textures = textures,
								visual_size = {
									x = self.base_size.x / 2,
									y = self.base_size.y / 2
								},
								collisionbox = {
									self.base_colbox[1] / 2,
									self.base_colbox[2] / 2,
									self.base_colbox[3] / 2,
									self.base_colbox[4] / 2,
									self.base_colbox[5] / 2,
									self.base_colbox[6] / 2
								},
							})
							ent2.child = true
							ent2.tamed = true
							ent2.owner = self.owner
						end)
						num = 0
						break
					end
				end
			end

			-- find player to follow
			if (self.follow ~= ""
			or self.order == "follow")
			and not self.following
			and self.state ~= "attack" then
				local s, p, dist
				for _,player in pairs(minetest.get_connected_players()) do
					s = self.object:getpos()
					p = player:getpos()
					dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5
					if dist < self.view_range then
						self.following = player
						break
					end
				end
			end

			if self.type == "npc"
			and self.order == "follow"
			and self.state ~= "attack"
			and self.owner ~= "" then
				-- npc stop following player if not owner
				if self.following
				and self.owner
				and self.owner ~= self.following:get_player_name() then
					self.following = nil
				end
			else
				-- stop following player if not holding specific item
				if self.following
				and self.following.is_player
				--and self.following:get_wielded_item():get_name() ~= self.follow then
				and follow_holding(self, self.following) == false then
					self.following = nil
				end
			end

			-- follow player or mob
			if self.following then
				local s = self.object:getpos()
				local p

				if self.following.is_player
				and self.following:is_player() then
					p = self.following:getpos()
				elseif self.following.object then
					p = self.following.object:getpos()
				end

				if p then
					local dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5
					if dist > self.view_range then
						self.following = nil
					else
						local vec = {x = p.x - s.x, y = p.y - s.y, z = p.z - s.z}
						yaw = (math.atan(vec.z / vec.x) + math.pi / 2) - self.rotate
						if p.x > s.x then
							yaw = yaw + math.pi
						end
						self.object:setyaw(yaw)

						-- anyone but standing npc's can move along
						if dist > 3 -- was 2
						and self.order ~= "stand" then
							if (self.jump
							and self.get_velocity(self) <= 0.5
							and self.object:getvelocity().y == 0)
							or (self.object:getvelocity().y == 0
							and self.jump_chance > 0) then
								self.direction = {
									x = math.sin(yaw) * -1,
									y = -20,
									z = math.cos(yaw)
								}
								do_jump(self)
							end
							self.set_velocity(self, self.walk_velocity)
							if self.walk_chance ~= 0 then
								self:set_animation("walk")
							end
						else
							self.set_velocity(self, 0)
							self:set_animation("stand")
						end
						return
					end
				end
			end

			if self.state == "stand" then
				-- randomly turn
				if math.random(1, 4) == 1 then
					-- if there is a player nearby look at them
					local lp = nil
					local s = self.object:getpos()

					if self.type == "npc" then
						local o = minetest.get_objects_inside_radius(self.object:getpos(), 3)

						local yaw = 0
						for _,o in ipairs(o) do
							if o:is_player() then
								lp = o:getpos()
								break
							end
						end
					end

					if lp ~= nil then
						local vec = {x = lp.x - s.x, y = lp.y - s.y, z = lp.z - s.z}
						yaw = (math.atan(vec.z / vec.x) + math.pi / 2) - self.rotate
						if lp.x > s.x then
							yaw = yaw + math.pi
						end
					else
						yaw = self.object:getyaw() + ((math.random(0, 360) - 180) / 180 * math.pi)
					end
					self.object:setyaw(yaw)
				end

				self.set_velocity(self, 0)
				self.set_animation(self, "stand")

				-- npc's ordered to stand stay standing
				if self.type == "npc"
				and self.order == "stand" then
					self.set_velocity(self, 0)
					self.state = "stand"
					self:set_animation("stand")
				else
					if self.walk_chance ~= 0
					and math.random(1, 100) <= self.walk_chance then
						self.set_velocity(self, self.walk_velocity)
						self.state = "walk"
						self.set_animation(self, "walk")
					end

					-- jumping mobs only
--					if self.jump and math.random(1, 100) <= self.jump_chance then
--						self.direction = {x = 0, y = 0, z = 0}
--						do_jump(self)
--						self.set_velocity(self, self.walk_velocity)
--					end
				end

			elseif self.state == "walk" then
				local s = self.object:getpos()
				local lp = minetest.find_node_near(s, 1, {"group:water"})

-- water swimmers cannot move out of water
if self.fly
and self.fly_in == "default:water_source"
and not lp then
	print ("out of water")
	self.set_velocity(self, 0)
	self.state = "flop" -- change to undefined state so nothing more happens
	self:set_animation("stand")
	return
end
				-- if water nearby then turn away
				if lp then
					local vec = {x = lp.x - s.x, y = lp.y - s.y, z = lp.z - s.z}
					yaw = math.atan(vec.z / vec.x) + 3 * math.pi / 2 - self.rotate
					if lp.x > s.x then
						yaw = yaw + math.pi
					end
					self.object:setyaw(yaw)

				-- otherwise randomly turn
				elseif math.random(1, 100) <= 30 then
					self.object:setyaw(self.object:getyaw() + ((math.random(0, 360) - 180) / 180 * math.pi))
				end
				if self.jump and self.get_velocity(self) <= 0.5
				and self.object:getvelocity().y == 0 then
					self.direction = {
						x = math.sin(yaw) * -1,
						y = -20,
						z = math.cos(yaw)
					}
					do_jump(self)
				end

				self:set_animation("walk")
				self.set_velocity(self, self.walk_velocity)
				if math.random(1, 100) <= 30 then
					self.set_velocity(self, 0)
					self.state = "stand"
					self:set_animation("stand")
				end

			-- exploding mobs
			elseif self.state == "attack" and self.attack_type == "explode" then
				if not self.attack.player
				or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					self.timer = 0
					self.blinktimer = 0
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5
				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)
					self.timer = 0
					self.blinktimer = 0
					self.attack = {player = nil, dist = nil}
					self:set_animation("stand")
					return
				else
					self:set_animation("walk")
					self.attack.dist = dist
				end

				local vec = {x = p.x - s.x, y = p.y - s.y, z = p.z - s.z}
				yaw = math.atan(vec.z / vec.x) + math.pi / 2 - self.rotate
				if p.x > s.x then
					yaw = yaw + math.pi
				end
				self.object:setyaw(yaw)
				if self.attack.dist > 3 then
					if not self.v_start then
						self.v_start = true
						self.set_velocity(self, self.run_velocity)
						self.timer = 0
						self.blinktimer = 0
					else
						self.timer = 0
						self.blinktimer = 0
						if self.get_velocity(self) <= 0.5
						and self.object:getvelocity().y == 0 then
							local v = self.object:getvelocity()
							v.y = 5
							self.object:setvelocity(v)
						end
						self.set_velocity(self, self.run_velocity)
					end
					self:set_animation("run")
				else
					self.set_velocity(self, 0)
					self.timer = self.timer + dtime
					self.blinktimer = (self.blinktimer or 0) + dtime
					if self.blinktimer > 0.2 then
						self.blinktimer = 0
						if self.blinkstatus then
							self.object:settexturemod("")
						else
							self.object:settexturemod("^[brighten")
						end
						self.blinkstatus = not self.blinkstatus
					end
					if self.timer > 3 then
						local pos = vector.round(self.object:getpos())
						entity_physics(pos, 3) -- hurt player/mobs caught in blast area
						if minetest.find_node_near(pos, 1, {"group:water"})
						or minetest.is_protected(pos, "") then
							self.object:remove()
							if self.sounds.explode ~= "" then
								minetest.sound_play(self.sounds.explode, {
									pos = pos,
									gain = 1.0,
									max_hear_distance = 16
								})
							end
							effect(pos, 15, "tnt_smoke.png", 5)
							return
						end
						self.object:remove()
						pos.y = pos.y - 1
						mobs:explosion(pos, 2, 0, 1, self.sounds.explode)
					end
				end
				-- end of exploding mobs

			elseif self.state == "attack"
			and self.attack_type == "dogfight" then
				if not self.attack.player
				or not self.attack.player:getpos() then
					print("stop attacking")
					self.state = "stand"
					self:set_animation("stand")
					return
				end
				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				local dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5

				-- fly bit modified from BlockMens creatures mod
				if self.fly
				and dist > 2 then

					local nod = minetest.get_node_or_nil(s)
					local p1 = s
					local me_y = math.floor(p1.y)
					local p2 = p
					local p_y = math.floor(p2.y + 1)
					local v = self.object:getvelocity()
					if nod
					and nod.name == self.fly_in then
						if me_y < p_y then
							self.object:setvelocity({
								x = v.x,
								y = 1 * self.walk_velocity,
								z = v.z
							})
						elseif me_y > p_y then
							self.object:setvelocity({
								x = v.x,
								y = -1 * self.walk_velocity,
								z = v.z
							})
						end
					else
						if me_y < p_y then
							self.object:setvelocity({
								x = v.x,
								y = 0.01,
								z = v.z
							})
						elseif me_y > p_y then
							self.object:setvelocity({
								x = v.x,
								y = -0.01,
								z = v.z
							})
						end
					end

				end
				-- end fly bit

				if dist > self.view_range
				or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.set_velocity(self, 0)
					self.attack = {player = nil, dist = nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end

				local vec = {x = p.x - s.x, y = p.y - s.y, z = p.z - s.z}
				yaw = (math.atan(vec.z / vec.x) + math.pi / 2) - self.rotate
				if p.x > s.x then
					yaw = yaw + math.pi
				end
				self.object:setyaw(yaw)
				-- attack distance is 2 + half of mob width so the bigger mobs can attack (like slimes)
				if self.attack.dist > ((-self.collisionbox[1] + self.collisionbox[4]) / 2) + 2 then
					-- jump attack
					if (self.jump
					and self.get_velocity(self) <= 0.5
					and self.object:getvelocity().y == 0)
					or (self.object:getvelocity().y == 0
					and self.jump_chance > 0) then
						self.direction = {
							x = math.sin(yaw) * -1,
							y = -20,
							z = math.cos(yaw)
						}
						do_jump(self)
					end
					self.set_velocity(self, self.run_velocity)
					self:set_animation("run")
				else
					self.set_velocity(self, 0)
					self:set_animation("punch")
					if self.timer > 1 then
						self.timer = 0
						local p2 = p
						local s2 = s
						p2.y = p2.y + 1.5
						s2.y = s2.y + 1.5
						if minetest.line_of_sight(p2, s2) == true then
							if self.sounds.attack then
								minetest.sound_play(self.sounds.attack, {
									object = self.object,
									max_hear_distance = self.sounds.distance
								})
							end
							self.attack.player:punch(self.object, 1.0,  {
								full_punch_interval=1.0,
								damage_groups = {fleshy=self.damage}
							}, vec)
							if self.attack.player:get_hp() <= 0 then
								self.state = "stand"
								self:set_animation("stand")
							end
						end
					end
				end

			elseif self.state == "attack"
			and self.attack_type == "shoot" then

				local s = self.object:getpos()
				local p = self.attack.player:getpos()
				if not p then
					self.state = "stand"
					return
				end
				p.y = p.y - .5
				s.y = s.y + .5
				local dist = ((p.x - s.x) ^ 2 + (p.y - s.y) ^ 2 + (p.z - s.z) ^ 2) ^ 0.5
				if dist > self.view_range
				or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.set_velocity(self, 0)
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end

				local vec = {x = p.x - s.x, y = p.y - s.y, z = p.z - s.z}
				yaw = (math.atan(vec.z / vec.x) + math.pi / 2) - self.rotate
				if p.x > s.x then
					yaw = yaw + math.pi
				end
				self.object:setyaw(yaw)
				self.set_velocity(self, 0)

				if self.shoot_interval
				and self.timer > self.shoot_interval
				and math.random(1, 100) <= 60 then
					self.timer = 0

					self:set_animation("punch")

					if self.sounds.attack then
						minetest.sound_play(self.sounds.attack, {
							object = self.object,
							max_hear_distance = self.sounds.distance
						})
					end

					local p = self.object:getpos()
					p.y = p.y + (self.collisionbox[2] + self.collisionbox[5]) / 2
					local obj = minetest.add_entity(p, self.arrow)
					local amount = (vec.x ^ 2 + vec.y ^ 2 + vec.z ^ 2) ^ 0.5
					local v = obj:get_luaentity().velocity
					vec.y = vec.y + self.shoot_offset -- this makes shoot aim accurate
					vec.x = vec.x *v / amount
					vec.y = vec.y *v / amount
					vec.z = vec.z *v / amount
					obj:setvelocity(vec)
				end
			end
		end,

		on_activate = function(self, staticdata, dtime_s)

			if self.type == "monster"
			and peaceful_only then
				self.object:remove()
			end

			-- load entity variables
			if staticdata then
				local tmp = minetest.deserialize(staticdata)
				if tmp then
					for _,stat in pairs(tmp) do
						self[_] = stat
					end
				end
			end

			-- select random texture, set model and size
			if not self.base_texture then
				self.base_texture = def.textures[math.random(1, #def.textures)]
				self.base_mesh = def.mesh
				self.base_size = self.visual_size
				self.base_colbox = self.collisionbox
			end

			-- set texture, model and size
			local textures = self.base_texture
			local mesh = self.base_mesh
			local vis_size = self.base_size
			local colbox = self.base_colbox

			-- specific texture if gotten
			if self.gotten == true
			and def.gotten_texture then
				textures = def.gotten_texture
			end

			-- specific mesh if gotten
			if self.gotten == true
			and def.gotten_mesh then
				mesh = def.gotten_mesh
			end

			-- if object is child then set half size
			if self.child == true then
				vis_size = {
					x = self.base_size.x / 2,
					y = self.base_size.y / 2
				}
				if def.child_texture then
					textures = def.child_texture[1]
				end
				colbox = {
					self.base_colbox[1] / 2,
					self.base_colbox[2] / 2,
					self.base_colbox[3] / 2,
					self.base_colbox[4] / 2,
					self.base_colbox[5] / 2,
					self.base_colbox[6] / 2
				}
			end

			if self.health == 0 then
				self.health = math.random (self.hp_min, self.hp_max)
			end

			self.object:set_hp( self.health )
			self.object:set_armor_groups({fleshy = self.armor})
			self.state = "stand"
			--self.order = "stand"
			self.following = nil
			self.old_y = self.object:getpos().y
			self.object:setyaw(math.random(1, 360) / 180 * math.pi)
			self.sounds.distance = (self.sounds.distance or 10)
			self.textures = textures
			self.mesh = mesh
			self.collisionbox = colbox
			self.visual_size = vis_size
			-- set anything changed above
			self.object:set_properties(self)

		end,

		get_staticdata = function(self)

			-- remove mob when out of range unless tamed
			if mobs.remove and self.remove_ok and not self.tamed then
				print ("REMOVED", self.remove_ok, self.name)
				self.object:remove()
			end
			self.remove_ok = true
			self.attack = nil
			self.following = nil

			local tmp = {}
			for _,stat in pairs(self) do
				local t = type(stat)
				if  t ~= 'function'
				and t ~= 'nil'
				and t ~= 'userdata' then
					tmp[_] = self[_]
				end
			end
			-- print('===== '..self.name..'\n'.. dump(tmp)..'\n=====\n')
			return minetest.serialize(tmp)
		end,

		on_punch = function(self, hitter, tflp, tool_capabilities, dir)
			-- weapon wear
			local weapon = hitter:get_wielded_item()
			local punch_interval = tool_capabilities.full_punch_interval or 1.4
			if weapon:get_definition().tool_capabilities ~= nil then
				local wear = (punch_interval / 75) * 9000
				weapon:add_wear(wear)
				hitter:set_wielded_item(weapon)
			end

			-- weapon sounds
			if weapon:get_definition().sounds ~= nil then
				local s = math.random(0, #weapon:get_definition().sounds)
				minetest.sound_play(weapon:get_definition().sounds[s], {
					object=hitter,
					max_hear_distance = 8
				})
			else
				minetest.sound_play("default_punch", {
					object = hitter,
					max_hear_distance = 5
				})
			end

			-- exit here if dead
			if check_for_death(self) then
				return
			end

			-- blood_particles
			if self.blood_amount > 0
			and not disable_blood then
				local pos = self.object:getpos()
				pos.y = pos.y + (-self.collisionbox[2] + self.collisionbox[5]) / 2
				effect(pos, self.blood_amount, self.blood_texture)
			end

			-- knock back effect
			if self.knock_back > 0 then
				local kb = self.knock_back
				local r = self.recovery_time
				local v = self.object:getvelocity()
				if tflp < tool_capabilities.full_punch_interval then
					if kb > 0 then
						kb = kb * ( tflp / tool_capabilities.full_punch_interval )
					end
					r = r * ( tflp / tool_capabilities.full_punch_interval )
				end
				self.object:setvelocity({x = dir.x * kb,y = 0,z = dir.z * kb})
				self.pause_timer = r
			end

			-- attack puncher and call other mobs for help
			if self.passive == false
			and not self.tamed then
				if self.state ~= "attack" then
					self.do_attack(self, hitter, 1)
				end
				-- alert others to the attack
				local obj = nil
				for _, oir in pairs(minetest.get_objects_inside_radius(hitter:getpos(), 5)) do
					obj = oir:get_luaentity()
					if obj then
						if obj.group_attack == true
						and obj.state ~= "attack" then
							obj.do_attack(obj, hitter, 1)
						end
					end
				end
			end
		end,
	})
end

mobs.spawning_mobs = {}

function mobs:spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)
	mobs.spawning_mobs[name] = true
	minetest.register_abm({
		nodenames = nodes,
		neighbors = neighbors,
		interval = interval,
		chance = chance,
		action = function(pos, node, _, active_object_count_wider)
			-- do not spawn if too many active entities in area
			if active_object_count_wider > active_object_count
			or not mobs.spawning_mobs[name] then
			--or not pos then
				return
			end

			-- spawn above node
			pos.y = pos.y + 1

			-- mobs cannot spawn inside protected areas if enabled
			if mobs.protected == 1
			and minetest.is_protected(pos, "") then
				return
			end

			-- check if light and height levels are ok to spawn
			local light = minetest.get_node_light(pos)
			if not light
			or light > max_light
			or light < min_light
			or pos.y > max_height
			or pos.y < min_height then
				return
			end

			-- are we spawning inside a solid node?
			local nod = minetest.get_node_or_nil(pos)
			if not nod
			or not nod.name
			or not minetest.registered_nodes[nod.name]
			or minetest.registered_nodes[nod.name].walkable == true then
				return
			end

			pos.y = pos.y + 1

			nod = minetest.get_node_or_nil(pos)
			if not nod
			or not nod.name
			or not minetest.registered_nodes[nod.name]
			or minetest.registered_nodes[nod.name].walkable == true then
				return
			end

			if minetest.setting_getbool("display_mob_spawn") then
				minetest.chat_send_all("[mobs] Add "..name.." at "..minetest.pos_to_string(pos))
			end

			-- spawn mob half block higher
			pos.y = pos.y - 0.5
			minetest.add_entity(pos, name)
			--print ("Spawned "..name.." at "..minetest.pos_to_string(pos).." on "..node.name.." near "..neighbors[1])

		end
	})
end

-- compatibility with older mob registration
function mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height)
	mobs:spawn_specific(name, nodes, {"air"}, min_light, max_light, 30, chance, active_object_count, -31000, max_height)
end

-- particle effects
function effect(pos, amount, texture, max_size)
	minetest.add_particlespawner({
		amount = amount,
		time = 0.25,
		minpos = pos,
		maxpos = pos,
		minvel = {x = -0, y = -2, z = -0},
		maxvel = {x = 2,  y = 2,  z = 2},
		minacc = {x = -4, y = -4, z = -4},
		maxacc = {x = 4, y = 4, z = 4},
		minexptime = 0.1,
		maxexptime = 1,
		minsize = 0.5,
		maxsize = (max_size or 1),
		texture = texture,
	})
end

-- explosion
function mobs:explosion(pos, radius, fire, smoke, sound)
	-- node hit, bursts into flame (cannot blast through unbreakable/specific nodes)
	if not fire then fire = 0 end
	if not smoke then smoke = 0 end
	local pos = vector.round(pos)
	local vm = VoxelManip()
	local minp, maxp = vm:read_from_map(vector.subtract(pos, radius), vector.add(pos, radius))
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	local p = {}
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_obsidian = minetest.get_content_id("default:obsidian")
	local c_brick = minetest.get_content_id("default:obsidianbrick")
	local c_chest = minetest.get_content_id("default:chest_locked")
	if sound
	and sound ~= "" then
		minetest.sound_play(sound, {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 16
		})
	end
	-- if area protected or at map limits then no blast damage
	if minetest.is_protected(pos, "")
	or not within_limits(pos, radius) then
		return
	end
	for z = -radius, radius do
	for y = -radius, radius do
	local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
	for x = -radius, radius do
		p.x = pos.x + x
		p.y = pos.y + y
		p.z = pos.z + z
		if data[vi] ~= c_air
		and data[vi] ~= c_ignore
		and data[vi] ~= c_obsidian
		and data[vi] ~= c_brick
		and data[vi] ~= c_chest then
			local n = minetest.get_node(p).name
			if minetest.get_item_group(n, "unbreakable") ~= 1 then
				-- if chest then drop items inside
				if n == "default:chest"
				or n == "3dchest:chest" then
					local meta = minetest.get_meta(p)
					local inv  = meta:get_inventory()
					for i = 1,32 do
						local m_stack = inv:get_stack("main", i)
						local obj = minetest.add_item(p, m_stack)
						if obj then
							obj:setvelocity({
								x = math.random(-2, 2),
								y = 7,
								z = math.random(-2, 2)
							})
						end
					end
				end
				if fire > 0
				and (minetest.registered_nodes[n].groups.flammable
				or math.random(1, 100) <= 30) then
					minetest.set_node(p, {name = "fire:basic_flame"})
				else
					minetest.remove_node(p)
				end
				if smoke > 0 then
					effect(p, 2, "tnt_smoke.png", 5)
				end
			end
		end
		vi = vi + 1
	end
	end
	end
end

-- on mob death drop items
function check_for_death(self)
	local hp = self.object:get_hp()
	if hp > 0 then
		self.health = hp
		if self.sounds.damage ~= nil then
			minetest.sound_play(self.sounds.damage,{
				object = self.object,
				max_hear_distance = self.sounds.distance
			})
		end
		return false
	end
	local pos = self.object:getpos()
	self.object:remove()
	local obj = nil
	for _,drop in ipairs(self.drops) do
		if math.random(1, drop.chance) == 1 then
			obj = minetest.add_item(pos,
				ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
			if obj then
				obj:setvelocity({
					x = math.random(-1, 1),
					y = 5,
					z = math.random(-1, 1)
				})
			end
		end
	end
	if self.sounds.death ~= nil then
		minetest.sound_play(self.sounds.death,{
			object = self.object,
			max_hear_distance = self.sounds.distance
		})
	end
	if self.on_die then
		self.on_die(self, pos)
	end
	return true
end

-- from TNT mod
function calc_velocity(pos1, pos2, old_vel, power)
	local vel = vector.direction(pos1, pos2)
	vel = vector.normalize(vel)
	vel = vector.multiply(vel, power)
	local dist = vector.distance(pos1, pos2)
	dist = math.max(dist, 1)
	vel = vector.divide(vel, dist)
	vel = vector.add(vel, old_vel)
	return vel
end

-- modified from TNT mod
function entity_physics(pos, radius)
	radius = radius * 2
	local objs = minetest.get_objects_inside_radius(pos, radius)
	local obj_pos, obj_vel, dist
	for _, obj in pairs(objs) do
		obj_pos = obj:getpos()
		obj_vel = obj:getvelocity()
		dist = math.max(1, vector.distance(pos, obj_pos))
		if obj_vel ~= nil then
			obj:setvelocity(calc_velocity(pos, obj_pos, obj_vel, radius * 10))
		end
		local damage = (4 / dist) * radius
		obj:set_hp(obj:get_hp() - damage)
	end
end

-- register arrow for shoot attack
function mobs:register_arrow(name, def)
	if not name or not def then return end -- errorcheck
	minetest.register_entity(name, {
		physical = false,
		visual = def.visual,
		visual_size = def.visual_size,
		textures = def.textures,
		velocity = def.velocity,
		hit_player = def.hit_player,
		hit_node = def.hit_node,
		hit_mob = def.hit_mob,
		drop = def.drop or false,
		collisionbox = {0, 0, 0, 0, 0, 0}, -- remove box around arrows

		on_step = function(self, dtime)
			self.timer = (self.timer or 0) + 1
			local pos = self.object:getpos()
			if self.timer > 150
			or not within_limits(pos, 0) then
				self.object:remove()
				return
			end

			local engage = 10 - (self.velocity / 2) -- clear entity before arrow becomes active
			local node = minetest.get_node_or_nil(pos)
			if node then node = node.name else node = "air" end

			if self.hit_node
			and minetest.registered_nodes[node]
			and minetest.registered_nodes[node].walkable then
				self.hit_node(self, pos, node)
				if self.drop == true then
					pos.y = pos.y + 1
					self.lastpos = (self.lastpos or pos)
					minetest.add_item(self.lastpos, self.object:get_luaentity().name)
				end
				self.object:remove() ; -- print ("hit node")
				return
			end

			if (self.hit_player or self.hit_mob)
			and self.timer > engage then
				for _,player in pairs(minetest.get_objects_inside_radius(pos, 1.0)) do
					if self.hit_player
					and player:is_player() then
						self.hit_player(self, player)
						self.object:remove() ; -- print ("hit player")
						return
					end
					if self.hit_mob
					and player:get_luaentity().name ~= self.object:get_luaentity().name
					and player:get_luaentity().name ~= "__builtin:item"
					and player:get_luaentity().name ~= "gauges:hp_bar"
					and player:get_luaentity().name ~= "signs:text" then
						self.hit_mob(self, player)
						self.object:remove() ; -- print ("hit mob")
						return
					end
				end
			end
			self.lastpos = pos
		end
	})
end

-- Spawn Egg
function mobs:register_egg(mob, desc, background, addegg)
	local invimg = background
	if addegg == 1 then
		invimg = invimg.."^mobs_chicken_egg.png"
	end
	minetest.register_craftitem(mob, {
		description = desc,
		inventory_image = invimg,
		on_place = function(itemstack, placer, pointed_thing)
			local pos = pointed_thing.above
			if pos and within_limits(pos, 0)
			and not minetest.is_protected(pos, placer:get_player_name()) then
				pos.y = pos.y + 0.5
				local mob = minetest.add_entity(pos, mob)
				local ent = mob:get_luaentity()
				if ent.type ~= "monster" then
					-- set owner
					ent.owner = placer:get_player_name()
					ent.tamed = true
				end
				itemstack:take_item()
			end
			return itemstack
		end,
	})
end

-- capture critter (thanks to blert2112 for idea)
function mobs:capture_mob(self, clicker, chance_hand, chance_net, chance_lasso, force_take, replacewith)
	if clicker:is_player()
	and clicker:get_inventory()
	and not self.child then
		-- get name of clicked mob
		local mobname = self.name
		-- if not nil change what will be added to inventory
		if replacewith then
			mobname = replacewith
		end
		local name = clicker:get_player_name()
		-- is mob tamed?
		if self.tamed == false
		and force_take == false then
			minetest.chat_send_player(name, "Not tamed!")
			return
		end
		-- cannot pick up if not owner
		if self.owner ~= name
		and force_take == false then
			minetest.chat_send_player(name, self.owner.." is owner!")
			return
		end

		if clicker:get_inventory():room_for_item("main", mobname) then
			-- was mob clicked with hand, net, or lasso?
			local tool = clicker:get_wielded_item()
			local chance = 0
			if tool:is_empty() then
				chance = chance_hand
			elseif tool:get_name() == "mobs:net" then
				chance = chance_net
				tool:add_wear(4000) -- 17 uses
				clicker:set_wielded_item(tool)
			elseif tool:get_name() == "mobs:magic_lasso" then
				-- pick up if owner
				chance = chance_lasso
				tool:add_wear(650) -- 100 uses
				clicker:set_wielded_item(tool)
			end
			-- return if no chance
			if chance == 0 then return end
			-- calculate chance.. was capture successful?
			if math.random(100) <= chance then
				-- successful capture.. add to inventory
				clicker:get_inventory():add_item("main", mobname)
				self.object:remove()
			else
				minetest.chat_send_player(name, "Missed!")
			end
		end
	end
end

-- follow what I'm holding ?
function follow_holding(self, clicker)
	local item = clicker:get_wielded_item()
	local t = type(self.follow)

	-- single item
	if t == "string"
	and item:get_name() == self.follow then
		return true

	-- multiple items
	elseif t == "table" then
		for no = 1, #self.follow do
			if self.follow[no] == item:get_name() then
				return true
			end
		end
	end

	return false
end

-- feeding, taming and breeding (thanks blert2112)
function mobs:feed_tame(self, clicker, feed_count, breed, tame)

	if not self.follow then return false end

	-- can eat/tame with item in hand
	if follow_holding(self, clicker) then

		-- take item
		if not minetest.setting_getbool("creative_mode") then
			local item = clicker:get_wielded_item()
			item:take_item()
			clicker:set_wielded_item(item)
		end

		-- heal health
		local hp = self.object:get_hp()
		--if hp < self.hp_max then
			hp = hp + 4
			if hp >= self.hp_max then
				hp = self.hp_max
				minetest.chat_send_player(clicker:get_player_name(),
					self.name:split(":")[2]
					.. " at full health")
			end
			self.object:set_hp(hp)
			self.health = hp
		--end

		-- make children grow quicker
		if self.child == true then
			self.hornytimer = self.hornytimer + 20
			return true
		end

		-- feed and tame
		self.food = (self.food or 0) + 1
		if self.food == feed_count then
			self.food = 0
			if breed and self.hornytimer == 0 then
				self.horny = true
			end
			self.gotten = false
			if tame then
				self.tamed = true
				if not self.owner or self.owner == "" then
					self.owner = clicker:get_player_name()
				end
			end

			-- make sound when fed so many times
			if self.sounds.random then
				minetest.sound_play(self.sounds.random, {
					object = self.object,
					max_hear_distance = self.sounds.distance
				})
			end
		end
		return true
	else
		return false
	end
end

-- check if within map limits (-30911 to 30927)
function within_limits(pos, radius)
	if  (pos.x - radius) > -30913
	and (pos.x + radius) <  30928
	and (pos.y - radius) > -30913
	and (pos.y + radius) <  30928
	and (pos.z - radius) > -30913
	and (pos.z + radius) <  30928 then
		return true -- within limits
	end
	return false -- beyond limits
end
