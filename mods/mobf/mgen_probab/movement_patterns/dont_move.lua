-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file dont_move.lua
--! @brief movementpattern for immobile mob
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup mpatterns
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


--! @struct dont_move_prototype
--! @brief a movement pattern resulting in a mob not moving at all
local dont_move_prototype = 		{
		name                            ="dont_move",
		jump_up							=0,
	
		random_jump_chance              =0,
		random_jump_initial_speed       =0,
		random_jump_delay               =0,    
		random_acceleration_change      =0,
--
--      --run towards player or run away?  1 <-> -1
--		player_attraction				=0,
--		--maximum distance a player has an effect
--		player_attraction_range         =-1,
	}

--!@}
	
table.insert(mov_patterns_defined,dont_move_prototype)