function lottmobs.register_dwarf(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops)
    mobs:register_mob("lottmobs:dwarf" .. n, {
    	type = "npc",
    	hp_min = hpmin,
    	hp_max = hpmax,
    	collisionbox = {-0.3,-.85,-0.3, 0.3,0.68,0.3},
    	textures = textures,
    	visual = "mesh",
    	visual_size = {x=1.1, y=0.85},
    	mesh = "lottarmor_character.b3d",
    	view_range = 12,
    	makes_footstep_sound = true,
    	walk_velocity = wv,
    	run_velocity = rv,
    	armor = arm,
    	damage = damg,
    	drops = drops,
    	light_resistant = true,
    	drawtype = "front",
    	water_damage = 0,
    	lava_damage = 10,
    	light_damage = 0,
    	attack_type = "dogfight",
    	follow = "lottother:narya",
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
    	},
    	jump = true,
    	sounds = {
    		war_cry = "mobs_die_yell",
    		death = "default_death",
    		attack = "default_punch2",
    	},
    	attacks_monsters = true,
    	on_rightclick = function(self, clicker)
    		lottmobs.guard(self, clicker, "default:goldblock")
    	end,
    	peaceful = true,
    	group_attack = true,
    	step = 1,
    })
    mobs:register_spawn("lottmobs:dwarf" .. n, {"default:stone"}, 15, -1, 6000, 3, -10)
    mobs:register_spawn("lottmobs:dwarf" .. n, {"lottmapgen:ironhill_grass"}, 20, -1, 6000, 3, 31000)
end

--Normal Dwarfs
local textures1 = {
    {"lottmobs_dwarf_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
}

local drops1 = {
    {name = "default:diamond",
    chance = 30,
    min = 1,
    max = 2,},
    {name = "default:iron_lump",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "default:copper_lump",
    chance = 4,
    min = 1,
    max = 4,},
    {name = "default:iron_ingot",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "lottores:tin_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:copper_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:bronze_ingot",
    chance = 5,
    min = 1,
    max = 6,},
    {name = "lottores:mithril_lump",
    chance = 50,
    min = 1,
    max = 3,},
}

lottmobs.register_dwarf("", 20, 30, textures1, 2, 4, 5, 175, drops1)

--Dwarfs with mithril armor & warhammers.
local textures2 = {
    {"lottmobs_dwarf_1.png", "lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_2.png", "lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_3.png", "lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
}

local drops2 = {
    {name = "default:diamond",
    chance = 30,
    min = 1,
    max = 2,},
    {name = "default:iron_lump",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "default:copper_lump",
    chance = 4,
    min = 1,
    max = 4,},
    {name = "default:iron_ingot",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "lottores:tin_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:copper_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:bronze_ingot",
    chance = 5,
    min = 1,
    max = 6,},
    {name = "lottores:mithril_lump",
    chance = 50,
    min = 1,
    max = 3,},
}

lottmobs.register_dwarf("1", 30, 40, textures2, 2.75, 3.5, 13, 75, drops2)

--Dwarfs with steel armor & swords.
local textures3 = {
    {"lottmobs_dwarf_1.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_2.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_3.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
}

local drops3 = {
    {name = "default:diamond",
    chance = 30,
    min = 1,
    max = 2,},
    {name = "default:iron_lump",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "default:copper_lump",
    chance = 4,
    min = 1,
    max = 4,},
    {name = "default:iron_ingot",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "lottores:tin_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:copper_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:bronze_ingot",
    chance = 5,
    min = 1,
    max = 6,},
    {name = "lottores:mithril_lump",
    chance = 50,
    min = 1,
    max = 3,},
}

lottmobs.register_dwarf("2", 25, 25, textures3, 2.5, 3.5, 7, 100, drops3)
