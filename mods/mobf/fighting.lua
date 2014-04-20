-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file fighting.lua
--! @brief component for fighting related features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup fighting Combat subcomponent
--! @brief Component handling all fighting
--! @ingroup framework_int
--! @{
-- Contact: sapier a t gmx net
-------------------------------------------------------------------------------

--! @class fighting

--! @brief factor added to mob melee combat range to get its maximum agression radius
MOBF_AGRESSION_FACTOR = 5

--!@}

mobf_assert_backtrace(fighting == nil)
--! @brief fighting class reference
fighting = {}

--! @brief user defined on death callback
--! @memberof fighting
fighting.on_death_callbacks = {}

-------------------------------------------------------------------------------
-- @function [parent=#fighting] register_on_death_callback(callback)
--
--! @brief register an additional callback to be called on death of a mob
--! @memberof fighting
--
--! @param callback function to call
--! @return true/false
-------------------------------------------------------------------------------
function fighting.register_on_death_callback(callback)

	if type(callback) == "function" then

		table.insert(fighting.on_death_callbacks,callback)
		return true
	end
	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] do_on_death_callback(entity,hitter)
--
--! @brief call all registred on_death callbacks
--! @memberof fighting
--
--! @param entity to do callback for
--! @param hitter object doing last punch
-------------------------------------------------------------------------------
function fighting.do_on_death_callback(entity,hitter)

	for i,v in ipairs(fighting.on_death_callbacks) do
		v(entity.data.name,entity.getbasepos(),hitter)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] push_back(entity,player)
--
--! @brief move a mob backward if it's punched
--! @memberof fighting
--! @private
--
--! @param entity mobbeing punched
--! @param dir direction to push back
-------------------------------------------------------------------------------
function fighting.push_back(entity,dir)
	--get some base information
	local mob_pos     = entity.object:getpos()
	local mob_basepos = entity.getbasepos(entity)
	local dir_rad     = mobf_calc_yaw(dir.x,dir.z)
	local posdelta    = mobf_calc_vector_components(dir_rad,0.5)

	--push back mob
	local new_pos = {
		x=mob_basepos.x + posdelta.x,
		y=mob_basepos.y,
		z=mob_basepos.z + posdelta.z
		}

	local pos_valid = environment.possible_pos(entity,new_pos)
	new_pos.y = mob_pos.y
	local line_of_sight = mobf_line_of_sight(mob_pos,new_pos)

	dbg_mobf.fighting_lvl2("MOBF: trying to punch mob from " .. printpos(mob_pos)
		.. " to ".. printpos(new_pos))
	if 	pos_valid and line_of_sight then
		dbg_mobf.fighting_lvl2("MOBF: punching back ")
		entity.object:moveto(new_pos)
	else
		dbg_mobf.fighting_lvl2("MOBF: not punching mob: " .. dump(pos_valid) .. " " ..dump(line_of_sight))
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#fighting] hit(entity,attacker)
--
--! @brief handler for mob beeing hit
--! @memberof fighting
--
--! @param entity mob being hit
--! @param attacker player/object hitting the mob
-------------------------------------------------------------------------------
function fighting.hit(entity,attacker)
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(attacker ~= nil)

	--execute user defined on_hit_callback
	if entity.data.generic.on_hit_callback ~= nil and
			entity.data.generic.on_hit_callback(entity,attacker) == true
		then
		dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " custom on hit handler superseeds generic handling")
		return
	end

	--get some base information
	local mob_pos     = entity.object:getpos()
	local mob_basepos = entity.getbasepos(entity)
	local targetpos   = attacker:getpos()
	local dir         = mobf_get_direction(targetpos,mob_basepos)

	--play hit sound
	if entity.data.sound ~= nil then
		sound.play(mob_pos,entity.data.sound.hit);
	end

	--push mob back
	fighting.push_back(entity,dir)

	--update lifebar
	mobf_lifebar.set(entity.lifebar,entity.object:get_hp()/entity.hp_max)

	-- make it die
	if entity.object:get_hp() < 0.5 then

		mobf_lifebar.del(entity.lifebar)

	--if entity.dynamic_data.generic.health < 1 then
		local result = entity.data.generic.kill_result
		if type(entity.data.generic.kill_result) == "function" then
			result = entity.data.generic.kill_result()
		end


		--call on kill callback and superseed normal on kill handling
		if entity.data.generic.on_kill_callback == nil or
			entity.data.generic.on_kill_callback(entity,attacker) == false
			then

			if entity.data.sound ~= nil then
				sound.play(mob_pos,entity.data.sound.die);
			end

			if attacker:is_player() then
				if type(result) == "table" then
					for i=1,#result, 1 do
						if attacker:get_inventory():room_for_item("main", result[i]) then
							attacker:get_inventory():add_item("main", result[i])
						end
					end
				else
					if attacker:get_inventory():room_for_item("main", result) then
						attacker:get_inventory():add_item("main", result)
					end
				end
			else
				--todo check if spawning a stack is possible
				minetest.add_item(mob_pos,result)
			end
			mobf_lifebar.del(entity.lifebar)
			spawning.remove(entity, "killed")
		else
			dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name
				.. " custom on kill handler superseeds generic handling")
		end
		return
	end

	--don't attack spawner
	if entity.dynamic_data.spawning.spawner ~= nil and
		attacker:is_player() then
		local playername = attacker:get_player_name()
		if entity.dynamic_data.spawning.spawner == playername then
			if entity.dynamic_data.state.current ~= "combat" then
				local current_yaw = entity.object:getyaw()
				entity.object:setyaw(current_yaw + math.pi/4)
			end
			return
		end
	end

	--dbg_mobf.fighting_lvl2("MOBF: attack chance is ".. entity.data.combat.angryness)
	-- fight back
	if entity.data.combat ~= nil and
		(	entity.data.combat.can_fight or
			(entity.data.combat.angryness ~= nil and entity.data.combat.angryness > 0)

		) then

		--face attacker
		if entity.mode == "3d" then
			entity.object:setyaw(mobf_calc_yaw(dir.x,dir.z))
		else
			entity.object:setyaw(mobf_calc_yaw(dir.x,dir.z)-math.pi)
		end

		dbg_mobf.fighting_lvl2("MOBF: mob with chance of fighting back attacked")
		--either the mob hasn't been attacked by now or a new player joined fight

		if math.random() < entity.data.combat.angryness then
			fighting.set_target(entity,attacker)
		end
	else
		--make non agressive animals run away
		fighting.run_away(entity,dir,attacker)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] run_away(entity,dir_to_enemy,enemy)
