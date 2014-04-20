-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file spawning.lua
--! @brief component containing spawning features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--

--! @defgroup spawning Spawn mechanisms
--! @brief all functions and variables required for automatic mob spawning
--! @ingroup framework_int
--! @{
--
--! @defgroup spawn_algorithms Spawn algorithms
--! @brief spawn algorithms provided by mob framework (can be extended by mods)
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(spawning == nil)
--! @class spawning
--! @brief spawning features
spawning = {}

--!@}

mobf_assert_backtrace(mobf_spawn_algorithms == nil)
--! @brief registry for spawn algorithms
--! @memberof spawning
--! @private
mobf_spawn_algorithms = {}


-------------------------------------------------------------------------------
-- name: remove_uninitialized(entity,staticdata)
-- @function [parent=#spawning] remove_uninitialized
--
--! @brief remove a spawn point based uppon staticdata supplied
--! @memberof spawning
--
--! @param entity to remove
--! @param staticdata of mob
-------------------------------------------------------------------------------
function spawning.remove_uninitialized(entity, staticdata)
	--entity may be known in spawnlist
	if staticdata ~= nil then
		local permanent_data = mobf_deserialize_permanent_entity_data(staticdata)
		if (permanent_data.spawnpoint ~= nil) then

			--prepare information required to remove entity
			entity.dynamic_data = {}
			entity.dynamic_data.spawning = {}
			entity.dynamic_data.spawning.spawnpoint = permanent_data.spawnpoint
			entity.dynamic_data.spawning.player_spawned = permanent_data.playerspawned
			entity.dynamic_data.spawning.spawner = permanent_data.spawner

			spawning.remove(entity,"remove uninitialized")
		end
	else
		dbg_mobf.spawning_lvl1("MOBF: remove uninitialized entity=" .. tostring(entity))
		--directly remove it can't be known to spawnlist
		entity.object:remove()
	end
end

-------------------------------------------------------------------------------
-- name: remove(entity)
-- @function [parent=#spawning] remove
--
--! @brief remove a mob
--! @memberof spawning
--
--! @param entity mob to remove
--! @param reason text to log as reason for removal
-------------------------------------------------------------------------------
function spawning.remove(entity,reason)
	local pos = entity.object:getpos()
	dbg_mobf.spawning_lvl3("MOBF: --> remove " .. printpos(pos))
	if entity ~= nil then
		entity.removed = true
		dbg_mobf.spawning_lvl1("MOBF: remove entity=" .. tostring(entity))
		if minetest.world_setting_get("mobf_log_removed_entities") then
			if reason == nil then
				reason = "unknown"
			end
			minetest.log(LOGLEVEL_NOTICE,"MOBF: removing " .. entity.data.name ..
				" at " .. printpos(pos) .. " due to: " .. reason)
		end
		mob_preserve.handle_remove(entity,reason)
		if entity.lifebar ~= nil then
			mobf_lifebar.del(entity.lifebar)
		end
		entity.object:remove()
	else
		minetest.log(LOGLEVEL_ERROR,"Trying to delete an an non existant mob")
	end

	dbg_mobf.spawning_lvl3("MOBF: <-- remove")
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity)
-- @function [parent=#spawning] init_dynamic_data
--
--! @brief initialize dynamic data required for spawning
--! @memberof spawning
--
--! @param entity mob to initialize dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function spawning.init_dynamic_data(entity,now)

	local player_spawned = false

	if entity.dynamic_data.spawning ~= nil and
		entity.dynamic_data.spawning.player_spawned then
		player_spawned = true
	end

	local data = {
		player_spawned     = player_spawned,
		ts_dense_check     = now,
		spawnpoint         = entity.object:getpos(),
		original_spawntime = now,
		spawner            = nil,
		density            = spawning.population_density_get_min(entity),
	}

	entity.removed = false
	entity.dynamic_data.spawning = data
end



-------------------------------------------------------------------------------
-- name: population_density_check(mob)
-- @function [parent=#spawning] population_density_check
--
--! @brief check and fix if there are too many mobs within a specific range
--! @memberof spawning
--
--! @param entity mob to check
--! @param now current time
-------------------------------------------------------------------------------
function spawning.population_density_check(entity,now)

	if entity == nil or
		entity.dynamic_data == nil or
		entity.dynamic_data.spawning == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!! " .. entity.data.name ..
			" pop dense check called for entity with missing spawn data entity=" ..
			tostring(entity))
		return false
	end


	--only check every 5 seconds
	if entity.dynamic_data.spawning.ts_dense_check + 5 > now then
		return true
	end

	-- don't check if mob is player spawned
	if entity.dynamic_data.spawning.player_spawned == true then
		dbg_mobf.spawning_lvl1("MOBF: mob is player spawned skipping pop dense check")
		return true
	end

	--don't do population check while fighting
	if entity.dynamic_data.combat ~= nil and
		entity.dynamic_data.combat.target ~= nil and
		entity.dynamic_data.combat.target ~= "" then
		dbg_mobf.spawning_lvl1(
			"MOBF: fighting right now skipping pop dense check: " ..
			dump(entity.dynamic_data.combat.target))
		return true
	end

	entity.dynamic_data.spawning.ts_dense_check = now

	local entitypos = mobf_round_pos(entity.object:getpos())

	--mob either not initialized completely or a bug
	if mobf_pos_is_zero(entitypos) then
		dbg_mobf.spawning_lvl1("MOBF: can't do a sane check")
		return true
	end

	local secondary_name = ""
	if entity.data.harvest ~= nil then
		secondary_name = entity.data.harvest.transform_to
	end

	mobf_assert_backtrace(entity.dynamic_data.spawning.density ~= nil)

	local mob_count = mobf_mob_around(entity.data.modname..":"..entity.data.name,
										secondary_name,
										entitypos,
										entity.dynamic_data.spawning.density,
										true)
	if  mob_count > 5 then
		dbg_mobf.spawning_lvl1("MOBF: " .. entity.data.name ..
			mob_count .. " mobs of same type around")
		entity.removed = true
		minetest.log(LOGLEVEL_INFO,"MOBF: Too many ".. mob_count .. " "..
			entity.data.name.." at one place dying: " ..
			tostring(entity.dynamic_data.spawning.player_spawned))
		spawning.remove(entity, "population density check")
		return false
	else
		dbg_mobf.spawning_lvl2("MOBF: " ..  entity.data.name ..
			" density ok only "..mob_count.." mobs around")
		return true
	end
end


-------------------------------------------------------------------------------
-- name: replace_entity(pos,name,spawnpos,health)
-- @function [parent=#spawning] replace_entity
--
--! @brief replace mob at a specific position by a new one
--! @memberof spawning
--
--! @param entity mob to replace
--! @param name of the mob to add
--! @param preserve preserve original spawntime
--! @return entity added or nil on error
-------------------------------------------------------------------------------
function spawning.replace_entity(entity,name,preserve)
	dbg_mobf.spawning_lvl3("MOBF: --> replace_entity("
		.. entity.data.name .. "|" .. name .. ")")

	if minetest.registered_entities[name] == nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: replace_entity: Bug no "
			..name.." is registred")
		return nil
	end

	-- avoid switching to same entity
	if entity.name == name then
		minetest.log(LOGLEVEL_INFO,"MOBF: not replacing " .. name ..
			" by entity of same type!")
		return nil
	end


	-- get data to be transfered to new entity
	local pos             = mobf.get_basepos(entity)
	local health          = entity.object:get_hp()
	local temporary_dynamic_data = entity.dynamic_data
	local entity_orientation = entity.object:getyaw()

	if preserve == nil or preserve == false then
		temporary_dynamic_data.spawning.original_spawntime = mobf_get_current_time()
	end

	--calculate new y pos
	if minetest.registered_entities[name].collisionbox ~= nil then
		pos.y = pos.y - minetest.registered_entities[name].collisionbox[2]
	end


	--delete current mob
	dbg_mobf.spawning_lvl2("MOBF: replace_entity: removing " ..  entity.data.name)

	--unlink dynamic data (this should work but doesn't due to other bugs)
	entity.dynamic_data = nil

	--removing is done after exiting lua!
	spawning.remove(entity,"replaced")

	--set marker to true to make sure activate handler knows it's replacing right now
	spawning.replacing_NOW = true
	local newobject = minetest.add_entity(pos,name)
	spawning.replacing_NOW = false
	local newentity = mobf_find_entity(newobject)

	if newentity ~= nil then
		if newentity.dynamic_data ~= nil then
			dbg_mobf.spawning_lvl2("MOBF: replace_entity: " ..  name)
			newentity.dynamic_data = temporary_dynamic_data
			newentity.object:set_hp(health)
			newentity.object:setyaw(entity_orientation)
		else
			minetest.log(LOGLEVEL_ERROR,
				"MOBF: replace_entity: dynamic data not set for "..name..
				" maybe delayed activation?")
			newentity.dyndata_delayed = {
				data = temporary_dynamic_data,
				health = health,
				orientation = entity_orientation
			}
		end
	else
		minetest.log(LOGLEVEL_ERROR,
			"MOBF: replace_entity 4 : Bug no "..name.." has been created")
	end
	dbg_mobf.spawning_lvl3("MOBF: <-- replace_entity")
	return newentity
end

------------------------------------------------------------------------------
-- name: lifecycle_callback()
-- @function [parent=#spawning] lifecycle_callback
--
--! @brief check mob lifecycle_callback
--! @memberof spawning
--
--! @return true/false still alive dead
-------------------------------------------------------------------------------
function spawning.lifecycle_callback(entity,now)

	if entity.dynamic_data.spawning.original_spawntime ~= nil then
		if entity.data.spawning.lifetime ~= nil then

			local lifetime = entity.data.spawning.lifetime

			local current_age = now - entity.dynamic_data.spawning.original_spawntime

			if current_age > 0 and
				current_age > lifetime then
				dbg_mobf.spawning_lvl1("MOBF: removing animal due to limited lifetime")
				spawning.remove(entity," limited mob lifetime")
				return false
			end
		end
	else
		entity.dynamic_data.spawning.original_spawntime = now
	end

	return true
end

------------------------------------------------------------------------------
-- name: register_spawn_algorithm(name, spawnfunc, cleanupfunc)
-- @function [parent=#spawning] register_spawn_algorithm
--
--! @brief print current spawn statistics
--! @memberof spawning
--
--! @param name name of spawn algorithm
--! @param spawnfunc function to be called to initialize this algorithm
--! @param cleanupfunc function to initialize a cleanup if spawner needs to be removed
--
--! @return true/false successfully added spawn algorithm
-------------------------------------------------------------------------------
function spawning.register_spawn_algorithm(name, spawnfunc, cleanupfunc)

	if (mobf_spawn_algorithms[name] ~= nil) then
		return false
	end

	local new_algorithm = {}

	new_algorithm.initialize_spawning   = spawnfunc
	new_algorithm.initialize_cleanup    = cleanupfunc

	mobf_spawn_algorithms[name] = new_algorithm

	return true
end

------------------------------------------------------------------------------
-- name: spawn_and_check(name,pos,text)
-- @function [parent=#spawning] spawn_and_check
--
--! @brief spawn an entity and check for presence
--! @memberof spawning
--! @param name name of entity
--! @param pos position to spawn mob at
--! @param text message used for log messages
--
--! @return spawned mob entity
-------------------------------------------------------------------------------
function spawning.spawn_and_check(name,pos,text)
	mobf_assert_validpos(pos)
	mobf_assert_backtrace(name ~= nil)

	local newobject = minetest.add_entity(pos,name)

	if newobject then
		local newentity = mobf_find_entity(newobject)

		if newentity == nil then
			dbg_mobf.spawning_lvl3("MOBF BUG!!! no " .. name ..
				" entity has been created by " .. text .. "!")
			mobf_bug_warning(LOGLEVEL_ERROR,"BUG!!! no " .. name ..
				" entity has been created by " .. text .. "!")
		else
			dbg_mobf.spawning_lvl2("MOBF: spawning "..name ..
				" entity by " .. text .. " at position ".. printpos(pos))
			minetest.log(LOGLEVEL_INFO,"MOBF: spawning "..name ..
				" entity by " .. text .. " at position ".. printpos(pos))
			return newentity
		end
	else
		dbg_mobf.spawning_lvl3("MOBF BUG!!! no "..name..
			" object has been created by " .. text .. "!")
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!! no "..name..
			" object has been created by " .. text .. "!")
	end

	return nil
end


------------------------------------------------------------------------------
-- name: chunk_get_center(min,max,current_step,interval)
-- @function [parent=#spawning] chunk_get_center
--
--! @brief calculate center and deltas
--! @memberof spawning
--
--! @return center,delta
-------------------------------------------------------------------------------
function spawning.chunk_get_center(min,max,current_step,interval)

	dbg_mobf.spawning_lvl3("MOBF: chunk_get_center params: " .. min .. " " .. max ..
		" " .. current_step .. " " .. interval )
	local abs_min = min + interval * (current_step-1)
	local abs_max = abs_min + interval

	if abs_max > max then
		abs_max = max
	end

	local delta = (abs_max - abs_min) / 2

	return (abs_min + delta),delta
end

------------------------------------------------------------------------------
-- name: divide_mapgen_entity(minp,maxp,spawning_data,spawnfunc,maxtries)
-- @function [parent=#spawning] divide_mapgen_entity
--
--! @brief divide mapblock into 2d chunks and call spawnfunc with randomized parameters for each
--! @memberof spawning
--! @param minp minimum 3d point of map block
--! @param maxp maximum 3d point of map block
--! @param spawning_data all information required for spawning
--! @param spawnfunc function to use for spawning
--! @param maxtries maximum number of tries to place a spawner
--
-------------------------------------------------------------------------------
function spawning.divide_mapgen_entity(minp,maxp,spawning_data,spawnfunc,maxtries)

	if maxtries == nil then
		maxtries = 2
	end

	mobf_assert_backtrace(type(spawning_data) == "table")
	mobf_assert_backtrace(type(maxtries) == "number")
	mobf_assert_backtrace(type(spawnfunc) == "function")

	local divs = 0
	local attempts = 0
	local spawned = 0

	local min_x = MIN(minp.x,maxp.x)
	local min_y = MIN(minp.y,maxp.y)
	local min_z = MIN(minp.z,maxp.z)

	local max_x = MAX(minp.x,maxp.x)
	local max_y = MAX(minp.y,maxp.y)
	local max_z = MAX(minp.z,maxp.z)


	local xdivs = math.floor(((max_x - min_x) / spawning_data.density) +1)
	local zdivs = math.floor(((max_z - min_z) / spawning_data.density) +1)

	dbg_mobf.spawning_lvl3("MOBF: X: " .. min_x .. "-->" .. max_x)
	dbg_mobf.spawning_lvl3("MOBF: Z: " .. min_z .. "-->" .. max_z)
	dbg_mobf.spawning_lvl3("MOBF: Y: " .. min_y .. "-->" .. max_y)
	dbg_mobf.spawning_lvl3("MOBF: generating in " .. xdivs .. " | " .. zdivs .. " chunks")

	for i = 1, xdivs,1 do
	for j = 1, zdivs,1 do

		local x_center,x_delta = spawning.chunk_get_center(min_x,max_x,i,spawning_data.density)
		local z_center,z_delta = spawning.chunk_get_center(min_z,max_z,j,spawning_data.density)

		local surface_center = mobf_get_surface(x_center,z_center,min_y,max_y)

		local centerpos = {x=x_center,y=surface_center,z=z_center}

		if surface_center  == nil then
			dbg_mobf.spawning_lvl2(
				"MOBF: didn't find surface for " ..printpos(centerpos))
			centerpos.y = min_y + ((max_y-min_y)/2)
		end

		dbg_mobf.spawning_lvl3("MOBF: center is set to " ..
			"(" .. x_center .. "," .. z_center .. ")"
			.."  --> (".. x_delta .."," .. z_delta .. ")")

		--check if there is already a mobspawner of same type within area
		local spawner_around = mobf_spawner_around(spawning_data.name,centerpos,spawning_data.density)
		if spawner_around == 0 then
			dbg_mobf.spawning_lvl3("no " .. spawning_data.name .. " spawner within range of " ..
				spawning_data.density .. " around " ..printpos(centerpos))

			for i = 0, maxtries, 1 do
				attempts = attempts +1
				local x_try = math.random(-x_delta,x_delta)
				local z_try = math.random(-z_delta,z_delta)

				local pos = { x= x_center + x_try,
								z= z_center + z_try }

				--do place spawners in center of block
				pos.x = math.floor(pos.x + 0.5)
				pos.z = math.floor(pos.z + 0.5)

				spawning_data.minp = min_y
				spawning_data.maxp = max_y

				if spawnfunc(spawning_data,pos,nil) then
					spawned = spawned +1
					break
				end
			end --for -> maxtries
		end --mob around

		divs = divs +1
	end -- for z divs
	end -- for x divs
	local max_available_tries = divs * maxtries
	dbg_mobf.spawning_lvl3("MOBF: divide_mapgen I " ..
			"(" .. divs .. "|" .. attempts .. "|" .. spawned .. "|" .. max_available_tries .. ")")
	mobf_rtd.total_spawned = mobf_rtd.total_spawned + spawned
	return spawned
end

------------------------------------------------------------------------------
-- name: divide_mapgen(minp,maxp,spawning_data,spawnfunc,surfacefunc,maxtries)
-- @function [parent=#spawning] divide_mapgen
--
--! @brief divide mapblock into 2d chunks and call spawnfunc with randomized parameters for each
--! @memberof spawning
--
--! @param minp minimum 3d point of map block
--! @param maxp maximum 3d point of map block
--! @param spawning_data full set of spawning parameters
--! @param spawnfunc function to use for spawning
--! @param surfacefunc funtion to determine surface level
--! @param maxtries maximum number of tries to place a entity
--
-------------------------------------------------------------------------------
function spawning.divide_mapgen(minp,maxp,spawning_data,spawnfunc,surfacefunc,maxtries)
	dbg_mobf.spawning_lvl3("MOBF: divide_mapgen params: ")

	mobf_assert_backtrace(type(spawning_data) == "table")

	if maxtries == nil then
		maxtries = 2
	end

	local divs = 0
	local attempts = 0
	local spawned = 0

	local starttime = mobf_get_time_ms()

	local min_x = MIN(minp.x,maxp.x)
	local min_y = MIN(minp.y,maxp.y)
	local min_z = MIN(minp.z,maxp.z)

	local max_x = MAX(minp.x,maxp.x)
	local max_y = MAX(minp.y,maxp.y)
	local max_z = MAX(minp.z,maxp.z)


	local xdivs = math.floor(((max_x - min_x) / spawning_data.density) +1)
	local zdivs = math.floor(((max_z - min_z) / spawning_data.density) +1)

	dbg_mobf.spawning_lvl3("MOBF: X: " .. min_x .. "-->" .. max_x)
	dbg_mobf.spawning_lvl3("MOBF: Z: " .. min_z .. "-->" .. max_z)
	dbg_mobf.spawning_lvl3("MOBF: Y: " .. min_y .. "-->" .. max_y)
	dbg_mobf.spawning_lvl3("MOBF: generating in " .. xdivs .. " | " .. zdivs .. " chunks")

	for i = 1, xdivs,1 do
	for j = 1, zdivs,1 do

		local x_center,x_delta = spawning.chunk_get_center(min_x,max_x,i,spawning_data.density)
		local z_center,z_delta = spawning.chunk_get_center(min_z,max_z,j,spawning_data.density)

		local surface_center = surfacefunc(x_center,z_center,min_y,max_y)

		local centerpos = {x=x_center,y=surface_center,z=z_center}

		if surface_center  == nil then
			dbg_mobf.spawning_lvl2(
				"MOBF: didn't find surface for " ..printpos(centerpos))
			centerpos.y = min_y + ((max_y-min_y)/2)
		end

		dbg_mobf.spawning_lvl3("MOBF: center is (" .. x_center .. "," .. z_center .. ") --> (".. x_delta .."," .. z_delta .. ")")

		for i = 0, maxtries, 1 do
			attempts = attempts +1
			local x_try = math.random(-x_delta,x_delta)
			local z_try = math.random(-z_delta,z_delta)

			local pos = { x= x_center + x_try,
							z= z_center + z_try }

			pos.y = surfacefunc(pos.x,pos.z,min_y,max_y)

			local continue = false
			local mobs_around = -1
			local pos_ok = true


			if not continue and
				pos.y == nil then
				continue = true
			end

			if not continue then
				mobs_around = mobf_mob_around(spawning_data.name,
											  spawning_data.name_secondary,
											  pos,
											  spawning_data.density,true)
				if mobs_around > 0 then
					continue = true
				end
			end

			--check if there s enough space above to place mob
			if not continue and
				spawning_data.height ~= nil and
				mobf_air_above(pos,spawning_data.height) ~= true then
				dbg_mobf.spawning_lvl3("MOBF: not enough room to spawn: " .. spawning_data.height)
				local mypos = pos
				for i=1,spawning_data.height,1 do
					local nodeatpos = minetest.get_node(mypos)
					dbg_mobf.spawning_lvl3("\t" .. printpos(mypos) .. ": " .. nodeatpos.name)
					mypos.y = mypos.y +1
				end
				continue = true
			end



			--check if position is ok
			if not continue then
				local pos_above = {
							x=pos.x,
							y=pos.y+1,
							z=pos.z}
				local state = spawning.pos_quality(spawning_data,pos_above)
				if not environment.evaluate_state(state,LT_SAFE_POS) then
					local node_at_pos = minetest.get_node(pos_above)
					--mobf_print("MOBF: pos: " .. node_at_pos.name)
					--mobf_print("MOBF: spawning data: " .. dump(spawning_data))
					--mobf_print("MOBF: invalid pos to spawn: " .. state:tostring())
					continue = true
				end
			end




			if not continue then
				if spawnfunc(spawning_data,pos) then
					spawned = spawned +1
					break
				end
			end -- mobs_around
		end --for -> 5

		divs = divs +1
	end -- for z divs
	end -- for x divs
	local max_available_tries = divs * maxtries
	dbg_mobf.spawning_lvl2("MOBF: divide_mapgen II " ..
			"(" .. divs .. "|" .. attempts .. "|" .. spawned .. "|" .. max_available_tries .. ")")
	mobf_rtd.total_spawned = mobf_rtd.total_spawned + spawned
	return spawned
end

------------------------------------------------------------------------------
-- name: register_spawner_entity(spawning_data,spawnfunc,suffix)
-- @function [parent=#spawning] register_spawner_entity
--
--! @brief register a spawner entity
--! @memberof spawning
--
--! @param spawning_data spawning information to use
--! @param spawnfunc function to call for spawning
--! @param surfacefunc if not nil use this function to find surface
--! @param suffix to add
--! @param max_tries maximum number of tries per step
--
-------------------------------------------------------------------------------
function spawning.register_spawner_entity(spawning_data,spawnfunc,surfacefunc,suffix,max_tries)
	if suffix == nil then
		suffix = ""
	end

	if max_tries == nil then
		max_tries = 25
	end

	mobf_assert_backtrace(type(spawning_data) == "table")
	mobf_assert_backtrace(type(spawnfunc) == "function")
	mobf_assert_backtrace(surfacefunc == nil or type(surfacefunc) == "function")
	mobf_assert_backtrace(spawning_data.respawndelay ~= nil)
	mobf_assert_backtrace(type(spawning_data.respawndelay) == "number")

	local spawner_texture = "invisible.png^[makealpha:128,0,0^[makealpha:128,128,0"
	local spawner_collisionbox = { 0.0,0.0,0.0,0.0,0.0,0.0}
	local punchfct = nil

	if minetest.world_setting_get("mobf_show_spawners") then
		spawner_texture = "spawner.png"
		spawner_collisionbox = { -0.5,-0.5,-0.5,0.5,0.5,0.5 }
		punchfct = function(self,puncher,time_from_last_punch, tool_capabilities, direction)
				if puncher ~= nil and
					puncher:is_player() then

					local playername = puncher:get_player_name()

					if playername ~= nil then
						local pos = self.object:getpos()
						local min_light_around = mobf_min_light_around(pos,5,0.5)
						local air_around = minetest.find_nodes_in_area(
							{ x=pos.x-2,y=pos.y-2,z=pos.z-2 },
							{ x=pos.x+2,y=pos.y+2,z=pos.z+2},
							 { "air" } )
						local ycheck = "false"
						if self.spawner_mob_spawndata.relaxed_y_check then
							ycheck = "true"
						end
						mobf_print("MOBF: punched spawner: " .. self.name ..
							" spawning: " .. self.spawner_mob_name ..
							" spawner suffix " .. self.spawner_suffix ..
							" air_around: " .. #air_around ..
							" min_light: " .. min_light_around ..
							" ignore y check: " .. ycheck)
					end
				end
			end
	end

	dbg_mobf.spawning_lvl2("MOBF: register spawner entity: \"" .. spawning_data.name .. "_spawner" .. suffix .. "\"")
	minetest.register_entity(spawning_data.name .. "_spawner" .. suffix,
		 {
			physical        = false,
			collisionbox    = spawner_collisionbox,
			visual          = "sprite",
			textures        = { spawner_texture },
			mobf_spawner    = true,
			groups          = { "immortal" },

			on_step = function(self,dtime)
				local starttime = mobf_get_time_ms()
				self.spawner_time_passed = self.spawner_time_passed -dtime

				if self.surfacefunc == nil then
					if self.spawner_surfacefunc ~= nil then
						if self.spawner_miny ~= nil and
							self.spawner_maxy ~= nil then

							self.surfacefunc = function(x,y,miny,maxy)
									return self.spawner_surfacefunc(x,y,self.spawner_miny,self.spawner_maxy)
								end
						else
							self.surfacefunc = self.spawner_surfacefunc
						end
					else
						self.surfacefunc = mobf_get_surface
					end
				end

				local surfacefunc = self.surfacefunc

				--self.spawner_time_passed has to be handled by spawnfunc!
				if self.spawner_time_passed < 0 then
					local successfull = false
					local spawnerpos = self.object:getpos()

					--find random pos around
					for try=1,max_tries,1 do
						local newpos = {}
						local continue = false

						--find a random new position
						local max_offset = 0.4*self.spawner_mob_spawndata.density

						newpos.x = math.floor(spawnerpos.x +
								math.random(0,max_offset) +
								0.5)
						newpos.z = math.floor(spawnerpos.z +
								math.random(0,max_offset) +
								0.5)

						dbg_mobf.spawning_lvl2(
							"MOBF: trying to get new random value, max_offset:" ..
							max_offset .. " checking pos: " .. printpos(newpos) .. " spawnerpos.y=" .. spawnerpos.y)

						newpos.y = mobf_get_surface(newpos.x,newpos.z,spawnerpos.y-10, spawnerpos.y+10)

						--NOT required for flying mobs
						if spawning_data.relaxed_y_check and newpos.y == nil then
							newpos.y = spawnerpos.y
						end

						if newpos.y == nil then
							dbg_mobf.spawning_lvl2("MOBF: didn't find surface")
							continue = true
						end

						if not spawning_data.relaxed_y_check then

							--check if minimum height at random pos is given
							if not continue then
								--check if there s enough space above to place mob
								if spawning_data.height ~= nil and
								mobf_air_above(newpos,
									self.spawner_mob_spawndata.height) ~= true then
									dbg_mobf.spawning_lvl2("MOBF: not enough air above")
									continue = true
								end
							end

							--check if new position is suitable for mob
							if not continue then
								--check if pos is ok
								if not environment.evaluate_state(
													spawning.pos_quality(self.spawner_mob_spawndata,newpos),
													LT_SAFE_POS) then
									dbg_mobf.spawning_lvl2("MOBF: not a safe pos")
									continue = true
								end
							end

							--don't spawn directly inside another mob
							if not continue then
								continue = spawning.position_in_use(newpos,
														self.spawner_mob_spawndata)
							end

							--check population density
							if not continue then
								continue = spawning.population_density_limit(newpos,
														self.spawner_mob_spawndata)
							end
						end

						--now try to spawn
						if not continue then
							local pos_below = {x=newpos.x,y=newpos.y-1,z=newpos.z }
							if spawnfunc(self.spawner_mob_spawndata,pos_below,self) then
								self.spawner_time_passed = self.spawner_mob_spawndata.respawndelay
								dbg_mobf.spawning_lvl2("MOBF: succesfully spawned")
								successfull = true
								break --break for loop
							else
								dbg_mobf.spawning_lvl2("MOBF: failed to spawn")
							end
						end
					end

					--if we didn't find a pos try again a little bit faster
					if not successfull then
						self.spawner_time_passed = self.spawner_mob_spawndata.respawndelay/2
					end
				end
				mobf_warn_long_fct(starttime,
					"spawner_entity_onstep_" .. self.spawner_mob_name,"spawn_onstep")
			end,

			on_activate = function(self,staticdata)
				local pos = self.object:getpos()
				dbg_mobf.spawning_lvl2("MOBF: spawner for mob: " ..
							self.spawner_mob_name .. " at " .. printpos(pos))
				local starttime = mobf_get_time_ms()
				if self.spawner_mob_transform == nil then
					self.spawner_mob_transform = ""
				end
				self.object:set_armor_groups({immortal=100})
				--TODO honor time since deactivation
				self.spawner_time_passed     = 1
				mobf_warn_long_fct(starttime,"spawner_entity_activate","spawn_onstep")
			end,

			on_punch = punchfct,

			spawner_mob_name        = spawning_data.name,
			spawner_mob_transform   = spawning_data.name_secondary,
			spawner_time_passed     = 1,
			spawner_mob_spawndata   = spawning_data,
			spawner_surfacefunc     = surfacefunc,
			spawner_suffix          = suffix,
		})
end

------------------------------------------------------------------------------
-- name: register_cleanup_spawner(mobname)
-- @function [parent=#spawning] register_cleanup_spawner
--
--! @brief register an entity to cleanup spawners
--! @memberof spawning
--
--! @param mobname mobname to create cleanup
-------------------------------------------------------------------------------
function spawning.register_cleanup_spawner(mobname)
	minetest.register_entity(mobname .. "_spawner",
		{
			on_activate = function(self,staticdata)
				self.object:remove()
			end
		})
end


------------------------------------------------------------------------------
-- name: setup_algorithm(mob)
-- @function [parent=#spawning] setup_algorithm
--
--! @brief set up a specific algorithm for a mob
--! @memberof spawning
--
--! @param primary_name name of mob
--! @param secondary_name name of mob (when harvested)
--! @param parameters spawning parameters
--! @param envid identifyer for environment of mob
--! @param collisionbox collisionbox of mob
-------------------------------------------------------------------------------
function spawning.setup_algorithm(primary_name,secondary_name,parameters,envid,collisionbox)

	if type(parameters) == "table" then

		if mobf_spawn_algorithms[parameters.algorithm] ~= nil and
			type(mobf_spawn_algorithms[parameters.algorithm].initialize_spawning) == "function" then
			dbg_mobf.spawning_lvl2("MOBF: algorithm: " .. parameters.algorithm)
			dbg_mobf.spawning_lvl2("MOBF: " .. dump(primary_name) .. " " ..
				dump(secondary_name) .. " " .. dump(parameters) .. " " ..
				dump(envid))

			local spawning_data = minetest.deserialize(minetest.serialize(parameters))

			spawning_data.name = primary_name
			spawning_data.name_secondary = secondary_name
			spawning_data.environment = environment_list[envid]
			spawning_data.collisionbox = collisionbox

			mobf_spawn_algorithms[parameters.algorithm].initialize_spawning(spawning_data)
		else
			dbg_mobf.spawning_lvl2("MOBF: setup algorithm: invalid algorithm identifier")
		end
	else
		dbg_mobf.spawning_lvl2("MOBF: setup algorithm: no spawndata specified")
	end
end

------------------------------------------------------------------------------
-- name: population_density_get_min(entity)
-- @function [parent=#spawning] population_density_get_min
--
--! @brief get minimum density for this mob
--! @memberof spawning
--
--! @param entity the mob itself
--
--! @return minimum density over all spawners defined for this mob
-------------------------------------------------------------------------------
function spawning.population_density_get_min(entity)
	if type(entity.data.spawning.primary_algorithms) == "table" then
		local density = nil
		for i=1 , #entity.data.spawning.primary_algorithms , 1 do
			if density == nil or
				entity.data.spawning.primary_algorithms[i].density < density then

				density = entity.data.spawning.primary_algorithms[i].density
			end
		end
		return density
	else
		return entity.data.spawning.density
	end
end

------------------------------------------------------------------------------
-- name: collisionbox_get_max(entity)
-- @function [parent=#spawning] collisionbox_get_max
--
--! @brief get maximum extent of mob
--! @memberof spawning
--
--! @param mob mob specification
--
--! @return a collisionbox covering all state collisionboxes
-------------------------------------------------------------------------------
function spawning.collisionbox_get_max(mob)

	--use 1 block as minimum for spawning
	local retval = {-0.5,-0.5,-0.5,0.5,0.5,0.5}

	--check all states if there's some collisionbox that requires more room
	for i=1,#mob.states,1 do
		if mob.states[i] ~= nil and
			mob.states[i].graphics_3d ~= nil and
			type(mob.states[i].graphics_3d.collisionbox) == "table" then
				retval[1] = MIN(retval[1],mob.states[i].graphics_3d.collisionbox[1])
				retval[2] = MIN(retval[2],mob.states[i].graphics_3d.collisionbox[2])
				retval[3] = MIN(retval[3],mob.states[i].graphics_3d.collisionbox[3])
				retval[4] = MAX(retval[4],mob.states[i].graphics_3d.collisionbox[4])
				retval[5] = MAX(retval[5],mob.states[i].graphics_3d.collisionbox[5])
				retval[6] = MAX(retval[6],mob.states[i].graphics_3d.collisionbox[6])
			end
	end

	return retval
end

------------------------------------------------------------------------------
-- name: register_mob(mob)
-- @function [parent=#spawning] register_mob
--
--! @brief initialize spawn algorithms for a mob
--! @memberof spawning
--
--! @param mob definition
-------------------------------------------------------------------------------
function spawning.register_mob(mob)
	--spawn mechanism handling
	if not minetest.world_setting_get("mobf_disable_animal_spawning") then
		--register spawn callback to world
		if environment_list[mob.generic.envid] ~= nil then
			local secondary_name = ""
			if mob.harvest ~= nil then
				secondary_name = mob.harvest.transforms_to
			end

			dbg_mobf.spawning_lvl3("MOBF: Environment to use: " .. tostring(mob.generic.envid))

			if mob.spawning.algorithm == nil then
				dbg_mobf.spawning_lvl2("MOBF: Register spawning algorithms")
				if type(mob.spawning.primary_algorithms) == "table" then
					for i=1 , #mob.spawning.primary_algorithms , 1 do
						spawning.setup_algorithm(
								mob.modname..":"..mob.name,
								secondary_name,
								mob.spawning.primary_algorithms[i],
								mob.generic.envid,
								spawning.collisionbox_get_max(mob))
					end
				else
					dbg_mobf.spawning_lvl2("MOBF: " .. mob.name
						.. " no primary spawn algorithm defined! ")
				end

				if minetest.world_setting_get("mobf_animal_spawning_secondary") then
					if type(mob.spawning.secondary_algorithms) == "table" then
						for i=1 , #mob.spawning.secondary_algorithms , 1 do
							spawning.setup_algorithm(
									mob.modname..":"..mob.name,
									secondary_name,
									mob.spawning.secondary_algorithms[i],
									mob.generic.envid)
						end
					end
				end
			else
				minetest.log(LOGLEVEL_WARNING,"MOBF: legacy spawning declaration"
						.. " for mob: " .. mob.name
						.. "!!! not supported any longer!")
			end
		else
			minetest.log(LOGLEVEL_ERROR,"MOBF: specified mob >" .. mob.name
				.. "< without environment!")
		end
	else
		dbg_mobf.spawning_lvl3("MOBF: MOB spawning disabled!")
	end
end

------------------------------------------------------------------------------
-- name: divide_mapgen_jobfunc(mob)
-- @function [parent=#spawning] divide_mapgen_jobfunc
--
--! @brief job wrapper function for divide mapgen
--! @memberof spawning
--
--! @param data job data
-------------------------------------------------------------------------------
function spawning.divide_mapgen_jobfunc(data)
	local spawned = spawning.divide_mapgen(
			data.minp,
			data.maxp,
			data.spawning_data,
			data.spawnfunc,
			data.surfacefunc,
			1
			)
	if data.func ~= nil then
		data.maxtries = data.maxtries -1
		data.spawned = data.spawned + spawned
		local stopspawning = 3
		if data.stopspawning ~= nil then
			stopspawning = data.stopspawning
		end
		if data.spawned < stopspawning and
			data.maxtries > 0 then
			--requeue job
			mobf_job_queue.add_job({callback=data.func,data=data})
		end
	end
end

------------------------------------------------------------------------------
-- name: divide_mapgen_jobfunc(mob)
-- @function [parent=#spawning] divide_mapgen_jobfunc
--
--! @brief job wrapper function for divide mapgen
--! @memberof spawning
--
--! @param data job data
-------------------------------------------------------------------------------
function spawning.divide_mapgen_entity_jobfunc(data)
	local spawned = spawning.divide_mapgen_entity(
			data.minp,
			data.maxp,
			data.spawning_data,
			data.spawnfunc,
			1
			)
	data.maxtries = data.maxtries -1

	if data.spawned == nil then
		data.spawned = 0
	end

	if data.func ~= nil then
		mobf_assert_backtrace(spawned ~= nil)
		data.spawned = data.spawned + spawned
		local stopspawning = 3
		if data.stopspawning ~= nil then
			stopspawning = data.stopspawning
		end
		if data.spawned < stopspawning and
			data.maxtries > 0 then
			--requeue job
			mobf_job_queue.add_job({callback=data.func,data=data})
		end
	else
		mobf_assert_backtrace(data.maxtries <= 0)
	end
end

------------------------------------------------------------------------------
-- name: pos_quality(spawning_data,pos)
-- @function [parent=#spawning] pos_quality
--
--! @brief build a entity like datastructure to be passed to pos_quality check
--! @memberof spawning
--
--! @param spawning_data to check quality for
--! @param pos position to check quality at
--
--! @return a possition quality element
-------------------------------------------------------------------------------
function spawning.pos_quality(spawning_data,pos)
	local dummyentity = {}

	dummyentity.collisionbox = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
	dummyentity.environment = spawning_data.environment

	--TODO find a way to pass this information!
	dummyentity.data = {}
	dummyentity.data.movement = {}
	dummyentity.data.movement.canfly = false

	return environment.pos_quality(pos,dummyentity)
end

------------------------------------------------------------------------------
-- name: position_in_use(pos,spawndata)
-- @function [parent=#spawning] position_in_use
--
--! @brief check if there already is a mob at a specific position
--! @memberof spawning
--
--! @param pos position to check
--! @param spawndata data for this mob
--
--! @return true == mob present false == no mob
-------------------------------------------------------------------------------
function spawning.position_in_use(pos,spawndata)
	local mobcount = mobf_mob_around(
						spawndata.name,
						spawndata.name_secondary,
						pos,
						1.5,true)
	if mobcount > 0 then
		dbg_mobf.spawning_lvl2("MOBF: mob at same pos")
		return true
	end

	return false
end

------------------------------------------------------------------------------
-- name: population_density_limit(pos,spawndata)
-- @function [parent=#spawning] population_density_limit
--
--! @brief check if population density limit is reached
--! @memberof spawning
--
--! @param pos position to check
--! @param spawndata data for this mob
--
--! @return true == mob present false == no mob
-------------------------------------------------------------------------------
function spawning.population_density_limit(pos,spawndata)
	mobf_assert_backtrace(spawndata ~= nil)
	mobf_assert_validpos(pos)
	mobf_assert_backtrace(spawndata.name ~= nil)
	mobf_assert_backtrace(spawndata.density ~= nil)
	local mobcount = mobf_mob_around(
						spawndata.name,
						spawndata.name_secondary,
						pos,
						spawndata.density,true)
	if mobcount > 0 then
		dbg_mobf.spawning_lvl2("MOBF: not spawning within pop density")
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: spawner_get_water_pos(pos,max_depth,min_y,max_y)
--
--! @brief find a position at x/z within some y limitations
--
--! @param pos position do spawn
--! @param min_depth min-y depth to spawn
--! @param max_depth max-y depth to spawn
--! @param min_y minimum y value of generated chunk
--! @param max_y maximum y value of generated chunk
-------------------------------------------------------------------------------
function spawning.spawner_get_water_pos(pos,min_depth,max_depth,min_y,max_y)
	--get information about current position
	local upper_pos = {x=pos.x,y=max_y,z=pos.z}

	mobf_assert_backtrace(type(min_depth) == "number")
	mobf_assert_backtrace(type(max_depth) == "number")

	if max_depth > max_y then
		dbg_mobf.spawning_lvl3("MOBF: get_water_pos to deep")
		return nil
	end

	if min_depth < min_y then
		dbg_mobf.spawning_lvl3("MOBF: get_water_pos to high")
		return nil
	end

	local ground_distance = mobf_ground_distance(upper_pos,
							{ "default:water_flowing",
								"default:water_source",
								"air" },max_y - min_y)
	local ground_level = max_y - ground_distance +1

	local ground_pos = {x=pos.x,y=ground_level,z=pos.z }
	local water_depth = mobf_air_distance(ground_pos)

	local surfacenode = minetest.get_node(ground_pos)



	if surfacenode == nil then
		dbg_mobf.spawning_lvl3("MOBF: invalid ground node")
		return nil
	end

	if surfacenode.name ~= "default:water_flowing" and
		surfacenode.name ~= "default:water_source" then
		--mobf_print("MOBF: WD:" .. water_depth .. " GD: " .. ground_distance)
		--mobf_print("MOBF: MAXD:" .. max_depth .. " " .. min_y .. "<->" .. max_y)
		dbg_mobf.spawning_lvl3("MOBF: " .. surfacenode.name .. " isn't open water: " .. printpos(ground_pos))
		--if ground_pos.y > 0 then
		--	for i=min_y,max_y,1 do
		--		local node = minetest.get_node({x=pos.x,y=i,z=pos.z})
		--		print("i=" .. i .. " : " .. node.name)
		--	end
		--end
		return nil
	end

	if water_depth <= 0 then
		dbg_mobf.spawning_lvl3("MOBF: water not found! GP: " .. ground_level .. " WD: " .. water_depth)
		--TODO spawn in caves?
		return nil
	end

	local water_surface_pos = {x=pos.x,y=ground_level + water_depth,z=pos.z}

	--dbg_mobf.spawning_lvl2
	dbg_mobf.spawning_lvl3("MOBF: mobf_spawner_get_water_pos GL: " ..
				ground_level ..
				" WDPT: " .. water_depth ..
				" WSP: " .. printpos(water_surface_pos))
	if MAX(ground_level,max_depth) > water_surface_pos.y then
		mobf_print("MOBF: WD:" .. water_depth .. " GD: " .. ground_distance)
		mobf_print("MOBF: MAXD:" .. max_depth .. " " .. min_y .. "<->" .. max_y)
		mobf_print("MOBF: mobf_spawner_get_water_pos GL: " ..
				ground_level ..
				" WDPT: " .. water_depth ..
				" WSP: " .. printpos(water_surface_pos))
		--this can happen if there are air bubbles within water
		--mobf_assert_backtrace(MAX(ground_level,max_depth) < water_surface_pos.y)
		return nil
	end

	--check if there is any chance to find a suitable pos
	if MAX(ground_level,max_depth) >= MIN(water_surface_pos.y,min_depth) then
		return nil
	end

	pos.y = math.floor(
				math.random(
					MAX(ground_level,max_depth),
					MIN(water_surface_pos.y,min_depth)
					)
				 + 0.5)
	return pos
end

--include spawn algorithms
dofile (mobf_modpath .. "/spawn_algorithms/at_night.lua")
dofile (mobf_modpath .. "/spawn_algorithms/forrest.lua")
dofile (mobf_modpath .. "/spawn_algorithms/in_shallow_water.lua")
dofile (mobf_modpath .. "/spawn_algorithms/shadows.lua")
dofile (mobf_modpath .. "/spawn_algorithms/willow.lua")
dofile (mobf_modpath .. "/spawn_algorithms/big_willow.lua")
dofile (mobf_modpath .. "/spawn_algorithms/in_air1.lua")
dofile (mobf_modpath .. "/spawn_algorithms/none.lua")
dofile (mobf_modpath .. "/spawn_algorithms/deep_large_caves.lua")
dofile (mobf_modpath .. "/spawn_algorithms/deep_water.lua")