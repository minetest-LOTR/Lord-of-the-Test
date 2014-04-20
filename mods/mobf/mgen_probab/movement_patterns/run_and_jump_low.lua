-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file run_and_jump_low.lua
--! @brief movementpattern running arround ad doing random low jumps
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup mpatterns
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


--! @struct run_and_jump_low_prototype
--! @brief a movement pattern used for quick moving and direction changing mobs
--! that jump every now and then
local run_and_jump_low_prototype = 	{
		name                            ="run_and_jump_low",
		jump_up							=0.2,
	
		random_jump_chance              =0.3,
		random_jump_initial_speed       =3.5,
		random_jump_delay               =2,
		random_acceleration_change      =0.6,
	}

--!~@}	

table.insert(mov_patterns_defined,run_and_jump_low_prototype)