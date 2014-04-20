-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file mob_state.lua
--! @brief component mob state transition handling
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup mob_state State handling functions
--! @brief a component to do basic changes to mob on state change
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(mob_state == nil)
--! @class mob_state
--! @brief state handling class
--! @}
mob_state = {}
mob_state.default_state_time = 30

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] initialize(entity,now)
--
--! @brief initialize state dynamic data
--! @memberof mob_state
--! @public
--
--! @param entity elemet to initialize state data
--! @param now current time
-------------------------------------------------------------------------------
function mob_state.initialize(entity,now)

	dbg_mobf.mob_state_lvl3("MOBF: " .. entity.data.name
		.. " initializing state dynamic data")

	local state = {
		current = "default",
		time_to_next_change = 30,
		locked = false,
		enabled = false,
	}

	local sum_chances = 0
	local state_count = 0

	if entity.data.states ~= nil then
		for s = 1, #entity.data.states , 1 do
			sum_chances = sum_chances + entity.data.states[s].chance

			if entity.data.states[s].name ~= "combat" and
				entity.data.states[s].name ~= "default" then
				state_count = state_count +1
			end
		end
	end

	--sanity check for state chances
	if sum_chances > 1 then
		minetest.log(LOGLEVEL_WARNING,"MOBF: Warning sum of state chances for mob "
			.. entity.data.name .. " > 1")
	end

	--only enable state changeing if there is at least one state
	if state_count > 0 then
		state.enabled = true
	end

	entity.dynamic_data.state = state
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] get_state_by_name(entity,name)
--
--! @brief get a state by its name
--! @memberof mob_state
--! @public
--
--! @param entity elemet to look for state data
--! @param name of state
--!
--! @return state data or nil
-------------------------------------------------------------------------------
function mob_state.get_state_by_name(entity,name)
	mobf_assert_backtrace(entity ~= nil and entity.data ~= nil)

	for i=1, #entity.data.states, 1 do
		if entity.data.states[i].name == name then
			return entity.data.states[i]
		end
	end

	return nil
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] lock(entity,value)
--
--! @brief disable random state changes for a mob
--! @memberof mob_state
--! @public
--
--! @param entity elemet to lock
--! @param value to set
-------------------------------------------------------------------------------
function mob_state.lock(entity,value)
	if value ~= false and value ~= true then
		return
	end
	if entity.dynamic_data.state == nil then
		dbg_mobf.mob_state_lvl1("MOBF: unable to lock state for: "
			.. entity.data.name .. " no state dynamic data present")
		return
	end

	entity.dynamic_data.state.locked = value
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_state] callback(entity,now,dstep)
--
--! @brief callback handling state changes
--! @memberof mob_state
--! @public
--
--! @param entity elemet to look for state data
--! @param now current time
--! @param dstep time passed since last call
--
--! @return
-------------------------------------------------------------------------------
function mob_state.callback(entity,now,dstep)

