-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file on_ground_2.lua
--! @brief a environment description for mobs on ground
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


--! @struct env_on_ground_2
--! @brief an environment for mobs capable of walking through junglegrass 
--! and stay on natural surfaces
env_on_ground_2 = {
			media = {
						"air",
					},
			surfaces = {
						good = {
							"default:dirt_with_grass",
							"default:dirt_with_grass_footsteps",
							"default:dirt",
							"default:stone",
							"default:gravel",
							"default:cobble",
							"default:mossycobble",
							"default:desert_stone",
							"default:stone_with_coal",
							"default:stone_with_iron",
							"default:stone_with_copper",
							"default:stone_with_mese",
							"default:stone_with_gold",
							"default:stone_with_diamond"
							},
						},

--TODO add support for light checks			
--			light = {
--				min_light = 0,
--				max_light = 0,
--			}
		}
		
--!@}

table.foreach(mobf_env_placable_items,
	function(index) 
		table.insert(env_on_ground_2.media,mobf_env_placable_items[index]) 
	end)
	
table.foreach(mobf_env_plants,
	function(index) 
		table.insert(env_on_ground_2.media,mobf_env_plants[index]) 
	end)
	
table.foreach(mobf_env_flowers,
	function(index) 
		table.insert(env_on_ground_2.media,mobf_env_flowers[index]) 
	end)
		
environment.register("on_ground_2", env_on_ground_2)