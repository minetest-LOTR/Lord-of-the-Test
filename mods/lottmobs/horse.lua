
local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0 or
	minetest.get_item_group(nn, "cracky") ~= 0 or
	minetest.get_item_group(nn, "choppy") ~= 0 or
	minetest.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function lottmobs:register_horse(name, craftitem, horse)

	if craftitem ~= nil then
		function craftitem.on_place(itemstack, placer, pointed_thing)
			if pointed_thing.above then
				minetest.add_entity(pointed_thing.above, name)
				
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			end
			return itemstack
		end
		minetest.register_craftitem(name, craftitem)
	end

	horse.v = 0
	horse.driver = nil

	function horse:set_animation(type)
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
					self.animation.speed_normal * 0.6, 0
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
					self.animation.speed_normal * 3, 0
				)
				self.animation.current = "walk"
			end
		elseif type == "punch" and self.animation.current ~= "punch"  then
			if
				self.animation.punch_start
				and self.animation.punch_end
				and self.animation.speed_normal
			then
				self.object:set_animation(
					{x=self.animation.punch_start,y=self.animation.punch_end},
					self.animation.speed_normal * 3, 0
				)
				self.animation.current = "punch"
			end
		end
	end

	function horse:on_step(dtime)
		local p = self.object:getpos()
		p.y = p.y - 0.1
		local on_ground = is_ground(p)

		self.v = get_v(self.object:getvelocity())*get_sign(self.v)

		-- driver controls
		if self.driver then
			local ctrl = self.driver:get_player_control()

			-- rotation (the faster we go, the less we rotate)
			if ctrl.left then
				self.object:setyaw(self.object:getyaw()+2*(1.5-math.abs(self.v/self.max_speed))*math.pi/90 +dtime*math.pi/90)
			end
			if ctrl.right then
				self.object:setyaw(self.object:getyaw()-2*(1.5-math.abs(self.v/self.max_speed))*math.pi/90 -dtime*math.pi/90)
			end
			-- jumping (only if on ground)
			if ctrl.jump and on_ground then
				local v = self.object:getvelocity()
				v.y = (self.jump_speed or 3)
				self.object:setvelocity(v)
			end

			-- forwards/backwards
			if ctrl.up then
				self.v = self.v + self.forward_boost
			elseif ctrl.down then
				self.v = self.v - 0.3
			elseif on_ground then
				if math.abs(self.v) < 1 then
					self.v = 0
				else
					self.v = self.v * 0.8
				end
			end
		else
			if math.abs(self.v) < 1 then
				self.v = 0
			else
				self.v = self.v * 0.95
			end
		end

		underattack = self.underattack or false

		if self.v == 0 then
			if underattack ~= true then
				self.object:setvelocity({x=0,y=0,z=0})
				self:set_animation("stand")
				return
			else
				self:set_animation("punch")
			end
		else
			self:set_animation("walk")
		end

		-- make sure we don't go past the limit
		if math.abs(self.v) > self.max_speed then
			self.v = self.max_speed*get_sign(self.v)
		end

		local p = self.object:getpos()
		p.y = p.y+1
		if not is_ground(p) then
			if minetest.registered_nodes[minetest.get_node(p).name].walkable then
				self.v = 0
			end
			self.object:setacceleration({x=0, y=-10, z=0})
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			-- falling
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end

		if self.object:getvelocity().y > 0.1 then
			local yaw = self.object:getyaw()
			if self.drawtype == "side" then
				yaw = yaw+(math.pi/2)
			end
			local x = math.sin(yaw) * -2
			local z = math.cos(yaw) * 2
			if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
				self.object:setacceleration({x = x, y = 2, z = z})
			else
				self.object:setacceleration({x = x, y = -5, z = z})
			end
		else
			if minetest.get_item_group(minetest.get_node(self.object:getpos()).name, "water") ~= 0 then
				self.object:setacceleration({x = 0, y = 2, z = 0})
			else
				self.object:setacceleration({x = 0, y = -5, z = 0})
			end
		end

	end

	function horse:on_rightclick(clicker)
		if not clicker or not clicker:is_player() then
			return
		end
		if self.driver and clicker == self.driver then
			self.driver = nil
			clicker:set_detach()
			default.player_attached[clicker:get_player_name()] = false
			if self.offset == true then
				clicker:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
			end
		elseif not self.driver then
			self.driver = clicker
			attach_h = self.attach_h or 15
			attach_r = self.attach_r or 90
			clicker:set_attach(self.object, "", {x=0,y= attach_h ,z=0}, {x=0,y= attach_r ,z=0})
			default.player_attached[clicker:get_player_name()] = true
			self.object:setyaw(clicker:get_look_yaw())
			self.ridername = clicker:get_player_name()
			
			if self.offset == true then
				offset_h = self.offset_h or 0
				offset_r = self.offset_r or 0
				clicker:set_eye_offset({x=0,y= offset_h ,z=0},{x=0,y= offset_r ,z=0})
			end
		end
	end

	function horse:on_activate(staticdata, dtime_s)
		self.object:set_armor_groups({fleshy=100})
		if staticdata then
			self.v = tonumber(staticdata)
		end
		
		local hp = self.hp or 10
		self.object:set_hp(hp)
	end

	function horse:get_staticdata()
		return tostring(self.v)
	end
	
	function horse:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
		--print(rider:get_player_name())
		local ridername = self.ridername
		if ridername ~= nil then
			rider = minetest.get_player_by_name(ridername)
			print(rider:get_player_name())
		end
		
		
		if puncher and puncher:is_player() then
			if puncher:get_player_name() == ridername or ridername == nil then
				puncher:get_inventory():add_item("main", name)
				default.player_attached[puncher:get_player_name()] = false
				puncher:set_detach()
				self.object:remove()
				if self.offset == true then
					puncher:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
				end
			elseif self.aggressive == true then
				local objs = minetest.get_objects_inside_radius(self.object:getpos(), 4)
				local _,obj
				for _,obj in ipairs(objs) do
					if obj:is_player() and puncher:get_player_name() == obj:get_player_name() then
						self.underattack = true
						minetest.after(2, function()
							self.underattack = false
						end)
						
						puncher:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = self.dps}
						}, nil)
					end
				end
			end
		else
			if puncher and self.aggressive == true then
				local objs = minetest.get_objects_inside_radius(self.object:getpos(), 4)
				local _,obj
				for _,obj in ipairs(objs) do
					if puncher:get_luaentity() == obj:get_luaentity() then
						self.underattack = true
						minetest.after(2, function()
							self.underattack = false
						end)
						
						puncher:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = self.dps}
						}, nil)
					end
				end
			end
		end
			
		if self.object:get_hp() <= 0 then
			default.player_attached[ridername] = false
			rider:set_detach()
			self.object:remove()
			if self.offset == true then
				rider:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
			end
		end
	end

	minetest.register_entity(name, horse)
