-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file mob_template.lua
--! @brief template for mob
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- WARNING this code might be not correct lua in order to get doxygen
--         compatibility!
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


--! @brief Template for creating mobs
--!
--! This template trys to describe all available configuration options
--! in mob framework.
--! @ingroup framework_mob
local mob_template = {

	--! @brief [MANDATORY] name of mob @b (alphanumeric and "_" only!!)
	name = "some name",
	--! @brief [MANDATORY] name of mod defining the mob
	modname = "name of mod",

	--! @brief [MANDATORY] generic parameters for mob
	generic = {
		--! @brief [MANDATORY] description to show on mouse over in inventory
		description="Some mob",

		--! @brief [MANDATORY] maximum health
		base_health=0,

		--! @brief [MANDATORY] environment of mob to be
		envid="some environment id",

		--! @brief [OPTIONAL] item description OR function all returning a item description of whats the result of a kill
		kill_result = nil,

		--! @brief [OPTIONAL] armor groups of mob
		armor_groups = nil,

		--! @brief [OPTIONAL] custom on_hit(entity,player) callback return true to skip normal fight callback
		on_hit_callback = nil,

		--! @brief [OPTIONAL] custom on_kill(entity,player) callback return true to skip normal on kill handling
		on_kill_callback = nil,

		--! @brief [OPTIONAL] custom on_place(entity, placer, pointed_thing) callback called after normal on place handling is done
		custom_on_place_handler = nil,

		--! @brief [OPTIONAL] custom on_activate(entity) callback called after normal on_activate handling is done
		custom_on_activate_handler = nil,

		--! @brief [OPTIONAL] custom on_step(entity) callback called after normal on_step handling is done
		custom_on_step_handler = nil,

		},

	--! @brief [MANDATORY] configuration of movement generator
	movement =  {
		--! @brief [MANDATORY] is this a flying mob
		canfly=false,

		--! @brief [MANDATORY] minumum acceleration of mob
		min_accel=0,

		--! @brief [MANDATORY] maximum acceleration of mob
		max_accel=0,

		--! @brief [MANDATORY] maximum absolute speed of mob
		max_speed=0,

		--! @brief [OPTIONAL] minimum speed a mob shall move (if moving at all)
		min_speed=0,

		--! @brief [MOV_GEN_DEPENDENT | MANDATORY] pattern based movement gen -> pattern to use for movement
		pattern="some pattern id",

		--! @brief [MOV_GEN_DEPENDENT | OPTIONAL] follow movement gen -> does this mob guard it's spawnpoint
		guardspawnpoint = false,

		--! @brief [MOV_GEN_DEPENDENT | OPTIONAL] follow movement gen -> time until this mob teleports to its target
		teleportdelay = 60,

		},

	--! @brief [OPTIONAL] if mob is harvestable configure it here
	harvest = {
		--! @brief [OPTIONAL] tool required for harvesting
		tool=nil,

		--! @brief [OPTIONAL] is tool consuled by harvesting
		tool_consumed=false,

		--! @brief [MANDATORY] result of harvest
		result="",

		--! @brief [OPTIONAL] mob transforms to this mob on harvest
		transforms_to="",

		--! @brief [MANDATORY] minimum time between two harvests (in case of transform set this to -1)
		min_delay=-1,
		},

	--! @brief [OPTIONAL] configuration how to catch the mob
	catching = {
		--! @brief [MANDATORY] tool required to wear to catch the mob
		tool = "some item",
		--! @brief [MANDATORY] is tool consumed by catching
		consumed = true,
		},

	--! @brief [OPTIONAL] does this mob do random drops
	random_drop    = {

		--! @brief [MANDATORY] item to be dropped
		result="some_material",

		--! @brief [MANDATORY] minimum delay between two drops
		min_delay=60,

		--! @brief [MANDATORY] chance per second to drop after min_delay has passed
		chance=0.2
		},

	--! @brief [OPTIONAL] if this mob s intended to transform by its own configure it here
	auto_transform = {

		--! @brief [MANDATORY] mob to transform to
		result="some_mob",

		--! @brief [MANDATORY] time to transformation
		delay=1800
		},

	--! @brief [OPTIONAL] combat settings for mob
	combat = {
		--! @brief [MANDATORY] does mob start an attack on its own?
		starts_attack=true,

		--! @brief [MANDATORY] chance mob will attack (if starting attack on its own or beeing attacked)
		angryness=0.95,

		--! @brief [OPTIONAL] is mob sensitive to sun?
		sun_sensitive=true,

		--! @brief [OPTIONAL] attacks hostile mobs
		attack_hostile_mobs=false,

		--! @brief [UNUSED] attacks hostile mobs
		--attack_friendly_mobs=false,

		--! @brief [OPTIONAL] configuration of meele attack
		melee = {
			--! @brief [MANDATORY] maximum damage mob does per hit
			maxdamage=4,
			--! @brief [MANDATORY] range mob will hit
			range=2,
			--! @brief [MANDATORY] minimum time between two hits
			speed=2,
			},
		--! @brief [OPTIONAL] configuration of distance attack
		distance = {
			--! @brief [MANDATORY] distance projectile to issue
			attack="some_entity",
			--! @brief [MANDATORY] distance to issue an attack
			range=10,
			--! @brief [OPTIONAL] minimum range of distance attack (should be > range of melee attack)
			min_range = 3,
			--! @brief [MANDATORY] minimum time between two attacks
			speed=2,
			},

		--! @brief [OPTIONAL] configuration for self destructing mob
		self_destruct = {
			--! [MANDATORY] maximum damage to be done on self destruct
			damage=15,
			--! [MANDATORY] maximum range to do damage
			range=5,
			--! [MANDATORY] range to destroy nodes on self destruction
			node_damage_range = 1.5,
			--! [MANDATORY] delay between self destruct triggering and explosion
			delay=5,
			},
		},
	--! @brief [MANDATORY] spawning configuration for mob
	spawning = {
		--! @brief [MANDATORY] rate this mob is spawned
		rate=0.01,
		--! @brief [MANDATORY] typical distance between two mobs of this type when spawend
		density=1000,
		--! @brief [MANDATORY] identifyer of spawn algorithm
		algorithm="some algorithm id",

		--! @brief [ALGORITHM DEPENDENT] shadows minimum number of air blocks above pos
		height = 1,
		},

	--! @brief [OPTIONAL] sounds to be played by mob
	sound = {
		--! @brief [OPTIONAL] random sound to be played
		random = {
			--! @brief [MANDATORY] basename of file
			name="random_1",
			--! @brief [MANDATORY] minimum time between playing sounds
			min_delta = 10,
			--! @brief [MANDATORY] chance per second to play sound after minimum time
			chance = 0.5,
			--! @brief [MANDATORY] amplify the sound by this value
			gain = 1,
			--! @brief [MANDATORY] maximum distance sound is heared
			max_hear_distance = 75,
			},
		--! @brief [OPTIONAL] sound played on self destruction
		self_destruct = {
			--! @brief [MANDATORY] basename of file
			name="bomb_explosion",
			--! @brief [MANDATORY] amplify the sound by this value
			gain = 2,
			--! @brief [MANDATORY] maximum distance sound is heared
			max_hear_distance = 1000,
			},
		--! @brief [OPTIONAL] sound played on harvest
		harvest = {
			--! @brief [MANDATORY] basename of file
			name="harvest",
			--! @brief [MANDATORY] amplify the sound by this value
			gain = 0.8,
			--! @brief [MANDATORY] maximum distance sound is heared
			max_hear_distance = 5,
			},
		--! @brief [OPTIONAL] sound played on distance attack
		distance = {
			--! @brief [MANDATORY] basename of file
			name="fireball",
			--! @brief [MANDATORY] amplify the sound by this value
			gain = 1,
			--! @brief [MANDATORY] maximum distance sound is heared
			max_hear_distance = 100,
			},
		--! @brief [OPTIONAL] sound played if mob dies
		die = {
			--! @brief [MANDATORY] basename of file
			name="die",
			--! @brief [MANDATORY] amplify the sound by this value
			gain = 1,
			--! @brief [MANDATORY] maximum distance sound is heared
			max_hear_distance = 100,
			},
		--! @brief [OPTIONAL] sound played if mob does meele attack
		melee = {
			--! @brief [MANDATORY] basename of file
			name="hit",
			--! @brief [MANDATORY] amplify the sound by this value
			gain = 1,
			--! @brief [MANDATORY] maximum distance sound is heared
			max_hear_distance = 100,
			},
		},

	--! @brief [OPTIONAL] parameters for rideable mobs
	ride = {
		--! @brief [OPTIONAL] speed when walking
		walkspeed  = 7.8,
		--! @brief [OPTIONAL] speed when sneaking
		sneakspeed = 0.8,
		--! @brief [OPTIONAL] inital jumpspeed
		jumpspeed  = 58,
		--! @brief [OPTIONAL] offset to center player is put to
		attacheoffset = { x=0,y=2,z=0},
		--! @brief [OPTIONAL] texture modifier when player is attached
		texturemod = "^mob_ostrich_ostrich_saddle_mesh.png",
		--! @brief [OPTIONAL] animation to show when riding
		walk_anim = "walk",
	},

	--! @brief [OPTIONAL] description of animations
	animation = {
		--! @brief [OPTIONAL] one or many animation descriptions
		animationname = {
			--! @brief [MANDATORY] start frame of animation
			start_frame = 1,
			--! @brief [MANDATORY] end frame of animation
			end_frame   = 2,
			},
		},

	--! @brief [OPTIONAL] configuration for a trader mob
	trader_inventory = {
				--! @brief [MANDATORY] goodlist to be sold
				goods = {
							--! @brief [MANDOTORY] first element in list
							{ "default:mese 1", "default:dirt 99", "default:cobble 50"},
							--! @brief [OPTIONAL] any further element
							{ "default:steel_ingot 1", "default:dirt 50", "default:cobble 20"},
						},
				--! @brief [MANDATORY] list of names randomly choosen for trader
				random_names = { "Name1","Name2","Name3"},
			},

	--! @brief [OPTIONAL] configuration for attention handling
	attention = {
				--! @brief [OPTIONAL] hear distance value
				hear_distance = 3,
				--! @brief [UPPER_VALUE_DEPENDENT | MANDATORY] value to add if within hear distance
				hear_distance_value = 0.5,

				--! @brief [OPTIONAL] view angle to consider
				view_angle = nil,
				--! @brief [UPPER_VALUE_DEPENDENT | MANDATORY] value to add if someone is within view angke
				own_view_value = 0,

				--! @brief [OPTIONAL] is remove view angle relevant?
				remote_view = false,
				--! @brief [UPPER_VALUE_DEPENDENT | MANDATORY] value to add if remote target looks at mob
				remote_view_value = 0,

				--! @brief [OPTIONAL] value to add if within attention distance
				attention_distance_value = 0.2,

				--! @brief [OPTIONAL] threshold to issue watch callback
				watch_threshold = 2,

				--! @brief [OPTIONAL] threshold to issue attack callback
				attack_threshold = nil,

				--! @brief [MANDATORY] maximum distance to consider objects for attantion
				attention_distance = 7.5,

				--! @brief [MANDATORY] maximum amount of attention any object can draw
				attention_max = 10,

				--! @brief [OPTIONAL] watch_callback(entity,target) a callback to be called once attention threshold is reached
				watch_callback = nil
		},

	--! @brief [OPTIONAL] factions configuration
	factions = {
			--! @brief [OPTIONAL] define factions to be member in
			member = {
				"faction_1",
				"faction_2",
				"faction_3",
				"faction_4"
				},
			},
	--! @brief [OPTIONAL] used to specify different movement/model states,
	--! you may specify as many states as you like
	states = {
			{
				--! @brief [MANDATORY] (default state is MUST have!) name of state
				name = "default",
				--! @brief [MANDATORY] typical duration of this state
				typical_state_time = 180,
				--! @brief [MANDATORY] chance of state to be selected (SUM may not be > 1)
				chance = 0.5,
				--! @brief [MANDATORY] a special movement handler for this state
				movgen = "none",
				--! @brief [3D MANDATORY] a special model to be used for this state
				graphics_3d = {
					--! @brief [MANDATORY] this is the drawtype to use
					visual = "mesh",
					--! @brief [MANDATORY] this is the drawtype to use
					mesh = "mesh.x",
					--! @brief [MANDATORY] the model of the mob
					textures = {"some node declatation"},
					--! @brief [MANDATORY] collisionbox to use
					collisionbox = { "<selectionbox declatation>" },
					--! @brief [MANDATORY] xyz scale factors for the model
					visual_size = {x=1,y=1,z=1},
					},
				--! @brief [2D MANDATORY] a special sprite to be used for this state
				graphics_2d = {
					--! @brief [MANDATORY] scale of sprite
					sprite_scale={x=0,y=0},
					--! @brief [MANDATORY] description of multi dimensional sprites (e.g. containing burning/ differend view directions)
					sprite_div = {x=0,y=0},
					--! @brief [MANDATORY] height of sprite
					visible_height = 3.2,

					},
				--! @brief [MANDATORY] a animation to be played while this state is active
				animation = "walk",
			},
			{
				--! @brief [MANDATORY] name of state
				name = "another_state_example",
				--! @brief [MANDATORY] typical duration of this state
				typical_state_time = 180,
				--! @brief [MANDATORY] chance of state to be selected (SUM may not be > 1)
				chance = 0.5,
				--! @brief [OPTIONAL] a function to check before switching to this state
				custom_preconhandler = nil,
				--! @brief [OPTIONAL] a special movement handler for this state
				movgen = "none",
				--! @brief [OPTIONAL] a special model to be used for this state
				graphics_3d = "<graphic definition as previous described>",
				--! @brief [OPTIONAL] a special sprite to be used for this state
				graphics_2d = "<graphic definition as previous described>",
				--! @brief [OPTIONAL] a animation to be played while this state is active
				animation = "name",
				--! @brief [OPTIONAL] mode to differentiate different states e.g. "auto" for auto switched states "user_def" for user defined or "combat" for combat states
				state_mode = "auto",
			},
		},
	}