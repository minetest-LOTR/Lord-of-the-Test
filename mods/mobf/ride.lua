-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file ride.lua
--! @brief class containing mobf functions for riding
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-06
--
--
--! @defgroup mobf_ride Rideable mobs subcomponent
--! @brief a component containing all functions required to ride a mob
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(mobf_ride == nil)
--! @class mobf_ride
--! @brief contains all riding specific functions
--! @}

mobf_ride = {}

------------------------------------------------------------------------------
-- @function [parent=#mobf_ride] attache_player(entity,player)
--
--! @brief make a player ride this mob
--! @class mobf_ride
--! @private
--
--! @param entity entity to be ridden
--! @param player player riding
-------------------------------------------------------------------------------
function mobf_ride.attache_player(entity,player)

	entity.dynamic_data.ride.is_attached = true
	entity.dynamic_data.ride.player = player
	entity.object:setacceleration({x=0,y=-9.81,z=0})
	entity.object:setvelocity({x=0,y=-9.81,z=0})

	local attacheoffset = {x=0,y=0.5,z=0}

	if entity.data.ride ~= nil and
		entity.data.ride.attacheoffset ~= nil then
		attacheoffset = entity.data.ride.attacheoffset
	end

	player:set_attach(entity.object,"",attacheoffset, {x=0,y=0,z=0})
	if entity.data.ride.texturemod ~= nil then
		entity.object:settexturemod(entity.data.ride.texturemod);
	end
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_ride] dettache_player(entity,player)
--
--! @brief make a player ride this mob
--! @class mobf_ride
--! @private
--
--! @param entity entity to be ridden
-------------------------------------------------------------------------------
function mobf_ride.dettache_player(entity)

	entity.dynamic_data.ride.is_attached = false
	entity.dynamic_data.ride.player:set_detach()
	entity.dynamic_data.ride.player = nil
	entity.object:settexturemod("");
end


