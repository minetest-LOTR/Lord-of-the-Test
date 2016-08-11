function lottmobs.register_hobbit(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops)
        mobs:register_mob("lottmobs:hobbit"..n, {
                                  type = "npc",
                                  race = "hobbits",
                                  hp_min = hpmin,
                                  hp_max = hpmax,
                                  collisionbox = {-0.3,-0.75,-0.3, 0.3,0.7,0.3},
                                  textures = textures,
                                  visual = "mesh",
                                  mesh = "lottarmor_character.b3d",
                                  visual_size = {x=1, y=0.75},
                                  makes_footstep_sound = true,
                                  walk_velocity = wv,
                                  run_velocity = rv,
                                  armor = arm,
                                  damage = damg,
                                  drops = drops,
                                  light_resistant = true,
                                  drawtype = "front",
                                  water_damage = 1,
                                  lava_damage = 5,
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
                                          lottmobs.guard(self, clicker, "default:gold_ingot", "Hobbit", "hobbit", "lottmobs:hobbit")
                                  end,
                                  do_custom = lottmobs.do_custom_guard,
                                  peaceful=true,
                                  group_attack=true,
                                  step=1,
                                  sounds = {
                                  },
        })
        mobs:register_spawn("lottmobs:hobbit"..n, {"lottmapgen:shire_grass"}, 20, -1, 6000, 3, 31000)        
end

--Normal Hobbits
local textures1 = {
    {"lottmobs_hobbit_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_hobbit_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_hobbit_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
}

lottmobs.register_hobbit("", 20, 30, textures1, 2, 4, 5, 175, drops)

--Hobbits with steel armor & swords.
local textures3 = {
    {"lottmobs_hobbit_1.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
    {"lottmobs_hobbit_2.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
    {"lottmobs_hobbit_3.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
}

lottmobs.register_hobbit("1", 25, 25, textures3, 2.5, 3.5, 7, 100, drops)

lottmobs.register_guard_craftitem("lottmobs:hobbit", "Hobbit Guard", "lottmobs_hobbit_guard_inv.png", {"lottmobs:hobbit", "lottmobs:hobbit1"})