--
--! @brief make a mob run away
--! @memberof fighting
--! @private
--
--! @param entity mob to run away
--! @param dir_to_enemy direction towards enemy
--! @param enemy the enemy to avoid
-------------------------------------------------------------------------------
function fighting.run_away(entity,dir_to_enemy,enemy)
	local flee_state = mob_state.get_state_by_name(entity,"flee")

	if flee_state == nil then
		local new_state = mob_state.get_state_by_name(entity,"walking")
		local dir_rad     = mobf_calc_yaw(dir_to_enemy.x,dir_to_enemy.z)
		local fleevelocity     = mobf_calc_vector_components(dir_rad,
										entity.data.movement.max_accel*2)

		local current_accel    = entity.object:getacceleration()
		local current_velocity = entity.object:getvelocity()

		mob_state.change_state(entity,new_state)

		entity.object:setvelocity({x=0,y=current_velocity.y,z=0})
		entity.object:setacceleration({
										x=fleevelocity.x,
										y=current_accel.y,
										z=fleevelocity.z}
									)
	else
		mob_state.change_state(entity,flee_state)
		entity.dynamic_data.current_movement_gen.set_target(entity,enemy)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] identify_combat_state(entity,target,distance)
--
--! @brief identify combat state to use
--! @memberof fighting
--! @private
--
--! @param entity mob to find state for
--! @param distance distance to target
--
--! @return state to use
-------------------------------------------------------------------------------
function fighting.identify_combat_state(entity,distance)

	local target = entity.dynamic_data.combat.target
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(target ~= nil)

	local combat_melee    = mob_state.get_state_by_name(entity,"combat_melee")
	local combat_distance = mob_state.get_state_by_name(entity,"combat_distance")
	local combat_generic  = mob_state.get_state_by_name(entity,"combat")

	if distance == nil then
		local mob_pos    = entity.object:getpos()
		local targetpos  = target:getpos()
		distance   = mobf_calc_distance(mob_pos,targetpos)
	end

	dbg_mobf.fighting_lvl2("MOBF: Identify combat state, mob: " .. entity.data.name .. " distance: " .. distance)

	if combat_melee ~= nil and
		distance < entity.data.combat.melee.range then
		return combat_melee
	end

	if combat_distance and
		entity.data.combat.distance ~= nil and
		distance < entity.data.combat.distance.range and
		(entity.data.combat.distance.min_range == nil or
		distance > entity.data.combat.distance.min_range) then

		-- distance within mele range
		return combat_distance
	end

	return combat_generic
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] switch_to_combat_state(entity,now,target)
--
--! @brief switch to combat state
--! @memberof fighting
--! @private
--
--! @param entity mob to switch state
--! @param now current time in seconds
--! @param target the target to attack
-------------------------------------------------------------------------------
function fighting.switch_to_combat_state(entity,now,target)

	mobf_assert_backtrace(entity ~= nil)

	--precheck
	if target == nil then
		dbg_mobf.fighting_lvl2("MOBF: no target for combat state change specified")
		return
	end

	--set attack target
	entity.dynamic_data.combat.target = target

	local current_state = entity.dynamic_data.state.current

	mobf_assert_backtrace(current_state.state_mode ~= "combat")

	local combat_state = fighting.identify_combat_state(entity)
	if combat_state == nil then
		dbg_mobf.fighting_lvl2("MOBF: no special combat state")
		return
	end

	dbg_mobf.fighting_lvl2("MOBF: switching to combat state")

	--make sure state is locked
	mob_state.lock(entity,true)

	--backup dynamic movement data
	local backup = {}
	backup.movement   = entity.dynamic_data.movement
	backup.p_movement = entity.dynamic_data.p_movement

	--create new movement data
	entity.dynamic_data.movement = {}
	entity.dynamic_data.p_movement = {}

	backup.current_state = entity.dynamic_data.state.current
	dbg_mobf.fighting_lvl2("MOBF: backing up state: " .. backup.current_state.name)

	--switch state
	mob_state.change_state(entity,combat_state)

	--save old movement data to use on switching back
	entity.dynamic_data.combat.movement_backup = backup

	--make sure a fighting mob ain't teleporting to target
	entity.dynamic_data.movement.teleportsupport = false

	--make sure we do follow our target
	entity.dynamic_data.movement.guardspawnpoint = false

	--set target
	entity.dynamic_data.current_movement_gen.set_target(entity,target)
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] restore_previous_state(entity,now)
--
--! @brief restore default movement generator of mob
--! @memberof fighting
--! @private
--
--! @param entity mob to restore movement generator
--! @param now current time in seconds
-------------------------------------------------------------------------------
function fighting.restore_previous_state(entity,now)

	--check if ther is anything we can restore
	if entity.dynamic_data.combat.movement_backup ~= nil then
		local backup = entity.dynamic_data.combat.movement_backup

		mobf_assert_backtrace(backup.current_state ~= "combat")

		if backup.current_state ~= nil then
			dbg_mobf.fighting_lvl2("MOBF: restore state: " .. backup.current_state.name)
			mob_state.change_state(entity,backup.current_state)
		else
			minetest.log(LOGLEVEL_WARNING,"MOBF: unable to restore previous state switching to default")
			mob_state.change_state(entity,mob_state.get_state_by_name(entity,"default"))
		end

		backup.current_state = nil

		--restore old movement data
		entity.dynamic_data.movement = backup.movement
		entity.dynamic_data.p_movement = backup.p_movement

		--don't restore old movement target if not valid anymore
		if entity.dynamic_data.movement.target == nil or
			(not mobf_is_pos(entity.dynamic_data.movement.target) and
			entity.dynamic_data.movement.target:getpos() == nil) then
			entity.dynamic_data.movement.target = nil
		end

		--make sure all remaining data is deleted
		entity.dynamic_data.combat.movement_backup = nil
	end

	--make sure state is unlocked
	mob_state.lock(entity,false)
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] in_range(entity,now)
--
--! @brief check if mob is within range of target
--! @memberof fighting
--! @private
--
--! @param entity mob
--! @param distance to target
-------------------------------------------------------------------------------
function fighting.in_range(entity,distance)
	if (entity.data.combat.melee == nil or
		distance > entity.data.combat.melee.range) and
		(entity.data.combat.distance == nil or
		distance > entity.data.combat.distance.range) then

		if entity.data.combat.melee ~= nil or
			entity.data.combat.distance ~= nil then
			dbg_mobf.fighting_lvl2("MOBF: distance="..distance)

			if entity.data.combat.melee ~= nil then
				dbg_mobf.fighting_lvl2("MOBF: melee="..entity.data.combat.melee.range)
			end
			if  entity.data.combat.distance ~= nil then
				dbg_mobf.fighting_lvl2("MOBF: distance="..entity.data.combat.distance.range)
			end
		end
		return false
	end

	return true
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] combat(entity,now)
--
--! @brief periodic callback called to do mobs own combat related actions
--! @memberof fighting
--
--! @param entity mob to do action
--! @param now current time
--! @param dtime time fraction since last call
--
--! @return continue callback execution or not
-------------------------------------------------------------------------------
function fighting.combat(entity,now,dtime)

	--handle self destruct mobs
	if fighting.self_destruct_handler(entity,now) then
		return false
	end

	if entity.dynamic_data.combat ~= nil and
		entity.dynamic_data.combat.target ~= nil then

		--check if target is still valid
		if not entity.dynamic_data.combat.target:is_player() then
			local target_entity = entity.dynamic_data.combat.target:get_luaentity()
			local target_pos    = entity.dynamic_data.combat.target:getpos()

			--print("MOBF: target is not player checking if stil valid: "
			--		.. dump(target_entity) .. " " .. dump(target_pos))

			if target_entity == nil or
				target_entity.data == nil or
				target_pos == nil then

				-- switch back to default movement gen
				fighting.restore_previous_state(entity,now)

				--there is no player by that name, stop attack
				entity.dynamic_data.combat.target = nil

				dbg_mobf.fighting_lvl1("MOBF: not a valid target: "
					.. dump(entity.dynamic_data.combat.target))
				return true
			end
		end

		local  targetname =
			fighting.get_target_name(entity.dynamic_data.combat.target)


		dbg_mobf.fighting_lvl1("MOBF: attacking player: "
											..targetname)


		--calculate some basic data
		local mob_pos    = entity.object:getpos()
		local targetpos  = entity.dynamic_data.combat.target:getpos()
		local distance   = mobf_calc_distance(mob_pos,targetpos)
		local dir        = mobf_get_direction(targetpos,mob_pos)
		local target     = entity.dynamic_data.combat.target

		--look towards target
		if entity.mode == "3d" then
			entity.object:setyaw(mobf_calc_yaw(dir.x,dir.z)+math.pi)
		else
			entity.object:setyaw(mobf_calc_yaw(dir.x,dir.z)-math.pi)
		end

		--initiate self destruct
		fighting.self_destruct_trigger(entity,distance,now)

		local range = entity.data.combat.melee.range * MOBF_AGRESSION_FACTOR

		if entity.data.combat.distance ~= nil and
			entity.data.combat.distance.range > range then
			range = entity.data.combat.distance.range
		end

		--find out if attacker is next to mob
		if distance > range then
			dbg_mobf.fighting_lvl2("MOBF: " .. entity.data.name .. " player >"
				.. targetname .. "< to far away " .. distance .. " > "
				.. range
				.. " stopping attack")

			--switch back to default movement gen
			fighting.restore_previous_state(entity,now)

			--there is no player by that name, stop attack
			entity.dynamic_data.combat.target = nil
			return true
		end

		--check if state needs to be switched
		local required_state = fighting.identify_combat_state(entity,distance)

		if required_state ~= nil and
			required_state.name ~= entity.dynamic_data.state.current then
			mob_state.change_state(entity,required_state)

			--reset current attack target as movement target after state switch
			entity.dynamic_data.current_movement_gen.set_target(entity,target)
		end

		--is mob near enough for any attack attack?
		if not fighting.in_range(entity,distance) then
			if entity.dynamic_data.combat.reset_path_counter > 1.5 then
				entity.dynamic_data.current_movement_gen.set_target(entity,target)
				entity.dynamic_data.combat.reset_path_counter = 0
			end
			entity.dynamic_data.combat.reset_path_counter =
				entity.dynamic_data.combat.reset_path_counter + dtime
			return true
		end

		--check if melee attack can be done
		if fighting.melee_attack_handler(entity,now,distance) == false then
			--check if distance attack can be done
			if fighting.distance_attack_handler(entity,
											targetpos,mob_pos,now,distance) then

				-- mob did an attack so give chance to stop attack
				local rand_value = math.random()

				if  entity.data.combat.angryness ~= nil and
					rand_value > entity.data.combat.angryness then
					dbg_mobf.fighting_lvl2("MOBF: rand=".. rand_value
						.. " angryness=" .. entity.data.combat.angryness)
					dbg_mobf.fighting_lvl2("MOBF: " .. entity.data.name .. " "
						.. now .. " random aborting attack at "
						..targetname)
					-- switch back to default movement gen
					fighting.restore_previous_state(entity,now)
					entity.dynamic_data.combat.target = nil
				end
			end
		end
	end

	--fight against generic enemy "sun"
	if fighting.sun_damage_handler(entity,now) then
		return false
	end

	return true
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] get_target(entity)
--
--! @brief find and possible target next to mob
--! @memberof fighting
--! @private
--
--! @param entity mob to look around
--! @return target
-------------------------------------------------------------------------------
function fighting.get_target(entity)

	local possible_targets = {}

	if entity.data.combat.melee.range > 0 then

		local range = entity.data.combat.melee.range*MOBF_AGRESSION_FACTOR

		if entity.data.combat.distance ~= nil and
			entity.data.combat.distance.range > range then
			range = entity.data.combat.distance.range
		end

		local objectlist = minetest.get_objects_inside_radius(
												entity.object:getpos(),range)

		local count = 0

		for i,v in ipairs(objectlist) do

			if v:is_player() then
				local playername = v:get_player_name()

				--don't attack spawner
				if entity.dynamic_data.spawning.spawner == nil or
					entity.dynamic_data.spawning.spawner ~= playername then
						count = count + 1
						table.insert(possible_targets,v)
						dbg_mobf.fighting_lvl2("MOBF: " .. playername ..
							" is next to a mob of type ".. entity.data.name)
				else
					dbg_mobf.fighting_lvl2("MOBF: " .. entity.data.name ..
							" not attacking: " .. playername .. " is spawner")
				end
			else
				if entity.data.combat.attack_hostile_mobs then
					dbg_mobf.fighting_lvl2("MOBF: " .. entity.data.name ..
							" trying to attack hostile mobs too")

					local target_entity = v:get_luaentity()
					if	target_entity ~= nil then
						local same_origin_protection = false

						if mobf_rtd.factions_available then
							same_origin_protection = not attention.is_enemy(entity,v)
						elseif target_entity.dynamic_data ~= nil and
							target_entity.dynamic_data.spawning ~= nil then

							same_origin_protection =
								target_entity.dynamic_data.spawning.spawner ==
										entity.dynamic_data.spawning.spawner
						end

						if	target_entity ~= entity and
							target_entity.data ~= nil and
							target_entity.data.combat ~= nil and
							target_entity.data.combat.starts_attack and
							not same_origin_protection then

							table.insert(possible_targets,v)
							dbg_mobf.fighting_lvl3(target_entity.data.name
								.. " is next to a mob of type "
								.. entity.data.name)
						end
					end
				end
			end
		end
		dbg_mobf.fighting_lvl2("MOBF: found ".. count .. " objects within" ..
										" attack range of " .. entity.data.name)
	end


	local targets_within_sight = {}

	for i,v in ipairs(possible_targets) do

		local entity_pos = entity.object:getpos()
		local target_pos = v:getpos()

		--is there a line of sight between mob and possible target
		--line of sight is calculated 1block above ground
		if mobf_line_of_sight({x=entity_pos.x,y=entity_pos.y+1,z=entity_pos.z},
					 {x=target_pos.x,y=target_pos.y+1,z=target_pos.z}) then

			table.insert(targets_within_sight,v)
		end

	end

	local nearest_target = nil
	local min_distance = -1

	for i,v in ipairs(targets_within_sight) do

		local distance = mobf_calc_distance(entity.object:getpos(),v:getpos())

		if min_distance < 0 or
			distance < min_distance then

			nearest_target = v
			min_distance = distance
		end

	end

	return nearest_target

