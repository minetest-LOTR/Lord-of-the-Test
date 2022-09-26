minetest.register_node("lottthrowing:light", {
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"lottthrowing_empty.png"},
	light_source = minetest.LIGHT_MAX - 4,
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

local arrow_types = {
	{"arrow", "Arrow", 3},
	{"arrow_mithril", "Mithril Arrow", 10},
	{"arrow_fire", "Fire Arrow", 5, "fire:basic_flame"},
	{"arrow_fire_blue", "Fire Arrow", 20, "lottother:blue_flame"},
	{"arrow_magical", "Magical Arrow", 0, nil, true},

	{"bolt", "Bolt", 5},
	{"bolt_mithril", "Mithril Bolt", 20},
	{"bolt_fire", "Fire Bolt", 8, "fire:basic_flame"},
}

for i in pairs(arrow_types) do
	local name = arrow_types[i][1]
	local desc = arrow_types[i][2]
	local dama = arrow_types[i][3]
	local fire = arrow_types[i][4]
	local tele = arrow_types[i][5]

	minetest.register_craftitem("lottthrowing:"..name, {
		description = desc,
		inventory_image = "lottthrowing_"..name..".png",
	})

	minetest.register_node("lottthrowing:"..name.."_box", {
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
		tiles = {"lottthrowing_"..name..".png", "lottthrowing_"..name..".png", "lottthrowing_"..name.."_back.png", "lottthrowing_"..name.."_front.png", "lottthrowing_"..name.."_2.png", "lottthrowing_"..name..".png"},
		use_texture_alpha = "clip",
		groups = {not_in_creative_inventory=1},
	})

	minetest.register_entity("lottthrowing:"..name.."_entity", {
		physical = false,
		timer = 0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"lottthrowing:"..name.."_box"},
		lastpos = {},
		collisionbox = {0,0,0,0,0,0},
		player = nil,
		on_step = function(self, dtime)
			self.timer = self.timer + dtime
			local pos = self.object:get_pos()
			local node = minetest.get_node(pos)

			if self.timer > 0.2 then
				local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 2)
				for k, obj in pairs(objs) do
					if obj:get_luaentity() ~= nil then
						if obj:get_luaentity().name ~= "lottthrowing:"..name.."_entity" and obj:get_luaentity().name ~= "__builtin:item" then
							if dama > 0 then
								obj:punch(self.player, 1.0, {
									full_punch_interval = 1.0,
									damage_groups = {fleshy= dama},
								}, nil)
							end
							self.object:remove()
						end
					else
						if dama > 0 then
							obj:punch(self.player, 1.0, {
								full_punch_interval = 1.0,
								damage_groups = {fleshy = dama},
							}, nil)
						end
						self.object:remove()
					end
				end
			end

			if self.lastpos.x ~= nil then
				if node.name ~= "air" and node.name ~= "lottthrowing:light" then
					if fire then
						minetest.set_node(self.lastpos, {name= fire})
					elseif tele then
						if self.player ~= "" then
							self.player:set_pos(self.lastpos)
							self.player:get_inventory():add_item("main", ItemStack("lottthrowing:arrow_magical"))
						end
					else
						minetest.add_item(self.lastpos, "lottthrowing:"..name)
					end
					self.object:remove()
				end
				if fire then
					if math.floor(self.lastpos.x+0.5) ~= math.floor(pos.x+0.5) or math.floor(self.lastpos.y+0.5) ~= math.floor(pos.y+0.5) or math.floor(self.lastpos.z+0.5) ~= math.floor(pos.z+0.5) then
						if minetest.get_node(self.lastpos).name == "lottthrowing:light" then
							minetest.remove_node(self.lastpos)
						end
						if minetest.get_node(pos).name == "air" then
							minetest.set_node(pos, {name="lottthrowing:light"})
						end
					end
				end
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end,
	})
end

minetest.register_craft({
	output = 'lottthrowing:arrow 16',
	recipe = {
		{'default:stick', 'default:stick', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:arrow_mithril 16',
	recipe = {
		{'default:stick', 'default:stick', 'lottores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'lottthrowing:arrow_fire 1',
	recipe = {
		{'default:stick', 'default:stick', 'default:torch'},
	},
})

minetest.register_craft({
	output = 'lottthrowing:arrow_fire_blue 1',
	recipe = {
		{'default:stick', 'default:stick', 'lottblocks:elf_torch'},
	},
})

minetest.register_craft({
	output = 'lottthrowing:arrow_magical',
	recipe = {
		{'default:stick', 'default:stick', 'default:mese'},
	}
})