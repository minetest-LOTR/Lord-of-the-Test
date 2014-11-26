minetest.register_node("curwe:blue_torch", {
	description = "Blue Torch",
	drawtype = "torchlike",
	tiles = {
		{name="curwe_blue_torch_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="curwe_blue_torch_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="curwe_blue_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	inventory_image = "curwe_blue_torch_floor.png",
	wield_image = "curwe_blue_torch_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,hot=2,forbidden=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
minetest.register_node("curwe:orc_torch", {
	description = "Orc Torch",
	drawtype = "torchlike",
	tiles = {
		{name="curwe_orc_torch_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="curwe_orc_torch_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="curwe_orc_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	inventory_image = "curwe_orc_torch_floor.png",
	wield_image = "curwe_orc_torch_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX-3,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,hot=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = 'curwe:blue_torch 2',
	recipe = {
		{'cemen:rough_rock_lump'},
		{'group:stick'},
	}
})
minetest.register_craft({
	output = 'curwe:orc_torch 2',
	recipe = {
		{'bones:bone'},
		{'group:stick'},
	}
})