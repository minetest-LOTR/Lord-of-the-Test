-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file meadow.lua
--! @brief meadow environment description
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_meadow
--! @brief environment for mobs that prefere green meadows but may walk on 
--! dirt and sand too
env_meadow = {
			media = {
						"air",
					},
			surfaces = {
						good = {
							"default:dirt_with_grass",
							"default:dirt_with_grass_footsteps"
							},
						possible = {
							"default:dirt",
							"default:sand",
							},
						},
		}
--!@}

table.foreach(mobf_env_placable_items,
	function(index) 
		table.insert(env_meadow.media,mobf_env_placable_items[index]) 
	end)
	
table.foreach(mobf_env_plants,
	function(index) 
		table.insert(env_meadow.media,mobf_env_plants[index]) 
	end)
	
table.foreach(mobf_env_flowers,
	function(index) 
		table.insert(env_meadow.media,mobf_env_flowers[index]) 
	end)

environment.register("meadow", env_meadow)