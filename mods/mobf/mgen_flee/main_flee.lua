-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file main_flee.lua
--! @brief component containing a movement generator trying to avoid a target
--! @copyright Sapier
--! @author Sapier
--! @date 2013-09-10
--
--! @defgroup mgen_flee MGEN: flee movement generator
--! @brief A movement generator creating movement that trys to avoid a moving
--! target or get away as far as possible from a given point on map
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class mgen_flee
--! @brief a movement generator trying to get a way from a target

--!@}

mgen_flee = {}

--! @brief movement generator identifier
--! @memberof mgen_flee
mgen_flee.name = "flee_mov_gen"

-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
--! @brief main callback to make a mob flee from a target
--! @memberof mgen_flee
--
--! @param entity mob to generate movement for
--! @param now current time
-------------------------------------------------------------------------------
function mgen_flee.callback(entity,now)

	dbg_mobf.flmovement_lvl3("MOBF: Follow mgen callback called")

	if entity == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!!: called movement gen without entity!")
		return
	end

	if entity.dynamic_data == nil or
		entity.dynamic_data.movement == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!!: >" ..entity.data.name ..
			"< removed=" .. dump(entity.removed) .. " entity=" ..
			tostring(entity) .. " probab movement callback")
		return
	end

	local flee_speedup =  {x=10,y=2,z=10 }

	if entity.data.movement.flee_speedup ~= nil then
		if type(entity.data.movement.flee_speedup) == "table" then
			flee_speedup = entity.data.movement.flee_speedup
		else
			flee_speedup.x= entity.data.movement.flee_speedup
			flee_speedup.z= entity.data.movement.flee_speedup
		end
	end

	--check max speed limit
	mgen_flee.checkspeed(entity)


	--check environment
	local basepos  = entity.getbasepos(entity)
	local pos_quality = environment.pos_quality(basepos,entity)

	if environment.evaluate_state(pos_quality, LT_GOOD_POS) or
		(entity.data.movement.canfly and
			environment.evaluate_state(pos_quality,LT_GOOD_FLY_POS)) then
		local toset = {
			x= basepos.x,
			y= basepos.y - 0.5 - entity.collisionbox[2],
			z= basepos.z }
		--save known good position
		entity.dynamic_data.movement.last_pos_in_env = toset
	end

	if pos_quality.media_quality == MQ_IN_AIR or           -- wrong media
		pos_quality.media_quality == MQ_IN_WATER or        -- wrong media
		pos_quality.geometry_quality == GQ_NONE or         -- no ground contact (TODO this was drop above water before)
		pos_quality.surface_quality_min == SQ_WATER then   -- above water


		if entity.dynamic_data.movement.invalid_env_count == nil then
			entity.dynamic_data.movement.invalid_env_count = 0
		end

		entity.dynamic_data.movement.invalid_env_count =
			entity.dynamic_data.movement.invalid_env_count + 1


		--don't change at first invalid pos but give some steps to cleanup by
		--other less invasive mechanisms
		if entity.dynamic_data.movement.invalid_env_count > 10 then
			dbg_mobf.flmovement_lvl1("MOBF: fled to wrong place " .. pos_quality.tostring(pos_quality))
			if entity.dynamic_data.movement.last_pos_in_env ~= nil then
				entity.object:moveto(entity.dynamic_data.movement.last_pos_in_env)
				basepos  = entity.getbasepos(entity)
			else
				local newpos = environment.get_suitable_pos_same_level(basepos,1,entity,true)

				if newpos == nil then
					newpos = environment.get_suitable_pos_same_level( {
																		x=basepos.x,
																		y=basepos.y-1,
																		z=basepos.z }
																		,1,entity,true)
				end

				if newpos == nil then
					newpos = environment.get_suitable_pos_same_level( {
																		x=basepos.x,
																		y=basepos.y+1,
																		z=basepos.z }
																		,1,entity,true)
				end

				if newpos == nil then
					dbg_mobf.flmovement_lvl1("MOBF: no way to fix it removing mob")
					spawning.remove(entity,"mgen_flee poscheck")
				else
					newpos.y = newpos.y - (entity.collisionbox[2] + 0.49)
					entity.object:moveto(newpos)
					basepos  = entity.getbasepos(entity)
				end
			end
		end
	else
		entity.dynamic_data.movement.invalid_env_count = 0
	end

	if pos_quality.level_quality ~= LQ_OK and
		entity.data.movement.canfly then
		local current_accel = entity.object:getacceleration()

		if pos_quality.level_quality == LQ_ABOVE then
			if current_accel.y >= 0 then
				current_accel.y = - entity.data.movement.max_accel
			end
		end

		if pos_quality.level_quality == LQ_BELOW then
			local current_accel = entity.object:getacceleration()
			if current_accel.y <= 0 then
				current_accel.y = entity.data.movement.max_accel
			end
		end

		entity.object:setacceleration(current_accel)
		return
	end

	--fixup height
	local current_accel = entity.object:getacceleration()
	if entity.data.movement.canfly then
		if current_accel.y ~= 0 then
			current_accel.y = 0
			entity.object:setacceleration(current_accel)
		end
	end

	if entity.dynamic_data.movement.target ~= nil then
		dbg_mobf.flmovement_lvl3("MOBF:   Target available")
		--calculate distance to target
		local targetpos = nil

		if entity.dynamic_data.movement.target ~= nil then
			dbg_mobf.flmovement_lvl3("MOBF:   have moving target")

			if not mobf_is_pos(entity.dynamic_data.movement.target) then
				targetpos = entity.dynamic_data.movement.target:getpos()
			else
				targetpos = entity.dynamic_data.movement.target
			end
		end

		if targetpos == nil then
			mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: flee " .. entity.data.name
			.. " don't have targetpos "
			.. " TGT: " .. dump(entity.dynamic_data.movement.target))
			return
		end

		--TODO need to do something if not line of sight?
		if mobf_line_of_sight({x=basepos.x,y=basepos.y+1,z=basepos.z},
						 {x=targetpos.x,y=targetpos.y+1,z=targetpos.z})  == false then
			dbg_mobf.flmovement_lvl3("MOBF:   no line of sight")
			--TODO teleport support?
			--TODO other ways to handle this?
			--return
		end

		local current_velocity = entity.object:getvelocity()
		local predicted_pos =
			movement_generic.predict_next_block(basepos,current_velocity,current_accel)
		local current_distance = mobf_calc_distance(targetpos,basepos)
		local predicted_distance = mobf_calc_distance(targetpos,predicted_pos)

		if not (predicted_distance > current_distance) then

			local current_rotation_addon = 0
			local accel_to_set = nil
			local jump_required = false

			while accel_to_set == nil and current_rotation_addon < math.pi*(5/16) do

				accel_to_set,jump_required = mgen_flee.calc_accel(entity,
													targetpos,
													basepos,
													current_rotation_addon,
													current_velocity)

				if accel_to_set == nil then
					accel_to_set,jump_required = mgen_flee.calc_accel(entity,
									targetpos,
									basepos,
									-current_rotation_addon,
									current_velocity)
				end

				if accel_to_set == nil then
					current_rotation_addon = current_rotation_addon + math.pi/8
				end
			end

			if accel_to_set ~= nil then
				mgen_flee.set_acceleration(entity,accel_to_set,flee_speedup,basepos)
				if jump_required then
					local jumpvel = current_velocity
					jumpvel.y = 5
					entity.object:setvelocity(jumpvel)
				end
			else
				dbg_mobf.flmovement_lvl2("MOBF: didn't find a way to flee, stopping")
			end
		end
	else
		--TODO evaluate if this is an error case
	end
