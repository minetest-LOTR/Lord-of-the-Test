-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file mgen_raster.lua
--! @brief component containing a probabilistic movement generator (uses mgen follow)
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup mgen_raster MGEN: raster based movement generator
--! @brief A movement generator creating movement that creates a rasterized 
--! random movement
--! @ingroup framework_int
--! @{ 
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class mgen_raster
--! @brief a movement generator creating a rasterized probabilistic movement
--!@}
mgen_raster = {}

--! @brief movement generator identifier
--! @memberof mgen_follow
mgen_raster.name = "probab_raster_mov_gen"


-------------------------------------------------------------------------------
-- name: stop(entity)
--
--! @brief stop this entity
--! @memberof mgen_raster
--
--! @param entity mob to stop
-------------------------------------------------------------------------------
function mgen_raster.stop(entity)
	local defgrav = environment.get_default_gravity(entity.getbasepos(entity),
										entity.environment,
										entity.data.movement.canfly)
	
	entity.dynamic_data.movement.target = nil
	entity.object:setvelocity({x=0,y=0,z=0})
	entity.object:setacceleration({x=0,y=defgrav,z=0})
end

-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
--! @brief main callback to make a mob follow its target
--! @memberof mgen_raster
--
--! @param entity mob to generate movement for
--! @param now current time
-------------------------------------------------------------------------------
function mgen_raster.callback(entity,now)

	local basepos = entity.getbasepos(entity)
	local dtime = entity.current_dtime
	
	entity.dynamic_data.movement.time_travelled = entity.dynamic_data.movement.time_travelled + dtime

	--check environment
	local pos_state = environment.pos_is_ok(basepos,entity)
	if pos_state ~= "ok" and
		pos_state ~= "possible_surface" then
		mgen_raster.stop(entity)
		
		--try to find a good position around to move mob to
		local new_pos = environment.get_suitable_pos_same_level(basepos,1,entity,false)
		
		if (new_pos == nil ) then
			new_pos = environment.get_suitable_pos_same_level({x=basepos.x,
																	y=basepos.y+1,
																	z=basepos.z}
																,1,entity,false)
		end
		
		if (new_pos == nil ) then
			new_pos = environment.get_suitable_pos_same_level({x=basepos.x,
																	y=basepos.y+1,
																	z=basepos.z}
																,1,entity,false)
		end
		
		if (new_pos ~= nil ) then
			--TODO fix position according to model information!
			enity.object:moveto(new_pos)
			basepos = new_pos
		else
			--TODO error handling
		end
	end
	
	--check on ground
	if not mgen_raster.onground(entity,now,basepos) then
		mgen_raster.stop(entity)
	end
	
	--check how long we've been traveling
	if ( entity.dynamic_data.movement.time_travelled > entity.dynamic_data.movement.eta ) then
		mgen_raster.stop(entity)
	end
	
	--check distance to target (target reached or missed)
	local distance_to_target = mobf_calc_distance(basepos,entity.dynamic_data.movement.target)
	if distance_to_target > 2.0 or
		distance_to_target < 0.1 then
		mgen_raster.stop(entity)
	end
	
	--find next point	
	if entity.dynamic_data.nextpoint == nil then
		entity.dynamic_data.nextpoint = environment.get_suitable_pos_same_level(basepos,1,entity,false)
		--TODO calc maximum eta + 10%
	end
	
	--call move to target mgen
	helper_mgen.callback(entity,now)
end

-------------------------------------------------------------------------------
-- name: initialize()
--
--! @brief initialize movement generator
--! @memberof mgen_raster
--! @public
-------------------------------------------------------------------------------
function mgen_raster.initialize(entity,now)
--intentionaly doing nothing this function is for symmetry reasons only
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof mgen_raster
--! @public
--
--! @param entity mob to initialize dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function mgen_raster.init_dynamic_data(entity,now)

	local pos = entity.object:getpos()

	local data = {
			target = nil,
			guardspawnpoint = true,
			orientation_fix_needed = true,
			time_travelled = 0,
			helper_mgen = getMovementGen(follow_mov_gen),
			max_distance = 0.1,
			}
	
	entity.dynamic_data.movement = data

end


-------------------------------------------------------------------------------
-- name: onground(entity,now)
--
--! @brief check if mob is touching ground
--! @memberof mgen_raster
--! @public
--
--! @param entity mob to initialize dynamic data
--! @param now current time
--! @param basepos position of feet
-------------------------------------------------------------------------------
function mgen_raster.onground(entity,now,basepos)

	local posbelow = { x=basepos.x, y=basepos.y-1,z=basepos.z}
	
	for dx=-1,1 do
	for dz=-1,1 do
		local fp0 = posbelow
		local fp = { x= posbelow.x + (0.5*dx),
					  y= posbelow.y,
					  z= posbelow.z + (0.5*dz) }
		local n = minetest.get_node(fp)
		if mobf_is_walkable(n) then
			return true
		end
	end
	end

end

-------------------------------------------------------------------------------
-- name: set_target(entity,target)
--
--! @brief set target for movgen
--! @memberof mgen_raster
--! @private
--
--! @param entity mob to apply to
--! @param target to set
-------------------------------------------------------------------------------
function mgen_raster.set_target(entity,target)
	return false
end

--register this movement generator
registerMovementGen(mgen_raster.name,mgen_raster)