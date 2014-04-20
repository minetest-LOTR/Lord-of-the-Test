-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file open_waters.lua
--! @brief open waters
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_open_waters
--! @brief open waters from 4 to 30 blocks deep
env_open_waters = {
			media = {
						"default:water_source",
						"default:water_flowing"
					},
			surfaces = nil,
			--ground is first node above/below not beeing of media type
			max_height_above_ground		= -4,
			min_height_above_ground     = -30
		}
--!@}

environment.register("open_waters", env_open_waters)