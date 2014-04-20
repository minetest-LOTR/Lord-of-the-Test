-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file data_storage.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2013-02-04
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup gen_func Generic functions
--! @brief functions for various tasks
--! @ingroup framework_int
--! @{
-------------------------------------------------------------------------------
-- name: mobf_global_data_store(value)
--
--! @brief save data and return unique identifier
--
--! @param value to save
--
--! @return unique identifier
-------------------------------------------------------------------------------
mobf_global_data_identifier = 0
mobf_global_data = {}
mobf_global_data.cleanup_index = 0
mobf_global_data.last_cleanup = mobf_get_current_time()
function mobf_global_data_store(value)

	local current_id = mobf_global_data_identifier
	
	mobf_global_data_identifier = mobf_global_data_identifier + 1
	
	mobf_global_data[current_id] = {
									value = value,
									added = mobf_get_current_time(),
									}
	return current_id
end


-------------------------------------------------------------------------------
-- name: mobf_global_data_store(value)
--
--! @brief pop data from global store
--
--! @param id to pop
--
--! @return stored value
-------------------------------------------------------------------------------
function mobf_global_data_get(id)

	local dataid = tonumber(id)

	if dataid == nil or 
		mobf_global_data[dataid] == nil then
		dbg_mobf.generic_lvl1("MOBF: data not found, id: " .. dump(dataid))
		return nil
	end

	local retval = mobf_global_data[dataid].value
	mobf_global_data[dataid] = nil
	return retval
end

-------------------------------------------------------------------------------
-- name: mobf_global_data_cleanup()
--
--! @brief periodic cleanup handler
--
-------------------------------------------------------------------------------
function mobf_global_data_cleanup()

	if mobf_global_data.last_cleanup + 500 < 
											mobf_get_current_time() then

		for i=1,50,1 do
			if mobf_global_data[mobf_global_data.cleanup_index] ~= nil then
				if mobf_global_data[mobf_global_data.cleanup_index].added < 
						mobf_get_current_time() - 300 then
						
					mobf_global_data[mobf_global_data.cleanup_index] = nil
				end
				mobf_global_data.cleanup_index = mobf_global_data.cleanup_index +1
				
				if mobf_global_data.cleanup_index > #mobf_global_data then
					mobf_global_data.cleanup_index = 0
					break
				end
			end
		end
		
		mobf_global_data.last_cleanup = mobf_get_current_time()
	end
end

--!@}