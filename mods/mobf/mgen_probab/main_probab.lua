-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file main_probab.lua
--! @brief component containing a probabilistic movement generator
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--
--! @defgroup mgen_probab MGEN: probabilistic movement generator
--! @brief A movement generator trying to create a random movement
--! @ingroup framework_int
--! @{
--
--! @defgroup mpatterns Movement patterns
--! @brief movement patterns used for probabilistic movement gen
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


--factor used to adjust chances defined as x/per second to on_step frequency
PER_SECOND_CORRECTION_FACTOR = 0.25

--! @class movement_gen
--! @brief a probabilistic movement generator
movement_gen = {}

--! @brief movement patterns known to probabilistic movement gen
mov_patterns_defined = {}

--!@}

dofile (mobf_modpath .. "/mgen_probab/movement_patterns/dont_move.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/run_and_jump_low.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/stop_and_go.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/swim_pattern1.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/swim_pattern2.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/flight_pattern1.lua")

dofile (mobf_modpath .. "/mgen_probab/height_level_control.lua")
dofile (mobf_modpath .. "/mgen_probab/direction_control.lua")

--! @brief movement generator identifier
--! @memberof movement_gen
movement_gen.name = "probab_mov_gen"

-------------------------------------------------------------------------------
-- name: register_pattern(pattern)
--
--! @brief initialize movement generator
--! @memberof movement_gen
--
--! @param pattern pattern to register
--! @return true/false
-------------------------------------------------------------------------------
function movement_gen.register_pattern(pattern)
		print ("\tregistering pattern "..pattern.name)
		if mobf_rtd.movement_patterns[pattern.name] == nil then
			mobf_rtd.movement_patterns[pattern.name] = pattern
			return true
		else
			return false
		end
end


-------------------------------------------------------------------------------
-- name: initialize(entity)
--
--! @brief initialize movement generator
--! @memberof movement_gen
--
-------------------------------------------------------------------------------
function movement_gen.initialize()
		for index,value in ipairs(mov_patterns_defined) do
		movement_gen.register_pattern(value)
	end
end