end

---------------------

lottmobs:register_horse("lottmobs:horseh1", {
	description = "Brown Horse",
	inventory_image = "lottmobs_horse_inventory.png",
	}, {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "horseh1_model.x",
	textures = {"lottmobs_horse.png"},
	animation = {
		speed_normal = 10,
		stand_start = 0,
		stand_end = 50,
		walk_start = 75,
		walk_end = 98,
		
	},
	max_speed = 7,
	forward_boost = 2.33,
	jump_boost = 4
})

--horse white

lottmobs:register_horse("lottmobs:horsepegh1", {
	description = "White Horse",
	inventory_image = "lottmobs_horsepeg_inventory.png",
	}, {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "horseh1_model.x",
	textures = {"lottmobs_horsepeg.png"},
	animation = {
		speed_normal = 10,
		stand_start = 0,
		stand_end = 50,
		walk_start = 75,
		walk_end = 98,
	},
	max_speed = 7,
	forward_boost = 2.33,
	jump_boost = 4
})

--horse arabik

lottmobs:register_horse("lottmobs:horsearah1", {
	description = "Black Horse",
	inventory_image = "lottmobs_horseara_inventory.png",
	}, {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "horseh1_model.x",
	textures = {"lottmobs_horseara.png"},
	animation = {
		speed_normal = 10,
		stand_start = 0,
		stand_end = 50,
		walk_start = 75,
		walk_end = 98,
	},
	max_speed = 7,
	forward_boost = 2.33,
	jump_boost = 4
})


lottmobs:register_horse("lottmobs:shireponyblackh1", {
	description = "Shire Pony",
	inventory_image = "lottmobs_shireponyblack_inventory.png",
	}, {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1.3,y=1.3},
	mesh = "shireponyh1_model.x",
	textures = {"lottmobs_shireponyblack.png"},
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 45,
		walk_end = 85,
	},
	max_speed = 5,
	forward_boost = 1.67,
	jump_boost = 3
})


