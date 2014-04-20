-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file step_quota.lua
--! @brief class containing mobf step quota handling
--! @copyright Sapier
--! @author Sapier
--! @date 2013-11-30
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(mobf_step_quota == nil)

--! @class mobf_step_quota
--! @brief step_quota handling
mobf_step_quota = {}


------------------------------------------------------------------------------
-- @function [parent=#mobf_step_quota] is_exceeded
--
--! @brief check if quota is exceeded
--! @memberof mobf_step_quota
--! @public
--
--! @return true == exceeded false == not exceeded
-------------------------------------------------------------------------------
function mobf_step_quota.is_exceeded()
	return mobf_step_quota.remaining_quota <= 0
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_step_quota] remaining()
--
--! @brief get remaining time this quota
--! @memberof mobf_step_quota
--! @public
--
--! @return time left
-------------------------------------------------------------------------------
function mobf_step_quota.remaining()
	if mobf_step_quota.remaining_quota >= 0 then
		return mobf_step_quota.remaining_quota
	else
		return 0
	end
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_step_quota] initialize()
--
--! @brief initialize quota handling
--! @memberof mobf_step_quota
--! @public
--
-------------------------------------------------------------------------------
function mobf_step_quota.initialize()
	--todo add setting
	mobf_step_quota.reload_value = 50
	minetest.register_globalstep(mobf_step_quota.reload)
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_step_quota] reload()
--
--! @brief reload current quota
--! @memberof mobf_step_quota
--! @public
--
-------------------------------------------------------------------------------
function mobf_step_quota.reload()
	mobf_step_quota.remaining_quota = mobf_step_quota.reload_value
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_step_quota] cosume(starttime)
--
--! @brief reduce remaining quota by time passed
--! @memberof mobf_step_quota
--! @public
--
--! @param starttime time this operation started
-------------------------------------------------------------------------------
function mobf_step_quota.consume(starttime)
	local now = mobf_get_time_ms()
	local passed = now - starttime

	if passed >= 0 then
		mobf_step_quota.remaining_quota = mobf_step_quota.remaining_quota - passed
	else
		--mobf_print("MOBF: error calculation consumed time: " .. starttime .. " --> " .. now)
	end
end