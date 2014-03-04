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

minetest.register_craft({
	output = 'default:desert_stone',
	recipe = {
		{'lottmapgen:mordor_stone'},
	}
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