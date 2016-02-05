-- Mobs Api (21st December 2015)
mobs = {}
mobs.mod = "redo"

-- Load settings
local damage_enabled = minetest.setting_getbool("enable_damage")
local peaceful_only = minetest.setting_getbool("only_peaceful_mobs")
local disable_blood = minetest.setting_getbool("mobs_disable_blood")

mobs.protected = tonumber(minetest.setting_get("mobs_spawn_protected")) or 1
mobs.remove = minetest.setting_getbool("remove_far_mobs")

-- internal functions

local pi = math.pi

do_attack = function(self, player)

	if self.state ~= "attack" then

		if math.random(0,100) < 90
		and self.sounds.war_cry then

			minetest.sound_play(self.sounds.war_cry,{
				object = self.object,
				max_hear_distance = self.sounds.distance
			})
		end

		self.state = "attack"
		self.attack = player
	end
end

set_velocity = function(self, v)

	local x = 0
	local z = 0

	if v and v ~= 0 then

		local yaw = (self.object:getyaw() + self.rotate) or 0

		x = math.sin(yaw) * -v
		z = math.cos(yaw) * v
	end

	self.object:setvelocity({
		x = x,
		y = self.object:getvelocity().y,
		z = z
	})
end

get_velocity = function(self)

	local v = self.object:getvelocity()

	return (v.x ^ 2 + v.z ^ 2) ^ (0.5)
end

set_animation = function(self, type)

	if not self.animation then
		return
	end

	self.animation.current = self.animation.current or ""

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
	and self.animation.current ~= "walk" then

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
	and self.animation.current ~= "run" then

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
	and self.animation.current ~= "punch" then

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

function check_for_death(self)

	-- return if no change
	local hp = self.object:get_hp()

	if hp == self.health then
		return false
	end

	local pos = self.object:getpos()

	-- still got some health? play hurt sound
	if hp > 0 then

		self.health = hp

		if self.sounds.damage then

			minetest.sound_play(self.sounds.damage,{
				pos = pos,
				gain = 1.0,
				max_hear_distance = self.sounds.distance
			})
		end

		return false
	end

	-- drop items when dead
	local obj

	for _,drop in ipairs(self.drops) do

		if math.random(1, drop.chance) == 1 then

			obj = minetest.add_item(pos,
				ItemStack(drop.name .. " "
					.. math.random(drop.min, drop.max)))

			if obj then

				obj:setvelocity({
					x = math.random(-1, 1),
					y = 6,
					z = math.random(-1, 1)
				})
			end
		end
	end

	-- play death sound
	if self.sounds.death then

		minetest.sound_play(self.sounds.death,{
			pos = pos,
			gain = 1.0,
			max_hear_distance = self.sounds.distance
		})
	end

	-- execute custom death function
	if self.on_die then
		self.on_die(self, pos)
	end

	self.object:remove()

	return true
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

-- is mob facing a cliff
local function is_at_cliff(self)

	if self.fear_height == 0 then -- if 0, no falling protection!
		return false
	end

	local yaw = self.object:getyaw()
	local dir_x = -math.sin(yaw) * (self.collisionbox[4] + 0.5)
	local dir_z = math.cos(yaw) * (self.collisionbox[4] + 0.5)
	local pos = self.object:getpos()
	local ypos = pos.y + self.collisionbox[2] -- just above floor

	if minetest.line_of_sight(
		{x = pos.x + dir_x, y = ypos, z = pos.z + dir_z},
		{x = pos.x + dir_x, y = ypos - self.fear_height, z = pos.z + dir_z}
	, 1) then

		return true
	end

	return false
end

