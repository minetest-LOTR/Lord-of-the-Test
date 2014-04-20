-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file attention.lua
--! @brief component for calculating attention of mobs
--! @copyright Sapier
--! @author Sapier
--! @date 2013-04-02
--
--! @defgroup attention attention subcomponent
--! @brief Component handling attention of a mob
--! @ingroup framework_int
--! @{
-- Contact: sapier a t gmx net
-------------------------------------------------------------------------------

--! @class attention

--!@}

mobf_assert_backtrace(attention == nil)
--! @brief attention handling class reference
--TODO rename to fix documentation issues
attention = {}

-------------------------------------------------------------------------------
-- @function [parent=#attention] aggression(entity)
--
--! @brief old agression handler to be used for legacy mobs
--! @memberof attention
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function attention.aggression(entity,now)

	--if no combat data is specified don't do anything
	if entity.data.combat == nil then
		return
	end

	local current_state = entity.dynamic_data.state.current

	--mob is specified as self attacking
	if entity.data.combat.starts_attack and
		entity.dynamic_data.combat.target == nil and
		current_state.state_mode ~= "combat" then
		dbg_mobf.fighting_lvl3("MOBF: ".. entity.data.name .. " " .. now
			.. " aggressive mob, is it time to attack?")
		if entity.dynamic_data.combat.ts_last_aggression_chance + 1 < now then
			dbg_mobf.fighting_lvl3("MOBF: ".. entity.data.name .. " " .. now
				.. " lazzy time over try to find an enemy")
			entity.dynamic_data.combat.ts_last_aggression_chance = now

			if  entity.data.combat.angryness ~= nil and
				math.random() < entity.data.combat.angryness then

				dbg_mobf.fighting_lvl3("MOBF: ".. entity.data.name .. " " .. now
					.. " really is angry")
				local target = fighting.get_target(entity)

				if target ~= nil then

					if target ~= entity.dynamic_data.combat.target then

						entity.dynamic_data.combat.target = target

						fighting.switch_to_combat_state(entity,now,target)

						local targetname = fighting.get_target_name(target)

						dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " "
									.. now .. " starting attack at player: "
									..targetname)
						minetest.log(LOGLEVEL_INFO,
								"MOBF: starting attack at player "..targetname)
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#attention] callback(entity)
--
--! @brief calculate attenntion level for mob mob
--! @memberof attention
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function attention.callback(entity,now)

	--do legacy code
	if entity.data.attention == nil then
		attention.aggression(entity,now)
		return
	end

	local top_attention_object = nil
	local top_attention_value = 0
	local top_attention_enemy = nil
	local top_attention_enemy_value = 0

	local current_attention_value = 0

	mobf_assert_backtrace(entity.dynamic_data.attention ~= nil)

	--set default values
	local reduction_value      = 0.1
	local attention_distance   = 5
	local target_switch_offset = 0.5

	if entity.data.attention.attention_distance ~= nil then
		attention_distance = entity.data.attention.attention_distance
	end

	if entity.data.attention.target_switch_offset ~= nil then
		target_switch_offset = entity.data.attention.target_switch_offset
	end

	--reduce attention level for all objects
	for k,v in pairs(entity.dynamic_data.attention.watched_objects) do
		if v.value > reduction_value then
			v.value = v.value - reduction_value
			dbg_mobf.attention_lvl3("MOBF: preserving " .. k ..
				" for watchlist new value: " .. v.value)
		else
			entity.dynamic_data.attention.watched_objects[k] = nil
			dbg_mobf.attention_lvl3("MOBF: removing " .. k .. " from watchlist")
		end
	end

	local new_objecttable = entity.dynamic_data.attention.watched_objects

	entity.dynamic_data.attention.watched_objects = new_objecttable
	local own_pos = entity.object:getpos()

	--get list of all objects in attention range
	local objectlist =
		minetest.get_objects_inside_radius(own_pos,attention_distance)

	if #objectlist > 0 then
		for i = 1 , #objectlist, 1 do
			local continue = true

			dbg_mobf.attention_lvl3("MOBF: checking " .. tostring(objectlist[i]))

			if not objectlist[i]:is_player() then
				local lua_entity = objectlist[i]:get_luaentity()

				if lua_entity ~= nil and
					not lua_entity.draws_attention then
					continue = false
				end
			end

			if continue then
				local remote_pos = objectlist[i]:getpos()

				local hear_addon = false
				local own_view_addon = false
				local remote_view_addon = false

				--is in audible distance
				if entity.data.attention.hear_distance ~= nil then
					local distance = mobf_calc_distance(own_pos,remote_pos)

					if distance < entity.data.attention.hear_distance then
						hear_addon = true
					end
				end

				--does own view angle matter
				if entity.data.attention.view_angle  ~= nil then
					local own_view = entity.object:getyaw()

					local min_yaw = own_view - entity.data.attention.view_angle/2
					local max_yaw = own_view + entity.data.attention.view_angle/2

					local direction = mobf_get_direction(own_pos,remote_pos)
					local yaw_to_target = mobf_calc_yaw(direction.x,direction.z)

					if yaw_to_target > min_yaw and
						yaw_to_target < max_yaw then

						own_view_addon = true
					end
				end

				--does remote view angle matter
				if entity.data.attention.remote_view == true then
					local remote_view = objectlist[i]:getyaw()

					if objectlist[i]:is_player() then
						remote_view = objectlist[i]:get_look_yaw()
					end

					if remote_view ~= nil then
						local direction = mobf_get_direction(own_pos,remote_pos)
						local yaw_to_target = mobf_calc_yaw(direction.x,direction.z)

						--TODO check for overflows
						if remote_view > yaw_to_target - (math.pi/2) and
							remote_view < yaw_to_target + (math.pi/2) then

							remote_view_addon = true
						end
					else
						dbg_mobf.attention_lvl2(
							"MOBF: unable to get yaw for obeject: "  ..table_id)
					end
				end

				--calculate new value

				local sum_values = 0;
				table_id = tostring(objectlist[i])

				if hear_addon then
					dbg_mobf.attention_lvl3("MOBF: " .. table_id .. " within hear distance")
					sum_values = sum_values + entity.data.attention.hear_distance_value
				end

				if own_view_addon then
					dbg_mobf.attention_lvl3("MOBF: " .. table_id .. " in view")
					sum_values = sum_values + entity.data.attention.own_view_value
				end

				if remote_view_addon then
					dbg_mobf.attention_lvl3("MOBF: " .. table_id .. " looks towards mob")
					sum_values = sum_values + entity.data.attention.remote_view_value
				end

				sum_values = sum_values + entity.data.attention.attention_distance_value

				if new_objecttable[table_id] == nil then
					dbg_mobf.attention_lvl3("MOBF: " .. table_id .. " unknown adding new entry")
					new_objecttable[table_id] = { value = 0 }
				end

				new_objecttable[table_id].value =
					new_objecttable[table_id].value + sum_values

				if entity.data.attention.attention_max ~= nil and
					new_objecttable[table_id].value > entity.data.attention.attention_max then
					new_objecttable[table_id].value = entity.data.attention.attention_max
				end

				dbg_mobf.attention_lvl3("MOBF: adding " .. sum_values ..
											" to " .. table_id ..
											" new value " ..
											new_objecttable[table_id].value)

				--update overall atttention values
				if new_objecttable[table_id].value > top_attention_value then
					top_attention_value = new_objecttable[table_id].value
					top_attention_object = objectlist[i]
				end

				--update value of old most relevant target only
				if objectlist[i] == entity.dynamic_data.attention.most_relevant_target then
					current_attention_value = new_objecttable[table_id].value
				end

				--update enemy attention values
				if new_objecttable[table_id].value > top_attention_enemy_value and
					attention.is_enemy(entity,objectlist[i]) then
					top_attention_enemy_value = new_objecttable[table_id].value
					top_attention_enemy = objectlist[i]
				end
			end
		end
	end

	--check if top attention exceeds current + offset
	if top_attention_value > current_attention_value + target_switch_offset then
		--update top attention object
		entity.dynamic_data.attention.most_relevant_target = top_attention_object
		current_attention_value = top_attention_value
	end
	dbg_mobf.attention_lvl3("MOBF: value=" .. current_attention_value .. " attack_threshold=" ..
		dump(entity.data.attention.attack_threshold) .. "watch_threshold= " ..
		dump(entity.data.attention.watch_threshold))

	local toattack = nil
	local attack_attention_value = nil

	if mobf_rtd.factions_available then
		if top_attention_enemy ~= nil then
			attack_attention_value	= top_attention_enemy_value
			toattack 				= top_attention_enemy
		end
		--don't attack anyone if factions mod is available and no enemy is found
	else
		attack_attention_value	= top_attention_value
		toattack				= top_attention_object
	end

	if entity.data.attention.attack_threshold ~= nil and
		attack_attention_value ~= nil and
		attack_attention_value > entity.data.attention.attack_threshold then

		local current_state = mob_state.get_state_by_name(entity,entity.dynamic_data.state.current)

		if entity.data.combat.starts_attack then
			dbg_mobf.attention_lvl3("MOBF: attack threshold exceeded starting attack of " ..
				dump(entity.dynamic_data.attention.most_relevant_target))
			entity.dynamic_data.attention.most_relevant_target = toattack
			current_attention_value = attack_attention_value
			fighting.set_target(entity,toattack)
		end
	else
		if entity.data.attention.watch_threshold ~= nil and
			current_attention_value > entity.data.attention.watch_threshold then
			if entity.data.attention.watch_callback ~= nil and
				type(entity.data.attention.watch_callback) == "function" then
					entity.data.attention.watch_callback(entity,
						entity.dynamic_data.attention.most_relevant_target)
				end
		end
	end

	entity.dynamic_data.attention.current_value = current_attention_value