end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] self_destruct_trigger(entity,distance)
--
--! @brief handle self destruct features
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param distance current distance to target
--! @param now current time
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.self_destruct_trigger(entity,distance,now)
	if entity.data.combat ~= nil and
		entity.data.combat.self_destruct ~= nil then

		dbg_mobf.fighting_lvl1("MOBF: checking for self destruct trigger " ..
						distance .. " " ..
						entity.dynamic_data.combat.ts_self_destruct_triggered ..
						" " .. now)

		--trigger self destruct
		if distance <= entity.data.combat.self_destruct.range and
			entity.dynamic_data.combat.ts_self_destruct_triggered == -1 then
			dbg_mobf.fighting_lvl2("MOBF: self destruct triggered")
			entity.dynamic_data.combat.ts_self_destruct_triggered = now
		end
	end
end
-------------------------------------------------------------------------------
-- @function [parent=#fighting] self_destruct_handler(entity)
--
--! @brief handle self destruct features
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param now current time
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.self_destruct_handler(entity,now)
	--self destructing mob?
	if entity.data.combat ~= nil and
		entity.data.combat.self_destruct ~= nil then

		local pos = entity.object:getpos()

		dbg_mobf.fighting_lvl1("MOBF: checking for self destruct imminent")
		--do self destruct
		if 	entity.dynamic_data.combat.ts_self_destruct_triggered > 0 and
			entity.dynamic_data.combat.ts_self_destruct_triggered +
			entity.data.combat.self_destruct.delay
			<= now then

			dbg_mobf.fighting_lvl2("MOBF: executing self destruct")

			if entity.data.sound ~= nil then
				sound.play(pos,entity.data.sound.self_destruct);
			end

			mobf_do_area_damage(pos,nil,
									entity.data.combat.self_destruct.damage,
									entity.data.combat.self_destruct.range)

			--TODO determine block removal by damage and remove blocks
			mobf_do_node_damage(pos,{},
							entity.data.combat.self_destruct.node_damage_range,
							1 - 1/entity.data.combat.self_destruct.node_damage_range)

			if mobf_rtd.fire_enabled then
				--Add fire
				for i=pos.x-entity.data.combat.self_destruct.range/2,
						pos.x+entity.data.combat.self_destruct.range/2, 1 do
				for j=pos.y-entity.data.combat.self_destruct.range/2,
						pos.y+entity.data.combat.self_destruct.range/2, 1 do
				for k=pos.z-entity.data.combat.self_destruct.range/2,
						pos.z+entity.data.combat.self_destruct.range/2, 1 do

					local current = minetest.get_node({x=i,y=j,z=k})

					if (current.name == "air") then
						minetest.set_node({x=i,y=j,z=k},
											{name="fire:basic_flame"})
					end

				end
				end
				end
			else
				minetest.log(LOGLEVEL_NOTICE,
					"MOBF: self destruct without fire isn't really impressive!")
			end
			mobf_lifebar.del(entity.lifebar)
			spawning.remove(entity, "self destruct")
			return true
		end
	end
	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] melee_attack_handler(entity,now)
