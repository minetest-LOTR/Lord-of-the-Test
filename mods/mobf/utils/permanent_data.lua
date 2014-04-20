-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file permanent_data.lua
--! @brief functions for storing required data permanently
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup perm_data Permanent data handling
--! @brief functions to deal with permanent data
--! @ingroup framework_int
--! @{

-------------------------------------------------------------------------------
-- name: mobf_deserialize_permanent_entity_data(datastring)
--
--! @brief parse datastring and return table of data
--
--! @param staticdata string to deserialize
--! @return table containing data
-------------------------------------------------------------------------------

function mobf_deserialize_permanent_entity_data(staticdata)

	--old style serialized static data
	local retval = {spawnpoint={x=0,y=0,z=0},playerspawned=false,original_spawntime=-1,state="default"}

	if staticdata == nil then
		return retval
	end

	local deserialized = minetest.deserialize(staticdata)

	if deserialized ~= nil and
		deserialized.version ~= nil then
		--mobf_print("DEBUG: deserialized -> " ..dump(deserialized))
		return deserialized
	end

	if staticdata ~= nil and
		staticdata ~= "" then
		local start_pos = 1
		local end_pos = string.find(staticdata,";")

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as first element")
			if string.sub(staticdata,start_pos,end_pos-1) == "true" then
				retval.playerspawned = true
			end
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as second element")
			retval.spawnpoint.x = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as third element")
			retval.spawnpoint.y = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as fourth element")
			retval.spawnpoint.z = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as fivth element")
			retval.original_spawntime = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as sixth element")
			retval.spawner = string.sub(staticdata,start_pos,end_pos-1)
			if retval.spawner == "" then
				retval.spawner = nil
			end
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as seventh element")
			retval.state = string.sub(staticdata,start_pos,end_pos-1)
			if retval.state == "" then
				retval.state = nil
			end
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as eigth element")
			retval.pathindex_raw = string.sub(staticdata,start_pos,end_pos-1)
			retval.pathindex = tonumber(retval.pathindex_raw)
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as nineth element")
			retval.pathowner = string.sub(staticdata,start_pos,end_pos-1)
			if retval.pathowner == "" then
				retval.pathowner = nil
			end
		else
			return retval
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_mobf.permanent_store_lvl1("MOBF: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as tenth element")
			retval.pathname = string.sub(staticdata,start_pos,end_pos-1)
			if retval.pathname == "" then
				retval.pathname = nil
			end
		else
			return retval
		end
	end

	return retval

end

-------------------------------------------------------------------------------
-- name: mobf_serialize_permanent_entity_data(entity)
--
--! @brief return string containing all entity data to be preserved
--
--! @param entity to get data from
--! @return string containing entitys permanent data
-------------------------------------------------------------------------------
function mobf_serialize_permanent_entity_data(entity)
	if entity.dynamic_data ~= nil and
			entity.dynamic_data.last_static_data ~= nil and
			entity.dynamic_data.last_static_data ~= "" then
			--mobf_print("MOBF: mob " .. entity.data.name .. "(" .. tostring(entity)
			--	.. ") wasn't even completely activated by now: " ..
			--	dump(entity.dynamic_data.last_static_data))
			return entity.dynamic_data.last_static_data
	end

	if entity.dynamic_data ~= nil and
		entity.dynamic_data.spawning ~= nil then

		local state = "default"
		if entity.dynamic_data.state ~= nil and
			entity.dynamic_data.state.current ~= nil then
			state = entity.dynamic_data.state.current.name
		end

		if entity.dynamic_data.spawning.original_spawntime == nil then
			entity.dynamic_data.spawning.original_spawntime = mobf_get_current_time()
			minetest.log(LOGLEVEL_WARNING,
				"MOBF: deactivating entity without spawntime setting current time")
		end

		local pathowner = ""
		local pathname  = ""
		local pathindex = ""

		if entity.dynamic_data.p_movement ~= nil then
			if entity.dynamic_data.p_movement.pathowner ~= nil then
				pathowner = entity.dynamic_data.p_movement.pathowner
			end

			if entity.dynamic_data.p_movement.pathname ~= nil then
				pathname = entity.dynamic_data.p_movement.pathname
			end

			if entity.dynamic_data.p_movement.next_path_index ~= nil then
				pathindex = "" .. entity.dynamic_data.p_movement.next_path_index
			end
		end

		local factions = mobf_factions.cleanupentity(entity)

		local toserialize = {
								spawnpoint = entity.dynamic_data.spawning.spawnpoint,
								playerspawned = entity.dynamic_data.spawning.player_spawned,
								original_spawntime = entity.dynamic_data.spawning.original_spawntime,
								spawner = entity.dynamic_data.spawning.spawner,
								version = 3,
								state = state,
								pathindex = pathindex,
								pathowner = pathowner,
								pathname = pathname,
								custom_persistent = entity.dynamic_data.custom_persistent,
								factions = factions,
							}
		local serialized = minetest.serialize(toserialize)
		--mobf_print("DEBUG: serialized -> " .. serialized)
		return serialized
	else
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: >" .. dump(entity.data.name) ..
			"< removed=" ..dump(entity.removed) .. " entity=" .. tostring(entity) ..
			" No spawning information available on saving mob")
	end

	return ""
end

--!@}
