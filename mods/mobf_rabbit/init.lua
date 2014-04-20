-------------------------------------------------------------------------------
-- Rabbit for Minetest
-- Model and texture by AspireMint
-- Code from Sokomine
-- based on Mob Framework Mod by Sapier
-------------------------------------------------------------------------------
minetest.log("action","MOD: mobf_rabbit loading ...")

local version = "0.0.1"

local selectionbox_rabbit = {-0.2, -0.0625, -0.2, 0.2, 0.3, 0.2}

local rabbit_groups = {
						not_in_creative_inventory=1
					}
mobf_rabbit = {}


-- there are 3 colors of rabbits with more ore less similar behaviour
mobf_rabbit.get_rabbit_prototype = function( mob_name, descr, texture )

   return {
		name    = mob_name,
		modname = "mobf_rabbit",

		factions = {
			member = {
				"animals",
				}
		},

	
		generic = {
					description=descr,
					base_health=2,
					kill_result="lottspecial:egg4",
					armor_groups= {
						fleshy=90,
					},
					groups = rabbit_groups,
					envid="on_ground_1",
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.6,
					max_accel=2.2,
					max_speed=5.0,
					pattern="run_and_jump_low",
					canfly=false,
					},
		spawning = {
					primary_algorithms = {
						{
						rate=0.02,
						density=250,
						algorithm="forrest_mapgen",
						height=1
						},
						{
						rate=0.01,
						density=250,
						algorithm="shadows_spawner",
						height=1,
						respawndelay = 120,
						},
					},
					secondary_algorithms = {
						{
						rate=0.002,
						density=250,
						algorithm="forrest",
						height=2
						},
						{
						rate=0.002,
						density=250,
						algorithm="shadows",
						height=2
						},
					}
				},
		animation = {
				walk = { -- running
					start_frame = 40,
					end_frame   = 60,
					basevelocity = 0.1,
					},
				stand = {   -- hidden
					start_frame = 0,
					end_frame   = 30,
					},
				guard = { -- on duty
					start_frame = 70,
					end_frame   = 130,
				}
			},
		states = {
				{ 
				name = "default",
				movgen = "none",
				chance = 0,
				animation = "stand",
				graphics_3d = {
					visual = "mesh",
					mesh = "mobf_rabbit.x",
					textures = {texture},
					collisionbox = selectionbox_rabbit,
					visual_size= {x=0.5,y=0.5,z=0.1},
					},
				graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},	
				typical_state_time = 10,
				},
				{ 
					name = "walking",
					movgen = "probab_mov_gen",
					chance = 0.34,
					animation = "walk",
					typical_state_time = 120,
				},
				{
					name = "hiding",
					movgen = "none",
					chance = 0.33,
					animation = "stand",
                                        typical_state_time = 10,
				},
				{
					name = "guarding",
					movgen = "none",
					chance = 0.33,
					animation = "guard",
                                        typical_state_time = 60,
				}

			},
		}
end


mobf_rabbit.rabbit_snow  = mobf_rabbit.get_rabbit_prototype( "snow_rabbit",  "Easter Bunny Egg", "mobf_rabbit_white.png" );
minetest.log("action","\tadding "..mobf_rabbit.rabbit_snow.name)
mobf_add_mob(mobf_rabbit.rabbit_snow)

mobf_rabbit.rabbit_grey  = mobf_rabbit.get_rabbit_prototype( "grey_rabbit",  "Grey Bunny Egg", "mobf_rabbit_grey.png" );
minetest.log("action","\tadding "..mobf_rabbit.rabbit_grey.name)
mobf_add_mob(mobf_rabbit.rabbit_grey)

mobf_rabbit.rabbit_brown = mobf_rabbit.get_rabbit_prototype( "brown_rabbit", "Brown Bunny Egg",      "mobf_rabbit_brown.png" );
minetest.log("action","\tadding "..mobf_rabbit.rabbit_brown.name)
mobf_add_mob(mobf_rabbit.rabbit_brown)


minetest.log("action","MOD: mobf_rabbit mod             version " .. version .. " loaded")