-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file in_air1.lua
--! @brief spawn algorithm for birds
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local AIR_ABOVE_GRASS_SPAWNER_SUFFIX = "_air_above_grass"

function mobf_random_air_y_pos(x,z,min_y,max_y)

	local surface = mobf_get_surface(x,z,min_y,max_y)

	if surface == nil then
		--try again with 10 less to avoid spawning below minimum height
		surface = mobf_get_surface(x,z,min_y-10,max_y)

		if surface == nil then
			local node_min = minetest.get_node({x=x,y=min_y,z=z})

			if node_min.name ~= "air" then
				return nil
			else
				surface = min_y
			end
		end
	end

	--spawn at least at height of 10
	surface = surface +10

	if max_y <= surface then
		return nil
	end

	local retval = {
		x=x,
		y= math.floor(math.random(surface,MIN(max_y,surface)) + 0.5),
		z=z
		}

	return retval
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_air_above_grass_spawner_spawnfunc(spawning_data,pos)
--
--! @brief function to spawn a spawner entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_air_above_grass_spawner_spawnfunc(spawning_data,pos)

	mobf_assert_backtrace(type(spawning_data.minp) == "number")
	mobf_assert_backtrace(type(spawning_data.maxp) == "number")

	local min_y = spawning_data.minp
	local max_y = spawning_data.maxp

	pos = mobf_random_air_y_pos(pos.x,pos.z,min_y,max_y)

	if pos == nil then
		return false
	end

	mobf_assert_validpos(pos)

	local spawner = spawning.spawn_and_check(spawning_data.name .. "_spawner",pos,"air_above_grass")

	if spawner == nil then
		return false
	else
		spawner.spawner_miny = min_y
		spawner.spawner_maxy = max_y
		return true
	end
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_air_above_grass_spawnfunc(spawning_data,pos)
--
--! @brief function to spawn a mob entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_air_above_grass_spawnfunc(spawning_data,pos)

	local spawnpos = mobf_random_air_y_pos(pos.x,pos.z,pos.y,pos.y+20)

	--mobf_print("MOBF: SP: " .. printpos(pos) .. " NP: " .. printpos(spawnpos))

	if spawnpos == nil then
		return false
	end

	local node = minetest.get_node(spawnpos)

	if node.name ~= "air" then
		mobf_print("MOBF: invalid pos: " .. printpos(spawnpos) .. " " .. node.name)
		return false
	end

	if not mobf_air_above(spawnpos,10) then
		return false
	end

	spawning.spawn_and_check(spawning_data.name,spawnpos,"air_above_grass")
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_air_above_grass_abm(spawning_data)
--
--! @brief find a place in sky to spawn mob
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------

function mobf_spawner_initialize_air_above_grass_abm(spawning_data)

	minetest.log(LOGLEVEL_INFO,
		"MOBF:\tregistering in air 1 spawn abm callback for mob "..
		spawning_data.name)

	local media = nil

	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media
	end

	minetest.register_abm({
			nodenames = { "default:dirt", "default:dirt_with_grass" },
			neighbors = media,
			interval = 3600,
			chance = math.floor(1/spawning_data.rate),
			action = function(pos, node, active_object_count, active_object_count_wider)
				local starttime = mobf_get_time_ms()

				pos = mobf_random_air_y_pos(pos.x,pos.z,pos.y,pos.y+20)

				--TODO check

				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_air_above_grass_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_air_above_grass_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_air_above_grass_mapgen(spawning_data)
--
--! @brief a spawner based spawn spawn algorithm
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_air_above_grass_mapgen(spawning_data)

	spawning.register_spawner_entity(
				spawning_data,
				mobf_spawner_air_above_grass_spawnfunc,
				mobf_random_air_y_pos)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {
				callback = spawning.divide_mapgen_entity_jobfunc,
				data = {
					minp          = minp,
					maxp          = maxp,
					spawning_data = spawning_data,
					spawnfunc     = mobf_spawner_air_above_grass_spawner_spawnfunc,
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
				spawning.divide_mapgen_entity(minp,maxp,spawning_data,
											mobf_spawner_air_above_grass_spawner_spawnfunc)
				mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
			end) --register mapgen
	end

end

--!@}

spawning.register_spawn_algorithm("in_air1", mobf_spawner_initialize_air_above_grass_abm)
spawning.register_spawn_algorithm("in_air1_spawner",
									mobf_spawner_initialize_air_above_grass_mapgen,
									spawning.register_cleanup_spawner)