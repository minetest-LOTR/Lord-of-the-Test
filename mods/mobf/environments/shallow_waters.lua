-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file shallow_waters.lua
--! @brief shallow waters
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_shallow_waters
--! @brief shallow waters not deeper than 10 blocks
env_shallow_waters = {
			media = {
						"default:water_source",
						"default:water_flowing"
					},
			surfaces = nil,
			--ground is first node above/below not beeing of media type
			max_height_above_ground		= 1,
			min_height_above_ground     = -10		
		}
--!@}

environment.register("shallow_waters", env_shallow_waters)