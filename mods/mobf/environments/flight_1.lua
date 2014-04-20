-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file flight_1.lua
--! @brief a environment description for in flight mobs
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_flight_1
--! @brief flying mobs in height between 13-23 blocks above surface
env_flight_1 = {
			media = {
						"air"
					},
			surfaces = nil,
			--ground is first node above/below not beeing of media type
			max_height_above_ground		= 23,
			min_height_above_ground     = 13
		}
		
--!@}

environment.register("flight_1", env_flight_1)