-------------------------------------------------------------------------------
-- name: callback(entity)
--
--! @brief main movement generation function
--! @memberof movement_gen
--! @private
--
--! @param entity mob to generate movement for
-------------------------------------------------------------------------------
function movement_gen.callback(entity)
	mobf_assert_backtrace(entity ~= nil)

	if entity.dynamic_data == nil or
		entity.dynamic_data.movement == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!!: >" ..entity.data.name ..
			"< removed=" .. dump(entity.removed) .. " entity=" ..
			tostring(entity) .. " probab movement callback")
		return
	end

	--initialize status datastructure
	local movement_state = {
		basepos         = entity.getbasepos(entity),
		default_y_accel = nil,
		centerpos       = entity.object:getpos(),
		current_acceleration    = nil,
		current_velocity        = entity.object:getvelocity(),
		now             = nil,

		override_height_change_chance = 0,
		accel_to_set    = nil,
		force_change    = false,
		changed         = false,
	}


	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  CHECK MOB POSITION                                   --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl3("MOBF: position check for mob ".. entity.data.name ..
		" "..printpos(movement_state.basepos))
	movement_state.default_y_accel =
			environment.get_default_gravity(movement_state.basepos,
								entity.environment.media,
								entity.data.movement.canfly)
	mobf_assert_backtrace(movement_state.default_y_accel ~= nil)
	movement_state.now			   = mobf_get_current_time()


	--check current position
	--movement state is modified by this function
	local retval = movement_gen.fix_current_pos(entity, movement_state)

	--mob has been removed due to unfixable problems
	if retval.abort_processing then
		return
	end

	--read additional information required for further processing
	movement_state.current_acceleration = entity.object:getacceleration()

	if movement_state.changed then
		minetest.log(LOGLEVEL_WARNING,
			"MOBF:position got fixed ".. entity.data.name)
	end

	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  CHECK MOB MOVEMENT ITSELF                            --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl3("MOBF: movement hard limits check for mob "..
		entity.data.name .. " "..printpos(movement_state.basepos))

	movement_gen.fix_runaway(entity,movement_state)

	--don't do slowness check each callback
	if entity.dynamic_data.movement.ts_last_slowcheck == nil or
		entity.dynamic_data.movement.ts_last_slowcheck +2 < movement_state.now then
		movement_gen.fix_to_slow(entity,movement_state)
		entity.dynamic_data.movement.ts_last_slowcheck = movement_state.now
	end

	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--    DO / PREPARE CHANGES THAT NEED TO BE DONE BECAUSE OF MOB IS        --
	--          PREDICTED TO BE SOMEWHERE WHERE IT SHOULDN'T BE              --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl3("MOBF: movement check for mob ".. entity.data.name
		.. " "..printpos(movement_state.basepos))

	--skip if movement already got changed
	if movement_state.changed == false then
		--predict next block mob will be
		local pos_predicted =
			movement_generic.predict_next_block( movement_state.basepos,
											movement_state.current_velocity,
											movement_state.current_acceleration)

		--if this isn't a flying mob ignore y prediction as it's not honoring
		--collisions
		if not entity.data.movement.canfly then
			pos_predicted.y = movement_state.basepos.y
		end
		--local pos_predicted =
		--	movement_generic.predict_enter_next_block(entity, movement_state.basepos,
		--									movement_state.current_velocity,
		--									movement_state.current_acceleration)

		local pos_predicted_quality = environment.pos_quality(pos_predicted,entity)

		dbg_mobf.pmovement_lvl3("MOBF: Pos pred quality: ".. entity.data.name
			.. ": " .. pos_predicted_quality:shortstring())

		-- Y-Movement
		if movement_state.changed == false then
			height_level_control.precheck_movement(entity,movement_state,
											pos_predicted,pos_predicted_quality)
		end

		-- X/Z-Movement
		if movement_state.changed == false then
			direction_control.precheck_movement(entity,movement_state,
											pos_predicted,pos_predicted_quality)
		end

	end



	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  DO RANDOM CHANGES TO MOB MOVEMENT                    --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl3("MOBF: randomized movement for mob "..
					entity.data.name .. " "..printpos(movement_state.basepos))

	--do randomized changes if not fighting
	height_level_control.random_movement_handler(entity,movement_state)
	direction_control.random_movement_handler(entity,movement_state)



	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  APPLY CHANGES CALCULATED BEFORE                      --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	movement_gen.apply_movement_changes(entity,movement_state)
end


-------------------------------------------------------------------------------
-- name: apply_movement_changes(entity,movement_state)
--
--! @brief check and apply the changes from movement_state
--! @memberof movement_gen
--! @private
--
--! @param entity mob to apply changes
--! @param movement_state changes to apply
-------------------------------------------------------------------------------
function movement_gen.apply_movement_changes(entity,movement_state)
	if movement_state.changed then

		--check if there is a acceleration to set
		if movement_state.accel_to_set == nil then
			movement_state.accel_to_set = {x=0,
							y=movement_state.default_y_accel,
							z=0}
			entity.object:setvelocity({x=0,y=0,z=0})
			minetest.log(LOGLEVEL_ERROR,
						"MOBF BUG!!!! set accel requested but no accel given!")
		end

		--check if gravity is set
		if movement_state.accel_to_set.y == nil then

			--print("fixing y movement: ".. printpos(movement_state.accel_to_set))
			movement_state.accel_to_set.y = movement_state.current_acceleration.y
		end

		-- make sure non flying mobs have default acceleration
		if entity.data.movement.canfly == false then
			movement_state.accel_to_set.y = movement_state.default_y_accel

			if movement_state.default_y_accel == 0 then
				minetest.log(LOGLEVEL_ERROR,"MOBF BUG!!! " .. entity.data.name
								.. " mob that can't fly has acceleration 0!")
			end
		end

		dbg_mobf.pmovement_lvl2("MOBF: setting acceleration to "
										..printpos(movement_state.accel_to_set))
		entity.dynamic_data.movement.acceleration = movement_state.accel_to_set
		entity.object:setacceleration(movement_state.accel_to_set)
	end
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof movement_gen
--
--! @param entity mob to initialize
--! @param now current time
-------------------------------------------------------------------------------
function movement_gen.init_dynamic_data(entity,now)

	local accel_to_set = {x=0,y=9.81,z=0}
	local pos = entity.object:getpos()

		--initialize acceleration values
	accel_to_set.y = environment.get_default_gravity(pos,
					entity.environment.media,
					entity.data.movement.canfly)

	mobf_assert_backtrace(accel_to_set.y ~= nil)

	local data = {
			started				= false,
			acceleration		= accel_to_set,
			changing_levels     = false,
			ts_random_jump		= now,
			ts_orientation_upd  = now,
			mpattern            = mobf_rtd.movement_patterns[entity.data.movement.pattern],
			orientation_fix_needed              = true,
			ts_last_slowcheck   = now,
			}

	entity.dynamic_data.movement = data