end

function mgen_flee.calc_accel(entity,targetpos,basepos,rot_addon,cur_vel)
	local dirxz,dirxy = mobf_calc_direction(targetpos,basepos)

	local dirxz = dirxz + rot_addon

	local accel_to_set = mobf_calc_vector_components(dirxz,entity.data.movement.max_speed)

	local yaccel = environment.get_default_gravity(basepos,
					entity.environment.media,
					entity.data.movement.canfly)

	accel_to_set.y = yaccel

	local predicted_pos =
		movement_generic.predict_next_block(basepos,cur_vel,accel_to_set)
	local pos_quality = environment.pos_quality(predicted_pos,entity)


	if pos_quality.media_quality == MQ_IN_MEDIA and
		pos_quality.surface_quality_min > SQ_WATER then
		return accel_to_set,false
	end

	predicted_pos.y = predicted_pos.y+1
	pos_quality = environment.pos_quality(predicted_pos,entity)
		if pos_quality.media_quality == MQ_IN_MEDIA and
		pos_quality.surface_quality_min > SQ_WATER then
		return accel_to_set,true
	end

	return nil,false
end

-------------------------------------------------------------------------------
-- name: next_block_ok()
--
--! @brief check quality of next block
--! @memberof mgen_flee
--! @public
-------------------------------------------------------------------------------
function mgen_flee.next_block_ok(entity,pos,acceleration,velocity)
	local current_velocity = velocity

	if current_velocity == nil then
		current_velocity = entity.object:getvelocity()
	end

	local predicted_pos = movement_generic.predict_next_block(pos,current_velocity,acceleration)

	local quality = environment.pos_quality(predicted_pos,entity)

	return (
			(quality.media_quality == MQ_IN_MEDIA) and
			(quality.level_quality == LQ_OK) and
			(
				(quality.surface_quality_min == Q_UNKNOWN) or
				(quality.surface_quality_min >= SQ_WRONG)
			)
		)
