minetest.register_node("lottmapgen:fog", {
	description = "Fog",
	drawtype = "glasslike",
	tiles = {"lottmapgen_fog.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	post_effect_color = {a=128, r=241, g=248, b=255},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:angsnowblock", {
	description = "Snow Block",
	tiles = {"default_snow.png"},
	is_ground_content = true,
     drop = 'default:snowblock',
	freezemelt = "default:water_source",
	groups = {crumbly=3, melts=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
})

minetest.register_node("lottmapgen:frozen_stone", {
	description = "Frozen Stone",
	tiles = {"default_stone.png^lottmapgen_frozen.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble','default:snow',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:mordor_stone", {
	description = "Mordor Stone",
	tiles = {"lottmapgen_mordor_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:ice", {
	description = "Ice",
	drawtype = "glasslike",
	tiles = {"lottmapgen_ice.png"},
	is_ground_content = true,
    alpha = 200,
	paramtype = "light",
	freezemelt = "default:water_source",
	groups = {cracky=3, melts=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lottmapgen:blacksource", {
	description = "Black Water Source",
	inventory_image = minetest.inventorycube("lottmapgen_black_water.png"),
	tiles = {"lottmapgen_black_water.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=224, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("lottmapgen:blackflowing", {
	drawtype = "flowingliquid",
	tiles = {"lottmapgen_black_water.png"},
	special_tiles = {
		{
			image="lottmapgen_black_water_flow.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
		{
			image="lottmapgen_black_water_flow.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
	},
	-- alpha = 224,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=224, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

-- Grasses

minetest.register_node("lottmapgen:dunland_grass", {
	description = "Dunland Grass",
	tiles = {"lottmapgen_dunland_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_dunland_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:ironhill_grass", {
	description = "Iron Hills Grass",
	tiles = {"lottmapgen_dunland_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_dunland_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:gondor_grass", {
	description = "Gondor Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:lorien_grass", {
	description = "Lorien Grass",
	tiles = {"lottmapgen_lorien_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_lorien_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:fangorn_grass", {
	description = "? Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:mirkwood_grass", {
	description = "Mirkwood Grass",
	tiles = {"lottmapgen_mirkwood_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_mirkwood_grass_side.png"}, 
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:rohan_grass", {
	description = "? Grass",
	tiles = {"lottmapgen_rohan_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_rohan_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:shire_grass", {
	description = "Shire Grass",
	tiles = {"lottmapgen_shire_grass.png", "default_dirt.png", "default_dirt.png^lottmapgen_shire_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory =1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})