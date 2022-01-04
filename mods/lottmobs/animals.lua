mobs:register_mob("lottmobs:chicken", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.3,0,-0.3, 0.3,0.8,0.3},
	textures = {
		{"lottmobs_chicken.png"},
	},
	sounds = {
		random = "mobs_chicken",
	},
	visual = "mesh",
	mesh = "chicken_model.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 300,
		drops = {
		{name = "lottmobs:meat_raw",
		chance = 1,
		min = 1,
		max = 3,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		speed_normal = 10,
		speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		sit_start = 1,
		sit_end = 9,
		walk_start = 10,
		walk_end = 50,
	},
	jump = true,
	step=1,
	passive = true,
	sounds = {
	},
})
mobs:register_spawn("lottmobs:chicken",
	{"lottmapgen:gondor_grass", "lottmapgen:dunland_grass", "lottmapgen:rohan_grass",
	"lottmapgen:shire_grass", "lottmapgen:ithilien_grass", "lottmapgen:ironhill_grass"},
	20, -1, 10000, 3, 31000)

mobs:register_mob("lottmobs:sheep", {
	type = "animal",
	passive = true,
	hp_min = 8,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
	visual = "mesh",
	mesh = "mobs_sheep.b3d",
	textures = {
		{"mobs_sheep_base.png^mobs_sheep_wool.png"}, --White
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#663300a0)"}, --Black
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#000000b0)"}, --Brown
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#5b5b5bb0)"}, --Grey
	},
	gotten_texture = {"mobs_sheep_shaved.png"},
	gotten_mesh = "mobs_sheep_shaved.b3d",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{name = "lottmobs:meat_raw", chance = 1, min = 1, max = 2},
		{name = "wool:white", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
	},
	follow = {"farming:wheat", "default:grass_5"},
	view_range = 8,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	replace_offset = -1,
	fear_height = 3,

	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then
			if self.gotten == false then
				self.object:set_properties({
					textures = {"mobs_sheep_base.png^mobs_sheep_wool.png"},
					mesh = "mobs_sheep.b3d",
				})
			end
			return
		end

		local item = clicker:get_wielded_item()
		local itemname = item:get_name()

		if itemname == "mobs:shears" then
			if self.gotten ~= false
			or self.child ~= false
			or not minetest.get_modpath("wool") then
				return
			end
			self.gotten = true -- shaved
			local obj = minetest.add_item(
				self.object:get_pos(),
				ItemStack( "wool:" .. col[1] .. " " .. math.random(1, 3) )
			)
			if obj then
				obj:setvelocity({
					x = math.random(-1, 1),
					y = 5,
					z = math.random(-1, 1)
				})
			end
			item:add_wear(650) -- 100 uses
			clicker:set_wielded_item(item)
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.b3d",
			})
			return
		end
	end
})

mobs:register_spawn("lottmobs:sheep",
    {"lottmapgen:shire_grass", "lottmapgen:gondor_grass", "lottmapgen:dunland_grass",
	"lottmapgen:ithilien_grass"},
    20, 10, 10000, 1, 31000)

mobs:register_mob("lottmobs:bunny", {
	type = "animal",
	passive = true,
	reach = 1,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.268, -0.5, -0.268,  0.268, 0.167, 0.268},
	visual = "mesh",
	mesh = "mobs_bunny.b3d",
	drawtype = "front",
	textures = {
		{"mobs_bunny_grey.png"},
		{"mobs_bunny_brown.png"},
		{"mobs_bunny_white.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{name = "lottmobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		stand_start = 1,
		stand_end = 15,
		walk_start = 16,
		walk_end = 24,
		punch_start = 16,
		punch_end = 24,
	},
	follow = {"farming:carrot", "farming_plus:carrot_item"},
	view_range = 8,
	replace_rate = 10,
	replace_what = {"farming:carrot_7", "farming:carrot_8", "farming_plus:carrot"},
	replace_with = "air",
})

mobs:register_spawn("lottmobs:bunny",
    {"lottmapgen:shire_grass", "lottmapgen:gondor_grass", "lottmapgen:dunland_grass",
	"lottmapgen:ironhill_grass", "lottmapgen:fangorn_grass", "lottmapgen:rohan_grass",
	"lottmapgen:ithilien_grass", "lottmapgen:lorien_grass", "default:dirt_with_snow"},
    20, 10, 10000, 1, 31000)

mobs:register_mob("lottmobs:rat", {
	type = "animal",
	passive = true,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.2, -1, -0.2, 0.2, -0.8, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.b3d",
	textures = {
		{"mobs_rat.png"},
		{"mobs_rat2.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_rat",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
})
mobs:register_spawn("lottmobs:rat", {"default:stone"}, 20, 5, 15000, 2, 0)

mobs:register_mob("lottmobs:pumba", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	reach = 2,
	damage = 2,
	hp_min = 5,
	hp_max = 15,
	armor = 200,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_pumba.x",
	textures = {
		{"mobs_pumba.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_pig",
		attack = "mobs_pig_angry",
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	follow = {"default:apple", "farming:potato"},
	view_range = 10,
	drops = {
		{name = "lottmobs:pork_raw", chance = 1, min = 1, max = 3},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 55,
		walk_start = 70,
		walk_end = 100,
		punch_start = 70,
		punch_end = 100,
	},
})
mobs:register_spawn("lottmobs:pumba", {"lottmapgen:ironhill_grass"}, 20, 10, 10000, 2, 31000)

minetest.register_craftitem("lottmobs:pork_raw", {
	description = "Raw Porkchop",
	inventory_image = "mobs_pork_raw.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("lottmobs:pork_cooked", {
	description = "Cooked Porkchop",
	inventory_image = "mobs_pork_cooked.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:pork_cooked",
	recipe = "lottmobs:pork_raw",
	cooktime = 5,
})
