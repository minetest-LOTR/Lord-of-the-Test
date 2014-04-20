-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file at_night.lua
--! @brief component containing spawning features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--TODO use environment!
local AT_NIGHT_SPAWNER_SURFACES = { "default:stone","default:dirt_with_grass","default:dirt","default:desert_stone","default:desert_sand" }
local AT_NIGHT_SPAWNER_SUFFIX = "_at_night"

-------------------------------------------------------------------------------
-- name: mobf_spawner_at_night_spawner_spawnfunc(spawning_data,pos,min_y,max_y)
--
--! @brief function to spawn a spawner entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_at_night_spawner_spawnfunc(spawning_data,pos)

	mobf_assert_backtrace(type(spawning_data.minp) == "number")
	mobf_assert_backtrace(type(spawning_data.maxp) == "number")

	local min_y = spawning_data.minp
	local max_y = spawning_data.maxp

	--check if there's a surface around the selected pos
	pos.y = mobf_get_surface(pos.x,pos.z,min_y,max_y)

	--there's no surface get a random value and check if spawner is not in air
	if pos.y == nil then
		pos.y = math.floor(math.random(min_y,max_y) + 0.5)
		local spawner_node = minetest.get_node(pos)

		-- we don't spawn this one up in the air
		if spawner_node.name == "air" then
			return false
		end
	end

	mobf_assert_validpos(pos)

	spawning.spawn_and_check(spawning_data.name .. "_spawner" ..AT_NIGHT_SPAWNER_SUFFIX,
								pos,
								"at_night_spawner")
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
function mobf_spawner_at_night_spawnfunc(spawning_data,pos)
	local gametime = minetest.get_timeofday()

	--not time to spawn don't try again to soon
	if gametime > 0.20 and
		gametime < 0.75 then
		return true
	end

	local node = minetest.get_node(pos)

	if not mobf_contains(AT_NIGHT_SPAWNER_SURFACES,node.name) then
		dbg_mobf.spawning_lvl3(
			"MOBF: node ain't of correct type: " .. node.name)
		return false
	end

	local pos_above = { x=pos.x,y=pos.y+1,z=pos.z }

	if not (minetest.get_node_light(pos_above,0.5) == LIGHT_MAX +1) or
		not (minetest.get_node_light(pos_above,0.0) < 7) or
		not (minetest.get_node_light(pos_above) < 6) then
		return false
	end

	spawning.spawn_and_check(spawning_data.name,pos_above,"at_night")
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_at_night_abm(spawning_data)
--
--! @brief initialize at night abm based spawner
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_at_night_abm(spawning_data)

	print("\tregistering night spawn abm callback for mob "..spawning_data.name)

	local media = nil

	if spawning_data.environment ~= nil and
		spawning_data.environment.media ~= nil then
		media = spawning_data.environment.media
	end

	minetest.register_abm({
			nodenames = AT_NIGHT_SPAWNER_SURFACES,
			neighbors = media,
			interval = 20,
			chance = math.floor(1/spawning_data.rate),
			action = function(pos, node, active_object_count, active_object_count_wider)
				local starttime = mobf_get_time_ms()
				local pos_above = { x = pos.x, y = pos.y + 1, z = pos.z }

				--never try to spawn an mob at pos (0,0,0) it's initial entity spawnpos and
				--used to find bugs in initial spawnpoint setting code
				if mobf_pos_is_zero(pos) then
					mobf_warn_long_fct(starttime,"mobf_spawn_at_night_abm_r1")
					return
				end

				--check if there s enough space above to place mob
				if spawning_data.height ~= nil and  mobf_air_above(pos,spawning_data.height) ~= true then
					mobf_warn_long_fct(starttime,"mobf_spawn_at_night_abm_r2")
					return
				end

				--check if pos is ok
				if not environment.evaluate_state(
									spawning.pos_quality(spawning_data,pos_above),
									LT_SAFE_POS) then
					mobf_warn_long_fct(starttime,"mobf_spawn_at_night_abm_r3")
					return
				end

				--check population density
				if mobf_mob_around(spawning_data.name,
									spawning_data.name_secondary,
									pos_above,spawning_data.density,true) > 0 then
					mobf_warn_long_fct(starttime,"mobf_spawn_at_night_abm_r4")
					return
				end
				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_at_night_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_at_night_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_at_night_mapgen(spawning_data)
--
--! @brief initialize at night mapgen based spawner
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_at_night_mapgen(spawning_data)
	minetest.log(LOGLEVEL_INFO,"MOBF:\tregistering at night mapgen spawn mapgen callback for mob "..spawning_data.name)

	spawning.register_spawner_entity(spawning_data,
				mobf_spawner_at_night_spawnfunc,
				nil,
				AT_NIGHT_SPAWNER_SUFFIX)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {
				callback = spawning.divide_mapgen_entity_jobfunc,
				data = {
					minp          = minp,
					maxp          = maxp,
					spawning_data = spawning_data,
					spawnfunc     = mobf_spawner_at_night_spawner_spawnfunc,
					maxtries      = 5,
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
										mobf_spawner_at_night_spawner_spawnfunc)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
		end) --register mapgen
	end
 end --end spawn algo

--!@}

spawning.register_spawn_algorithm("at_night", mobf_spawner_initialize_at_night_abm)
spawning.register_spawn_algorithm("at_night_spawner",
									mobf_spawner_initialize_at_night_mapgen,
									spawning.register_cleanup_spawner)