-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file main_follow.lua
--! @brief component containing a movement generator based uppon jordan4ibanez code
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup mgen_jordan4ibanez MGEN: a velocity based movement generator
--! @brief A movement generator creating simple random movement
--! @ingroup framework_int
--! @{ 
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class mgen_jordan4ibanez
--! @brief a movement generator trying to follow or reach a target
--!@}

mgen_jordan4ibanez = {}

--! @brief chillaxin_speed
--! @memberof mgen_jordan4ibanez
mgen_jordan4ibanez.chillaxin_speed = 0.1


--! @brief movement generator identifier
--! @memberof mgen_jordan4ibanez
mgen_jordan4ibanez.name = "jordan4ibanez_mov_gen"

-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
--! @brief main callback to make a mob follow its target
--! @memberof mgen_jordan4ibanez
--
--! @param entity mob to generate movement for
--! @param now current time
-------------------------------------------------------------------------------
function mgen_jordan4ibanez.callback(entity,now)

	--update timers
	entity.dynamic_data.movement.timer = entity.dynamic_data.movement.timer + 0.01
	entity.dynamic_data.movement.turn_timer = entity.dynamic_data.movement.turn_timer + 0.01
	entity.dynamic_data.movement.jump_timer = entity.dynamic_data.movement.jump_timer + 0.01
	entity.dynamic_data.movement.door_timer = entity.dynamic_data.movement.door_timer + 0.01

    
    if entity.dynamic_data.movement.direction ~= nil then
        entity.object:setvelocity({x=entity.dynamic_data.movement.direction.x*mgen_jordan4ibanez.chillaxin_speed,
        y=entity.object:getvelocity().y,
        z=entity.dynamic_data.movement.direction.z*mgen_jordan4ibanez.chillaxin_speed})
    end
    
    if entity.dynamic_data.movement.turn_timer > math.random(1,4) then
        entity.dynamic_data.movement.yaw = 360 * math.random()
        entity.object:setyaw(entity.dynamic_data.movement.yaw)
        entity.dynamic_data.movement.turn_timer = 0
        entity.dynamic_data.movement.direction = {x = math.sin(entity.dynamic_data.movement.yaw)*-1, 
        											y = -10, 
        											z = math.cos(entity.dynamic_data.movement.yaw)}
        --entity.object:setvelocity({x=entity.dynamic_data.movement.direction.x,y=entity.object:getvelocity().y,z=entity.dynamic_data.movement.direction.z})
        --entity.object:setacceleration(entity.dynamic_data.movement.direction)
    end
    
	--TODO update animation
	
    --open a door [alpha]
    if entity.dynamic_data.movement.direction ~= nil then
        if entity.dynamic_data.movement.door_timer > 2 then
            local is_a_door = minetest.get_node({x=entity.object:getpos().x + entity.dynamic_data.movement.direction.x,
            										 y=entity.object:getpos().y,z=entity.object:getpos().
            										 z + entity.dynamic_data.movement.direction.z}).name
            if is_a_door == "doors:door_wood_t_1" then
                minetest.punch_node({x=entity.object:getpos().x + entity.dynamic_data.movement.direction.x,
                						 y=entity.object:getpos().y-1,
                						 z=entity.object:getpos().z + entity.dynamic_data.movement.direction.z})
                entity.dynamic_data.movement.door_timer = 0
            end
            local is_in_door = minetest.get_node(entity.object:getpos()).name
            if is_in_door == "doors:door_wood_t_1" then
                minetest.punch_node(entity.object:getpos())
            end
        end
    end
    
    --jump
    if entity.dynamic_data.movement.direction ~= nil then
        if entity.dynamic_data.movement.jump_timer > 0.3 then
            if minetest.registered_nodes[minetest.get_node({x=entity.object:getpos().x + entity.dynamic_data.movement.direction.x,
            													y=entity.object:getpos().y-1,
            													z=entity.object:getpos().z + entity.dynamic_data.movement.direction.z}).name].walkable then
                entity.object:setvelocity({x=entity.object:getvelocity().x,y=5,z=entity.object:getvelocity().z})
                entity.dynamic_data.movement.jump_timer = 0
            end
        end
    end

end

-------------------------------------------------------------------------------
-- name: initialize()
--
--! @brief initialize movement generator
--! @memberof mgen_jordan4ibanez
--! @public
-------------------------------------------------------------------------------
function mgen_jordan4ibanez.initialize(entity,now)
--intentionaly doing nothing this function is for symmetry reasons only
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof mgen_jordan4ibanez
--! @public
--
--! @param entity mob to initialize dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function mgen_jordan4ibanez.init_dynamic_data(entity,now)

	local data = {
			timer = 0,
			turn_timer = 0,
			jump_timer = 0,
			door_timer = 0,
			direction = nil,
			yaw = nil,
			orientation_fix_needed = false,
			}
	
	entity.dynamic_data.movement = data
end

-------------------------------------------------------------------------------
-- name: set_target(entity,target)
--
--! @brief set target for movgen
--! @memberof mgen_jordan4ibanez
--
--! @param entity mob to apply to
--! @param target to set
-------------------------------------------------------------------------------
function mgen_jordan4ibanez.set_target(entity,target)
	return false
end


--register this movement generator
registerMovementGen(mgen_jordan4ibanez.name,mgen_jordan4ibanez)