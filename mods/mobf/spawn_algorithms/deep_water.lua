-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file deep_water.lua
--! @brief spawn algorithm for deep water spawning
--! @copyright Sapier
--! @author Sapier
--! @date 2013-11-24
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local DEEP_WATER_MIN_DEPTH = -20
local DEEP_WATER_MAX_DEPTH = -50
local DEEP_WATER_SPAWNER_SUFFIX = "_deep_water"

-------------------------------------------------------------------------------
-- name: mobf_spawner_deep_water_spawner_spawnfunc(spawning_data,pos,self)
--
--! @brief function to spawn a spawner entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
--! @param self entity calling this function
-------------------------------------------------------------------------------
function mobf_spawner_deep_water_spawner_spawnfunc(spawning_data,pos,self)

	mobf_assert_backtrace(type(spawning_data.minp) == "number")
	mobf_assert_backtrace(type(spawning_data.maxp) == "number")

	local min_y = spawning_data.minp
	local max_y = spawning_data.maxp

	dbg_mobf.spawning_lvl3("spawning data: " .. dump(spawning_data))

	--check if we try to spawn in correct area
	if max_y < DEEP_WATER_MAX_DEPTH then
		dbg_mobf.spawning_lvl3("MOBF: deep water spawner --> to deep: " ..
			max_y .. " < " .. DEEP_WATER_MAX_DEPTH)
		return false
	end

	if min_y > DEEP_WATER_MIN_DEPTH then
		dbg_mobf.spawning_lvl3("MOBF: deep water spawner --> to high: " ..
			max_y .. " < " .. DEEP_WATER_MIN_DEPTH)
		return false
	end

	local waternodes = minetest.find_nodes_in_area({x=pos.x,y=min_y,z=pos.z},
									{x=pos.x,y=max_y,z=pos.z},
									{ "default:water_flowing",
									"default:water_source"} )
	--check for water
	if #waternodes == 0 then
		dbg_mobf.spawning_lvl3("MOBF: deep water spawner no water at position "
			.. printpos(pos) ..
			" " .. min_y .. "<->" .. max_y .. " found")
		return false
	end

	pos = spawning.spawner_get_water_pos(	pos,
										DEEP_WATER_MIN_DEPTH,
										DEEP_WATER_MIN_DEPTH,
										min_y,max_y)

	if pos == nil then
		dbg_mobf.spawning_lvl3(
			"MOBF: deep water spawnerunable to find a suitable depth at position "
			.. printpos(pos))
		return false
	end

	--only place a spawner if there's enough water around
	local found_nodes = minetest.find_nodes_in_area({x=pos.x-2,y=pos.y-2,z=pos.z-2},
														{x=pos.x+2,y=pos.y+2,z=pos.z+2},
														{ "default:water_flowing",
															"default:water_source"} )

	--maximum number of water nodes is 64 if less than half is water don't spawn here
	if #found_nodes < 32 then
		dbg_mobf.spawning_lvl3("MOBF: deep water spawner " .. printpos(pos) ..
		" not enough water around: " ..  #found_nodes)
		return false
	end

	local spawner = spawning.spawn_and_check(
								spawning_data.name .. "_spawner" ..
								DEEP_WATER_SPAWNER_SUFFIX,
								pos,
								"deep_water")

	if spawner == nil then
		return false
	else
		dbg_mobf.spawning_lvl3("MOBF: deep water spawner spawned at " ..
		printpos(pos))
		spawner.spawner_miny = min_y
		spawner.spawner_maxy = max_y
		return true
	end
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_deep_water_spawnfunc(spawning_data,pos)
--
--! @brief function to spawn a mob entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_deep_water_spawnfunc(spawning_data,pos)
	local node = minetest.get_node(pos)



	--first find a new water pos
	pos = spawning.spawner_get_water_pos(pos,
				DEEP_WATER_MIN_DEPTH,
				DEEP_WATER_MAX_DEPTH,
				pos.y+DEEP_WATER_MAX_DEPTH,
				MIN(0,pos.y-DEEP_WATER_MAX_DEPTH))

	if pos == nil then
		dbg_mobf.spawning_lvl2("MOBF: didn't find a pos in water")
		return false
	end

	--only place a spawner if it's within water
	local found_nodes = minetest.find_nodes_in_area(
								{x=pos.x-2,y=pos.y-2,z=pos.z-2},
								{x=pos.x+2,y=pos.y+2,z=pos.z+2},
								{ "default:water_flowing","default:water_source"} )

	--maximum number of water nodes is 64 if less than half is water don't spawn here
	if #found_nodes < 32 then
		dbg_mobf.spawning_lvl2("MOBF: spawner " .. printpos(pos) .. " not enough water around: " ..  #found_nodes)
		return false
	end

	--check if there is a mob right there
	if spawning.position_in_use(pos,spawning_data) then
		dbg_mobf.spawning_lvl2("MOBF: spawner " .. printpos(pos) .. " is in use")
		return false
	end

	--check popualation density limit
	if spawning.population_density_limit(pos,spawning_data) then
		dbg_mobf.spawning_lvl2("MOBF: spawner " .. printpos(pos) .. " to many mobs around")
		return false
	end

	local pos_above = { x=pos.x,y=pos.y+1,z=pos.z }

	local spawner = spawning.spawn_and_check(spawning_data.name,pos_above,"deep_water")

	if spawner == nil then
		return false
	end
end

-------------------------------------------------------------------------------
-- name: mobf_spawn_initialize_deep_water_abm(spawning_data)
--
--! @brief find a place in water to spawn mob
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------

function mobf_spawn_initialize_deep_water_abm(spawning_data)

	minetest.log(LOGLEVEL_INFO,
		"MOBF: \tregistering deep water spawn abm callback for mob "..
		spawning_data.name)

	local media = nil

	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media
	end

	minetest.register_abm({
			nodenames = { "default:water_source" },
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
					mobf_warn_long_fct(starttime,"mobf_spawn_deep_water_abm_r1")
					return
				end

				--check if pos is ok
				if not environment.evaluate_state(
									spawning.pos_quality(spawning_data,pos_above),
									LT_SAFE_POS) then
					mobf_warn_long_fct(starttime,"mobf_spawn_deep_water_abm_r2")
					return
				end

				--check population density
				if mobf_mob_around(spawning_data.name,
									spawning_data.name_secondary,
									pos_above,spawning_data.density,true) > 0 then
					mobf_warn_long_fct(starttime,"mobf_spawn_deep_water_abm_r3")
					return
				end

				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_deep_water_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_deep_water_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawn_initialize_deep_water_mapgen(spawning_data)
--
--! @brief find a place in deep water
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawn_initialize_deep_water_mapgen(spawning_data)
	minetest.log(LOGLEVEL_INFO,
		"MOBF:\tregistering in deep water mapgen spawn mapgen callback for mob "..
		spawning_data.name)

		--disable spawner entity y position check
		spawning_data.relaxed_y_check = true

	spawning.register_spawner_entity(spawning_data,
		mobf_spawner_deep_water_spawnfunc,
		nil, --TODO
		DEEP_WATER_SPAWNER_SUFFIX)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {
				callback = spawning.divide_mapgen_entity_jobfunc,
				data = {
					minp          = minp,
					maxp          = maxp,
					spawning_data = spawning_data,
					spawnfunc     = mobf_spawner_deep_water_spawner_spawnfunc,
					maxtries      = 15,
					func          = spawning.divide_mapgen_entity_jobfunc,
					}
				}
			mobf_job_queue.add_job(job)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name .. "_job_queued","mapgen")
		end)
	else
		--add mob spawner on map generation
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			spawning.divide_mapgen_entity(minp,maxp,
									spawning_data,
									mobf_spawner_deep_water_spawner_spawnfunc,
									15)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
		end) --register mapgen
	end
 end --end spawn algo
--!@}

spawning.register_spawn_algorithm("deep_water", mobf_spawn_deep_water)
spawning.register_spawn_algorithm("deep_water_spawner",
									mobf_spawn_initialize_deep_water_mapgen,
									spawning.register_cleanup_spawner)