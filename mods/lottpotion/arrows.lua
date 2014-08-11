lottpotion.register_arrow = function(potion_name, name, hname, potion_use_funct, desc, img)
	minetest.register_craftitem(potion_name.."_arrow", {
		description = "Potion Arrow ("..desc..")",
		inventory_image = img.."^lottthrowing_arrow.png",
		groups = {},
	})
	
	local THROWING_ARROW_ENTITY={
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"lottthrowing:arrow_box"},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
	}
	
	THROWING_ARROW_ENTITY.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:getpos()
		local node = minetest.env:get_node(pos)
	
		if self.timer>0.2 then
			local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= potion_name.."_arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
						self.object:remove()
					end
				else
					local damage = 3
					potion_use_funct({take_item = function()end}, obj)
					self.object:remove()
				end
			end
		end
	
		if self.lastpos.x~=nil then
			if node.name ~= "air" then
				self.object:remove()
			end
		end
		self.lastpos={x=pos.x, y=pos.y, z=pos.z}
	end
	
	minetest.register_entity(potion_name.."_arrow_entity", THROWING_ARROW_ENTITY)
	
	minetest.register_craft({
		output = potion_name.."_arrow",
		recipe = {
			{'lottthrowing:arrow', potion_name},
		}
	})
	
	arrows[#arrows+1] = {potion_name.."_arrow", potion_name.."_arrow_entity"}
end