--
--! @brief handle melee attack
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param now current time
--! @param distance distance to player
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.melee_attack_handler(entity,now,distance)

	if entity.data.combat.melee == nil then
		dbg_mobf.fighting_lvl2("MOBF: no meele attack specified")
		return false
	end

	local time_of_next_attack_chance = entity.dynamic_data.combat.ts_last_attack
											+ entity.data.combat.melee.speed
	--check if mob is ready to attack
	if now <  time_of_next_attack_chance then
		dbg_mobf.fighting_lvl1("MOBF: to early for meele attack " ..
								now .. " >= " .. time_of_next_attack_chance)
		return false
	end

	mobf_assert_backtrace( entity.dynamic_data.combat.target ~= nil)
	local ownpos = entity.object:getpos()
	local target_obj = entity.dynamic_data.combat.target.object

	if target_obj == nil then
		target_obj = entity.dynamic_data.combat.target
	end

	if distance <= entity.data.combat.melee.range
		and mobf_line_of_sight(ownpos,target_obj:getpos()) then

		--save time of attack
		entity.dynamic_data.combat.ts_last_attack = now

		if entity.data.sound ~= nil then
			sound.play(entity.object:getpos(),entity.data.sound.melee);
		end

		--calculate damage to be done
		local damage_done =
			math.floor(math.random(0,entity.data.combat.melee.maxdamage)) + 1

		--TODO call punch instead of manually setting health for player too
		if target_obj:is_player() then
			local target_health = target_obj:get_hp()

			--do damage
			target_obj:set_hp(target_health -damage_done)
		else
			target_obj:punch(entity.object, 1.0, {
							full_punch_interval=1.0,
							groupcaps={
								fleshy={times={	[1]=1/(damage_done-2),
												[2]=1/(damage_done-1),
												[3]=1/damage_done}},
								snappy={times={	[1]=1/(damage_done-2),
												[2]=1/(damage_done-1),
												[3]=1/damage_done}},
							}
						}, nil)
		end

		dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name ..
							" doing melee attack damage=" .. damage_done)

		return true
	end
	dbg_mobf.fighting_lvl1("MOBF: not within meele range " ..
							distance .. " > " .. entity.data.combat.melee.range)
	return false
