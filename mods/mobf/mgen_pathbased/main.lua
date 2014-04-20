-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file path_based_movement_gen.lua
--! @brief component containing a path based movement generator
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup mgen_path_based MGEN: Path based movement generator
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class p_mov_gen
--! @brief a movement generator evaluating a path to a target and following it
--!@}
p_mov_gen = {}



--! @brief movement generator identifier
--! @memberof p_mov_gen
p_mov_gen.name = "mgen_path"

-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
--! @brief path based movement generator callback
--! @memberof p_mov_gen
--
-- param1: mob to do movement
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.callback(entity,now,dstep)

	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(entity.dynamic_data ~= nil)
	mobf_assert_backtrace(entity.dynamic_data.p_movement ~= nil)

	if entity.dynamic_data.p_movement.eta ~= nil then
		if now < entity.dynamic_data.p_movement.eta then
			return
		end
	end

	local current_pos = entity.object:getpos()
	local handled = false

	if entity.dynamic_data.p_movement.path == nil then
		dbg_mobf.path_mov_lvl1(
				"MOBF: path movement but mo path set!!")
		return
	end


	local max_distance = entity.data.movement.max_distance

	if entity.dynamic_data.movement.max_distance ~= nil then
		max_distance = entity.dynamic_data.movement.max_distance
	end

	mobf_assert_backtrace(entity.dynamic_data.p_movement.next_path_index ~= nil)
	mobf_assert_backtrace(max_distance ~= nil)

	--check if target is reached
	if p_mov_gen.distance_to_next_point(entity,current_pos)
						< max_distance then
		dbg_mobf.path_mov_lvl1("MOBF: pathmov next to next point switching target")
		local update_target = true

		--return to begining of path
		if entity.dynamic_data.p_movement.next_path_index
				== #entity.dynamic_data.p_movement.path then

			if entity.dynamic_data.p_movement.cycle_path or
				(entity.dynamic_data.p_movement.cycle_path == nil and
				entity.data.patrol ~= nil and
				entity.data.patrol.cycle_path) then
				--0 is correct as it's incremented by one later
				entity.dynamic_data.p_movement.next_path_index = 0
			else
				if entity.dynamic_data.p_movement.HANDLER_end_of_path ~= nil
					and type(entity.dynamic_data.p_movement.HANDLER_end_of_path) == "function" then
					entity.dynamic_data.p_movement.HANDLER_end_of_path(entity)
				end
				dbg_mobf.path_mov_lvl1("MOBF: cycle not set not updating point")
				update_target = false
				handled = true
			end
		end

		if update_target then
			mobf_assert_backtrace(entity.dynamic_data.p_movement.path ~= nil)
			entity.dynamic_data.p_movement.next_path_index =
				entity.dynamic_data.p_movement.next_path_index + 1

			entity.dynamic_data.movement.target =
				entity.dynamic_data.p_movement.path
					[entity.dynamic_data.p_movement.next_path_index]

			dbg_mobf.path_mov_lvl1("MOBF: (1) setting new target to index: " ..
				entity.dynamic_data.p_movement.next_path_index .. " pos: " ..
				printpos(entity.dynamic_data.movement.target))
			handled = true
		end
	end

	if not handled and
		entity.dynamic_data.movement.target == nil then
		mobf_assert_backtrace(entity.dynamic_data.p_movement.path ~= nil)

		entity.dynamic_data.movement.target =
				entity.dynamic_data.p_movement.path
					[entity.dynamic_data.p_movement.next_path_index]

		dbg_mobf.path_mov_lvl1("MOBF: (2) setting new target to index: " ..
				entity.dynamic_data.p_movement.next_path_index .. " pos: " ..
				printpos(entity.dynamic_data.movement.target))
	end

	mgen_follow.callback(entity,now)
end


