-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file willow.lua
--! @brief spawn algorithm willow
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: mobf_spawner_big_willow_spawnfunc(spawning_data,pos)
--
--! @brief find a place on big willow to spawn a mob
--
--! @param spawning_data spawning configuration
--! @param pos position to spawn at
-------------------------------------------------------------------------------
function mobf_spawner_big_willow_spawnfunc(spawning_data,pos)

	--check if there's a flat plane surrounding the spawnpos
	--as well as enough room above that plane
	local pos_is_big_willow = true

	for x=pos.x-2,pos.x+2,1 do
	for z=pos.z-2,pos.z+2,1 do
		local node_to_check = minetest.get_node({x=x,y=pos.y,z=z})
		if node_to_check == nil or
			node_to_check.name ~= "default:dirt_with_grass" then
			pos_is_big_willow = false
			break
		end

		--check if there s enough space above to place mob
		if not mobf_air_above({x=x,y=pos.y,z=z},spawning_data.height) then
			pos_is_big_willow = false
			break
		end
	end
	end

	--evaluate checks
	if pos_is_big_willow then
		dbg_mobf.spawning_lvl3("willow is big enough " ..printpos(centerpos))
		local spawnpos = {x=pos.x,y=pos.y+1,z=pos.z}
		spawning.spawn_and_check(spawning_data.name,spawnpos,"on_big_willow_mapgen")
		return true
	end

	return false
end


-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_on_big_willow_abm(spawning_data)
--
--! @brief find a place on big willow to spawn a mob
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_on_big_willow_abm(spawning_data)
	minetest.log(LOGLEVEL_WARNING,"MOBF: using deprecated abm based spawn algorithm \"spawn_on_willow\" most likely causing lag in server!\t Use spawn_on_willow_mapgen instead!")
	minetest.log(LOGLEVEL_INFO,"MOBF:\tregistering willow spawn abm callback for mob ".. spawning_data.name)

	local media = nil

	if spawning_data.environment ~= nil and
		spawning_data.environment.media ~= nil then
		media = spawning_data.environment.media
	end

	minetest.register_abm({
			nodenames = { "default:dirt_with_grass" },
			neighbors = media,
			interval = 7200,
			chance = math.floor(1/spawning_data.rate),
			action = function(pos, node, active_object_count, active_object_count_wider)
				local starttime = mobf_get_time_ms()
				local pos_above = {
					x = pos.x,
					y = pos.y + 1,
					z = pos.z
				}

				--never try to spawn an mob at pos (0,0,0) it's initial entity spawnpos and
				--used to find bugs in initial spawnpoint setting code
				if mobf_pos_is_zero(pos_above) then
					mobf_warn_long_fct(starttime,"mobf_spawn_on_big_willow_abm_r1")
					return
				end

				--check if there s enough space above to place mob
				if spawning_data.height ~= nil and mobf_air_above(pos_above,spawning_data.height) ~= true then
					mobf_warn_long_fct(starttime,"mobf_spawn_on_big_willow_abm_r2")
					return
				end

				--check if pos is ok
				if not environment.evaluate_state(
									spawning.pos_quality(spawning_data,pos_above),
									LT_SAFE_POS) then
					mobf_warn_long_fct(starttime,"mobf_spawn_on_big_willow_abm_r3")
					return
				end

				if mobf_mob_around(spawning_data.name,
									spawning_data.name_secondary,
									pos_above,spawning_data.density,true) > 0 then
					mobf_warn_long_fct(starttime,"mobf_spawn_on_big_willow_abm_r4")
					return
				end

				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_big_willow_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_on_big_willow_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawn_on_big_willow_mapgen(spawning_data)
--
--! @brief find a place on big willow to spawn a mob on map generation
--
--! @param spawning_data all information required for spawning
-------------------------------------------------------------------------------
function mobf_spawner_initialize_big_willow_mapgen(spawning_data)
	minetest.log(LOGLEVEL_INFO,"MOBF:\tregistering willow mapgen spawn mapgen callback for mob "..spawning_data.name)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {
				callback = spawning.divide_mapgen_jobfunc,
				data = {
					minp          = minp,
					maxp          = maxp,
					spawning_data = spawning_data,
					spawnfunc     = mobf_spawner_big_willow_spawnfunc,
					surfacefunc   = mobf_get_sunlight_surface,
					maxtries      = 20,
					spawned       = 0,
					func          = spawning.divide_mapgen_jobfunc
					}
				}
			mobf_job_queue.add_job(job)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name .. "_job_queued","mapgen")
		end)
	else
		--add mob on map generation
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			spawning.divide_mapgen(minp,maxp,
									spawning_data,
									mobf_spawner_big_willow_spawnfunc,
									mobf_get_sunlight_surface,
									20)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
		end)
	end
 end --end spawn algo
--!@}

spawning.register_spawn_algorithm("big_willow", mobf_spawner_initialize_on_big_willow_abm)
spawning.register_spawn_algorithm("big_willow_mapgen", mobf_spawner_initialize_big_willow_mapgen)