end


-------------------------------------------------------------------------------
-- @function [parent=#fighting] distance_attack_handler(entity,now)
--
--! @brief handle distance attack
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param targetpos position of target
--! @param mob_pos position of mob
--! @param now current time
--! @param distance distance between target and player
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.distance_attack_handler(entity,targetpos,mob_pos,now,distance)
		if 	entity.data.combat.distance == nil then
			dbg_mobf.fighting_lvl2("MOBF: no distance attack specified")
			return false
		end

		local time_of_next_attack_chance = entity.dynamic_data.combat.ts_last_attack
											+ entity.data.combat.distance.speed

		--check if mob is ready to attack
		if 	now < time_of_next_attack_chance then
			dbg_mobf.fighting_lvl1("MOBF: to early for distance attack " ..
									now .. " >= " .. time_of_next_attack_chance)
			return false
		end

		if	distance <= entity.data.combat.distance.range and
			(entity.data.combat.distance.min_range == nil or
			distance > entity.data.combat.distance.min_range)
			then

			dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name ..
											" doing distance attack")

			--save time of attack
			entity.dynamic_data.combat.ts_last_attack = now

			local dir = mobf_get_direction({	x=mob_pos.x,
												y=mob_pos.y+1,
												z=mob_pos.z
												},
												targetpos)

			if entity.data.sound ~= nil then
				sound.play(mob_pos,entity.data.sound.distance);
			end

			local newobject=minetest.add_entity({	x=mob_pos.x+dir.x,
														y=mob_pos.y+dir.y+1,
														z=mob_pos.z+dir.z
														},
														entity.data.combat.distance.attack
														)

			local thrown_entity = mobf_find_entity(newobject)

			if thrown_entity ~= nil then
				local vel_thrown = {
									x=dir.x*thrown_entity.velocity + math.random(0,0.05),
									y=dir.y*thrown_entity.velocity,
									z=dir.z*thrown_entity.velocity + math.random(0,0.05),
									}

				if entity.data.combat.distance.balistic == true then
					--this isn't an exact calculation but just something to make
					--it not too perfect
					local height_diff = targetpos.y - mob_pos.y
					local current_scalar_speed =
						mobf_calc_scalar_speed(vel_thrown.x,vel_thrown.z)
					local time_to_target = (distance/current_scalar_speed)

					local y_vel = mobf_balistic_start_speed(
											height_diff -1,
											time_to_target,
											-thrown_entity.gravity)

					vel_thrown.y = y_vel + math.random(0,0.25)
				end

				dbg_mobf.fighting_lvl2("MOBF: throwing with velocity: " ..
															printpos(vel_thrown))

				newobject:setvelocity(vel_thrown)

				newobject:setacceleration({x=0, y=-thrown_entity.gravity, z=0})
				thrown_entity.owner = entity.object

				if entity.data.sound ~= nil then
					sound.play(mob_pos,entity.data.sound.shoot_distance);
				end

				dbg_mobf.fighting_lvl2("MOBF: distance attack issued")
			else
				minetest.log(LOGLEVEL_ERROR,
							"MOBF: unable to find entity for distance attack")
			end
			return true
		end
		dbg_mobf.fighting_lvl1("MOBF: not within distance range " ..
								distance .. " > " ..
								entity.data.combat.distance.range)
		return false