-------------------------------------------------------------------------------
-- name: distance_to_next_point(entity)
--
--! @brief get distance to next target point (2d only)
--! @memberof p_mov_gen
--! @private
--
--! @param entity mob to check
--! @param current_pos position mob is atm
--
--! @retval distance
-------------------------------------------------------------------------------
function p_mov_gen.distance_to_next_point(entity,current_pos)
	local index = entity.dynamic_data.p_movement.next_path_index
	mobf_assert_backtrace(entity.dynamic_data.p_movement.path ~= nil)
	mobf_assert_backtrace(index <= #entity.dynamic_data.p_movement.path)
	return mobf_calc_distance_2d(current_pos,
		entity.dynamic_data.p_movement.path[index])
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof p_mov_gen
--
--! @param entity to initialize
--! @param now current time
--! @param restored_data data restored on activate
-------------------------------------------------------------------------------
function p_mov_gen.init_dynamic_data(entity,now,restored_data)

	local pos = entity.object:getpos()

	local data = {
			path                = nil,
			eta                 = nil,
			last_move_stop      = now,
			next_path_index     = 1,
			force_target        = nil,
			pathowner           = nil,
			pathname            = nil,
			}

	if restored_data ~= nil then
		dbg_mobf.path_mov_lvl3(
			"MOBF: path movement reading stored data: " .. dump(restored_data))
		if restored_data.pathowner ~= nil and
			restored_data.pathname ~= nil then
			data.pathowner = restored_data.pathowner
			data.pathname = restored_data.pathname

			data.path = mobf_path.getpoints(data.pathowner,data.pathname)
			dbg_mobf.path_mov_lvl3(
				"MOBF: path movement restored points: " .. dump(data.path))
		end

		if restored_data.pathindex ~= nil and
			type(restored_data.pathindex) == "number" and
			restored_data.pathindex > 0 and
			data.path ~= nil and
			restored_data.pathindex < #data.path then
			data.next_path_index = restored_data.pathindex
		end
	end

	entity.dynamic_data.p_movement = data

	mgen_follow.init_dynamic_data(entity,now)
end

-------------------------------------------------------------------------------
-- name: set_path(entity,path)
--
--! @brief set target for movgen
--! @memberof p_mov_gen
--! @public
--
--! @param entity mob to apply to
--! @param path to set
-------------------------------------------------------------------------------
function p_mov_gen.set_path(entity,path)
	mobf_assert_backtrace(entity.dynamic_data.p_movement ~= nil)
	if path ~= nil then
		entity.dynamic_data.p_movement.next_path_index = 1
		entity.dynamic_data.movement.max_distance = 0.5
		entity.dynamic_data.p_movement.path = path

		--a valid path has at least 2 positions
		mobf_assert_backtrace(#entity.dynamic_data.p_movement.path > 1)
		entity.dynamic_data.movement.target =
				entity.dynamic_data.p_movement.path[2]
		return true
	else
		entity.dynamic_data.p_movement.next_path_index = nil
		entity.dynamic_data.movement.max_distance = nil
		entity.dynamic_data.p_movement.path = nil
		entity.dynamic_data.movement.target = nil
		return false
	end
end

-------------------------------------------------------------------------------
-- name: set_cycle_path(entity,value)
--
--! @brief set state of path cycle mechanism
--! @memberof p_mov_gen
--! @public
--
--! @param entity mob to apply to
--! @param value to set true/false/nil(mob global default)
-------------------------------------------------------------------------------
function p_mov_gen.set_cycle_path(entity,value)
	mobf_assert_backtrace(entity.dynamic_data.p_movement ~= nil)
	entity.dynamic_data.p_movement.cycle_path = value
end

-------------------------------------------------------------------------------
-- name: set_end_of_path_handler(entity,handler)
--
--! @brief set handler to call for non cyclic paths if final target is reached
--! @memberof p_mov_gen
--! @public
--
--! @param entity mob to apply to
--! @param handler to call at final target
-------------------------------------------------------------------------------
function p_mov_gen.set_end_of_path_handler(entity,handler)
	entity.dynamic_data.p_movement.HANDLER_end_of_path = handler
end

-------------------------------------------------------------------------------
-- name: set_target(entity,target)
--
--! @brief set target for movgen
--! @memberof p_mov_gen
--! @public
--
--! @param entity mob to apply to
--! @param target to set
-------------------------------------------------------------------------------
function p_mov_gen.set_target(entity,target)
	mobf_assert_backtrace(target ~= nil)

	local current_pos = entity.getbasepos(entity)
	local targetpos = nil

	if not mobf_is_pos(target) then
		if target:is_player() then
			targetpos = target:getpos()
			targetpos.y = targetpos.y +0.5
		else
			if type(target.getbasepos) == "function" then
				targetpos = target.getbasepos(target)
			else
				targetpos = target:getpos()
			end
		end
	else
		targetpos = target
	end

	if targetpos == nil then
		return false
	end

	if entity.dynamic_data.p_movement.lasttargetpos ~= nil then
		if mobf_pos_is_same(entity.dynamic_data.p_movement.lasttargetpos,
			targetpos) then
			return true
		end
	end

	entity.dynamic_data.p_movement.lasttargetpos = targetpos

	entity.dynamic_data.p_movement.path = nil
	entity.dynamic_data.p_movement.next_path_index = 1

	--on target mode max distance is always 0.5
	entity.dynamic_data.movement.max_distance = 0.5

	--try to find path on our own
	if not mobf_get_world_setting("mobf_disable_pathfinding") then
		entity.dynamic_data.p_movement.path =
			minetest.find_path(current_pos,targetpos,5,1,1,nil)
	else
		entity.dynamic_data.p_movement.path = nil
	end

	if entity.dynamic_data.p_movement.path ~= nil then
		--a valid path has at least 2 positions
		mobf_assert_backtrace(#entity.dynamic_data.p_movement.path > 1)
		entity.dynamic_data.movement.target =
				entity.dynamic_data.p_movement.path[2]
		return true
	end


	if entity.dynamic_data.p_movement.path == nil then
		minetest.log(LOGLEVEL_INFO,
			"MOBF: no pathfinding support/ no path found directly setting targetpos as path")

		entity.dynamic_data.p_movement.path = {}

		table.insert(entity.dynamic_data.p_movement.path,targetpos)
		entity.dynamic_data.movement.target =
				entity.dynamic_data.p_movement.path[1]
		return true
	end

	return false
end

--register this movement generator
registerMovementGen(p_mov_gen.name,p_mov_gen)
