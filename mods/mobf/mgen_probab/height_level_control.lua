-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file height_level_control.lua
--! @brief component containing random drop features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @ingroup mgen_probab
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class height_level_control
--! @brief class containing height level functionality
height_level_control = {}


--!@}

-------------------------------------------------------------------------------
-- name: calc_level_change_time(entity)
--
--! @brief calculate time required to change one height level
--! @memberof height_level_control
--! @private
--
--! @param entity mob to calculate change time
--! @param default_accel default accel for mob
--! @return time in seconds
-------------------------------------------------------------------------------
function height_level_control.calc_level_change_time(entity,default_accel)
	local retval = 1 --default value

	--calculate a reasonable value to stop level change
	if entity.data.movement.canfly == nil or
		entity.data.movement.canfly == false then --case mob can't fly
		return 0
	else
		-- if it's a flying mob and left it's normal medium
		if default_accel ~= 0 then
			retval = 0
		else
			retval = math.sqrt(2/entity.data.movement.min_accel)
		end
	end

	return retval
end

-------------------------------------------------------------------------------
-- name: precheck_movement(entity,movement_state,pos_predicted,pos_predicted_quality)
--
--! @brief check if there is a level change in progress that may
-- need to be stopped
--! @memberof height_level_control
--
--! @param entity mob to check for level change
--! @param movement_state current state of movement
--! @param pos_predicted position the mob will be next
--! @param pos_predicted_quality quality of the next position
-------------------------------------------------------------------------------
function height_level_control.precheck_movement(entity,movement_state,pos_predicted,pos_predicted_quality)

	if entity.data.movement.canfly ~= nil and
		entity.data.movement.canfly == true and
		entity.dynamic_data.movement.changing_levels == true then

		local level_change_time = height_level_control.calc_level_change_time(entity,movement_state.default_y_accel)

		local time_completed = entity.dynamic_data.movement.ts_random_jump + level_change_time

		dbg_mobf.pmovement_lvl1("MOBF: ".. movement_state.now .. " " .. entity.data.name ..
			" check complete level change " .. time_completed)

		if entity.dynamic_data.movement.changing_levels and
			time_completed  < movement_state.now then

			dbg_mobf.pmovement_lvl2("MOBF: ".. movement_state.now .. " " .. entity.data.name ..
			" level change complete reestablishing default y acceleration " .. movement_state.default_y_accel)
			entity.dynamic_data.movement.changing_levels = false

			movement_state.current_velocity.y = 0
			entity.object:setvelocity(movement_state.current_velocity)

			movement_state.accel_to_set = movement_state.current_acceleration
			movement_state.accel_to_set.y = movement_state.default_y_accel
			movement_state.changed = true
		end
	end

	--mob would fly/swim into height it shouldn't be
	if movement_state.changed == false then
		local invalid_pos_handled = false

		--mob would fly/swim into height it shouldn't be
		if invalid_pos_handled == false and
			pos_predicted_quality.level_quality == LQ_ABOVE then

			local min_y,max_y = environment.get_absolute_min_max_pos(entity.environment,movement_state.basepos)

			if (pos_predicted.y - max_y) > 10 then
				movement_state.override_height_change_chance = 1
			else
				movement_state.override_height_change_chance = (pos_predicted.y - max_y)/10
			end

			invalid_pos_handled = true
		end

		--mob would fly/swim into height it shouldn't be
		if invalid_pos_handled == false and
			pos_predicted_quality.level_quality == LQ_BELOW then

			local min_y,max_y = environment.get_absolute_min_max_pos(entity.environment,movement_state.basepos)

			if (min_y - pos_predicted.y) > 10 then
					movement_state.override_height_change_chance = 1
			else
					movement_state.override_height_change_chance = (min_y - pos_predicted.y)/10
			end
		end
	end
end

-------------------------------------------------------------------------------
-- name: random_jump_fly(entity,movement_state)
--
--! @brief apply random jump for flying mobs
--! @memberof height_level_control
--! @private
--
--! @param entity mob to apply random jump
--! @param movement_state current movement state
--! @return movement_state is modified!
-------------------------------------------------------------------------------
function height_level_control.random_jump_fly(entity,movement_state)

	--get some information
	local accel_to_set  = movement_state.current_acceleration
	local current_state = environment.pos_is_ok(movement_state.basepos,entity)

	--find direction
	local ydirection = 1

	if current_state == "ok" then
		if math.random() <= 0.5 then
			ydirection = -1
		end
	end

	if current_state == "above_limit" then
		ydirection = -1
	end

	--state "below_limit" is already handled by initialization value


	--prepare basic information about what may be afterwards
	local targetpos = {x=movement_state.basepos.x,y=movement_state.basepos.y+ydirection,z=movement_state.basepos.z}
	local target_state = environment.pos_is_ok(targetpos,entity);

	dbg_mobf.pmovement_lvl2("MOBF: " .. entity.data.name .." flying change y accel dir="..ydirection.." ypos="..movement_state.basepos.y..
			" min="..entity.environment.min_height_above_ground..
			" max="..entity.environment.max_height_above_ground..
			" below="..target_state)

	--really do level change
	if (target_state == "ok") or
		target_state == current_state then

		local min_y, max_y = environment.get_absolute_min_max_pos(entity.environment,movement_state.basepos)

		dbg_mobf.pmovement_lvl2("MOBF: check level borders current=".. movement_state.basepos.y ..
									" min=" .. min_y ..
									" max=" .. max_y)

		movement_state.accel_to_set.y = ydirection * entity.data.movement.min_accel
		entity.dynamic_data.movement.ts_random_jump = movement_state.now
		entity.dynamic_data.movement.changing_levels = true
		dbg_mobf.pmovement_lvl2("MOBF: " .. entity.data.name .. " " .. movement_state.now .. " " ..
							" changing level within borders: " .. movement_state.accel_to_set.y)
		movement_state.changed = true
	end

