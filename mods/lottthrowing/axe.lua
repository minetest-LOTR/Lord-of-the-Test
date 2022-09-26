local creative = minetest.settings:get_bool("creative_mode")

local lottthrowing_register_axe = function(axe, desc, damage, craft1, craft2)
	local axe_entity = "lottthrowing:" .. axe .. "_entity"
	local lottthrowing_throw_axe = function(itemstack, player)
		if not minetest.settings:get_bool("creative_mode") then
			player:get_inventory():remove_item("main", player:get_wield_index())
		end
		local playerpos = player:get_pos()
		local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, axe_entity)
		obj:get_luaentity().player = player or nil
		local dir = player:get_look_dir()
		obj:set_velocity({x=dir.x*27, y=dir.y*30, z=dir.z*27})
		obj:set_acceleration({x=dir.x*-1, y=-5, z=dir.z*-1})
		obj:set_yaw(player:get_look_horizontal()+math.pi)
		minetest.sound_play("lottthrowing_sound", {pos=playerpos})
		if obj:get_luaentity().player == "" then
			obj:get_luaentity().player = player
		end
		obj:get_luaentity().node = player:get_inventory():get_stack("main", 1):get_name()
		return true
	end

	minetest.register_craftitem("lottthrowing:axe_" .. axe, {
		description = desc .. " Throwing Axe",
	    on_use = function(itemstack, user, pointed_thing)
	        lottthrowing_throw_axe(item, user, pointed_thing)
	        if not creative then
				itemstack:take_item()
	        end
	        return itemstack
	    end,
		inventory_image = "lottthrowing_axe_" .. axe .. "_inv.png",
	})

	minetest.register_node("lottthrowing:" .. axe .. "_axe_box", {
		drawtype = "nodebox",
	    node_box = {
			type = "fixed",
			fixed = {
				{0.375, -0.5, -0.0625, 0.5, -0.375, 0.0625}, -- NodeBox1
				{0.25, -0.375, -0.0625, 0.375, -0.25, 0.0625}, -- NodeBox2
				{0.125, -0.25, -0.0625, 0.25, -0.125, 0.0625}, -- NodeBox3
				{0, -0.125, -0.0625, 0.125, 0, 0.0625}, -- NodeBox4
				{-0.125, 0, -0.0625, 0, 0.125, 0.0625}, -- NodeBox5
				{-0.25, 0, -0.0625, -0.125, 0.25, 0.0625}, -- NodeBox6
				{-0.375, 0, -0.0625, -0.25, 0.375, 0.0625}, -- NodeBox7
				{-0.5, 0, -0.0625, -0.375, 0.5, 0.0625}, -- NodeBox8
			}
		},
	    tiles = {
			"lottthrowing_axe_top.png",
			"lottthrowing_axe_top.png",
			"lottthrowing_axe_back.png",
			"lottthrowing_axe_" .. axe .. "_front.png",
			"lottthrowing_axe_" .. axe .. ".png",
			"lottthrowing_axe_" .. axe .. "2.png"
		},
		use_texture_alpha = "clip",
		groups = {not_in_creative_inventory=1},
	})

	local aep = axe_entity .. "_placeholder"

	local aep = {
		physical = false,
		timer = 0,
		visual = "wielditem",
		visual_size = {x=0.5, y=0.5},
		textures = {"lottthrowing:" .. axe .. "_axe_box"},
		lastpos = {},
		collisionbox = {0,0,0,0,0,0},
		player = nil,
	}

	aep.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:get_pos()
		local node = minetest.get_node(pos)

		if self.timer>0.2 then
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= axe_entity and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.player, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
						self.object:remove()
	                    if math.random(1, 4) ~= 3 and not creative then
	                        minetest.add_item(self.lastpos, 'lottthrowing:axe_' .. axe)
	                    end
					end
				else
					obj:punch(self.player, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					self.object:remove()
	                if math.random(1, 4) ~= 3 and not creative then
	                    minetest.add_item(self.lastpos, 'lottthrowing:axe_' .. axe)
	                end
				end
			end
		end

		if self.lastpos.x~=nil then
			if node.name ~= "air" then
				self.object:remove()
				if not creative then
					minetest.add_item(self.lastpos, 'lottthrowing:axe_' .. axe)
				end
			end
		end
		self.lastpos={x=pos.x, y=pos.y, z=pos.z}
	end
	minetest.register_entity(axe_entity, aep)
	if not craft2 then
		minetest.register_craft({
			output = "lottthrowing:axe_" .. axe .. " 4",
			recipe = {
				{craft1, "group:stick"},
				{craft1, "group:stick"},
				{"", "group:stick"},
			}
		})
	else
		minetest.register_craft({
			output = "lottthrowing:axe_" .. axe .. " 4",
			recipe = {
				{craft2, "group:stick"},
				{craft1, "group:stick"},
				{"", "group:stick"},
			}
		})
	end
end

lottthrowing_register_axe("dwarf", "Dwarvern", 12, "lottores:mithril_ingot", "default:steel_ingot")
lottthrowing_register_axe("elf", "Elven", 10, "lottores:galvorn_ingot", "default:steel_ingot")
lottthrowing_register_axe("steel", "Steel", 5, "default:steel_ingot")
lottthrowing_register_axe("galvorn", "Galvorn", 7, "lottores:galvorn_ingot")