------------------------------------------------------------------------------
-- @function [parent=#mobf_ride] on_step_callback(entity)
--
--! @brief make a player ride this mob
--! @class mobf_ride
--! @public
--
--! @param entity entity to be ridden
-------------------------------------------------------------------------------
function mobf_ride.on_step_callback(entity)

	if entity.dynamic_data.ride.is_attached then
		dbg_mobf.ride_lvl3("MOBF: have attached player")
		local walkspeed  = 3
		local sneakspeed = 0.5
		local jumpspeed  = 30

		if entity.data.ride ~= nil then
			if entity.data.ride.walkspeed ~= nil then
				walkspeed = entity.data.ride.walkspeed
			end

			if entity.data.ride.runspeed ~= nil then
				runspeed = entity.data.ride.runspeed
			end

			if entity.data.ride.sneakspeed ~= nil then
				sneakspeed = entity.data.ride.sneakspeed
			end

			if entity.data.ride.jumpspeed ~= nil then
				jumpspeed = entity.data.ride.jumpspeed
			end
		end

		local dir = entity.dynamic_data.ride.player:get_look_yaw()
		local current_speed = entity.object:getacceleration()

		local speed_to_set = {x=0,y=current_speed.y,z=0}
		if dir ~= nil then
			local playerctrl = entity.dynamic_data.ride.player:get_player_control()

			if playerctrl ~= nil then

				local setspeed = false

				if playerctrl.jump and
					entity.is_on_ground(entity) then
					speed_to_set.y = jumpspeed
					setspeed = true
				end

				--just set speed to playerview direction
				if playerctrl.up then
					setspeed = true
				end

				--invert playerview direction
				if playerctrl.down then
					dir = dir + math.pi
					setspeed = true
				end

				if playerctrl.left then
					if playerctrl.up then
						dir = dir + math.pi/4
					elseif playerctrl.down then
						dir = dir - math.pi/4
					else
						dir = dir + math.pi/2
					end
					setspeed = true
				end

				if playerctrl.right then
					if playerctrl.up then
						dir = dir - math.pi/4
					elseif playerctrl.down then
						dir = dir + math.pi/4
					else
						dir = dir - math.pi/2
					end
					setspeed = true
				end

				local selected_speed = walkspeed

				if playerctrl.sneak then
					selected_speed = sneakspeed
				end



				if setspeed then
					speed_to_set_xz = mobf_calc_vector_components(dir,selected_speed)

					speed_to_set.x = speed_to_set_xz.x
					speed_to_set.z = speed_to_set_xz.z

					if entity.data.ride.walk_anim ~= nil then
						graphics.set_animation(entity,entity.data.ride.walk_anim)
					end
				else
					if entity.data.ride.walk_anim ~= nil then
						if entity.data.ride.stand_anim ~= nil then
							graphics.set_animation(entity,entity.data.ride.stand_anim)
							mob_state.change_state(entity,mob_state.get_state_by_name(entity,entity.data.ride.state_stand))
						else
							graphics.set_animation(entity,"stand")
						end
					end
				end

				entity.object:setvelocity(speed_to_set)

				--fix switched model orientation
				entity.object:setyaw(dir)
			end


		end
		return true
	else
		return false
	end
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_ride] on_punch_callback(entity,player)
--
--! @brief make a player ride this mob
--! @class mobf_ride
--! @public
--
--! @param entity entity to be ridden
--! @param player player riding
-------------------------------------------------------------------------------
function mobf_ride.on_punch_callback(entity,player)
	dbg_mobf.ride_lvl2("MOBF: ride on punch callback")
	print("MOBF: ride on punch callback")
	--detache
	if entity.dynamic_data.ride.is_attached ~= false then
		dbg_mobf.ride_lvl2("MOBF: punched ridden mob")
		if entity.dynamic_data.ride.player == player then
			dbg_mobf.ride_lvl2("MOBF: detaching player")
			mobf_ride.dettache_player(entity)
			player:get_inventory():add_item("main","animalmaterials:saddle 1")
			return true
		end
	else
		--check if player has saddle
		dbg_mobf.ride_lvl2("MOBF: punched free mob")
		if player:get_wielded_item():get_name() == "animalmaterials:saddle" then
			dbg_mobf.ride_lvl2("MOBF: punching with saddle")
			if player:get_inventory():contains_item("main","animalmaterials:saddle 1") then
				dbg_mobf.ride_lvl2("MOBF: have saddle")
				mobf_ride.attache_player(entity,player)
				player:get_inventory():remove_item("main","animalmaterials:saddle 1")
				return true
			end
		else
			dbg_mobf.ride_lvl2("MOBF: not punching with saddle but: " .. player:get_wielded_item():get_name())
		end
	end

	return false
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_ride] is_enabled(entity)
--
--! @brief check if riding is enabled for a mob
--! @class mobf_ride
--! @public
--
--! @param entity entity to be ridden
-------------------------------------------------------------------------------
function mobf_ride.is_enabled(entity)
	if entity.data.ride ~= nil then
		return true
	end
	dbg_mobf.ride_lvl2("riding of " .. entity.data.name .. " is disabled")
	return false
end

------------------------------------------------------------------------------
-- @function [parent=#mobf_ride] attache_player(entity,player)
--
--! @brief make a player ride this mob
--! @class mobf_ride
--! @public
--
--! @param entity entity to be ridden
-------------------------------------------------------------------------------
function mobf_ride.init(entity)
	local data = {
		is_attached = false,
		player = nil,
		}

	entity.dynamic_data.ride = data
end

-- special handler on leave
minetest.register_on_leaveplayer( function(player)
	if player ~= nil and
		player.object ~= nil then
		local pos = player.object:getpos()

		--print("MOBF: got player position: " ..printpos(pos) )

		if pos ~= nil then
			local objects = get_objects_inside_radius(pos, 5)

			print("MOBF: found " .. dump(#objects) .. " objects around player")

			if objects ~= nil then
				for i=1,#objects,1 do
					local entity = objects[i]:get_luaentity()
					if entity ~= nil and
						entity.dynamic_data ~= nil and
						entity.dynamic_data.ride ~= nil and
						entity.dynamic_data.ride.player == player then
						print("MOBF: found player to be attached")
						ride.dettache_player(entity)
						break
					end
				end
			end
		end
	end
end)