end

-------------------------------------------------------------------------------
-- name: fix_runaway(entity,movement_state)
--
--! @brief fix runaway speed mobs
--! @memberof movement_gen
--! @private
--
--! @param entity mob to check speed limits
--! @param movement_state current state of movement
-------------------------------------------------------------------------------
function movement_gen.fix_runaway(entity,movement_state)


	--avoid mobs racing away
	local xzspeed = mobf_calc_scalar_speed(movement_state.current_velocity.x,
											movement_state.current_velocity.z)

	dbg_mobf.pmovement_lvl3("MOBF: checkrunaway x=" ..
							movement_state.current_velocity.x ..
							" z=" ..movement_state.current_velocity.z ..
							" xz=" .. xzspeed ..
							" maximum=" .. entity.data.movement.max_speed)

	if xzspeed > entity.data.movement.max_speed then
		dbg_mobf.pmovement_lvl3("MOBF: too fast! vxz=" .. xzspeed)
		dbg_mobf.pmovement_lvl3("MOBF: current acceleration:" ..
								printpos(movement_state.current_acceleration))

		local direction = mobf_calc_yaw(movement_state.current_velocity.x,
										movement_state.current_velocity.z)

		--reduce speed to 90% of current speed
		local new_speed = mobf_calc_vector_components(direction,xzspeed*0.9)
		new_speed.y = movement_state.current_velocity.y
		entity.object:setvelocity(new_speed)

		movement_state.current_velocity = new_speed

		--don't accelerate any longer
		movement_state.accel_to_set = {x=0,z=0}
		movement_state.changed = true

		dbg_mobf.pmovement_lvl2("MOBF: fix runaway new acceleration:" ..
									printpos(movement_state.accel_to_set))
	end
end

-------------------------------------------------------------------------------
-- name: fix_to_slow(entity,movement_state)
--
--! @brief check if mobs motion is below its minimal speed (e.g. flying birds)
--! @memberof movement_gen
--! @private
--
--! @param entity mob to check speed limits
--! @param movement_state current state of movement
-------------------------------------------------------------------------------
function movement_gen.fix_to_slow(entity,movement_state)
	local xzspeed = mobf_calc_scalar_speed(movement_state.current_velocity.x,
											movement_state.current_velocity.z)

	dbg_mobf.pmovement_lvl3("MOBF: checktoslow x=" ..
							movement_state.current_velocity.x ..
							" z=" ..movement_state.current_velocity.z ..
							" xz=" .. xzspeed ..
							" minimum=" .. dump(entity.data.movement.min_speed))

	--this ain't perfect to avoid flying mobs standing in air
	--but it's a quick solution to fix most of the problems
	if (entity.data.movement.min_speed ~= nil and
		xzspeed < entity.data.movement.min_speed) or
		xzspeed == nil or
		xzspeed == 0 then

		dbg_mobf.pmovement_lvl2("MOBF: too slow! vxz=" .. xzspeed)
		--use normal speed change handling
		movement_state.force_change = true
	end