end


-------------------------------------------------------------------------------
-- @function [parent=#fighting] sun_damage_handler(entity,now)
--
--! @brief handle damage done by sun
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param now current time
--
--! @return true/false if killed or not
-------------------------------------------------------------------------------
function fighting.sun_damage_handler(entity,now)
	if entity.data.combat ~= nil and
		entity.data.combat.sun_sensitive then
		mobf_assert_backtrace(entity.dynamic_data.combat ~= nil)

		local pos = entity.object:getpos()
		local current_state = entity.dynamic_data.state.current
		local current_light = minetest.get_node_light(pos)

		if current_light == nil then
			mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: Bug!!! didn't get a light value for "
				.. printpos(pos))
			return false
		end
		--check if mob is in sunlight
		if ( current_light > LIGHT_MAX) then
			dbg_mobf.fighting_lvl1("MOBF: " .. entity.data.name ..
										" health at start:" .. entity.object:get_hp())

			if current_state.animation ~= nil and
				entity.data.animation ~= nil and
				entity.data.animation[current_state.animation .. "__burning"] ~= nil then
				graphics.set_animation(entity,current_state.animation .. "burning")
			else
				graphics.set_animation(entity,"burning")
			end


			if entity.dynamic_data.combat.ts_last_sun_damage +1 < now then
				local damage = (1 + math.floor(entity.data.generic.base_health/15))
				dbg_mobf.fighting_lvl1("Mob ".. entity.data.name .. " takes "
					..damage .." damage because of sun")

				entity.object:set_hp(entity.object:get_hp() - damage)
				mobf_lifebar.set(entity.lifebar,entity.object:get_hp()/entity.hp_max)

				if entity.data.sound ~= nil then
					sound.play(mob_pos,entity.data.sound.sun_damage);
				end

				if entity.object:get_hp() <= 0 then
				--if entity.dynamic_data.generic.health <= 0 then
					dbg_mobf.fighting_lvl2("Mob ".. entity.data.name .. " died of sun")
					mobf_lifebar.del(entity.lifebar)
					spawning.remove(entity,"died by sun")
					return true
				end
				entity.dynamic_data.combat.ts_last_sun_damage = now
			end
		else
			--use last sun damage to avoid setting animation over and over
			--even if nothing changed
			if entity.dynamic_data.combat.ts_last_sun_damage ~= -1 and
				current_state.animation ~= nil then
				graphics.set_animation(entity,current_state.animation)
				entity.dynamic_data.combat.ts_last_sun_damage = -1
			end
		end
	end

	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] get_target_name(target)