-- environmental damage (water, lava, fire, light)
do_env_damage = function(self)

	-- feed/tame text timer (so mob 'full' messages dont spam chat)
	if self.htimer > 0 then
		self.htimer = self.htimer - 1
	end

	local pos = self.object:getpos()

	self.time_of_day = minetest.get_timeofday()

	-- remove mob if beyond map limits
	if not within_limits(pos, 0) then
		self.object:remove()
		return
	end

	-- daylight above ground
	if self.light_damage ~= 0
	and pos.y > 0
	and self.time_of_day > 0.2
	and self.time_of_day < 0.8
	and (minetest.get_node_light(pos) or 0) > 12 then

		self.object:set_hp(self.object:get_hp() - self.light_damage)

		effect(pos, 5, "tnt_smoke.png")
	end

	if self.water_damage ~= 0 or self.lava_damage ~= 0 then

		pos.y = (pos.y + self.collisionbox[2]) + 0.1 -- foot level

		local nod = node_ok(pos, "air") ;  -- print ("standing in "..nod.name)
		local nodef = minetest.registered_nodes[nod.name]

		pos.y = pos.y + 1

		-- water
		if self.water_damage ~= 0
		and nodef.groups.water then

			self.object:set_hp(self.object:get_hp() - self.water_damage)

			effect(pos, 5, "bubble.png")
		end

		-- lava or fire
		if self.lava_damage ~= 0
		and (nodef.groups.lava
		or nod.name == "fire:basic_flame"
		or nod.name == "fire:permanent_flame") then

			self.object:set_hp(self.object:get_hp() - self.lava_damage)

			effect(pos, 5, "fire_basic_flame.png")
		end
	end

	check_for_death(self)
end

-- jump if facing a solid node (not fences)
do_jump = function(self)

	if self.fly
	or self.child then
		return
	end

	local pos = self.object:getpos()
	local temp_Y = pos.y

	-- what is mob standing on?
	pos.y = (temp_Y + self.collisionbox[2]) - 0.2

	local nod = node_ok(pos)

--print ("standing on:", nod.name, pos.y)

	if minetest.registered_nodes[nod.name].walkable == false
	or not self.direction then
		return
	end

	-- what is in front of mob?
	local nod = node_ok({
		x = pos.x + self.direction.x,
		y = pos.y + 0.5,
		z = pos.z + self.direction.z
	})

	-- thin blocks that do not need to be jumped
	if nod.name == "default:snow" then
		return
	end

--print ("in front:", nod.name, pos.y + 0.5)

	if minetest.registered_items[nod.name].walkable
	and not nod.name:find("fence")
	or self.walk_chance == 0 then

		local v = self.object:getvelocity()

		-- move back a bit - allows jump velocity to carry it forward and succeed better
		self.object:setpos({x=pos.x - self.direction.x/2, y=temp_Y, z=pos.z - self.direction.z/2})

		v.y = self.jump_height + 1
		v.x = v.x * 2.2
		v.z = v.z * 2.2

		self.object:setvelocity(v)

		if self.sounds.jump then

			minetest.sound_play(self.sounds.jump, {
				pos = pos,
				gain = 1.0,
				max_hear_distance = self.sounds.distance
			})
		end
	end
end

-- blast damage to entities nearby (modified from TNT mod)
function entity_physics(pos, radius)

	radius = radius * 2

	local objs = minetest.get_objects_inside_radius(pos, radius)
	local obj_pos, dist

	for _, obj in pairs(objs) do

		obj_pos = obj:getpos()
		dist = math.max(1, vector.distance(pos, obj_pos))

		local damage = math.floor((4 / dist) * radius)
		obj:set_hp(obj:get_hp() - damage)
	end
end

-- get node but use fallback for nil or unknown
function node_ok(pos, fallback)

	fallback = fallback or "default:dirt"

	local node = minetest.get_node_or_nil(pos)

	if not node then
		return minetest.registered_nodes[fallback]
	end

	local nodef = minetest.registered_nodes[node.name]

	if nodef then
		return node
	end

	return minetest.registered_nodes[fallback]
end

-- should mob follow what I'm holding ?
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

