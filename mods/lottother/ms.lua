-- Mobs spawner names (not working currently)


--Mordor

minetest.register_node("lottother:mordorms_off", {
	description = "mordor spawner off",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("lottother:mordorms_on", {
	description = "mordor spawner on",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

-- Rohan

minetest.register_node("lottother:rohanms_off", {
	description = "rohan spawner off",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("lottother:rohanms_on", {
	description = "rohan spawner on",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_abm({
	nodenames = {"lottother:rohanms_off"},
	interval = 8,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="lottother:rohanms_on"})
	end,
})

-- Elf

minetest.register_node("lottother:elfms_off", {
	description = "elf spawner off",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("lottother:elfms_on", {
	description = "elf spawner on",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Hobbit

minetest.register_node("lottother:hobbitms_off", {
	description = "hobbit spawner off",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("lottother:hobbitms_on", {
	description = "hobbit spawner on",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Gondor

minetest.register_node("lottother:gondorms_off", {
	description = "gondor spawner off",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("lottother:gondorms_on", {
	description = "gondor spawner on",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Angmar

minetest.register_node("lottother:angmarms_off", {
	description = "angmar spawner off",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
     drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_node("lottother:angmarms_on", {
	description = "angmar spawner on",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})