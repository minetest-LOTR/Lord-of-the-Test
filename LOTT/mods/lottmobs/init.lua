dofile(minetest.get_modpath("lottmobs").."/api.lua")
-- Mobs

lottmobs:register_mob("lottmobs:elf", {
	type = "animal",
	hp_max = 10,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	textures = {"lottmobs_elf.png"},
	visual = "mesh",
	mesh = "elf_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 100,
		drops = {
		{name = "",
		chance = 1,
		min = 1,
		max = 1,},
	},
	light_resistant = true,
    armor = 100,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:elf", {"lottplants:elanor"}, 20, -1, 50, 3, 31000)
lottmobs:register_spawn("lottmobs:elf", {"lottplants:niphredil"}, 20, -1, 50, 3, 31000)
lottmobs:register_spawn("lottmobs:elf", {"lottplants:lissuin"}, 20, -1, 50, 3, 31000)
lottmobs:register_spawn("lottmobs:elf", {"lottplants:mallorntree"}, 20, -1, 50, 3, 31000)
lottmobs:register_spawn("lottmobs:elf", {"lottplants:mallornleaf"}, 20, -1, 100, 3, 31000)

lottmobs:register_mob("lottmobs:ent", {
	type = "animal",
	hp_max = 20,
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 2.6, 0.7},
	textures = {"lottmobs_ent.png"},
	visual_size = {x=9,y=9},
	visual = "mesh",
	mesh = "ent_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 500,
	drops = {
		{name = "default:tree",
		chance = 10,
		min = 5,
		max = 10,},
	},
	    light_resistant = true,
    armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 20,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62,
	},
})
lottmobs:register_spawn("lottmobs:ent", {"default:leaves"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:birchtree"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:birchleaf"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:rowanleaf"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:elmleaf"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:asphodel"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:anemones"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:eglantive"}, 15, -1, 300, 1, 31000)
lottmobs:register_spawn("lottmobs:ent", {"lottplants:iris"}, 15, -1, 300, 1, 31000)

lottmobs:register_mob("lottmobs:rohan_guard", {
	type = "animal",
	hp_max = 10,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	textures = {"lottmobs_rohan_guard.png"},
	visual = "mesh",
	mesh = "human_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "default:sword_stone",
		chance = 100,
		min = 1,
		max = 1,},
	},
	    light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:rohan_guard", {"lottplants:mallos"}, 20, -1, 20, 3, 31000)
lottmobs:register_spawn("lottmobs:rohan_guard", {"lottplants:athelas"}, 20, -1, 20, 3, 31000)
lottmobs:register_spawn("lottmobs:rohan_guard", {"lottplants:pipeweed_wild"}, 20, -1, 20, 3, 31000)
lottmobs:register_spawn("lottmobs:rohan_guard", {"lottplants:lebethrontree"}, 20, -1, 20, 3, 31000)
lottmobs:register_spawn("lottmobs:rohan_guard", {"lottplants:aldertree"}, 20, -1, 20, 3, 31000)

lottmobs:register_mob("lottmobs:gondor_guard", {
	type = "animal",
	hp_max = 10,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	textures = {"lottmobs_gondor_guard.png"},
	visual = "mesh",
	mesh = "human_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "bones:bones",
		chance = 1,
		min = 1,
		max = 1,},
	},
	    light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:mallos"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:athelas"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:pipeweed_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:corn_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:potato_wild"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:mushroom_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:berries_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:turnips_wild"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:tomatoes_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:cabbage_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:pilinehtar"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:lebethrontree"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:gondor_guard", {"lottplants:aldertree"}, 20, -1, 5, 3, 31000)

lottmobs:register_mob("lottmobs:dunlending", {
	type = "monster",
	hp_max = 5,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_dunlending.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 4,
	drops = {
		{name = "default:axe_stone",
		chance = 100,
		min = 1,
		max = 1,},
	},
        light_resistant = true,
	armor = 100,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:mallos"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:athelas"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:pipeweed_wild"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:corn_wild"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:potato_wild"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:mushroom_wild"}, 20, -1, 5, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:berries_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:turnips_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:tomatoes_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:cabbage_wild"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:pilinehtar"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:lebethrontree"}, 20, -1, 10, 3, 31000)
lottmobs:register_spawn("lottmobs:dunlending", {"lottplants:aldertree"}, 20, -1, 10, 3, 31000)

lottmobs:register_mob("lottmobs:hobbit", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	textures = {"lottmobs_hobbit.png"},
	visual = "mesh",
	mesh = "dwarf_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 100,
	drops = {
		{name = "flowers:rose",
		chance = 1,
		min = 1,
		max = 1,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:hobbit", {"flowers:dandelion_yellow"}, 20, -1, 1000, 3, 31000)
lottmobs:register_spawn("lottmobs:hobbit", {"flowers:geranium"}, 20, -1, 1000, 3, 31000)
lottmobs:register_spawn("lottmobs:hobbit", {"flowers:dandelion_white"}, 20, -1, 1000, 3, 31000)
lottmobs:register_spawn("lottmobs:hobbit", {"flowers:rose"}, 20, -1, 1000, 3, 31000)
lottmobs:register_spawn("lottmobs:hobbit", {"flowers:tulip"}, 20, -1, 1000, 3, 31000)
lottmobs:register_spawn("lottmobs:hobbit", {"flowers:viola"}, 20, -1, 1000, 3, 31000)

lottmobs:register_mob("lottmobs:orc", {
	type = "monster",
	hp_max = 7,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_orc.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 2,
	drops = {
		{name = "bones:bones",
		chance = 1,
		min = 1,
		max = 1,},
	},
        light_resistant = true,
	armor = 100,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 7,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:orc", {"lottmapgen:mordor_stone"}, 20, -1, 300, 3, 31000)

lottmobs:register_mob("lottmobs:uruk_hai", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_uruk_hai.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 4,
	drops = {
		{name = "default:sword_steel",
		chance = 100,
		min = 1,
		max = 1,},
	},
        light_resistant = true,
	armor = 200,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:uruk_hai", {"lottmapgen:mordor_stone"}, 15, -1, 1000, 3, 31000)

lottmobs:register_mob("lottmobs:battle_troll", {
	type = "monster",
	hp_max = 25,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "troll_model.x",
	textures = {"lottmobs_battle_troll.png"},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 5,
	drops = {
		{name = "bones:bones",
		chance = 1,
		min = 3,
		max = 3,},
	},
        light_resistant = true,
	armor = 100,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 1,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
})
lottmobs:register_spawn("lottmobs:battle_troll", {"lottmapgen:mordor_stone"}, 10, -1, 10000, 5, 31000)

lottmobs:register_mob("lottmobs:half_troll", {
	type = "monster",
	hp_max = 15,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_half_troll.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 8,
	drops = {
		{name = "default:sword_steel",
		chance = 100,
		min = 1,
		max = 1,},
	},
        light_resistant = true,
	armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:half_troll", {"default:snow"}, 15, -1, 8000, 3, 31000)
lottmobs:register_spawn("lottmobs:half_troll", {"default:snowblock"}, 15, -1, 8000, 3, 31000)
lottmobs:register_spawn("lottmobs:half_troll", {"lottmapgen:mordor_stone"}, 15, -1, 8000, 3, 31000)

lottmobs:register_mob("lottmobs:nazgul", {
	type = "monster",
	hp_max = 50,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_nazgul.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 10,
	drops = {
		{name = "lottores:mithril_ingot",
		chance = 1,
		min = 1,
		max = 2,},
	},
	armor = 100,
	drawtype = "front",
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "lottmobs:darkball",
	shoot_interval = 4,
	sounds = {
		attack = "lottmobs:darkball",
	},
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
})
lottmobs:register_spawn("lottmobs:nazgul", {"default:stone"}, 2, -1, 10000, 3, -50)

lottmobs:register_mob("lottmobs:witch_king", {
	type = "monster",
	hp_max = 75,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_witch_king.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 10,
	drops = {
		{name = "lottores:mithril_ingot",
		chance = 1,
		min = 5,
		max = 9,},
	},
	armor = 50,
	drawtype = "front",
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "lottmobs:darkball",
	shoot_interval = 2,
	sounds = {
		attack = "lottmobs:darkball",
	},
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
})
lottmobs:register_spawn("lottmobs:witch_king", {"default:stone"}, 2, -1, 30000, 10, -1000)

lottmobs:register_mob("lottmobs:balrog", {
	type = "monster",
	hp_max = 100,
	collisionbox = {-0.6,-2.0,-0.6, 0.6,1.6,0.6},
	visual_size = {x=2, y=2},
	visual = "mesh",
	mesh = "balrog_model.b3d",
	textures = {"lottmobs_balrog.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 20,
	drops = {
		{name = "lottores:mithril_ingot",
		chance = 1,
		min = 50,
		max = 99,},
	},
	armor = 100,
	drawtype = "front",
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "lottmobs:fireslash",
	shoot_interval = 4,
	sounds = {
		attack = "lottmobs:fireslash",
	},
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
})
lottmobs:register_spawn("lottmobs:balrog", {"default:stone"}, 2, -1, 70000, 10, -10000)

lottmobs:register_mob("lottmobs:dead_men", {
	type = "monster",
	hp_max = 1,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {"lottmobs_dead_men.png"},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1,
	damage = 2,
	armor = 10000000000000000000000000000000,
	water_damage = 0,
	lava_damage = 0,
	light_damage = 1,
	drawtype = "front",
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:dead_men", {"default:stone"}, 2, -1, 9000, 10, -100)

lottmobs:register_mob("lottmobs:troll", {
	type = "monster",
	hp_max = 15,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "troll_model.x",
	textures = {"lottmobs_troll.png"},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 10,
	drops = {
		{name = "default:stone",
		chance = 1,
		min = 5,
		max = 7,},
	},
	armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	light_damage = 15,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
})
lottmobs:register_spawn("lottmobs:troll", {"default:stone"}, 2, -1, 9000, 5, -10)
lottmobs:register_spawn("lottmobs:troll", {"default:snow"}, 2, -1, 300, 5, -10)
lottmobs:register_spawn("lottmobs:troll", {"default:snowblock"}, 2, -1, 300, 5, -10)

lottmobs:register_mob("lottmobs:dwarf", {
	type = "animal",
	hp_max = 10,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	textures = {"lottmobs_dwarf.png"},
	visual = "mesh",
	mesh = "dwarf_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "default:diamond",
		chance = 30,
		min = 1,
		max = 2,},
	},
	    light_resistant = true,
    armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})
lottmobs:register_spawn("lottmobs:dwarf", {"default:stone"}, 15, -1, 1500, 3, -10)

-- Arrows

lottmobs:register_arrow("lottmobs:darkball", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"lottmobs_darkball.png"},
	velocity = 5,
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=4},
		}, vec)
		local pos = self.object:getpos()
		for dx=-1,1 do
			for dy=-1,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
						minetest.env:set_node(p, {name="fire:basic_flame"})
					else
						minetest.env:remove_node(p)
					end
				end
			end
		end
	end,
	hit_node = function(self, pos, node)
		for dx=-1,1 do
			for dy=-2,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
						minetest.env:set_node(p, {name="fire:basic_flame"})
					else
						minetest.env:remove_node(p)
					end
				end
			end
		end
	end
})

lottmobs:register_arrow("lottmobs:fireslash", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"lottmobs_fireslash.png"},
	velocity = 5,
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=8},
		}, vec)
		local pos = self.object:getpos()
		for dx=-1,1 do
			for dy=-1,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
						minetest.env:set_node(p, {name="fire:basic_flame"})
					else
						minetest.env:remove_node(p)
					end
				end
			end
		end
	end,
	hit_node = function(self, pos, node)
		for dx=-1,1 do
			for dy=-2,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 30 then
						minetest.env:set_node(p, {name="fire:basic_flame"})
					else
						minetest.env:remove_node(p)
					end
				end
			end
		end
	end
})