local function breed(self)

	-- horny animal can mate for 40 seconds,
	-- afterwards horny animal cannot mate again for 200 seconds
	if self.horny == true
	and self.hornytimer < 240
	and self.child == false then

		self.hornytimer = self.hornytimer + 1

		if self.hornytimer >= 240 then
			self.hornytimer = 0
			self.horny = false
		end
	end

	-- child take 240 seconds before growing into adult
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

			-- jump when fully grown so not to fall into ground
			self.object:setvelocity({
				x = 0,
				y = self.jump_height,
				z = 0
			})
		end
	end

	-- find another same animal who is also horny and mate if close enough
	if self.horny == true
	and self.hornytimer <= 40 then

		local pos = self.object:getpos()

		effect({x = pos.x, y = pos.y + 1, z = pos.z}, 4, "heart.png")

		local ents = minetest.get_objects_inside_radius(pos, 3)
		local num = 0
		local ent = nil

		for i, obj in ipairs(ents) do

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

			-- found your mate? then have a baby
			if num > 1 then

				self.hornytimer = 41
				ent.hornytimer = 41

				-- spawn baby
				minetest.after(5, function(dtime)

					local mob = minetest.add_entity(pos, self.name)
					local ent2 = mob:get_luaentity()
					local textures = self.base_texture

					if self.child_texture then
						textures = self.child_texture[1]
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
end

function replace(self, pos)

	if self.replace_rate
	and self.child == false
	and math.random(1, self.replace_rate) == 1 then

		local pos = self.object:getpos()

		pos.y = pos.y + self.replace_offset

-- print ("replace node = ".. minetest.get_node(pos).name, pos.y)

		if self.replace_what
		and self.object:getvelocity().y == 0
		and #minetest.find_nodes_in_area(pos, pos, self.replace_what) > 0 then

			minetest.set_node(pos, {name = self.replace_with})

			-- when cow/sheep eats grass, replace wool and milk
			if self.gotten == true then
				self.gotten = false
				self.object:set_properties(self)
			end
		end
	end
end

-- check if daytime and also if mob is docile during daylight hours
function day_docile(self)

	if self.docile_by_day == false then

		return false

	elseif self.docile_by_day == true
	and self.time_of_day > 0.2
	and self.time_of_day < 0.8 then

		return true
	end
end

-- register mob function
function mobs:register_mob(name, def)

minetest.register_entity(name, {

	stepheight = def.stepheight or 0.6,
	name = name,
	type = def.type,
	attack_type = def.attack_type,
	fly = def.fly,
	fly_in = def.fly_in or "air",
	owner = def.owner or "",
	order = def.order or "",
	on_die = def.on_die,
	do_custom = def.do_custom,
	jump_height = def.jump_height or 6,
	jump_chance = def.jump_chance or 0,
	drawtype = def.drawtype, -- DEPRECATED, use rotate instead
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
	damage = def.damage or 0,
	light_damage = def.light_damage or 0,
	water_damage = def.water_damage or 0,
	lava_damage = def.lava_damage or 0,
	fall_damage = def.fall_damage or 1,
	fall_speed = def.fall_speed or -10, -- must be lower than -2 (default: -10)
	drops = def.drops or {},
	armor = def.armor,
	on_rightclick = def.on_rightclick,
	arrow = def.arrow,
	shoot_interval = def.shoot_interval,
	sounds = def.sounds or {},
	animation = def.animation,
	follow = def.follow,
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
	env_damage_timer = 0, -- only used when state = "attack"
	tamed = false,
	pause_timer = 0,
	horny = false,
	hornytimer = 0,
	child = false,
	gotten = false,
	health = 0,
	reach = def.reach or 3,
	htimer = 0,
	child_texture = def.child_texture,
	docile_by_day = def.docile_by_day or false,
	time_of_day = 0.5,
	fear_height = def.fear_height or 3,
	id = 0,
	game_name = "mob",

	on_step = function(self, dtime)

		local pos = self.object:getpos()
		local yaw = self.object:getyaw() or 0

		-- when lifetimer expires remove mob (except npc and tamed)
		if self.type ~= "npc"
		and not self.tamed
		and self.state ~= "attack" then

			self.lifetimer = self.lifetimer - dtime

			if self.lifetimer <= 0 then

				minetest.log("action",
					"lifetimer expired, removed " .. self.name)

				effect(pos, 15, "tnt_smoke.png")

				self.object:remove()

				return
			end
		end

		if not self.fly then

			-- floating in water (or falling)
			local v = self.object:getvelocity()

			-- going up then apply gravity
			if v.y > 0.1 then

				self.object:setacceleration({
					x = 0,
					y = self.fall_speed,
					z = 0
				})
			end

			-- in water then float up
			if minetest.registered_nodes[node_ok(pos).name].groups.water then

				if self.floats == 1 then

					self.object:setacceleration({
						x = 0,
						y = -self.fall_speed / (math.max(1, v.y) ^ 2),
						z = 0
					})
				end
			else
				-- fall downwards
				self.object:setacceleration({
					x = 0,
					y = self.fall_speed,
					z = 0
				})

				-- fall damage
				if self.fall_damage == 1
				and self.object:getvelocity().y == 0 then

					local d = self.old_y - self.object:getpos().y

					if d > 5 then

						self.object:set_hp(self.object:get_hp() - math.floor(d - 5))

						effect(pos, 5, "tnt_smoke.png")

						if check_for_death(self) then
							return
						end
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

		-- never go over 100
		if self.timer > 100 then
			self.timer = 1
		end

		-- node replace check (cow eats grass etc.)
		replace(self, pos)

		-- mob plays random sound at times
		if self.sounds.random
		and math.random(1, 100) <= 1 then

			minetest.sound_play(self.sounds.random, {
				object = self.object,
				max_hear_distance = self.sounds.distance
			})
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

			self.env_damage_timer = 0

			do_env_damage(self)

			-- custom function
			if self.do_custom then
				self.do_custom(self)
			end
		end

		-- find someone to attack
		if self.type == "monster"
		and damage_enabled
		and self.state ~= "attack"
		and not day_docile(self) then

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
					-- aim higher to make looking up hills more realistic
					p.y = p.y + 1
					sp.y = sp.y + 1
					dist = vector.distance(p, s)

					if dist < self.view_range then
					-- field of view check goes here

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
				do_attack(self, min_player)
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

			for _, oir in pairs(minetest.get_objects_inside_radius(s, self.view_range)) do

				obj = oir:get_luaentity()

				if obj
				and obj.type == "monster" then

					-- attack monster
					p = obj.object:getpos()

					dist = vector.distance(p, s)

					if dist < min_dist then
						min_dist = dist
						min_player = obj.object
					end
				end
			end

			if min_player then
				do_attack(self, min_player)
			end
		end

		-- breed and grow children
		breed(self)

		-- find player to follow
		if (self.follow ~= ""
		or self.order == "follow")
		and not self.following
		and self.state ~= "attack" then

			local s, p, dist

			for _,player in pairs(minetest.get_connected_players()) do

				s = self.object:getpos()
				p = player:getpos()
				dist = vector.distance(p, s)

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
			and self.following:is_player()
			and follow_holding(self, self.following) == false then
				self.following = nil
			end

		end

		-- follow that thing
		if self.following then

			local s = self.object:getpos()
			local p

			if self.following:is_player() then

				p = self.following:getpos()

			elseif self.following.object then

				p = self.following.object:getpos()
			end

			if p then

				local dist = vector.distance(p, s)

				-- dont follow if out of range
				if dist > self.view_range then
					self.following = nil
				else
					local vec = {
						x = p.x - s.x,
						z = p.z - s.z
					}

					yaw = (math.atan2(vec.z, vec.x) - pi / 2) - self.rotate
					self.object:setyaw(yaw)

					-- anyone but standing npc's can move along
					if dist > self.reach
					and self.order ~= "stand" then

						if (self.jump
						and get_velocity(self) <= 0.5
						and self.object:getvelocity().y == 0)
						or (self.object:getvelocity().y == 0
						and self.jump_chance > 0) then

							self.direction = {
								x = math.sin(yaw) * -1,
								y = 0,
								z = math.cos(yaw)
							}

							do_jump(self)
						end

						set_velocity(self, self.walk_velocity)

						if self.walk_chance ~= 0 then
							set_animation(self, "walk")
						end
					else
						set_velocity(self, 0)
						set_animation(self, "stand")
					end

					return
				end
			end
		end

		if self.state == "stand" then

			if math.random(1, 4) == 1 then

				local lp = nil
				local s = self.object:getpos()

				if self.type == "npc" then

					local o = minetest.get_objects_inside_radius(self.object:getpos(), 3)

					for _,o in ipairs(o) do

						if o:is_player() then
							lp = o:getpos()
							break
						end
					end
				end

				-- look at any players nearby, otherwise turn randomly
				if lp then

					local vec = {
						x = lp.x - s.x,
						z = lp.z - s.z
					}

					yaw = (math.atan2(vec.z, vec.x) - pi / 2) - self.rotate
				else
					yaw = math.random() * 2 * pi
				end

				self.object:setyaw(yaw)
			end

			set_velocity(self, 0)
			set_animation(self, "stand")

			-- npc's ordered to stand stay standing
			if self.type ~= "npc"
			or self.order ~= "stand" then

				if self.walk_chance ~= 0
				and math.random(1, 100) <= self.walk_chance
				and is_at_cliff(self) == false then

					set_velocity(self, self.walk_velocity)
					self.state = "walk"
					set_animation(self, "walk")
				end
			end

		elseif self.state == "walk" then

			local s = self.object:getpos()
			local lp = minetest.find_node_near(s, 1, {"group:water"})

			-- water swimmers cannot move out of water
			if self.fly
			and self.fly_in == "default:water_source"
			and not lp then

				print ("out of water")

				set_velocity(self, 0)

				-- change to undefined state so nothing more happens
				self.state = "flop"
				set_animation(self, "stand")

				return
			end

			lp = minetest.find_node_near(s, 3, {"group:water"})

			-- if water nearby then turn away
			if lp then
				local vec = {
					x = lp.x - s.x,
					z = lp.z - s.z
				}

				yaw = math.atan2(vec.z, vec.x) + pi / 2 - self.rotate

				self.object:setyaw(yaw)

			-- otherwise randomly turn
			elseif math.random(1, 100) <= 30 then

				yaw = math.random() * 2 * pi

				self.object:setyaw(yaw)
			end

			-- stand for great fall in front
			local temp_is_cliff = is_at_cliff(self)

			-- jump when walking comes to a halt
			if temp_is_cliff == false
			and self.jump
			and get_velocity(self) <= 0.5
			and self.object:getvelocity().y == 0 then

				self.direction = {
					x = math.sin(yaw) * -1,
					y = 0,
					z = math.cos(yaw)
				}

				do_jump(self)
			end

			if temp_is_cliff
			or math.random(1, 100) <= 30 then

				set_velocity(self, 0)
				self.state = "stand"
				set_animation(self, "stand")
			else
				set_velocity(self, self.walk_velocity)
				set_animation(self, "walk")
			end

		-- attack routines (explode, dogfight, shoot, dogshoot)
		elseif self.state == "attack" then

		-- calculate distance from mob and enemy
		local s = self.object:getpos()
		local p = self.attack:getpos() or s
		local dist = vector.distance(p, s)

		-- stop attacking if player or out of range
		if dist > self.view_range
		or not self.attack
		or not self.attack:getpos()
		or self.attack:get_hp() <= 0 then

			--print(" ** stop attacking **", dist, self.view_range)
			self.state = "stand"
			set_velocity(self, 0)
			set_animation(self, "stand")
			self.attack = nil
			self.v_start = false
			self.timer = 0
			self.blinktimer = 0

			return
		end

		if self.attack_type == "explode" then

			local vec = {
				x = p.x - s.x,
				z = p.z - s.z
			}

			yaw = math.atan2(vec.z, vec.x) - pi / 2 - self.rotate
			self.object:setyaw(yaw)

			if dist > self.reach then

				if not self.v_start then

					self.v_start = true
					set_velocity(self, self.run_velocity)
					self.timer = 0
					self.blinktimer = 0
				else
					self.timer = 0
					self.blinktimer = 0

					if get_velocity(self) <= 0.5
					and self.object:getvelocity().y == 0 then

						local v = self.object:getvelocity()
						v.y = 5
						self.object:setvelocity(v)
					end

					set_velocity(self, self.run_velocity)
				end

				set_animation(self, "run")
			else
				set_velocity(self, 0)
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

					local pos = self.object:getpos()

					-- hurt player/mobs caught in blast area
					entity_physics(pos, 3)

					if minetest.find_node_near(pos, 1, {"group:water"})
					or minetest.is_protected(pos, "") then

						if self.sounds.explode then

							minetest.sound_play(self.sounds.explode, {
								pos = pos,
								gain = 1.0,
								max_hear_distance = 16
							})
						end

						self.object:remove()

						effect(pos, 15, "tnt_smoke.png", 5)

						return
					end

					pos.y = pos.y - 1

					mobs:explosion(pos, 2, 0, 1, self.sounds.explode)

					self.object:remove()

					return
				end
			end

		elseif self.attack_type == "dogfight"
		or (self.attack_type == "dogshoot" and dist <= self.reach) then

			-- fly bit modified from BlockMens creatures mod
			if self.fly
			and dist > self.reach then

				local nod = node_ok(s)
				local p1 = s
				local me_y = math.floor(p1.y)
				local p2 = p
				local p_y = math.floor(p2.y + 1)
				local v = self.object:getvelocity()

				if nod.name == self.fly_in then

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

			local vec = {
				x = p.x - s.x,
				y = p.y - s.y,
				z = p.z - s.z
			}

			yaw = (math.atan2(vec.z, vec.x) - pi / 2) - self.rotate
			self.object:setyaw(yaw)

			-- move towards enemy if beyond mob reach
			if dist > self.reach then

				-- jump attack
				if (self.jump
				and get_velocity(self) <= 0.5
				and self.object:getvelocity().y == 0)
				or (self.object:getvelocity().y == 0
				and self.jump_chance > 0) then

					self.direction = {
						x = math.sin(yaw) * -1,
						y = 0,
						z = math.cos(yaw)
					}

					do_jump(self)
				end

				if is_at_cliff(self) then

					set_velocity(self, 0)
					set_animation(self, "stand")
				else
					set_velocity(self, self.run_velocity)
					set_animation(self, "run")
				end

			else

				set_velocity(self, 0)
				set_animation(self, "punch")

				if self.timer > 1 then

					self.timer = 0

					local p2 = p
					local s2 = s

					p2.y = p2.y + 1.5
					s2.y = s2.y + 1.5

					if minetest.line_of_sight(p2, s2) == true then

						-- play attack sound
						if self.sounds.attack then

							minetest.sound_play(self.sounds.attack, {
								object = self.object,
								max_hear_distance = self.sounds.distance
							})
						end

						-- punch player
						self.attack:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = self.damage}
						}, nil)
					end
				end
			end

		elseif self.attack_type == "shoot"
		or (self.attack_type == "dogshoot" and dist > self.reach) then

			p.y = p.y - .5
			s.y = s.y + .5

			local dist = vector.distance(p, s)
			local vec = {
				x = p.x - s.x,
				y = p.y - s.y,
				z = p.z - s.z
			}

			yaw = (math.atan2(vec.z, vec.x) - pi / 2) - self.rotate
			self.object:setyaw(yaw)

			set_velocity(self, 0)

			if self.shoot_interval
			and self.timer > self.shoot_interval
			and math.random(1, 100) <= 60 then

				self.timer = 0
				set_animation(self, "punch")

				-- play shoot attack sound
				if self.sounds.shoot_attack then

					minetest.sound_play(self.sounds.shoot_attack, {
						object = self.object,
						max_hear_distance = self.sounds.distance
					})
				end

				local p = self.object:getpos()

				p.y = p.y + (self.collisionbox[2] + self.collisionbox[5]) / 2

				local obj = minetest.add_entity(p, self.arrow)
				local ent = obj:get_luaentity()

				local amount = (vec.x ^ 2 + vec.y ^ 2 + vec.z ^ 2) ^ 0.5
				local v = ent.velocity
				ent.switch = 1

				 -- offset makes shoot aim accurate
				vec.y = vec.y + self.shoot_offset
				vec.x = vec.x * v / amount
				vec.y = vec.y * v / amount
				vec.z = vec.z * v / amount

				obj:setvelocity(vec)
			end
		end

		end -- END if self.state == "attack"
	end,

	on_activate = function(self, staticdata, dtime_s)

		-- remove monsters if playing on peaceful
		if self.type == "monster"
		and peaceful_only then

			self.object:remove()

			return
		end

		-- load entity variables
		if staticdata then

			local tmp = minetest.deserialize(staticdata)

			if tmp then

				for _,stat in pairs(tmp) do
					self[_] = stat
				end
			end
		else
			self.object:remove()

			return
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

		-- set child objects to half size
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

		self.object:set_hp(self.health)
		self.object:set_armor_groups({fleshy = self.armor})
		self.old_y = self.object:getpos().y
		self.object:setyaw(math.random(1, 360) / 180 * pi)
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
		if mobs.remove
		and self.remove_ok
		and not self.tamed then

			--print ("REMOVED", self.remove_ok, self.name)

			self.object:remove()

			return nil
		end

		self.remove_ok = true
		self.attack = nil
		self.following = nil
		self.state = "stand"

		-- used to rotate older mobs
		if self.drawtype
		and self.drawtype == "side" then
			self.rotate = math.rad(90)
		end

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

		-- no punch punch spamming
		if tflp < 0.45 then
			return
		end

		-- weapon wear
		local weapon = hitter:get_wielded_item()
		local punch_interval = 1.4

		if tool_capabilities then
			punch_interval = tool_capabilities.full_punch_interval or 1.4
		end

		if weapon:get_definition()
		and weapon:get_definition().tool_capabilities then

			weapon:add_wear(math.floor((punch_interval / 75) * 9000))
			hitter:set_wielded_item(weapon)
		end

		-- weapon sounds
		if weapon:get_definition().sounds ~= nil then

			local s = math.random(0, #weapon:get_definition().sounds)

			minetest.sound_play(weapon:get_definition().sounds[s], {
				object = hitter,
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

			local v = self.object:getvelocity()
			local r = 1.4 - math.min(punch_interval, 1.4)
			local kb = r * 5

			self.object:setvelocity({
				x = dir.x * kb,
				y = 2,
				z = dir.z * kb
			})

			self.pause_timer = r
		end

		-- attack puncher and call other mobs for help
		if self.passive == false
		and not self.tamed then

			if self.state ~= "attack" then
				do_attack(self, hitter)
			end

			-- alert others to the attack
			local obj = nil

			for _, oir in pairs(minetest.get_objects_inside_radius(hitter:getpos(), 5)) do

				obj = oir:get_luaentity()

				if obj then

					if obj.group_attack == true
					and obj.state ~= "attack" then
						do_attack(obj, hitter)
					end
				end
			end
		end
	end,
})

end -- END mobs:register_mob function

-- global functions

mobs.spawning_mobs = {}

function mobs:spawn_specific(name, nodes, neighbors, min_light, max_light,
	interval, chance, active_object_count, min_height, max_height)

	mobs.spawning_mobs[name] = true

	-- chance override in minetest.conf for registered mob
	local new_chance = tonumber(minetest.setting_get(name .. "_chance"))

	if new_chance ~= nil then
		chance = new_chance
		print ("[Mobs Redo] Chance setting for " .. name .. " is now " .. chance)
	end

	minetest.register_abm({

		nodenames = nodes,
		neighbors = neighbors,
		interval = interval,
		chance = chance,
		--catch_up = false,

		action = function(pos, node, _, active_object_count_wider)

			-- do not spawn if too many active entities in area
			if active_object_count_wider > active_object_count
			or not mobs.spawning_mobs[name] then
				return
			end

			-- spawn above node
			pos.y = pos.y + 1

			-- mobs cannot spawn in protected areas when enabled
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

			-- are we spawning inside solid nodes?
			if minetest.registered_nodes[node_ok(pos).name].walkable == true then
				return
			end

			pos.y = pos.y + 1

			if minetest.registered_nodes[node_ok(pos).name].walkable == true then
				return
			end

			-- spawn mob half block higher than ground
			pos.y = pos.y - 0.5

			local mob = minetest.add_entity(pos, name)
			--local ent = mob:get_luaentity()

			if mob == false then
				print ("[mobs]" .. name .. " failed to spawn at "
				.. minetest.pos_to_string(pos))
			else
--				print ("[mobs] Spawned " .. name .. " at "
--				.. minetest.pos_to_string(pos) .. " on "
--				.. node.name .. " near " .. neighbors[1])
			end

		end
	})
end

-- compatibility with older mob registration
function mobs:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, max_height)

	mobs:spawn_specific(name, nodes, {"air"}, min_light, max_light, 30,
		chance, active_object_count, -31000, max_height)