--TODO find out if this needs to be replaced
--	if entity.dynamic_data.state == nil then
--		minetest.log(LOGLEVEL_ERRROR,"MOBF BUG: " .. entity.data.name
--			.. " mob state callback without mob dynamic data!")
--		mob_state.initialize(entity,now)
--		local default_state = mob_state.get_state_by_name(self,"default")
--		entity.dynamic_data.current_movement_gen = getMovementGen(default_state.movgen)
--		entity.dynamic_data.current_movement_gen.init_dynamic_data(entity,mobf_get_current_time())
--		entity = spawning.replace_entity(entity,entity.data.modname .. ":"..entity.data.name,true)
--		return true
--	end

	--abort state change if current state is locked
	if entity.dynamic_data.state.locked or
		entity.dynamic_data.state.enabled == false then
		dbg_mobf.mob_state_lvl3("MOBF: " .. entity.data.name
			.. " state locked or no custom states definded ")
		return true
	end

	entity.dynamic_data.state.time_to_next_change = entity.dynamic_data.state.time_to_next_change -dstep

	--do only change if last state timed out
	if entity.dynamic_data.state.time_to_next_change < 0 then

		dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
			.. " time to change state: " .. entity.dynamic_data.state.time_to_next_change
			.. " , " .. dstep .. " entity=" .. tostring(entity))

		local rand = math.random()

		local maxvalue = 0

		local state_table = {}

		--fill table with available states
		for i=1, #entity.data.states, 1 do
			if (entity.data.states[i].HANDLER_precondition == nil or
				entity.data.states[i].HANDLER_precondition(entity,entity.data.states[i])) and
				--ignore states that are not supposed to be switched to
				--by automatic state change handling e.g. fighting states or
				--manual set states
				( entity.data.states[i].state_mode == nil or
				  entity.data.states[i].state_mode == "auto") then
				table.insert(state_table,entity.data.states[i])
			end
		end

		dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name .. " "
			.. dump(#state_table) .. " states do pass pecondition check ")

		--try to get a random state to change to
		for i=1, #state_table, 1 do

			local rand_state = math.random(#state_table)
			local current_chance = 0

			if type (state_table[rand_state].chance) == "function" then
				current_chance = state_table[rand_state].chance(entity,now,dstep)
			else
				if state_table[rand_state].chance ~= nil then
					current_chance = state_table[rand_state].chance
				end
			end

			local random_value = math.random()

			if random_value < current_chance then
				dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
					.. " switching to state " .. state_table[rand_state].name)
				mob_state.change_state(entity,state_table[rand_state])
				return true
			else
				dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
					.. " not switching to state " .. state_table[rand_state].name
					.. " rand was: " .. random_value)
				table.remove(state_table,rand_state)
			end
		end
		dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
			.. " no specific state selected switching to default state ")
		--switch to default state (only reached if no change has been done
		mob_state.change_state(entity,mob_state.get_state_by_name(entity,"default"))
	else
		dbg_mobf.mob_state_lvl3("MOBF: " .. entity.data.name
			.. " is not ready for state change ")
		return true
	end

	return true
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] switch_switch_movgenentity(entity,state)
--
--! @brief helper function to swich a movement based on new state
--! @memberof mob_state
--! @private
--
--! @param entity to change movement gen
--! @param state to take new entity
-------------------------------------------------------------------------------
function mob_state.switch_movgen(entity,state)
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(state ~= nil)
	local mov_to_set = nil

	--determine new movement gen
	if state.movgen ~= nil then
		mov_to_set = getMovementGen(state.movgen)
	else
		local default_state = mob_state.get_state_by_name(entity,"default")
		mov_to_set = getMovementGen(default_state.movgen)
	end

	--check if new mov gen differs from old one
	if mov_to_set ~= nil and
		mov_to_set ~= entity.dynamic_data.current_movement_gen then
		entity.dynamic_data.current_movement_gen = mov_to_set

		--TODO initialize new movement gen
		entity.dynamic_data.current_movement_gen.init_dynamic_data(entity,mobf_get_current_time())
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_state] change_state(entity,state)
--
--! @brief change state for an entity
--! @memberof mob_state
--! @public
--
--! @param entity to change state
--! @param state to change to
-------------------------------------------------------------------------------
function mob_state.change_state(entity,state)

	dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
		.. " state change called entity=" .. tostring(entity) .. " state:"
		.. dump(state))

	--check if custom precondition handler tells us to stop state change
	if state ~= nil and
		type(state.HANDLER_precondition) == "function" then
		if not state.HANDLER_precondition(entity,state) then
			dbg_mobf.mob_state_lvl1("MOBF: " .. entity.data.name
				.. " custom precondition handler didn't meet ")
			--don't assert but switch to default in this case
			state = mob_state.get_state_by_name(entity,"default")
		end
	end

	--switch to default state if no state given
	if state == nil then
		dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
			.. " invalid state switch, switching to default instead of: "
			.. dump(state))
		state = mob_state.get_state_by_name(entity,"default")
	end

	local entityname = entity.data.name
	local statename = state.name

	dbg_mobf.mob_state_lvl2("MOBF: " .. entityname .. " switching state to "
		.. statename)

	if entity.dynamic_data.state == nil then
		mobf_bug_warning(LOGLEVEL_WARNING,"MOBF BUG!!! mob_state no state dynamic data")
	end

	if entity.dynamic_data.state.current.name ~= state.name then
		--call leave state handler for old state
		if entity.dynamic_data.state.current.HANDLER_leave_state ~= nil and
			type(entity.dynamic_data.state.current.HANDLER_leave_state) == "function" then
			entity.dynamic_data.state.current.HANDLER_leave_state(entity,state)
		end

		dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
			.. " different states now really changeing to " .. state.name)

		mob_state.switch_model(entity,state)
		mob_state.switch_movgen(entity,state)

		entity.dynamic_data.state.time_to_next_change =
			mob_state.getTimeToNextState(state.typical_state_time)
		entity.dynamic_data.state.current = state

		graphics.set_animation(entity,state.animation)

		if state.HANDLER_enter_state ~= nil and
			type(state.HANDLER_enter_state) == "function" then
			state.HANDLER_enter_state(entity)
		end
	else
		dbg_mobf.mob_state_lvl2("MOBF: " .. entity.data.name
			.. " switching to same state as before")
		entity.dynamic_data.state.time_to_next_change = mob_state.getTimeToNextState(state.typical_state_time)

		if state.HANDLER_enter_state ~= nil and
			type(state.HANDLER_enter_state) == "function" then
			state.HANDLER_enter_state(entity)
		end

	end

	dbg_mobf.mob_state_lvl2("MOBF:  time to next change = "
			.. entity.dynamic_data.state.time_to_next_change)
