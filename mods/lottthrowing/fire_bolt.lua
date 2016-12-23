minetest.register_craftitem("lottthrowing:bolt_fire", {
	description = "Fire Bolt",
	inventory_image = "lottthrowing_bolt_fire.png",
})

minetest.register_node("lottthrowing:bolt_fire_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"lottthrowing_bolt_fire.png", "lottthrowing_bolt_fire.png", "lottthrowing_bolt_fire_back.png", "lottthrowing_bolt_fire_front.png", "lottthrowing_bolt_fire_2.png", "lottthrowing_bolt_fire.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_BOLT_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"lottthrowing:bolt_fire_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	player = nil,
}

THROWING_BOLT_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "lottthrowing:bolt_fire_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 7
					obj:punch(self.player, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage = 7
				obj:punch(self.player, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" and node.name ~= "lottthrowing:light" then
			minetest.set_node(self.lastpos, {name="fire:basic_flame"})
			self.object:remove()
		end
		if math.floor(self.lastpos.x+0.5) ~= math.floor(pos.x+0.5) or math.floor(self.lastpos.y+0.5) ~= math.floor(pos.y+0.5) or math.floor(self.lastpos.z+0.5) ~= math.floor(pos.z+0.5) then
			if minetest.get_node(self.lastpos).name == "lottthrowing:light" then
				minetest.remove_node(self.lastpos)
			end
			if minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name="lottthrowing:light"})
			end
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("lottthrowing:bolt_fire_entity", THROWING_BOLT_ENTITY)

minetest.register_craft({
	output = 'lottthrowing:bolt_fire 1',
	recipe = {
		{'default:steel_ingot', 'default:torch'},
	},
})

minetest.register_node("lottthrowing:light", {
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"lottthrowing_empty.png"},
	light_source = LIGHT_MAX-4,
	selection_box = {
		type = "fixed",
		fixed = {
			{0,0,0,0,0,0}
		}
	},
	groups = {not_in_creative_inventory=1}
})

minetest.register_abm({
	nodenames = {"lottthrowing:light"},
	interval = 10,
	chance = 1,
	action = function(pos, node)
		minetest.remove_node(pos)
	end
})
