-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file shadows.lua
--! @brief spawn algorithm for in shadow spawning
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local SHADOWS_SPAWNER_SURFACES = { "default:stone",
							"default:gravel",
							"default:dirt",
							"default:sand" }
local SHADOWS_SPAWNER_SUFFIX = "_shadows"

-------------------------------------------------------------------------------
-- name: mobf_spawner_in_shadows_spawner_spawnfunc(spawning_data,pos)
--
--! @brief function to spawn a spawner entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_in_shadows_spawner_spawnfunc(spawning_data,pos)

	mobf_assert_backtrace(type(spawning_data.minp) == "number")
	mobf_assert_backtrace(type(spawning_data.maxp) == "number")

	local min_y = spawning_data.minp
	local max_y = spawning_data.maxp

	pos.y = math.floor(math.random(min_y,max_y) + 0.5)

	local min_light_around = mobf_min_light_around(pos,2,0.5)
	local air_around_list = minetest.find_nodes_in_area(
							{ x=pos.x-2,y=pos.y-2,z=pos.z-2 },
							{ x=pos.x+2,y=pos.y+2,z=pos.z+2},
							 { "air","ignore" } )
	local air_around = 0

	if air_around_list ~= nil then
		air_around = #air_around_list
	end


	--if there's only sunlight around and we're not submerged
	if min_light_around > 6 and
		air_around > 60 then
		return false
	end
	--mobf_print("MLA:" .. min_light_around .. " AA: " .. air_around .. " POS: " .. printpos(pos))

	spawning.spawn_and_check(spawning_data.name .. "_spawner" .. SHADOWS_SPAWNER_SUFFIX,
								pos,
								"shadows_spawner")
	return true
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_in_shadows_spawnfunc(spawning_data,pos)
--
--! @brief function to spawn a mob entity
--
--! @param spawning_data spawning configuration
--! @param pos position do spawn
-------------------------------------------------------------------------------
function mobf_spawner_in_shadows_spawnfunc(spawning_data,pos)
	local node = minetest.get_node(pos)

	if not mobf_contains(SHADOWS_SPAWNER_SURFACES,node.name) then
		dbg_mobf.spawning_lvl3(
			"MOBF: node ain't of correct type: " .. node.name)
		return false
	end

	local pos_above = { x=pos.x,y=pos.y+1,z=pos.z }

	--check if its always in shadows
	for i=0.0,1,0.1 do
		if mobf_max_light_around(pos_above,1,i) > 6 then
			return false
		end
	end

	spawning.spawn_and_check(spawning_data.name,pos_above,"shadows")
end

-------------------------------------------------------------------------------
-- name: mobf_spawn_in_shadows(spawning_data)
--
--! @brief find a place with low light to spawn an mob
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------

function mobf_spawner_initialize_in_shadows_abm(spawning_data)

	minetest.log(LOGLEVEL_INFO,
		"MOBF:\tregistering shadow spawn abm callback for mob "..
		spawning_data.name)

	local media = nil

	if spawning_data.environment ~= nil and
		spawning_data.environment.media ~= nil then
		media = spawning_data.environment.media
	end

	minetest.register_abm({
			nodenames = SHADOWS_SPAWNER_SURFACES,
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
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows_abm_r1")
					return
				end

				--check if there s enough space above to place mob
				if spawning_data.height ~= nil and mobf_air_above(pos,spawning_data.height) ~= true then
					dbg_mobf.spawning_lvl3("MOBF: height requirement not met")
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows_abm_r2")
					return
				end

				--check if pos is ok
				if not environment.evaluate_state(
									spawning.pos_quality(spawning_data,pos_above),
									LT_SAFE_POS) then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows_abm_r3")
					return
				end

				--check population density
				if mobf_mob_around(spawning_data.name,
									spawning_data.name_secondary,
									pos_above,spawning_data.density,true) > 0 then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows_abm_r4")
					return
				end

				spawning_data.minp = pos.y
				spawning_data.maxp = pos.y

				mobf_spawner_in_shadows_spawner_spawnfunc(spawning_data,pos)
				mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows_abm_done")
			end,
		})
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_initialize_in_shadows_mapgen(spawning_data)
--
--! @brief initialize in shadows spawner
--
--! @param spawning_data spawning configuration
-------------------------------------------------------------------------------
function mobf_spawner_initialize_in_shadows_mapgen(spawning_data)

	spawning.register_spawner_entity(
				spawning_data,
				mobf_spawner_in_shadows_spawnfunc,
				nil,
				SHADOWS_SPAWNER_SUFFIX
				)

	if minetest.world_setting_get("mobf_delayed_spawning") then
		minetest.register_on_generated(function(minp, maxp, seed)
			local starttime = mobf_get_time_ms()
			local job = {
				callback = spawning.divide_mapgen_entity_jobfunc,
				data = {
					minp          = minp,
					maxp          = maxp,
					spawning_data = spawning_data,
					spawnfunc     = mobf_spawner_in_shadows_spawner_spawnfunc,
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
											mobf_spawner_in_shadows_spawner_spawnfunc)
			mobf_warn_long_fct(starttime,"on_mapgen " .. spawning_data.name,"mapgen")
		end) --register mapgen
	end
end

--!@}

spawning.register_spawn_algorithm("shadows", mobf_spawner_initialize_in_shadows_abm)
spawning.register_spawn_algorithm(	"shadows_spawner",
									mobf_spawner_initialize_in_shadows_mapgen,
									spawning.register_cleanup_spawner)