end


-------------------------------------------------------------------------------
-- @function [parent=#mob_state] getTimeToNextState(typical_state_time)
--
--! @brief helper function to calculate a gauss distributed random value
--! @memberof mob_state
--! @private
--
--! @param typical_state_time center of gauss
--!
--! @return a random value around typical_state_time
-------------------------------------------------------------------------------
function mob_state.getTimeToNextState(typical_state_time)

	if typical_state_time == nil then
		mobf_bug_warning(LOGLEVEL_WARNING,"MOBF MOB BUG!!! missing typical state time!")
		typical_state_time = mob_state.default_state_time
	end

	local u1 = 2 * math.random() -1
	local u2 = 2 * math.random() -1

	local q = u1*u1 + u2*u2

	local maxtries = 0

	while (q == 0 or q >= 1) and maxtries < 10 do
		u1 = math.random()
		u2 = math.random() * -1
		q = u1*u1 + u2*u2

		maxtries = maxtries +1
	end

	--abort random generation
	if maxtries >= 10 then
		return typical_state_time
	end

	local p = math.sqrt( (-2*math.log(q))/q )

	local retval = 2
	--calculate normalized state time with maximum error or half typical time up and down
	if math.random() < 0.5 then
		retval = typical_state_time + ( u1*p * (typical_state_time/2))
	else
		retval = typical_state_time + ( u2*p * (typical_state_time/2))
	end

	-- ensure minimum state time of 2 seconds
	if retval > 2 then
		return retval
	else
		return 2
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] prepare_states(mob)
--
--! @brief prepare mobs states upon registration
--! @memberof mob_state
--! @public
--
--! @param mob a mob declaration
-------------------------------------------------------------------------------
function mob_state.prepare_states(mob)
	local builtin_state_overrides = {}

	--scan for states overriding mobf internal state definitions
	if mob.states ~= nil then
		for s = 1, #mob.states , 1 do
			if mob.states[s].name == "combat" then
				builtin_state_overrides["combat"] = true
			end

			--TODO patrol state

			--hunger state
			if mob.states[s].name == "RSVD_hunger" then
				builtin_state_overrides["RSVD_hunger"] = true
			end

		end
	else
		mob.states = {}
	end

	--add a default combat state if no custom state is defined
	if mob.combat ~= nil and builtin_state_overrides["combat"] ~= true then
		table.insert(mob.states,
				{
				name = "combat",
				custom_preconhandler = nil,
				movgen = "follow_mov_gen",
				typical_state_time = -1,
				chance = 0,
				})
	end

	if mob.hunger ~= nil and builtin_state_overrides["RSVD_hunger"] ~= true then
		table.insert(mob.states,
					{
					name = "RSVD_hunger",
					HANDLER_precondition = mob_state.BuiltinHungerPrecondition(mob),
					HANDLER_leave_state  = mob_state.BuiltinHungerLeave(mob),
					HANDLER_enter_state  = mob_state.BuiltinHungerEnter(mob),
					movgen = "mgen_path",
					typical_state_time = mob.hunger.typical_walk_time or 45,
					chance             = mob.hunger.chance or 0.1,
					animation          = mob.hunger.animation or "walk"
				})
	end