end

-- set content id's
local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_obsidian = minetest.get_content_id("default:obsidian")
local c_brick = minetest.get_content_id("default:obsidianbrick")
local c_chest = minetest.get_content_id("default:chest_locked")

-- explosion (cannot break protected or unbreakable nodes)
function mobs:explosion(pos, radius, fire, smoke, sound)

	radius = radius or 0
	fire = fire or 0
	smoke = smoke or 0

	-- if area protected or near map limits then no blast damage
	if minetest.is_protected(pos, "")
	or not within_limits(pos, radius) then
		return
	end

	-- explosion sound
	if sound
	and sound ~= "" then

		minetest.sound_play(sound, {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 16
		})
	end

	pos = vector.round(pos) -- voxelmanip doesn't work properly unless pos is rounded ?!?!

	local vm = VoxelManip()
	local minp, maxp = vm:read_from_map(vector.subtract(pos, radius), vector.add(pos, radius))
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	local p = {}

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

			local n = node_ok(p).name

			if minetest.get_item_group(n, "unbreakable") ~= 1 then

				-- if chest then drop items inside
				if n == "default:chest"
				or n == "3dchest:chest"
				or n == "bones:bones" then

					local meta = minetest.get_meta(p)
					local inv  = meta:get_inventory()

					for i = 1, inv:get_size("main") do

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

				-- after effects
				if fire > 0
				and (minetest.registered_nodes[n].groups.flammable
				or math.random(1, 100) <= 30) then

					minetest.set_node(p, {name = "fire:basic_flame"})
				else
					minetest.set_node(p, {name = "air"})

					if smoke > 0 then
						effect(p, 2, "tnt_smoke.png", 5)
					end
				end
			end
		end

		vi = vi + 1

	end
	end
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
		timer = 0,
		switch = 0,

		on_step = function(self, dtime)

			self.timer = self.timer + 1

			local pos = self.object:getpos()

			if self.switch == 0
			or self.timer > 150
			or not within_limits(pos, 0) then

				self.object:remove() ; -- print ("removed arrow")

				return
			end

			if self.hit_node then

				local node = node_ok(pos).name

				if minetest.registered_nodes[node].walkable then

					self.hit_node(self, pos, node)

					if self.drop == true then

						pos.y = pos.y + 1

						self.lastpos = (self.lastpos or pos)

						minetest.add_item(self.lastpos, self.object:get_luaentity().name)
					end

					self.object:remove() ; -- print ("hit node")

					return
				end
			end

			if (self.hit_player or self.hit_mob)
			-- clear mob entity before arrow becomes active
			and self.timer > (10 - (self.velocity / 2)) then

				for _,player in pairs(minetest.get_objects_inside_radius(pos, 1.0)) do

					if self.hit_player
					and player:is_player() then

						self.hit_player(self, player)
						self.object:remove() ; -- print ("hit player")
						return
					end

					if self.hit_mob
					and player:get_luaentity()
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
		invimg = invimg .. "^mobs_chicken_egg.png"
	end

	minetest.register_craftitem(mob, {

		description = desc,
		inventory_image = invimg,

		on_place = function(itemstack, placer, pointed_thing)

			local pos = pointed_thing.above

			if pos
			and within_limits(pos, 0)
			and not minetest.is_protected(pos, placer:get_player_name()) then

				pos.y = pos.y + 1

				local mob = minetest.add_entity(pos, mob)
				local ent = mob:get_luaentity()

				if ent.type ~= "monster" then
					-- set owner and tame if not monster
					ent.owner = placer:get_player_name()
					ent.tamed = true
				end

				-- if not in creative then take item
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			end

			return itemstack
		end,
	})
