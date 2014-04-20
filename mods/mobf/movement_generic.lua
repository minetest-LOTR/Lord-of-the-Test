-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file movement_generic.lua
--! @brief generic movement related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup generic_movement Generic movement functions
--! @brief Movement related functions used by different movement generators
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(movement_generic == nil)
movement_generic = {}

--!@}

-------------------------------------------------------------------------------
-- @function [parent=#movement_generic] get_accel_to(new_pos,entity,ymovement)
--
--! @brief calculate a random speed directed to new_pos
--
--! @param new_pos position to go to
--! @param entity mob to move
--! @param ymovement current movement in y direction
--! @return { x,y,z } random speed directed to new_pos
-------------------------------------------------------------------------------
--
function movement_generic.get_accel_to(new_pos,entity,ymovement)

	if new_pos == nil or entity == nil then
		minetest.log(LOGLEVEL_CRITICAL,
			"MOBF: movement_generic.get_accel_to : Invalid parameters")
	end

	local old_pos  = entity.object:getpos()
	local node 	   = minetest.get_node(old_pos)
	local maxaccel = entity.data.movement.max_accel
	local minaccel = entity.data.movement.min_accel

	local yaccel = environment.get_default_gravity(old_pos,
							entity.environment.media,
							entity.data.movement.canfly)
	mobf_assert_backtrace(yaccel ~= nil)

	--calculate plane direction to target
	local xz_direction =
		mobf_calc_yaw(new_pos.x-old_pos.x,new_pos.z-old_pos.z)

	--find a new speed
	local absolute_accel = minaccel + (maxaccel - minaccel) * math.random()

	local new_accel_vector = nil

	--flying mob calculate accel towards target
	if entity.data.movement.canfly and
		yaccel == 0 then
		local xz_direction,xy_direction = mobf_calc_direction(old_pos,new_pos)

		new_accel_vector =
			mobf_calc_vector_components_3d(xz_direction,
											xy_direction,
											absolute_accel)

		if (new_pos.y > old_pos.y) then
			mobf_assert_backtrace(new_accel_vector.y >= 0)
		end

		if (new_pos.y < old_pos.y) then
			mobf_assert_backtrace(new_accel_vector.y <= 0)
		end

	else
		new_accel_vector =
			mobf_calc_vector_components(xz_direction,absolute_accel)
		new_accel_vector.y = yaccel
	end

	return new_accel_vector
end



-------------------------------------------------------------------------------
-- @function [parent=#movement_generic] calc_new_pos(pos,acceleration,prediction_time)
--
--! @brief calc the position a mob would be after a specified time
--         this doesn't handle velocity changes due to colisions
--
--! @param pos position
--! @param acceleration acceleration to predict pos
--! @param prediction_time time to predict pos
--! @param current_velocity current velocity of mob
--! @return { x,y,z } position after specified time
-------------------------------------------------------------------------------
function movement_generic.calc_new_pos(pos,acceleration,prediction_time,current_velocity)

	local predicted_pos = {x=pos.x,y=pos.y,z=pos.z}

	predicted_pos.x = predicted_pos.x + current_velocity.x * prediction_time + (acceleration.x/2)*math.pow(prediction_time,2)
	predicted_pos.z = predicted_pos.z + current_velocity.z * prediction_time + (acceleration.z/2)*math.pow(prediction_time,2)


	return predicted_pos
end

-------------------------------------------------------------------------------
-- @function [parent=#movement_generic] predict_next_block(pos,velocity,acceleration)
--
--! @brief predict next block based on pos velocity and acceleration
--
--! @param pos current position
--! @param velocity current velocity
--! @param acceleration current acceleration
--! @return { x,y,z } position of next block
-------------------------------------------------------------------------------
function movement_generic.predict_next_block(pos,velocity,acceleration)

	local prediction_time = 2

	local pos_predicted = movement_generic.calc_new_pos(pos,
								acceleration,
								prediction_time,
								velocity
								)
	local count = 1

	--check if after prediction time we would have traveled more than one block and adjust to not predict to far
	while mobf_calc_distance(pos,pos_predicted) > 1 do

		pos_predicted = movement_generic.calc_new_pos(pos,
								acceleration,
								prediction_time - (count*0.1),
								velocity
								)

		if (prediction_time - (count*0.1)) < 0 then
			minetest.log(LOGLEVEL_WARNING,"MOBF: Bug!!!! didn't find a suitable prediction time. Mob will move more than one block within prediction period")
			break
		end

		count = count +1
	end

	return pos_predicted
end

-------------------------------------------------------------------------------
-- @function [parent=#movement_generic] predict_enter_next_block(entity,pos,velocity,acceleration)
--
--! @brief predict next block based on pos velocity and acceleration
--
--! @param entity entitiy to do prediction for
--! @param pos current position
--! @param velocity current velocity
--! @param acceleration current acceleration
--! @return { x,y,z } position of next block
-------------------------------------------------------------------------------
function movement_generic.predict_enter_next_block(entity,pos,velocity,acceleration)


	local cornerpositions = {}

	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[4] -0.01,y=pos.y,z=pos.z + entity.collisionbox[6] -0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[4] -0.01,y=pos.y,z=pos.z + entity.collisionbox[3] +0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[1] +0.01,y=pos.y,z=pos.z + entity.collisionbox[6] -0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[1] +0.01,y=pos.y,z=pos.z + entity.collisionbox[3] +0.01})

	local sameblock = function(a,b)
		for i=1,#a,1 do
			if not mobf_pos_is_same(
						mobf_round_pos(a[i]),
						mobf_round_pos(b[i])) then
				return false
			end
		end
		return true
	end

	local prediction_time = 0.1
	local predicted_corners = {}

	for i=1,#cornerpositions,1 do
		predicted_corners[i] = movement_generic.calc_new_pos(cornerpositions[i],
								acceleration,
								prediction_time,
								velocity
								)
	end

	--check if any of the corners is in different block after prediction time
	while sameblock(cornerpositions,predicted_corners) and
		prediction_time < 2 do

		prediction_time = prediction_time + 0.1

		for i=1,#cornerpositions,1 do
			predicted_corners[i] = movement_generic.calc_new_pos(cornerpositions[i],
									acceleration,
									prediction_time,
									velocity
									)
		end

	end

	local pos_predicted = movement_generic.calc_new_pos(pos,
								acceleration,
								prediction_time,
								velocity
								)

	return pos_predicted
end