end

-------------------------------------------------------------------------------
-- name: fix_current_pos(entity,movement_state)
--
--! @brief check current position for validity and try to fix
--! @memberof movement_gen
--! @private
--
--! @param entity to fix position
--! @param movement_state movement state of mob
--! @return { speed_to_set = {x,y,z},
--!           speed_changed = true/false,
--!           force_speed_change = true/false }
-------------------------------------------------------------------------------
function movement_gen.fix_current_pos(entity,movement_state)

	--check if current pos is ok
	local current_state = environment.pos_is_ok(movement_state.basepos,entity)
	local handled = false

	dbg_mobf.pmovement_lvl3("MOBF: current state "..
							entity.data.name .. ": " .. current_state)

	movement_state.accel_to_set = { x=0,
									y=movement_state.default_y_accel,
									z=0 }

	local abort_processing = false

	if current_state == "ok" or
		current_state == "possible_surface" then
		entity.dynamic_data.movement.last_pos_in_env = movement_state.centerpos
		handled = true
	end

	--states ok drop and wrong_surface don't require an imediate action
	if current_state ~= "ok" and
		current_state ~= "drop" and
		current_state ~= "wrong_surface" and
		current_state ~= "possible_surface" and
		current_state ~= "below_limit" and
		current_state ~= "above_limit" then
		dbg_mobf.movement_lvl1("MOBF: BUG !!! somehow your mob managed to get"
									.." where it shouldn't be ("
									.. current_state .. "), trying to fix")

		--stop mob from moving at all
		entity.object:setacceleration({x=0,y=movement_state.default_y_accel,z=0})
		movement_state.force_change = true

		--mob is currently in water,
		--try to find a suitable position 1 level above current level
		if current_state == "in_water" or
			current_state == "above_water" then

			local targetpos = nil

			--if we don't have an old pos or old pos is to far away
			--try to finde another good pos around
			if entity.dynamic_data.movement.last_pos_in_env == nil or
				entity.dynamic_data.movement.last_pos_in_env.y >
											movement_state.centerpos.y + 2 then
				targetpos =
					environment.get_suitable_pos_same_level({
								x=movement_state.basepos.x,
								y=movement_state.basepos.y+1,
								z=movement_state.basepos.z},
								1,
								entity)
				if targetpos ~= nil then
					targetpos.y = targetpos.y - entity.collisionbox[2]
				end
			else
				targetpos = entity.dynamic_data.movement.last_pos_in_env
			end

			if targetpos ~= nil then
				mobf_bug_warning(LOGLEVEL_INFO,"MOBF: BUG !!! didn't find a way"
					.. " out of water, for mob at: " ..
					printpos(movement_state.basepos) ..
					" using last known good position")

				if targetpos == nil then
					targetpos = entity.dynamic_data.movement.last_pos_in_env
				else
					targetpos.y = targetpos.y - entity.collisionbox[2]
				end

				minetest.log(LOGLEVEL_INFO,"MOBF: Your mob " ..
						entity.data.name .. " " ..
						tostring(entity) .. " dropt into water moving to "..
						printpos(targetpos).." state: "..
						environment.pos_is_ok(targetpos,entity))
				entity.object:moveto(targetpos)
				movement_state.current_velocity.x = 0 --movement_state.current_velocity.x/10
				movement_state.current_velocity.z = 0 --movement_state.current_velocity.z/10
				entity.object:setvelocity(movement_state.current_velocity)
				movement_state.centerpos = targetpos
				movement_state.basepos = entity.getbasepos(entity)

				movement_state.accel_to_set.y =
					environment.get_default_gravity(targetpos,
													entity.environment.media,
													entity.data.movement.canfly)

				mobf_assert_backtrace(movement_state.accel_to_set.y ~= nil)
			else
				mobf_bug_warning(LOGLEVEL_WARNING,"MOBF: BUG !!! didn't find a way"
							.." out of water, for mob at: " ..
							printpos(movement_state.basepos) .. " drowning, last pos in env:" ..
							dump(entity.dynamic_data.movement.last_pos_in_env))
				abort_processing = true
				spawning.remove(entity, "mgen probab watercheck")
			end

			handled = true
		end

		if current_state == "in_air" then
			--TODO die?
			handled = true
		end
	end

	local damagetime = 60

	if entity.data.generic.wrong_surface_damage_time ~= nil then
		damagetime = entity.data.generic.wrong_surface_damage_time
	end

	if current_state == "wrong_surface" and
		entity.dynamic_data.good_surface ~= nil then
		if movement_state.now - entity.dynamic_data.good_surface  > damagetime then

			entity.object:set_hp(	entity.object:get_hp() -
									(entity.data.generic.base_health/25))
			dbg_mobf.movement_lvl1("MOBF: mob is on wrong surface it will slowly take damage")

			--reset timer for next damage interval
			entity.dynamic_data.good_surface = movement_state.now
			if entity.object:get_hp() <= 0 then
				abort_processing = true
				spawning.remove(entity, "mgen probab surfacecheck")
			end

			movement_state.force_change = true
		end

		handled = true
	else
		entity.dynamic_data.good_surface = movement_state.now
	end

	if current_state == "collision" then

		local current_pos = mobf_round_pos(movement_state.basepos);
		local current_node = minetest.get_node( current_pos );

		local walkable = false
		if minetest.registered_nodes[current_node.name] then
			walkable = minetest.registered_nodes[current_node.name].walkable
		end

		dbg_mobf.movement_lvl2( "MOBF: Mob collided with "..
			tostring( current_pos.x )..":"..
			tostring( current_pos.y )..":"..
			tostring( current_pos.z ).." Nodename:"..
			tostring( current_node.name ).." walkable:"..
			tostring( walkable ))

		if not mobf_is_walkable(current_node) then
			local targetpos = entity.dynamic_data.movement.last_pos_in_env

			if targetpos == nil then
				targetpos =
				environment.get_suitable_pos_same_level({x=current_pos.x,
														y=current_pos.y,
														z=current_pos.z},
														1,
														entity)
			end

			if targetpos == nil then
				targetpos =
					environment.get_suitable_pos_same_level({x=current_pos.x,
															y=current_pos.y+1,
															z=current_pos.z},
															1,
															entity)
			end

			if targetpos ~= nil then
				minetest.log(LOGLEVEL_INFO,
							"MOBF: Your mob " ..
							entity.data.name ..
							" is within solid block moving to"..
							printpos(targetpos).." state: "..
							environment.pos_is_ok(targetpos,entity))

				entity.object:moveto(targetpos)
				movement_state.accel_to_set.y =
					environment.get_default_gravity(targetpos,
													entity.environment.media,
													entity.data.movement.canfly)
				mobf_assert_backtrace(movement_state.default_y_accel ~= nil)
			else
				minetest.log(LOGLEVEL_WARNING,"MOBF: mob " .. entity.data.name
					.. " was within solid block, removed")
				abort_processing = true
				spawning.remove(entity, "mgen probab solidblockcheck")
			end
		else
			dbg_mobf.movement_lvl2( "MOBF: mob is on walkable surface " ..
				"so no forced repositioning" )
		end

		handled = true
	end

	if not handled then
		dbg_mobf.movement_lvl1("MOBF: ".. entity.data.name .. " state: "..
				current_state .. " not handled!")
	end

	return {	abort_processing=abort_processing,	 }
end

-------------------------------------------------------------------------------
-- name: set_target(entity,target)
--
--! @brief set target for movgen
--! @memberof movement_gen
--! @private
--
--! @param entity mob to apply to
--! @param target to set
-------------------------------------------------------------------------------
function movement_gen.set_target(entity,target)
	return false
end

--register this movement generator
registerMovementGen(movement_gen.name,movement_gen)