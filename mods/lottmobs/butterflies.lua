minetest.register_entity("lottmobs:butterfly", {
	initial_properties = {
		visual = "mesh",
		mesh = "butterfly.b3d",
		textures = {"blank.png"},
		physical = false,
		collide_with_objects = false,
		weight = 5,
		collisionbox = {-0.15, 0, -0.15, 0.15, 0.15, 0.15},
		visual_size = {x = 2, y = 2},
	},
	get_staticdata = function(self)
		if self.textures ~= nil then
			return minetest.serialize(self.textures)
		end
	end,
	on_activate = function(self, staticdata)
		local textures = minetest.deserialize(staticdata)
		if not textures then
			self.textures = "lottmobs_butterfly_" .. math.random(4) .. ".png"
			textures = self.textures
		else
			self.textures = textures
		end
		self.object:set_properties({textures = {textures}})
		self.object:set_animation({x = 1, y = 90}, 40)
	end,
	-- Will always spawn in air, hopefully!
	standing_in = "air",
	y_vel = 0,
	on_step = function(self, dtime)
		self.node_timer = (self.node_timer or 0) + dtime
		self.grass_timer = (self.grass_timer or 0) + dtime
		local pos = self.object:get_pos()
		if self.node_timer > 0.25 then
			self.node_timer = 0
			self.standing_in = minetest.get_node(pos).name
			local yaw = self.object:get_yaw()
			if self.standing_in == "air" then
				if self.grass_timer > 3 then
					self.grass_timer = 0
					local near_grass = minetest.find_nodes_in_area(
						{x = pos.x, y = pos.y - 7, z = pos.z},
						{x = pos.x, y = pos.y + 1, z = pos.z},
						"group:dirt_with_grass")
					if #near_grass < 1 then
						self.y_vel = -2
						local vel = self.object:get_velocity()
						self.object:set_velocity({
							x = vel.x,
							y = -2,
							z = vel.z,
						})
						return
					end
				end
				if math.random(1, 100) <= 20 then
					yaw = yaw + math.random(-0.25, 0.25)
					local y_vel = self.y_vel + math.random(-0.15, 0.15)
					if y_vel > 0.5 then
						y_vel = 0.5
					elseif y_vel < -0.5 then
						y_vel = -0.5
					end
					self.y_vel = y_vel
					self.object:set_yaw(yaw)
					self.object:set_velocity({
						x = (math.sin(yaw) * -1),
						y = y_vel,
						z = (math.cos(yaw) * 1),
					})
				end
			else
				local flyable_nodes = minetest.find_nodes_in_area(
					{x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
					{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
					"air")
				if #flyable_nodes < 1 then
					self.object:remove()
				else
					local escape_target = flyable_nodes[math.random(1, #flyable_nodes)]
					local escape_direction = vector.direction(pos, escape_target)
					self.object:set_yaw((escape_direction.x / -escape_direction.z))
					self.y_vel = escape_direction.y * 2
					self.object:set_velocity(
						vector.multiply(escape_direction, 2))
				end
			end
		end
	end,
})