lottmobs:register_horse("lottmobs:shireponyh1", {
	description = "Shire Pony",
	inventory_image = "lottmobs_shirepony_inventory.png",
	}, {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1.3,y=1.3},
	mesh = "shireponyh1_model.x",
	textures = {"lottmobs_shirepony.png"},
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 45,
		walk_end = 85,
	},
	max_speed = 5,
	forward_boost = 1.67,
	jump_boost = 3
})


----------------------

mobs:register_mob("lottmobs:horse", {
	type = "animal",
	hp_min = 5,
    hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"lottmobs_horse.png"},
	},
	visual = "mesh",
	mesh = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "lottmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "",
    },
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
        	minetest.add_entity(self.object:getpos(), "lottmobs:horseh1")
        	if not minetest.setting_getbool("creative_mode") then
				item:take_item()
        		clicker:set_wielded_item(item)
        	end
		self.object:remove()
		end
	end,
    jump = true,
	step=1,
	passive = true,
})
mobs:register_spawn("lottmobs:horse", {"lottmapgen:rohan_grass"}, 20, -1, 6000, 3, 31000)

mobs:register_mob("lottmobs:horsepeg", {
	type = "animal",
	hp_min = 5,
    hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"lottmobs_horsepeg.png"},
	},
	visual = "mesh",
	mesh = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "lottmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "",
    },
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
        	minetest.add_entity(self.object:getpos(), "lottmobs:horsepegh1")
        	if not minetest.setting_getbool("creative_mode") then
				item:take_item()
        		clicker:set_wielded_item(item)
        	end
		self.object:remove()
		end
	end,
     jump = true,
	step=1,
	passive = true,
})
mobs:register_spawn("lottmobs:horsepeg", {"lottmapgen:rohan_grass"}, 20, -1, 7000, 3, 31000)


mobs:register_mob("lottmobs:horseara", {
	type = "animal",
	hp_min = 5,
	hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"lottmobs_horseara.png"},
	},
	visual = "mesh",
	mesh = "horse_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "lottmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "",
    },
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
    		minetest.add_entity(self.object:getpos(), "lottmobs:horsearah1")
    		if not minetest.setting_getbool("creative_mode") then
				item:take_item()
    			clicker:set_wielded_item(item)
            end
			self.object:remove()
		end
	end,
    jump = true,
	step=1,
	passive = true,
})
mobs:register_spawn("lottmobs:horseara", {"lottmapgen:rohan_grass"}, 20, -1, 7000, 3, 31000)

mobs:register_mob("lottmobs:shirepony", {
	type = "animal",
	hp_min = 5,
    hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"lottmobs_shirepony.png"},
	},
	visual = "mesh",
	mesh = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
    visual_size = {x=1.3,y=1.3},
	drops = {
		{name = "lottmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "",
    },
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 40,
		walk_start = 45,
		walk_end = 85,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
        	minetest.add_entity(self.object:getpos(), "lottmobs:shireponyh1")
			if not minetest.setting_getbool("creative_mode") then
			   	item:take_item()
            	clicker:set_wielded_item(item)
            end
			self.object:remove()
		end
	end,
    jump = true,
	step=1,
	passive = true,
})
mobs:register_spawn("lottmobs:shirepony", {"lottmapgen:shire_grass"}, 20, -1, 6000, 3, 31000)

mobs:register_mob("lottmobs:shireponyblack", {
	type = "animal",
	hp_min = 5,
    hp_max = 7,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"lottmobs_shireponyblack.png"},
	},
	visual = "mesh",
	mesh = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
    visual_size = {x=1.3,y=1.3},
	drops = {
		{name = "lottmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    sounds = {
		random = "",
    },
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 40,
		walk_start = 45,
		walk_end = 85,
	},
	follow = "farming:wheat",
	view_range = 5,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
    		minetest.add_entity(self.object:getpos(), "lottmobs:shireponyblackh1")
        	if not minetest.setting_getbool("creative_mode") then
				item:take_item()
                clicker:set_wielded_item(item)
        	end
			self.object:remove()
		end
	end,
    jump = true,
	step=1,
	passive = true,
})
mobs:register_spawn("lottmobs:shireponyblack", {"lottmapgen:shire_grass"}, 20, -1, 9000, 3, 31000)
