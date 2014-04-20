-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file on_ground_1.lua
--! @brief a environment description for mobs on ground
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_on_ground_1
--! @brief an environment for mobs capable of walking through junglegrass
env_on_ground_1 = {
			media = {
						"air",
					}
		}
--!@}

table.foreach(mobf_env_placable_items,
	function(index) 
		table.insert(env_on_ground_1.media,mobf_env_placable_items[index]) 
	end)
	
table.foreach(mobf_env_plants,
	function(index) 
		table.insert(env_on_ground_1.media,mobf_env_plants[index]) 
	end)
	
table.foreach(mobf_env_flowers,
	function(index) 
		table.insert(env_on_ground_1.media,mobf_env_flowers[index]) 
	end)

environment.register("on_ground_1", env_on_ground_1)