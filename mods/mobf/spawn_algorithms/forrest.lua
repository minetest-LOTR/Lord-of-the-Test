-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file forrest.lua
--! @brief spawn algorithm for forrest spawning
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

MOBF_ADDITIONAL_TREE_NODES = {}

-------------------------------------------------------------------------------
-- name: mobf_spawner_in_forrest_spawnfunc(spawning_data,pos)
--
--! @brief find a place in the forrest to spawn an mob
--
--! @param spawning_data spawning configuration
--! @param pos position to spawn at
-------------------------------------------------------------------------------
function mobf_spawner_in_forrest_spawnfunc(spawning_data,pos)
	mobf_assert_validpos(pos)

	local tree_around = false

	--check if tree around
	if (minetest.find_node_near(pos, 8, { "default:leaves" } ) ~= nil) and
		(minetest.find_node_near(pos, 5, { "default:tree"} ) ~= nil) or
		minetest.find_node_near(pos, 8, MOBF_ADDITIONAL_TREE_NODES ) ~= nil then
		tree_around = true
	end


	if tree_around then
		local spawnpos = {x=pos.x,y=pos.y+1,z=pos.z}
		spawning.spawn_and_check(spawning_data.name,spawnpos,"in_forrest_mapgen")
		return true
	end
	return false
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_in_forrest_abm(spawning_data)
--
--! @brief find a place in the forrest to spawn an mob
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_in_forrest_abm(spawning_data)
	minetest.log(LOGLEVEL_WARNING,"MOBF: using deprecated abm based spawn algorithm \"spawn_in_forrest\" most likely causing lag in server!\t Use spawn_in_forrest_mapgen instead!")
	minetest.log(LOGLEVEL_INFO,"MOBF:\tregistering forrest spawn abm callback for mob ".. spawning_data.name)

	local media = nil

	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media
	end

	minetest.register_abm({
			nodenames = { "default:dirt_with_grass" },
			neighbors = media,
			interval = 60,
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
				if mobf_pos_is_zero(pos) then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_forrest_abm_r1")
					return
				end

				--check if there s enough space above to place mob
				if spawning_data.height ~= nil and mobf_air_above(pos,spawning_data.height) ~= true then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_forrest_abm_r2")
					return
				end

				--check if pos is ok
				if not environment.evaluate_state(
									spawning.pos_quality(spawning_data,pos_above),
									LT_SAFE_POS) then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_forrest_abm_r3")
					return
				end

				--check population density
				if mobf_mob_around(spawning_data.name,
									spawning_data.name_secondary,
									pos_above,spawning_data.density,true) > 0 then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_forrest_abm_r4")
					return
				end

				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_in_forrest_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_in_forrest_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_in_forrest_mapgen(spawning_data)
--
--! @brief find a place in the forrest to spawn an mob on mapgen
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_in_forrest_mapgen(spawning_data)

	minetest.log(LOGLEVEL_INFO,
		"MOBF:\tregistering forrest spawn mapgen callback for mob "..
		spawning_data.name)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {
				callback = spawning.divide_mapgen_jobfunc,
				data = {
					minp          = minp,
					maxp          = maxp,
					spawning_data = spawning_data,
					spawnfunc     = mobf_spawner_in_forrest_spawnfunc,
					surfacefunc   = mobf_get_sunlight_surface,
					maxtries      = 5
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
									mobf_spawner_in_forrest_spawnfunc,
									mobf_get_sunlight_surface,
									5)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
			end) --register mapgen
	end
end --end spawn algo

--!@}

spawning.register_spawn_algorithm("forrest_mapgen", mobf_spawner_initialize_in_forrest_mapgen)
spawning.register_spawn_algorithm("forrest", mobf_spawner_initialize_in_forrest_abm)