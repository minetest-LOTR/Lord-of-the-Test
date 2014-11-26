minetest.register_node("cemen:dirt", {
	description = "Dirt Substitute",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
     drop = 'default:dirt',
	groups = {crumbly=3,soil=1,not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("cemen:snow", {
	description = "Snow Substitute",
	tiles = {"default_snow.png"},
	is_ground_content = true,
     drop = 'default:snowblock',
	freezemelt = "default:water_source",
	groups = {crumbly=3, melts=1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
})

minetest.register_node("cemen:mordor_stone_s", {
	description = "Mordor Stone Substitute",
	tiles = {"cemen_mordor_stone.png"},
	is_ground_content = true,
     drop = 'cemen:mordor_stone',
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("cemen:air", {
	description = "Air Substitute",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_abm({
	nodenames = {"cemen:dirt"},
	neighbors = {"air"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local down = {x=x,y=y-1,z=z}
          local down2 = {x=x,y=y-2,z=z}
          local down3 = {x=x,y=y-3,z=z}
          local down4 = {x=x,y=y-4,z=z}
          local down5 = {x=x,y=y-5,z=z}
          local down6 = {x=x,y=y-6,z=z}
          local down7 = {x=x,y=y-7,z=z}
		if minetest.get_node(down).name == "air" then
			minetest.set_node(down, {name="default:dirt"})
               minetest.set_node(down2, {name="default:dirt"})
               minetest.set_node(down3, {name="default:dirt"})
               minetest.set_node(down4, {name="default:dirt"})
               minetest.set_node(down5, {name="default:dirt"})
               minetest.set_node(down6, {name="default:dirt"})
               minetest.set_node(down7, {name="cemen:dirt"})
		end
     end,
})

minetest.register_abm({
	nodenames = {"cemen:snow"},
	neighbors = {"air"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local down = {x=x,y=y-1,z=z}
          local down2 = {x=x,y=y-2,z=z}
          local down3 = {x=x,y=y-3,z=z}
          local down4 = {x=x,y=y-4,z=z}
          local down5 = {x=x,y=y-5,z=z}
          local down6 = {x=x,y=y-6,z=z}
          local down7 = {x=x,y=y-7,z=z}
		if minetest.get_node(down).name == "air" then
			minetest.set_node(down, {name="default:snowblock"})
               minetest.set_node(down2, {name="default:snowblock"})
               minetest.set_node(down3, {name="default:snowblock"})
               minetest.set_node(down4, {name="default:snowblock"})
               minetest.set_node(down5, {name="default:snowblock"})
               minetest.set_node(down6, {name="default:snowblock"})
               minetest.set_node(down7, {name="cemen:snow"})
		end
     end,
})

minetest.register_abm({
	nodenames = {"cemen:mordor_stone_s"},
	neighbors = {"air"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local down = {x=x,y=y-1,z=z}
          local down2 = {x=x,y=y-2,z=z}
          local down3 = {x=x,y=y-3,z=z}
          local down4 = {x=x,y=y-4,z=z}
          local down5 = {x=x,y=y-5,z=z}
          local down6 = {x=x,y=y-6,z=z}
          local down7 = {x=x,y=y-7,z=z}
		if minetest.get_node(down).name == "air" then
			minetest.set_node(down, {name="cemen:mordor_stone"})
               minetest.set_node(down2, {name="cemen:mordor_stone"})
               minetest.set_node(down3, {name="cemen:mordor_stone"})
               minetest.set_node(down4, {name="cemen:mordor_stone"})
               minetest.set_node(down5, {name="cemen:mordor_stone"})
               minetest.set_node(down6, {name="cemen:mordor_stone"})
               minetest.set_node(down7, {name="cemen:mordor_stone_s"})
		end
     end,
})

minetest.register_abm({
	nodenames = {"cemen:dirt"},
	neighbors = {"default:dirt"},
	interval = 150,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="default:dirt"})
     end,
})

minetest.register_abm({
	nodenames = {"cemen:snow"},
	neighbors = {"default:snowblock"},
	interval = 150,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="default:snowblock"})
     end,
})

minetest.register_abm({
	nodenames = {"cemen:mordor_stone_s"},
	neighbors = {"cemen:mordor_stone"},
	interval = 150,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="cemen:mordor_stone"})
     end,
})

minetest.register_abm({
	nodenames = {"cemen:air"},
	interval = 7,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:remove_node(pos)
	end,
})

-- Mobs spawner (disabled currently)
--Mordor

minetest.register_node("cemen:mordorms_off", {
	description = "mordor spawner off",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("cemen:mordorms_on", {
	description = "mordor spawner on",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

-- Rohan

minetest.register_node("cemen:rohanms_off", {
	description = "rohan spawner off",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("cemen:rohanms_on", {
	description = "rohan spawner on",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_abm({
	nodenames = {"cemen:rohanms_off"},
	interval = 8,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="cemen:rohanms_on"})
	end,
})

-- Elf

minetest.register_node("cemen:elfms_off", {
	description = "elf spawner off",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("cemen:elfms_on", {
	description = "elf spawner on",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Hobbit

minetest.register_node("cemen:hobbitms_off", {
	description = "hobbit spawner off",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("cemen:hobbitms_on", {
	description = "hobbit spawner on",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Gondor

minetest.register_node("cemen:gondorms_off", {
	description = "gondor spawner off",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("cemen:gondorms_on", {
	description = "gondor spawner on",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Angmar

minetest.register_node("cemen:angmarms_off", {
	description = "angmar spawner off",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("cemen:angmarms_on", {
	description = "angmar spawner on",
	drawtype = "glasslike",
	tiles = {"cemen_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})