end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] switch_model(entity,state)
--
--! @brief switch model used for a entity
--! @memberof mob_state
--! @public
--
--! @param entity to switch model
--! @param state to change to
-------------------------------------------------------------------------------
function mob_state.switch_model(entity,state)
	--TODO set object propertys to new model
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] BuiltinHungerPrecondition(mob)
--
--! @brief prepare builtin hunger precondition handler
--! @memberof mob_state
--! @public
--
--! @param mob definition of mob
--! @return function to be called as precondition handler
-------------------------------------------------------------------------------
function mob_state.BuiltinHungerPrecondition(mob)

	mobf_assert_backtrace(
		(mob.hunger.target_nodes ~= nil) or
		(mob.hunger.target_entities ~= nil))
	mobf_assert_backtrace(mob.hunger.range ~= nil)

	return function(entity,state)
			mobf_assert_backtrace(state ~= nil)
			mobf_assert_backtrace(state.name == "RSVD_hunger")

			local pos = entity.object:getpos()
			--mobf_print("MOBF: trying to find " ..
			--				dump(mob.hunger.target_nodes) .. " or " ..
			--				dump(mob.hunger.target_entities) ..
			--				" around: " .. printpos(pos))

			local lower_pos = {x=pos.x-mob.hunger.range,
								y=pos.y-mob.hunger.range,
								z=pos.z-mob.hunger.range}
			local upper_pos = {x=pos.x+mob.hunger.range,
								y=pos.y+mob.hunger.range,
								z=pos.z+mob.hunger.range}

			local target_nodes = nil
			local target_entities = nil

			if mob.hunger.target_nodes ~= nil then
				target_nodes = minetest.find_nodes_in_area(lower_pos,
											upper_pos,
											 mob.hunger.target_nodes)
			end

			if mob.hunger.target_entities ~= nil then
				local objectlist = minetest.get_objects_inside_radius(pos,mob.hunger.range)
				--mobf_print("MOBF: found: " .. #objectlist .. " objects around")
				if objectlist ~= nil and #objectlist > 0 then
					target_entities = {}
					for i=1,#objectlist,1 do
						local luaentity = objectlist[i]:get_luaentity()
						if luaentity ~= nil and
							mobf_contains(mob.hunger.target_entities,luaentity.name) then
							table.insert(target_entities,objectlist[i])
						end
					end
				end
			end

			local targets = {}

			if target_nodes ~= nil then
				for i=1,#target_nodes,1 do
					table.insert(targets,target_nodes[i])
				end
			end

			if target_entities ~= nil then
				for i=1,#target_entities,1 do
					table.insert(targets,target_entities[i])
				end
			end

			if targets ~= nil then
				dbg_mobf.mob_state_lvl3("MOBF: Hunger found " .. #targets .. " targets")
				for i=1,5,1 do
					if #targets == 0 then
						break
					end

					local index = math.floor(math.random(1,#targets) + 0.5)

					local target = targets[index]
					table.remove(targets,index)

					--target is a entity
					if type(target) == "userdata" then
						entity.dynamic_data.hunger = {}
						entity.dynamic_data.hunger.target = target
						--mobf_print("MOBF: saving hungerdata: " .. dump(entity.dynamic_data.hunger))
						return true
					else
						local targetpos = target
						targetpos.y = targetpos.y +1

						--if mob is not in air try 1 above for pathfinding
						local current_node = minetest.get_node(pos)
						if current_node ~= nil and
							current_node.name ~= "air" then
							pos.y = pos.y+1
						end

						local path = minetest.find_path(pos,targetpos,5,1,1,"A*_noprefetch")

						if path ~= nil then
							entity.dynamic_data.hunger = {}
							entity.dynamic_data.hunger.target = { x=targetpos.x,y=targetpos.y-1,z=targetpos.z}
							entity.dynamic_data.hunger.path = path
							--mobf_print("MOBF: Found new target: " .. printpos(targetpos) .. " Path: " .. dump(path))
							--mobf_print("MOBF: saving hungerdata: " .. dump(entity.dynamic_data.hunger))
							return true
						else
							dbg_mobf.mob_state_lvl2("MOBF: hunger no path to: " .. printpos(targetpos))
						end
					end
				end
			end
			return false
		end --end of handler
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] BuiltinHungerLeave(mob)
--
--! @brief prepare builtin hunger leave handler
--! @memberof mob_state
--! @public
--
--! @param mob definition of mob
--! @return function to be called as leave handler
-------------------------------------------------------------------------------
function mob_state.BuiltinHungerLeave(mob)

	return function(entity,state)
		--restore old stepheight
		entity.object:set_properties({stepheight=entity.dynamic_data.hunger.old_stepheight})
		entity.dynamic_data.hunger = nil
		p_mov_gen.set_cycle_path(entity,nil)
		p_mov_gen.set_path(entity,nil)
		p_mov_gen.set_end_of_path_handler(entity,nil)

	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] BuiltinHungerEnter(mob)
--
--! @brief prepare builtin hunger enter handler
--! @memberof mob_state
--! @public
--
--! @param mob definition of mob
--! @return function to be called as enter handler
-------------------------------------------------------------------------------
function mob_state.BuiltinHungerEnter(mob)

	return function(entity)
		mobf_assert_backtrace(entity.dynamic_data.state.current.name == "RSVD_hunger")
		mobf_assert_backtrace(entity.dynamic_data.hunger ~= nil)

		--use stepheight 1 as we did look for a path by using this
		entity.dynamic_data.hunger.old_stepheight = entity.stepheight

		if (type(entity.dynamic_data.hunger.target) == "userdata") then
			if not p_mov_gen.set_target(entity,entity.dynamic_data.hunger.target) then
				dbg_mobf.mob_state_lvl1("MOBF: EnterHungerState, failed to set target")
			end
		else
			entity.object:set_properties({stepheight=1})
			p_mov_gen.set_path(entity,entity.dynamic_data.hunger.path)
		end
		--p_mov_gen.set_cycle_path(entity,handler)
		p_mov_gen.set_cycle_path(entity,false)
		p_mov_gen.set_end_of_path_handler(entity,mob_state.BuiltinHungerTargetReached)

	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mob_state] BuiltinHungerTargetReached(entity)
--
--! @brief handle target reached
--! @memberof mob_state
--! @public
--
--! @param entity that reached the target
-------------------------------------------------------------------------------
function mob_state.BuiltinHungerTargetReached(entity)
	--consume original target
	if (entity.dynamic_data.hunger.target ~= nil) and
		(entity.data.hunger.keep_food == nil or
		entity.data.hunger.keep_food == false) then
		if type(entity.dynamic_data.hunger.target) ~= "userdata" then
			dbg_mobf.mob_state_lvl2("MOBF: consuming targetnode: " ..
				printpos(entity.dynamic_data.hunger.target))
			minetest.remove_node(entity.dynamic_data.hunger.target)
		else
			local targetentity = entity.dynamic_data.hunger.target:get_luaentity()

			if targetentity ~= nil and
				type(targetentity.mobf_hunger_interface) == "function" then
				targetentity.mobf_hunger_interface(entity,"HUNGER_CONSUME")
				dbg_mobf.mob_state_lvl2("MOBF: consuming targetentity")
			end
		end
	end

	local eating_state = mob_state.get_state_by_name(entity,"eating")

	if eating_state ~= nil then
		mob_state.change_state(entity,eating_state)
	else
		local default_state = mob_state.get_state_by_name(entity,"default")
		mob_state.change_state(entity,default_state)
	end
end