--
--! @brief get name of target
--! @memberof fighting
--! @private
--
--! @param target to get name for
--
--! @return name of target
-------------------------------------------------------------------------------
function fighting.get_target_name(target)
	if target == nil then
		return "invalid"
	end

	if target:is_player() then
		return target:get_player_name()
	else
		local target_entity = target:get_luaentity()
		if target_entity ~= nil and
			target_entity.data ~= nil and
			target_entity.data.name ~= nil then
			return "MOB: " .. target_entity.data.name
		end
	end

	return "unknown"
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] set_target(entity,target)
--
--! @brief decide if only switching target or state
--! @memberof fighting
--! @public
--
--! @param entity entity to update
--! @param target to set
-------------------------------------------------------------------------------
function fighting.set_target(entity,target)

	mobf_assert_backtrace(entity.dynamic_data ~= nil)

	if not fighting.is_valid_target(target) then
		return
	end

	if entity.dynamic_data.combat.target ~= nil then
		dbg_mobf.fighting_lvl2("MOBF: switching attack target")

		--set movement target
		entity.dynamic_data.current_movement_gen.set_target(entity,target)

		--set attack target
		entity.dynamic_data.combat.target = target
	else
		if entity.dynamic_data.combat.target ~= target then

			local attackername = fighting.get_target_name(target)
			dbg_mobf.fighting_lvl2("MOBF: initial attack at: ".. attackername)

			if entity.dynamic_data.combat.target == nil then
				fighting.switch_to_combat_state(entity,mobf_get_current_time(),target)
			end

		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] is_valid_target(target)
--
--! @brief check if a target is a valid target
--! @memberof fighting
--! @public
--
--! @param target to set
-------------------------------------------------------------------------------
function fighting.is_valid_target(target)

	--remove target case
	if target == nil then
		return true
	end

	--valid if it's a player
	if target:is_player() then
		return true
	end

	--valid if it's a lua entity
	if target:get_luaentity() ~= nil then
		return true
	end

	--invalid any other case
	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#fighting] fighting.init_dynamic_data(entity)
--
--! @brief initialize all dynamic data on activate
--! @memberof fighting
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function fighting.init_dynamic_data(entity,now)
	local data = {
		ts_last_sun_damage			= now,
		ts_last_attack				= now,
		ts_last_aggression_chance 	= now,
		ts_self_destruct_triggered	= -1,

		target						= nil,
		reset_path_counter			= 0,
	}

	entity.dynamic_data.combat = data
end
