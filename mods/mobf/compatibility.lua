-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file compatibility.lua
--! @brief contains compatibility/transition code thats to be removed
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

minetest.register_abm({
		nodenames = { "animalmaterials:wool_white" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:white"})
		end
	
	})
	
minetest.register_abm({
		nodenames = { "animalmaterials:wool_grey" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:grey"})
		end
	
	})
	
minetest.register_abm({
		nodenames = { "animalmaterials:wool_brown" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:brown"})
		end
	
	})
	
minetest.register_abm({
		nodenames = { "animalmaterials:wool_black" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="wool:black"})
		end
	
	})
	
-------------------------------------------------------------------------------
-- compatibility functions to make transition to new name easier
-------------------------------------------------------------------------------
	
function animals_add_animal(animal)
    mobf_add_mob(animal)
end