end

-------------------------------------------------------------------------------
-- name: initialize()
--
--! @brief initialize movement generator
--! @memberof mgen_flee
--! @public
-------------------------------------------------------------------------------
function mgen_flee.initialize(entity,now)
	--intentionally empty
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof mgen_flee
--! @public
--
--! @param entity mob to initialize dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function mgen_flee.init_dynamic_data(entity,now)

	local pos = entity.object:getpos()


	local data = {
			target = nil,
			invalid_env_count = 0,
			}

	entity.dynamic_data.movement = data
end

-------------------------------------------------------------------------------
-- name: checkspeed(entity)
--
--! @brief check if mobs speed is within it's limits and correct if necessary
--! @memberof mgen_flee
--! @private
--
--! @param entity mob to initialize dynamic data
-------------------------------------------------------------------------------
function mgen_flee.checkspeed(entity)

	local current_velocity = entity.object:getvelocity()

	local xzspeed =
		mobf_calc_scalar_speed(current_velocity.x,current_velocity.z)

	if (xzspeed > (entity.data.movement.max_speed * 10)) then

		--preserver orientation when correcting speed
		local dir = mobf_calc_yaw(current_velocity.x,current_velocity.z)
		local velocity_to_set = mobf_calc_vector_components(dir,entity.data.movement.max_speed * 0.25)

		velocity_to_set.y=current_velocity.y

		entity.object:setvelocity(velocity_to_set)

		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: set_acceleration(entity,accel,speedup)
--
--! @brief apply acceleration to entity
--! @memberof mgen_flee
--! @private
--
--! @param entity mob to apply to
--! @param accel acceleration to set
--! @param speedup speedup factor
--! @param pos current position
-------------------------------------------------------------------------------
function mgen_flee.set_acceleration(entity,accel,speedup,pos)
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(accel ~= nil)
	mobf_assert_backtrace(speedup ~= nil)

	accel.x = accel.x*speedup.x
	accel.z = accel.z*speedup.z

	if entity.data.movement.canfly then
		accel.y = accel.y*speedup.y
	end

	if mgen_flee.next_block_ok(entity,pos,accel) then
		dbg_mobf.flmovement_lvl3("MOBF:   flee setting acceleration to: " .. printpos(accel));
		entity.object:setacceleration(accel)
		return true
	elseif mgen_flee.next_block_ok(entity,pos,{x=0,y=0,z=0}) then
		accel_to_set = {x=0,y=0,z=0}
		dbg_mobf.flmovement_lvl3("MOBF:   flee setting acceleration to: " .. printpos(accel));
		entity.object:setacceleration(accel)
		return true
	else
		local current_velocity = entity.object:getvelocity()
		current_velocity.y = 0

		if mgen_flee.next_block_ok(entity,pos,{x=0,y=0,z=0},current_velocity) then
			accel_to_set = {x=0,y=0,z=0}
			entity.object:setvelocity(current_velocity)
			entity.object:setacceleration(accel)
			return true
		end
	end

	dbg_mobf.flmovement_lvl1(
		"MOBF: \t acceleration " .. printpos(accel) ..
		" would result in invalid position not applying!")

	return false
end

-------------------------------------------------------------------------------
-- name: set_target(entity,target)
--
--! @brief set target for movgen
--! @memberof mgen_flee
--
--! @param entity mob to apply to
--! @param target to set
-------------------------------------------------------------------------------
function mgen_flee.set_target(entity,target)
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(target ~= nil)
	entity.dynamic_data.movement.target = target
	return true
end

--register this movement generator
registerMovementGen(mgen_flee.name,mgen_flee)