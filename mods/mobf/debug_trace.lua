-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file debug_trace.lua
--! @brief contains switchable debug trace functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup debug_trace Debug trace functions
--! @brief central configuration of trace functions
--! @ingroup framework_int

--lvl1 excessive output
--lvl2 medium output
--lvl3 less output

--! @brief configuration of trace level to use for various components
--! @ingroup debug_trace
dbg_mobf = {

	generic_lvl1			= function () end,
	generic_lvl2			= function () end,
	generic_lvl3			= function () end,
	
	graphics_lvl1			= function () end,
	graphics_lvl2			= function () end,
	graphics_lvl3			= function () end,
	
	spawning_lvl1			= function () end,
	spawning_lvl2			= function () end,
	spawning_lvl3			= function () end,
	
	permanent_store_lvl1	= function () end,
	permanent_store_lvl2	= function () end,
	permanent_store_lvl3	= function () end,
	
	movement_lvl1			= function () end,
	movement_lvl2			= function () end,
	movement_lvl3			= function () end,
	
	pmovement_lvl1			= function () end,
	pmovement_lvl2			= function () end,
	pmovement_lvl3			= function () end,
	
	fmovement_lvl1			= function () end,
	fmovement_lvl2			= function () end,
	fmovement_lvl3			= function () end,
	
	flmovement_lvl1			= function () end,
	flmovement_lvl2			= function () end,
	flmovement_lvl3			= function () end,
	
	path_mov_lvl1			= function () end,
	path_mov_lvl2			= function () end,
	path_mov_lvl3			= function () end,
	
	fighting_lvl1			= function () end,
	fighting_lvl2			= function () end,
	fighting_lvl3			= function () end,
	
	environment_lvl1		= function () end,
	environment_lvl2		= function () end,
	environment_lvl3		= function () end,
	
	harvesting_lvl1			= function () end,
	harvesting_lvl2			= function () end,
	harvesting_lvl3			= function () end,
	
	sound_lvl1				= function () end,
	sound_lvl2				= function () end,
	sound_lvl3				= function () end,
	
	random_drop_lvl1		= function () end,
	random_drop_lvl2		= function () end,
	random_drop_lvl3		= function () end,
	
	mob_state_lvl1			= function () end,
	mob_state_lvl2			= function () end,
	mob_state_lvl3			= function () end,
	
	mobf_core_lvl1			= function () end,
	mobf_core_lvl2			= function () end,
	mobf_core_lvl3			= function () end,
	
	mob_preserve_lvl1		= function () end,
	mob_preserve_lvl2		= function () end,
	mob_preserve_lvl3		= function () end,
	
	mobf_core_helper_lvl1	= function () end,
	mobf_core_helper_lvl2	= function () end,
	mobf_core_helper_lvl3	= function () end,
	
	trader_inv_lvl1			= function () end,
	trader_inv_lvl2			= function () end,
	trader_inv_lvl3			= function () end,
	
	ride_lvl1				= function () end,
	ride_lvl2				= function () end,
	ride_lvl3				= function () end,
	
	path_lvl1				= function () end,
	path_lvl2				= function () end,
	path_lvl3				= function () end,
	
	lifebar_lvl1			= function () end,
	lifebar_lvl2			= function () end,
	lifebar_lvl3			= function () end,
	
	attention_lvl1			= function () end,
	attention_lvl2			= function () end,
	attention_lvl3			= function () end,
}