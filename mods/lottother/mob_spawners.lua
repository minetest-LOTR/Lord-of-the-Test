-- Mobs spawners for buildings
-- Mordor

minetest.register_node("lottother:mordorms", {
	description = "Mordor Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 4) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:orc")
		elseif math.random(1, 5) == 3 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:uruk_hai")
		elseif math.random(1, 11) == 4 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:battle_troll")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

-- Rohan

minetest.register_node("lottother:rohanms", {
	description = "Rohan Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 3) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:rohan_guard")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

-- Elf

minetest.register_node("lottother:elfms", {
	description = "Elf Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:elf")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Hobbit

minetest.register_node("lottother:hobbitms", {
	description = "Hobbit Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:hobbit")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Gondor

minetest.register_node("lottother:gondorms", {
	description = "Gondor Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 3) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:gondor_guard")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Angmar

minetest.register_node("lottother:angmarms", {
	description = "Angmar Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:half_troll")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

--Dwarf

minetest.register_node("lottother:dwarfms", {
	description = "Dwarf Mob Spawner",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	drop = '',
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	on_construct = function(pos, node)
		if math.random(1, 2) == 2 then
			minetest.add_entity({x = pos.x, y = pos.y+1, z = pos.z}, "lottmobs:dwarf")
		end
		minetest.remove_node(pos)
	end,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
})

minetest.register_alias("lottother:gondorms_on", "lottother:gondorms")
minetest.register_alias("lottother:gondorms_off", "lottother:gondorms")
minetest.register_alias("lottother:rohanms_on", "lottother:rohanms")
minetest.register_alias("lottother:rohanms_off", "lottother:rohanms")
minetest.register_alias("lottother:angmarms_on", "lottother:angmarms")
minetest.register_alias("lottother:angmarms_off", "lottother:angmarms")
minetest.register_alias("lottother:hobbitms_on", "lottother:hobbitms")
minetest.register_alias("lottother:hobbitms_off", "lottother:hobbitms")
minetest.register_alias("lottother:elfms_on", "lottother:elfms")
minetest.register_alias("lottother:elfms_off", "lottother:elfms")
minetest.register_alias("lottother:mordorms_on", "lottother:mordorms")
minetest.register_alias("lottother:mordorms_off", "lottother:mordorms")
