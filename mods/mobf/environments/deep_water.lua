-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file deep_water.lua
--! @brief deep water
--! @copyright Sapier
--! @author Sapier
--! @date 2013-10-03
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_deep_water
--! @brief deep water is not moving water with a depht up to -50
env_deep_water = {
			media = {
						"default:water_source",
					},
			surfaces = nil,
			--ground is first node above/below not beeing of media type
			max_height_above_ground		= 0,
			min_height_above_ground     = -50
		}
--!@}

environment.register("deep_water", env_deep_water)