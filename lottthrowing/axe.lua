minetest.register_craftitem("lottthrowing:axe", {
	description = "axe",
	inventory_image = "throwing_axe.png",
})

minetest.register_node("lottthrowing:axe_box", {
	tiles = {"default_tool_stoneaxe"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_AXE_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"lottthrowing:axe_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}

THROWING_AXE_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "lottthrowing:axe_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 3
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage = 3
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, 'lottthrowing:axe')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("lottthrowing:axe_entity", THROWING_AXE_ENTITY)

minetest.register_craft({
	output = 'lottthrowing:axe 16',
	recipe = {
		{'default:stick', 'default:stick', 'default:steel_ingot'},
	}
})

axes = {
	{"lottthrowing:axe", "lottthrowing:axe_entity"},
}

local throwing_shoot_axe = function(itemstack, player)
	for _,axe in ipairs(axes) do
		if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == axe[1] then
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", axe[1])
			end
			local playerpos = player:getpos()
			local obj = minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, axe[2])
			local dir = player:get_look_dir()
			obj:setvelocity({x=dir.x*19, y=dir.y*19, z=dir.z*19})
			obj:setacceleration({x=dir.x*-3, y=-10, z=dir.z*-3})
			obj:setyaw(player:get_look_yaw()+math.pi)
			minetest.sound_play("throwing_sound", {pos=playerpos})
			if obj:get_luaentity().player == "" then
				obj:get_luaentity().player = player
			end
			obj:get_luaentity().node = player:get_inventory():get_stack("main", 1):get_name()
			return true
		end
	end
	return false
end

minetest.register_tool("lottthrowing:axe_thrower_skill", {
	description = "Axe Thrower Skill",
	inventory_image = "lottthrowing_axe_thrower_skill.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if throwing_shoot_axe(itemstack, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
			end
		end
		return itemstack
	end,
})