end

-------------------------------------------------------------------------------
-- name: random_jump_ground(entity,movement_state)
--
--! @brief apply random jump for ground mobs
--! @memberof height_level_control
--! @private
--
--! @param entity mob to apply random jump
--! @param movement_state current movement state
--! @return movement_state is a modification!
-------------------------------------------------------------------------------
function height_level_control.random_jump_ground(entity,movement_state)

	if movement_state.default_y_accel == 0 then
		minetest.log(LOGLEVEL_ERROR,"MOBF BUG!!! ground mob can't have zero default acceleration!!!")
	end

	local random_jump_time = 2 * (entity.dynamic_data.movement.mpattern.random_jump_initial_speed /
									math.abs(movement_state.default_y_accel))

	local next_jump = entity.dynamic_data.movement.ts_random_jump +
						entity.dynamic_data.movement.mpattern.random_jump_delay +
						random_jump_time

	dbg_mobf.movement_lvl2("MOBF: now=" .. movement_state.now .. " time of next jump=" .. next_jump ..
				" | " .. random_jump_time .. " " .. entity.dynamic_data.movement.mpattern.random_jump_delay .. " " ..
				entity.dynamic_data.movement.ts_random_jump .. " " .. movement_state.default_y_accel .. " " ..
				entity.dynamic_data.movement.mpattern.random_jump_initial_speed)

	if movement_state.now > next_jump then

		local ground_distance = mobf_ground_distance(movement_state.basepos)


		--we shouldn't be moving in y direction at that time so probably we are just dropping
		--we can only jump while on solid ground!
		if ground_distance <= 1 then

			local current_speed = entity.object:getvelocity();

			dbg_mobf.pmovement_lvl2("MOBF: " .. entity.data.name .." doing random jump "..
								"speed: " .. entity.dynamic_data.movement.mpattern.random_jump_initial_speed ..
								": ",entity)

			current_speed.y = entity.dynamic_data.movement.mpattern.random_jump_initial_speed

			entity.object:setvelocity(current_speed)

			entity.dynamic_data.movement.ts_random_jump = movement_state.now
		else
			dbg_mobf.pmovement_lvl2("MOBF: " .. entity.data.name .. " Random jump but ground distance was:" .. ground_distance ..
							" " ..movement_state.current_acceleration.y ..
							" " ..movement_state.default_y_accel)

			--this is a workaround for a bug
			--setting y acceleration to 0 for ground born mobs shouldn't be possible
			if movement_state.current_acceleration.y == 0 then
				movement_state.accel_to_set.x = movement_state.current_acceleration.x
				movement_state.accel_to_set.y = movement_state.default_y_accel
				movement_state.accel_to_set.z = movement_state.current_acceleration.z
				movement_state.changed = true
			end
		end
	end
end

-------------------------------------------------------------------------------
-- name: random_movement_handler(entity,movement_state)
--
--! @brief generate a random y-movement
--! @memberof height_level_control
--
--! @param entity mob to apply random jump
--! @param movement_state current movement state
--! @return movement_state is a modified!
-------------------------------------------------------------------------------
function height_level_control.random_movement_handler(entity,movement_state)
	--generate random y movement changes
	if movement_state.changed == false and
		entity.dynamic_data.movement.changing_levels == false and
		(math.random() < entity.dynamic_data.movement.mpattern.random_jump_chance or
		 math.random() < movement_state.override_height_change_chance) then

		dbg_mobf.pmovement_lvl1("MOBF: Random jump chance for mob " .. entity.data.name .. " "..
						entity.dynamic_data.movement.ts_random_jump .. " "..
						entity.dynamic_data.movement.mpattern.random_jump_delay .. " " .. movement_state.now
			)

		local to_set
		--flying/swiming mobs do level change on random jump chance
		if entity.data.movement.canfly then

			height_level_control.random_jump_fly(entity,movement_state)
		--ground mobs
		else
			height_level_control.random_jump_ground(entity,movement_state)
		end
	end
end
