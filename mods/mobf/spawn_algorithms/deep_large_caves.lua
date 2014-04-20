-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file deep_large_caves.lua
--! @brief spawn algorithm to spawn in deep large caves
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
local DEEP_LARGE_CAVE_SURFACES = { "default:stone","default:gravel","default:dirt" }
local DEEP_LARGE_CAVE_SPAWNER_SUFFIX = "_deep_large_cave"
-------------------------------------------------------------------------------
-- name: mobf_spawner_deep_large_caves_spawner_spawnfunc(spawning_data,pos,min_y,max_y)
--
--! @brief function to spawn a spawner entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_deep_large_caves_spawner_spawnfunc(spawning_data,pos)

	mobf_assert_backtrace(type(spawning_data.minp) == "number")
	mobf_assert_backtrace(type(spawning_data.maxp) == "number")

	local min_y = spawning_data.minp
	local max_y = spawning_data.maxp

	pos.y = math.floor(math.random(min_y,max_y) + 0.5)

	if pos.y > spawning_data.min_depth then
		dbg_mobf.spawning_lvl3("MOBF: min depth requirement not met")
		return false
	end

	spawning.spawn_and_check(spawning_data.name .. "_spawner" .. DEEP_LARGE_CAVE_SPAWNER_SUFFIX,
								pos,
								"deep_large_caves_spawner")
	return true
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_at_night_spawnfunc(spawning_data,pos)
--
--! @brief function to spawn a mob entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_deep_large_caves_spawnfunc(spawning_data,pos)
	mobf_assert_validpos(pos)
	mobf_assert_backtrace(type(spawning_data) == "table")

	local node = minetest.get_node(pos)
	local pos_above = { x=pos.x,y=pos.y+1,z=pos.z }

	if not mobf_contains(DEEP_LARGE_CAVE_SURFACES,node.name) then
		dbg_mobf.spawning_lvl3(
			"MOBF: node ain't of correct type: " .. node.name)
		return false
	end

	if pos.y > spawning_data.min_depth then
		dbg_mobf.spawning_lvl3("MOBF: min depth requirement not met")
		return false
	end

	spawning.spawn_and_check(spawning_data.name,pos_above,"deep_large_caves")
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_deep_large_caves_abm(spawning_data)
--
--! @brief initialize spawner to find a place in a deep large cave
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------

function mobf_spawner_initialize_deep_large_caves_abm(spawning_data)

	minetest.log(LOGLEVEL_INFO,
		"MOBF:\tregistering shadow spawn abm callback for mob "..spawning_data.name)

	local media = nil

	if spawning_data.environment ~= nil and
		spawning_data.environment.media ~= nil then
		media = spawning_data.environment.media
	end

	minetest.register_abm({
			nodenames = DEEP_LARGE_CAVE_SURFACES,
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
					dbg_mobf.spawning_lvl1("MOBF: not spawning due to 0 pos")
					mobf_warn_long_fct(starttime,"mobf_spawn_in_deep_large_caves_abm_r1")
					return
				end

				--check if there s enough space above to place mob
				if spawning_data.height ~= nil and mobf_air_above(pos,spawning_data.height) ~= true then
					dbg_mobf.spawning_lvl3("MOBF: height requirement not met")
					mobf_warn_long_fct(starttime,"mobf_spawn_in_deep_large_caves_abm_r2")
					return
				end

				--check if pos is ok
				if not environment.evaluate_state(
									spawning.pos_quality(spawning_data,pos_above),
									LT_SAFE_POS) then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_deep_large_caves_abm_r3")
					return
				end

				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_deep_large_caves_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_in_deep_large_caves_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_deep_large_caves_mapgen(spawning_data)
--
--! @brief initialize spawner to find a place in a deep large cave
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_deep_large_caves_mapgen(spawning_data)

	spawning.register_spawner_entity(spawning_data,
		mobf_spawner_deep_large_caves_spawnfunc,
		nil,
		DEEP_LARGE_CAVE_SPAWNER_SUFFIX)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {

						callback = spawning.divide_mapgen_entity_jobfunc,
						data = {
							minp          = minp,
							maxp          = maxp,
							spawning_data = spawning_data,
							spawnfunc     = mobf_spawner_deep_large_caves_spawner_spawnfunc,
							maxtries      = 30,
							spawned       = 0,
							func          = spawning.divide_mapgen_entity_jobfunc
							}
						}
			mobf_job_queue.add_job(job)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name .. "_job_queued","mapgen")
		end)
	else
		--add mob spawner on map generation
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			spawning.divide_mapgen_entity(minp,maxp,spawning_data,
										mobf_spawner_deep_large_caves_spawner_spawnfunc)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
		end) --register mapgen
	end

end
--!@}

spawning.register_spawn_algorithm("deep large caves", mobf_spawner_initialize_deep_large_caves_abm)
spawning.register_spawn_algorithm("deep_large_caves_spawner",
									mobf_spawner_initialize_deep_large_caves_mapgen,
									spawning.register_cleanup_spawner)