end

-------------------------------------------------------------------------------
-- @function [parent=#attention] init_dynamic_data(entity)
--
--! @brief initialize all dynamic data on activate
--! @memberof attention
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function attention.init_dynamic_data(entity,now)
	local data = {
		watched_objects = {},
		most_relevant_target = nil,
		current_value = 0,
	}

	entity.dynamic_data.attention = data
end


-------------------------------------------------------------------------------
-- @function [parent=#attention] increase_attention_level(entity,source,value)
--
--! @brief initialize all dynamic data on activate
--! @memberof attention
--
--! @param entity mob to do action
--! @param source object causing this change
--! @param value amount of change
-------------------------------------------------------------------------------
function attention.increase_attention_level(entity,source,value)
	table_id = tostring(source)

	if entity.dynamic_data.attention ~= nil then

		if entity.dynamic_data.attention.watched_objects[table_id] == nil then
			entity.dynamic_data.attention.watched_objects[table_id] =  { value = 0 }
		end

		entity.dynamic_data.attention.watched_objects[table_id].value =
			entity.dynamic_data.attention.watched_objects[table_id].value + value

	end
end

-------------------------------------------------------------------------------
-- @function [parent=#attention] is_enemy(entity,object)
--
--! @brief initialize all dynamic data on activate
--! @memberof attention
--
--! @param entity mob to do action
--! @param object to check if it's an enemy
--! @return true/false
-------------------------------------------------------------------------------
function attention.is_enemy(entity,object)
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(object ~= nil)
	if mobf_rtd.factions_available then

		local remote_factions = factions.get_factions(object)

		if remote_factions == nil or
			#remote_factions < 1 then
			dbg_mobf.attention_lvl3("MOBF: no remote factions for: " .. tostring(object))
			return false
		end

		for j=1, #remote_factions, 1 do
			local rep = factions.get_reputation(remote_factions[j],entity)

			if rep < 0 then
				dbg_mobf.attention_lvl3("MOBF: ".. remote_factions[j] .. " " .. tostring(object) .. " is enemy: " .. rep)
				return true
			end
		end
	end

	return false
end