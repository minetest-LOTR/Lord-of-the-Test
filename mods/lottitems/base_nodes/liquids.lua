-- Water

minetest.register_node("lottitems:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	paramtype = "light",
	tiles = {{
		name = "lottitems_water_source_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1.0,
		}
	}},
	drop = "",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	alpha = 160,
	drowning = 2,
	liquid_viscosity = 1,
	liquidtype = "source",
	liquid_alternative_source = "lottitems:water_source",
	liquid_alternative_flowing = "lottitems:water_flowing",
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 1, liquid = 1},
})

minetest.register_node("lottitems:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	tiles = {"lottitems_water.png"},
	special_tiles = {{
		name = "lottitems_water_flowing_animated.png",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 0.8,
		}},
		{
		name = "lottitems_water_flowing_animated.png",
		backface_culling = true,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 0.8,
		},},
	},
	drop = "",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	alpha = 160,
	drowning = 2,
	liquid_viscosity = 1,
	liquidtype = "flowing",
	liquid_alternative_source = "lottitems:water_source",
	liquid_alternative_flowing = "lottitems:water_flowing",
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 1, liquid = 1},
})

-- Lava

minetest.register_node("lottitems:lava_source", {
	description = "Lava Source",
	drawtype = "liquid",
	paramtype = "light",
	light_source = 11,
	tiles = {{
		name = "lottitems_lava_source_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.0,
		}
	}},
	drop = "",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 5,
	liquid_renewable = false,
	liquid_viscosity = 1,
	damage_per_second = 6,
	liquidtype = "source",
	liquid_alternative_source = "lottitems:lava_source",
	liquid_alternative_flowing = "lottitems:lava_flowing",
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 1, liquid = 1},
})

minetest.register_node("lottitems:lava_flowing", {
	description = "Flowing Lava",
	drawtype = "flowingliquid",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 11,
	tiles = {"lottitems_lava.png"},
	special_tiles = {{
		name = "lottitems_lava_flowing_animated.png",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.0,
		}},
		{
		name = "lottitems_lava_flowing_animated.png",
		backface_culling = true,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.0,
		},},
	},
	drop = "",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 5,
	liquid_viscosity = 7,
	damage_per_second = 6,
	liquidtype = "flowing",
	liquid_alternative_source = "lottitems:lava_source",
	liquid_alternative_flowing = "lottitems:lava_flowing",
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 1, liquid = 1},
})

-- Mordor Water
minetest.register_node("lottitems:mordor_water_source", {
	description = "Water Source",
	drawtype = "liquid",
	paramtype = "light",
	tiles = {{
		name = "lottitems_mordor_water_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.0,
		}
	}},
	drop = "",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	alpha = 200,
	drowning = 2,
	damage_per_second = 2,
	liquid_viscosity = 2,
	liquidtype = "source",
	liquid_alternative_source = "lottitems:morodr_water_source",
	liquid_alternative_flowing = "lottitems:mordor_water_flowing",
	post_effect_color = {a=192, r=140, g=140, b=140},
	groups = {water = 1, liquid = 1},
})

minetest.register_node("lottitems:mordor_water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	tiles = {"lottitems_mordor_water.png"},
	special_tiles = {{
		name = "lottitems_mordor_water_animated.png",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 0.5,
		}},
		{
		name = "lottitems_mordor_water_animated.png",
		backface_culling = true,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 0.5,
		},},
	},
	drop = "",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	alpha = 200,
	drowning = 2,
	damage_per_second = 2,
	liquid_viscosity = 2,
	liquidtype = "flowing",
	liquid_alternative_source = "lottitems:mordor_water_source",
	liquid_alternative_flowing = "lottitems:mordor_water_flowing",
	post_effect_color = {a=192, r=140, g=140, b=140},
	groups = {mordor = 1, water = 1, liquid = 1},
})

