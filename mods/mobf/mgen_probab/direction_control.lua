-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file direction_control.lua
--! @brief functions for direction control in probabilistic movement gen
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @ingroup mgen_probab
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class direction_control
--! @brief functions for direction control in probabilistic movement gen
direction_control = {}
--!@}

-------------------------------------------------------------------------------
-- name: changeaccel(pos,entity,velocity)
--
--! @brief find a suitable new acceleration for mob
--! @memberof direction_control
--! @private
--
--! @param pos current position
--! @param entity mob to get acceleration for
--! @param current_velocity current velocity
--! @return {{ x/y/z accel} + jump flag really?
-------------------------------------------------------------------------------
function direction_control.changeaccel(pos,entity,current_velocity)

	local maxtries = 5
	local old_quality = environment.pos_quality(pos,entity)

	local new_accel = direction_control.get_random_acceleration(entity.data.movement.min_accel,
														entity.data.movement.max_accel,entity.object:getyaw(),0)
	local pos_predicted = movement_generic.predict_next_block(pos,current_velocity,new_accel)

	local new_quality = environment.pos_quality(pos_predicted,entity)
	local prefered_state =
		environment.evaluate_state(	new_quality,
									old_quality,
									MQ_IN_MEDIA,
									nil,
									GQ_FULL,
									SQ_POSSIBLE,
									SQ_OK)

	while not prefered_state do
		dbg_mobf.pmovement_lvl1("MOBF: predicted pos " .. printpos(pos_predicted)
			.. " isn't perfect " .. maxtries .. " tries left, state: "
			.. new_quality.tostring(new_quality))

		--don't loop forever get to save mode and try next time
		if maxtries <= 0 then
			dbg_mobf.pmovement_lvl1("MOBF: Aborting acceleration finding for this cycle due to max retries")
			if 	state == "collision_jumpable" then
				dbg_mobf.movement_lvl1("Returning "..printpos(new_accel).." as new accel as mob may jump")
				return new_accel
			end

			dbg_mobf.pmovement_lvl1("MOBF: Didn't find a suitable acceleration stopping movement: " .. entity.data.name .. printpos(pos))
			entity.object:setvelocity({x=0,y=0,z=0})
			entity.dynamic_data.movement.started = false
			--don't slow down mob
			return  {  x=0,
						y=0,
						z=0 }
		end

		local probab = math.random()

		--accept possible surface in rare cases
		if probab < 0.3 then
			local acceptable_state =
				environment.evaluate_state(new_quality,
									nil,
									MQ_IN_MEDIA,
									GQ_PARTIAL,
									nil,
									SQ_WRONG,
									SQ_POSSIBLE)

			if acceptable_state then
				return new_accel
			end
		end

		--accept possible surface in rare cases
		if probab < 0.2 then
			local acceptable_state =
				environment.evaluate_state(new_quality,
									nil,
									MQ_IN_MEDIA,
									nil,
									GQ_FULL,
									SQ_WRONG,
									SQ_POSSIBLE)

			if acceptable_state then
				return new_accel
			end
		end

		--try another acceleration
		new_accel = direction_control.get_random_acceleration(entity.data.movement.min_accel,
														entity.data.movement.max_accel,entity.object:getyaw(),1.57)
		pos_predicted = movement_generic.predict_next_block(pos,current_velocity,new_accel)


		local prefered_state =
			environment.evaluate_state(	new_quality,
									old_quality,
									MQ_IN_MEDIA,
									nil,
									GQ_FULL,
									SQ_POSSIBLE,
									SQ_OK)
		maxtries = maxtries -1
	end

	return new_accel

end

-------------------------------------------------------------------------------
-- name: get_random_acceleration(minaccel,maxaccel,current_yaw, minrotation)
--
--! @brief get a random x/z acceleration within a specified acceleration range
--! @memberof direction_control
--! @private
--
--! @param minaccel minimum acceleration to use
--! @param maxaccel maximum acceleration
--! @param current_yaw current orientation of mob
--! @param minrotation minimum rotation to perform
--! @return x/y/z acceleration
-------------------------------------------------------------------------------
function direction_control.get_random_acceleration(minaccel,maxaccel,current_yaw, minrotation)

	local direction = 1
	if math.random() < 0.5 then
		direction = -1
	end

	--calc random absolute value
	local rand_accel = (math.random() * (maxaccel - minaccel)) + minaccel

	local orientation_delta = mobf_gauss(math.pi/6,1/2)

	--calculate new acceleration
	local new_direction =  current_yaw + ((minrotation + orientation_delta) * direction)

	local new_accel = mobf_calc_vector_components(new_direction,rand_accel)

	dbg_mobf.pmovement_lvl3(" new direction: " .. new_direction ..
							" old direction: " .. current_yaw ..
							" new accel: " .. printpos(new_accel) ..
							" orientation_delta: " .. orientation_delta)

	return new_accel
end



-------------------------------------------------------------------------------
-- name: precheck_movement(entity,movement_state,pos_predicted,pos_predicted_quality)
--
--! @brief check if x/z movement results in invalid position and change
--         movement if required
--! @memberof direction_control
--
--! @param entity mob to generate movement
--! @param movement_state current state of movement
--! @param pos_predicted position mob will be next
--! @param pos_predicted_quality quality of predicted position
--! @return movement_state is changed!
-------------------------------------------------------------------------------
function direction_control.precheck_movement(entity,movement_state,pos_predicted,pos_predicted_quality)

	if movement_state.changed then
		--someone already changed something
		return
	end

	local prefered_quality =
		environment.evaluate_state(	pos_predicted_quality, LT_GOOD_POS)

	-- ok predicted pos isn't as good as we'd wanted it to be let's find out why
	if not prefered_quality then

		local mob_is_safe = environment.evaluate_state(	pos_predicted_quality,LT_SAFE_POS)

		if movement_state.current_quality == nil then
			movement_state.current_quality = environment.pos_quality(
												movement_state.basepos,
												entity
												)
		end

		if environment.compare_state(movement_state.current_quality,pos_predicted_quality) > 0 and
			pos_predicted_quality.media_quality == MQ_IN_MEDIA then
			--movement state is better than old one so we're fine
			return
		end

		local walking_at_edge =
			environment.evaluate_state(	pos_predicted_quality,LT_SAFE_EDGE_POS)

		if walking_at_edge then
			--mob center still on ground but at worst walking at edge, do nothing
			return
		end

		local drop_pending =
				(pos_predicted_quality.geometry_quality <= GQ_PARTIAL and
				 pos_predicted_quality.center_geometry_quality <= GQ_NONE) or
				 pos_predicted_quality.surface_quality_min <= SQ_WATER

		if drop_pending then
			dbg_mobf.pmovement_lvl2("MOBF: mob " .. entity.data.name .. " is going to walk on water or drop")

			local new_pos = environment.get_pos_same_level(movement_state.basepos,1,entity,
						function(quality)
							return environment.evaluate_state(quality,LT_SAFE_EDGE_POS)
						end
						)

			if new_pos == nil then
				dbg_mobf.pmovement_lvl2("MOBF: mob " .. entity.data.name .. " trying edge pos")
				new_pos = environment.get_pos_same_level(movement_state.basepos,1,entity,
						function(quality)
							return environment.evaluate_state(quality,LT_EDGE_POS)
						end
						)
			end

			if new_pos == nil then
				dbg_mobf.pmovement_lvl2("MOBF: mob " .. entity.data.name .. " trying relaxed surface")
				new_pos = environment.get_pos_same_level(movement_state.basepos,1,entity,
						function(quality)
							return environment.evaluate_state(quality,LT_EDGE_POS_GOOD_CENTER)
						end
						)
			end

			if new_pos == nil then
				dbg_mobf.pmovement_lvl2("MOBF: mob " .. entity.data.name .. " trying even more relaxed surface")
				new_pos = environment.get_pos_same_level(movement_state.basepos,1,entity,
						function(quality)
							return environment.evaluate_state(quality,LT_EDGE_POS_POSSIBLE_CENTER)
						end
						)
			end

			if new_pos ~= nil then
				dbg_mobf.pmovement_lvl2("MOBF: redirecting to safe position .. " .. printpos(new_pos))
				movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
				movement_state.changed = true
				return
			else
				--no suitable pos found, if mob is safe atm just stop it
				if mob_is_safe then
					entity.object:setvelocity({x=0,y=0,z=0})
					movement_state.accel_to_set = {x=0,y=nil,z=0}
					dbg_mobf.pmovement_lvl2("MOBF: no suitable pos found stopping at safe pos")
					movement_state.changed = true
				end
			end

			dbg_mobf.pmovement_lvl2("MOBF: mob " .. entity.data.name .. " didn't find a way to fix drop trying random")
			--make mgen change direction randomly
			movement_state.force_change = true
			return
		end

		--check if mob is going to be somewhere where it can't be
		if pos_predicted_quality.media_quality ~= MQ_IN_MEDIA then
			dbg_mobf.pmovement_lvl2("MOBF: collision pending "
				.. printpos(movement_state.basepos) .. "-->"
				.. printpos(pos_predicted))

			--try to find a better position at same level
			local new_pos =
				environment.get_suitable_pos_same_level(movement_state.basepos,1,entity)

			if new_pos == nil then
				new_pos = environment.get_suitable_pos_same_level(movement_state.basepos,1,entity,true)
			end

			--there is at least one direction to go
			if new_pos ~= nil then
				dbg_mobf.pmovement_lvl2("MOBF: mob " ..entity.data.name
					.. " redirecting to:" .. printpos(new_pos))
				local new_predicted_state = nil
				local new_predicted_pos = nil
				for i=1,5,1 do
					movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
					--TODO check if acceleration is enough
					new_predicted_pos =
						movement_generic.predict_enter_next_block( entity,
												movement_state.basepos,
												movement_state.current_velocity,
												movement_state.accel_to_set)
					new_predicted_state = environment.pos_quality(
												new_predicted_pos,
												entity
												)
					if new_predicted_state.media_quality == MQ_IN_MEDIA then
						break
					end
				end
				if new_predicted_state.media_quality ~= MQ_IN_MEDIA then
					movement_state.accel_to_set = movement_state.current_acceleration

					dbg_mobf.pmovement_lvl2("MOBF: mob " ..entity.data.name
						.. " acceleration not enough to avoid collision try to jump")
					if math.random() <
						( entity.dynamic_data.movement.mpattern.jump_up * PER_SECOND_CORRECTION_FACTOR) then
						local upper_pos = {
										x= pos_predicted.x,
										y= pos_predicted.y +1,
										z= pos_predicted.z
										}

						local upper_quality = environment.pos_quality(
													upper_pos,
													entity
													)

						if environment.evaluate_state(	upper_quality,LT_EDGE_POS) then

							entity.object:setvelocity(
									{x=movement_state.current_velocity.x,
									y=5,
									z=movement_state.current_velocity.z})
						end
					end
				end
				movement_state.changed = true
				return
			end

			--try to find a better position above
			new_pos = environment.get_suitable_pos_same_level({ x=movement_state.basepos.x,
														 y=movement_state.basepos.y+1,
														 z=movement_state.basepos.z},
														1,entity)

			if new_pos == nil then
				new_pos = environment.get_suitable_pos_same_level({ x=movement_state.basepos.x,
											 y=movement_state.basepos.y+1,
											 z=movement_state.basepos.z},
											1,entity)
			end

			if new_pos ~= nil then
				dbg_mobf.pmovement_lvl2("MOBF: mob " ..entity.data.name
					.. " seems to be locked in, jumping to:" .. printpos(new_pos))

				entity.object:setvelocity({x=0,
											y=5.5,
											z=0})
				movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
				movement_state.changed = true
				return
			end

			dbg_mobf.pmovement_lvl2("MOBF: mob " ..entity.data.name
					.. " unable to fix collision try random")
			--a collision is going to happen force change of direction
			movement_state.force_change = true
			return
		end

		local suboptimal_surface =
			environment.evaluate_state(	pos_predicted_quality,
					{	old_state=nil,
						min_media=MQ_IN_MEDIA,
						min_geom=GQ_PARTIAL,
						min_geom_center=nil,
						min_min_surface=SQ_WRONG,
						min_max_surface=SQ_POSSIBLE,
						min_center_surface=nil	})

		if suboptimal_surface then
			dbg_mobf.pmovement_lvl2("MOBF: suboptimal positiond detected trying to find better pos")
			--try to find a better position at same level
			local new_pos =
				environment.get_suitable_pos_same_level(movement_state.basepos,1,entity)

			if new_pos ~= nil then
				dbg_mobf.pmovement_lvl2("MOBF: redirecting to better position .. " .. printpos(new_pos))
				movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
				movement_state.changed = true
				return
			else
				-- pos isn't critical don't do anything
				return
			end
		end

		local geom_ok =
			environment.evaluate_state(	pos_predicted_quality,
					{	old_state=nil,
						min_media=MQ_IN_MEDIA,
						min_geom=GQ_PARTIAL,
						min_geom_center=nil,
						min_min_surface=nil,
						min_max_surface=nil,
						min_center_surface=nil	})
		if geom_ok and
			pos_predicted_quality.surface_quality_max == SQ_WRONG then
			dbg_mobf.pmovement_lvl2("MOBF: wrong surface detected trying to find better pos")
			local new_pos =
				environment.get_suitable_pos_same_level(movement_state.basepos,1,entity)

			if new_pos == nil then
				new_pos = environment.get_suitable_pos_same_level(movement_state.basepos,2,entity)
			end

			if new_pos ~= nil then
				dbg_mobf.pmovement_lvl2("MOBF: redirecting to better position .. " .. printpos(new_pos))
				movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
				movement_state.changed = true
				return
			else
				--try generic
				movement_state.force_change = true
				return
			end
		end

		mobf_print("Unhandled suboptimal state:" .. pos_predicted_quality.tostring(pos_predicted_quality))
		movement_state.force_change = true
	end
end

-------------------------------------------------------------------------------
-- name: random_movement_handler(entity,movement_state)
--
--! @brief generate a random y-movement
--! @memberof direction_control
--
--! @param entity mob to apply random jump
--! @param movement_state current movement state
--! @return movement_state is modified!
-------------------------------------------------------------------------------
function direction_control.random_movement_handler(entity,movement_state)
	dbg_mobf.pmovement_lvl3("MOBF: random movement handler called")
	local rand_value = math.random()
	local max_value = entity.dynamic_data.movement.mpattern.random_acceleration_change * PER_SECOND_CORRECTION_FACTOR
	if movement_state.changed == false and
		(rand_value < max_value or
		movement_state.force_change) then

		movement_state.accel_to_set = direction_control.changeaccel(movement_state.basepos,
							entity,movement_state.current_velocity)
		if movement_state.accel_to_set ~= nil then
			--retain current y acceleration
			movement_state.accel_to_set.y = movement_state.current_acceleration.y
			movement_state.changed = true
		end
		dbg_mobf.pmovement_lvl1("MOBF: randomly changing speed from "..
			printpos(movement_state.current_acceleration).." to "..
			printpos(movement_state.accel_to_set))
	else
		dbg_mobf.pmovement_lvl3("MOBF:" .. entity.data.name ..
			" not changing speed random: " .. rand_value .." >= " .. max_value)
	end
end