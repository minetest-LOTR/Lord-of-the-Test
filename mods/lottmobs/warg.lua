lottmobs:register_horse("lottmobs:warg_mount", {
	description = "Warg",
	inventory_image = "lottmobs_warg_inv.png",
	}, {
	physical = true,
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 2.5, 0.5},
	visual = "mesh",
	stepheight = 1.1,
	attach_height = 20,
	offset = true,
	offset_h = 4,
	run = true,
	hp = 40,
	dps = 8,
	aggressive = true,
	mesh = "warg_mount.b3d",
	textures = {"lottmobs_warg.png"},
	animation = {
		speed_normal = 10,
		stand_start = 135,
		stand_end = 280,
		walk_start = 80,
		walk_end = 130,
		punch_start = 350,
		punch_end = 390,
	},
	max_speed = 7,
	forward_boost = 2.33,
	jump_boost = 7,
})
----------------

mobs:register_mob("lottmobs:warg", {
	type = "npc",
	race = "GAMEorc",
	hp_min = 25,
	hp_max = 40,
	collisionbox = {-1.2, -0.1, -1.2, 1.2, 1.5, 1.2},
	textures = {
		{"lottmobs_warg.png"},
	},
	visual = "mesh",
	mesh = "warg.b3d",
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 3,
	view_range = 15,
	armor = 300,
	drops = {
		{name = "lottmobs:meat_raw",
		chance = 5,
		min = 3,
		max = 10,},
		{name = "lottclothes:felt_grey",
		chance = 5,
		min = 2,
		max = 7,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 3,
	lava_damage = 1,
	light_damage = 0,
	damage = 8,
	attack_type = "dogfight", --Rather suitable name!
	animation = {
		speed_normal = 10,
		speed_run = 10,
		stand_start = 135,
		stand_end = 280,
		walk_start = 40,
		walk_end = 75,
		run_start = 80,
		run_end = 130,
		punch_start = 350,
		punch_end = 420,
	},
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "bones:skeleton_body" then
        	minetest.add_entity(self.object:getpos(), "lottmobs:warg_mount")
        	if not minetest.setting_getbool("creative_mode") then
				item:take_item()
        		clicker:set_wielded_item(item)
        	end
		self.object:remove()
		end
	end,
	do_custom = lottmobs.do_custom_guard,
	jump = true,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	sounds = {},
})
mobs:register_spawn("lottmobs:warg", {"lottmapgen:mordor_stone"}, 20, -1, 5000, 3, 31000)
mobs:register_spawn("lottmobs:warg", {"default:snowblock"}, 15, -1, 7500, 3, 31000)
mobs:register_spawn("lottmobs:warg", {"lottmapgen:angsnowblock"}, 20, -1, 5000, 5, 31000)