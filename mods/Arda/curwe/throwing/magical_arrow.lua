minetest.register_craftitem("curwe:arrow_magical", {
	description = "Magical Arrow",
	inventory_image = "curwe_arrow_magical.png",
     groups = {forbidden=1},
})

minetest.register_node("curwe:arrow_magical_box", {
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
	tiles = {"curwe_arrow_magical.png", "curwe_arrow_magical.png", "curwe_arrow_magical_back.png", "curwe_arrow_magical_front.png", "curwe_arrow_magical_2.png", "curwe_arrow_magical.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"curwe:arrow_magical_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	player = "",
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "curwe:arrow_magical_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					if self.player ~= "" then
						self.player:setpos(pos)
						self.player:get_inventory():add_item("main", ItemStack("curwe:arrow_magical"))
					end
					self.object:remove()
				end
			else
				if self.player ~= "" then
					self.player:setpos(pos)
					self.player:get_inventory():add_item("main", ItemStack("curwe:arrow_magical"))
				end
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			if self.player ~= "" then
					self.player:setpos(self.lastpos)
					self.player:get_inventory():add_item("main", ItemStack("curwe:arrow_magical"))
				end
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("curwe:arrow_magical_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = 'curwe:arrow_magical',
	recipe = {
		{'default:stick', 'default:stick', 'default:mese'},
	}
})
