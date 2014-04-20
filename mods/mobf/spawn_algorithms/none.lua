-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file none.lua
--! @brief dummy for mobs that don't spawn by themselfs at all
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_none(spawning_data)
--
--! @brief don't spawn at all
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_none(spawning_data)
	--intended to do nothing!
end

--!@}

spawning.register_spawn_algorithm("none", mobf_spawner_initialize_none)