end

-- capture critter (thanks to blert2112 for idea)
function mobs:capture_mob(self, clicker, chance_hand, chance_net, chance_lasso, force_take, replacewith)

	if not self.child
	and clicker:is_player()
	and clicker:get_inventory() then

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

				chance = chance_lasso

				tool:add_wear(650) -- 100 uses

				clicker:set_wielded_item(tool)
			end

			-- return if no chance
			if chance == 0 then return end

			-- calculate chance.. add to inventory if successful?
			if math.random(1, 100) <= chance then

				clicker:get_inventory():add_item("main", mobname)

				self.object:remove()
			else
				minetest.chat_send_player(name, "Missed!")
			end
		end
	end
end

-- feeding, taming and breeding (thanks blert2112)
function mobs:feed_tame(self, clicker, feed_count, breed, tame)

	if not self.follow then
		return false
	end

	-- can eat/tame with item in hand
	if follow_holding(self, clicker) then

		-- take item
		if not minetest.setting_getbool("creative_mode") then

			local item = clicker:get_wielded_item()

			item:take_item()

			clicker:set_wielded_item(item)
		end

		-- heal health
		local hp = self.object:get_hp() + 4

		if hp >= self.hp_max then

			hp = self.hp_max

			if self.htimer < 1 then

				minetest.chat_send_player(clicker:get_player_name(),
					self.name:split(":")[2]
					.. " at full health (" .. tostring(hp) .. ")")

				self.htimer = 5
			end
		end

		self.object:set_hp(hp)
		self.health = hp

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
