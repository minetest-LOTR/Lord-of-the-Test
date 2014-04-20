-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file tracing.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2013-02-04
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup gen_func Generic functions
--! @brief functions for various tasks
--! @ingroup framework_int
--! @{

callback_statistics = {}

statistics = {}
statistics.total = 0
statistics.abms = 0
statistics.onstep = 0
statistics.mapgen = 0
statistics.lastcalc = 0
statistics.activate = 0
statistics.queue_load = 0
statistics.spawn_onstep = 0
statistics.user_1 = 0
statistics.user_2 = 0
statistics.user_3 = 0
statistics.data = {}
statistics.data.total        = { current=0,maxabs=0,max=0 }
statistics.data.abm          = { current=0,maxabs=0,max=0 }
statistics.data.onstep       = { current=0,maxabs=0,max=0 }
statistics.data.mapgen       = { current=0,maxabs=0,max=0 }
statistics.data.activate     = { current=0,maxabs=0,max=0 }
statistics.data.queue_load   = { current=0,maxabs=0,max=0 }
statistics.data.mobs         = { current=0,maxabs=" ",max=0 }
statistics.data.queue         = { current=0,maxabs=0,max=0 }
statistics.data.spawn_onstep = { current=0,maxabs=0,max=0 }

statistics.data.user_1 = { current=0,maxabs=0,max=0 }
statistics.data.user_2 = { current=0,maxabs=0,max=0 }
statistics.data.user_3 = { current=0,maxabs=0,max=0 }

-------------------------------------------------------------------------------
-- name: mobf_statistic_calc()
--
--! @brief periodic update statistics
--
-------------------------------------------------------------------------------
function mobf_statistic_calc(dtime)
	local refresh_interval = 50 -- in tenth of seconds
	local now = mobf_get_time_ms()
	if statistics.lastcalc == nil or now > statistics.lastcalc +
												(refresh_interval*100) then
		local delta = now - statistics.lastcalc
		local current_total  = (statistics.total/delta)*100
		local current_abm    = (statistics.abms/delta)*100
		local current_onstep = (statistics.onstep/delta)*100

		local current_mapgen = (statistics.mapgen/delta)*100
		local current_activate = (statistics.activate/delta)*100
		local current_queue_load  = (statistics.queue_load/delta)*100
		local current_spawn_onstep  = (statistics.spawn_onstep/delta)*100
		local current_user_1  = (statistics.user_1/delta)*100
		local current_user_2  = (statistics.user_2/delta)*100
		local current_user_3  = (statistics.user_3/delta)*100

		local active_mobs = 1
		for index,value in pairs(minetest.luaentities) do
			if value.data ~= nil and value.data.name ~= nil then
				active_mobs = active_mobs +1
			end
		end

		statistics.total = 0
		statistics.abms = 0
		statistics.onstep = 0
		statistics.mapgen = 0
		statistics.activate = 0
		statistics.queue_load = 0
		statistics.spawn_onstep = 0
		statistics.user_1 = 0
		statistics.user_2 = 0
		statistics.user_3 = 0

		statistics.data.total.current = current_total
		statistics.data.total.maxabs = MAX(statistics.data.total.maxabs, math.floor(current_total*refresh_interval))
		statistics.data.total.max = MAX(statistics.data.total.max,current_total)

		statistics.data.abm.current = current_abm
		statistics.data.abm.maxabs = MAX(statistics.data.abm.maxabs, math.floor(current_abm*refresh_interval))
		statistics.data.abm.max = MAX(statistics.data.abm.max,current_abm)

		statistics.data.onstep.current = current_onstep
		statistics.data.onstep.maxabs = MAX(statistics.data.onstep.maxabs, math.floor(current_onstep*refresh_interval))
		statistics.data.onstep.max = MAX(statistics.data.onstep.max,current_onstep)

		statistics.data.mapgen.current = current_mapgen
		statistics.data.mapgen.maxabs = MAX(statistics.data.mapgen.maxabs, math.floor(current_mapgen*refresh_interval))
		statistics.data.mapgen.max = MAX(statistics.data.mapgen.max,current_mapgen)

		statistics.data.activate.current = current_activate
		statistics.data.activate.maxabs = MAX(statistics.data.activate.maxabs, math.floor(current_activate*refresh_interval))
		statistics.data.activate.max = MAX(statistics.data.activate.max,current_activate)

		statistics.data.queue_load.current = current_queue_load
		statistics.data.queue_load.maxabs = MAX(statistics.data.queue_load.maxabs, math.floor(current_queue_load*refresh_interval))
		statistics.data.queue_load.max = MAX(statistics.data.queue_load.max,current_queue_load)

		statistics.data.spawn_onstep.current = current_spawn_onstep
		statistics.data.spawn_onstep.maxabs = MAX(statistics.data.spawn_onstep.maxabs, math.floor(current_spawn_onstep*refresh_interval))
		statistics.data.spawn_onstep.max = MAX(statistics.data.spawn_onstep.max,current_spawn_onstep)

		statistics.data.mobs.current = active_mobs
		statistics.data.mobs.max = MAX(statistics.data.mobs.max,active_mobs)

		statistics.data.queue.current = #mobf_job_queue.queue
		statistics.data.queue.max = MAX(statistics.data.queue.max,#mobf_job_queue.queue)

		statistics.data.user_1.current = current_user_1
		statistics.data.user_1.maxabs = MAX(statistics.data.user_1.maxabs, math.floor(current_user_1*refresh_interval))
		statistics.data.user_1.max = MAX(statistics.data.user_1.max,current_user_1)

		statistics.data.user_2.current = current_user_2
		statistics.data.user_2.maxabs = MAX(statistics.data.user_2.maxabs, math.floor(current_user_2*refresh_interval))
		statistics.data.user_2.max = MAX(statistics.data.user_2.max,current_user_2)

		statistics.data.user_3.current = current_user_3
		statistics.data.user_3.maxabs = MAX(statistics.data.user_3.maxabs, math.floor(current_user_3*refresh_interval))
		statistics.data.user_3.max = MAX(statistics.data.user_3.max,current_user_3)

		statistics.lastcalc = now
	end
end

-------------------------------------------------------------------------------
-- name: mobf_warn_long_fct(starttime,fctname,facility)
--
--! @brief alias to get current time
--
--! @param starttime time fct started
--! @param fctname name of function
--! @param facility name of facility to add time to
--
--! @return current time in seconds
-------------------------------------------------------------------------------
function mobf_warn_long_fct(starttime,fctname,facility)
	local currenttime = mobf_get_time_ms()
	mobf_assert_backtrace(starttime ~= nil)
	local delta = 0

	if (starttime < currenttime) then
		delta = currenttime - starttime
	end

	if delta > 0 and minetest.world_setting_get("mobf_enable_statistics") then
		if facility == "abm" then
			statistics.abms = statistics.abms + delta
			statistics.total = statistics.total + delta
		end

		if facility == "on_step_total" then
			statistics.onstep = statistics.onstep + delta
			statistics.total = statistics.total + delta
		end

		if facility == "mapgen" then
			statistics.mapgen = statistics.mapgen + delta
			statistics.total = statistics.total + delta
		end

		if facility == "spawn_onstep" then
			statistics.spawn_onstep = statistics.spawn_onstep + delta
			statistics.total = statistics.total + delta
		end

		if facility == "onpunch_total" then
			statistics.onstep = statistics.onstep + delta
			statistics.total = statistics.total + delta
		end

		if facility == "delayed_processing" then
			statistics.queue_load = statistics.queue_load + delta
			statistics.total = statistics.total + delta
		end

		if facility == "onactivate_total" then
			statistics.activate = statistics.activate + delta
			statistics.total = statistics.total + delta
		end

		if facility == "user_1" then
			statistics.user_1 = statistics.user_1 + delta
		end

		if facility == "user_2" then
			statistics.user_2 = statistics.user_2 + delta
		end

		if facility == "user_3" then
			statistics.user_3 = statistics.user_3 + delta
		end
	end

	if minetest.world_setting_get("mobf_enable_callback_statistics") then
		if fctname == nil then
			fctname = "unknown"
		end

		if callback_statistics[fctname] == nil then
			callback_statistics[fctname] = {
				upto_005ms = 0,
				upto_010ms = 0,
				upto_020ms = 0,
				upto_050ms = 0,
				upto_100ms = 0,
				upto_200ms = 0,
				more       = 0,
				valcount   = 0,
				sum        = 0,
				last_time  = 0,
			}
		end

		callback_statistics[fctname].valcount = callback_statistics[fctname].valcount +1
		callback_statistics[fctname].sum = callback_statistics[fctname].sum + delta

		if callback_statistics[fctname].valcount == 1000 then
			callback_statistics[fctname].valcount = 0
			local deltatime = currenttime - callback_statistics[fctname].last_time
			callback_statistics[fctname].last_time = currenttime

			minetest.log(LOGLEVEL_ERROR,"Statistics for: " .. fctname .. ": " ..
										callback_statistics[fctname].upto_005ms .. "," ..
										callback_statistics[fctname].upto_010ms .. "," ..
										callback_statistics[fctname].upto_020ms .. "," ..
										callback_statistics[fctname].upto_050ms .. "," ..
										callback_statistics[fctname].upto_100ms .. "," ..
										callback_statistics[fctname].upto_200ms .. "," ..
										callback_statistics[fctname].more ..
										" (".. callback_statistics[fctname].sum .. " / " .. deltatime .. ") " ..
										tostring(math.floor((callback_statistics[fctname].sum/deltatime) * 100)) .. "%")

			callback_statistics[fctname].sum = 0
		end

		if delta < 5 then
			callback_statistics[fctname].upto_005ms = callback_statistics[fctname].upto_005ms +1
			return
		end
		if delta < 10 then
			callback_statistics[fctname].upto_010ms = callback_statistics[fctname].upto_010ms +1
			return
		end
		if delta < 20 then
			callback_statistics[fctname].upto_020ms = callback_statistics[fctname].upto_020ms +1
			return
		end
		if delta < 50 then
			callback_statistics[fctname].upto_050ms = callback_statistics[fctname].upto_050ms +1
			return
		end
		if delta < 100 then
			callback_statistics[fctname].upto_100ms = callback_statistics[fctname].upto_100ms +1
			return
		end

		if delta < 200 then
			callback_statistics[fctname].upto_200ms = callback_statistics[fctname].upto_200ms +1
			return
		end

		callback_statistics[fctname].more = callback_statistics[fctname].more +1
	end

	if delta >200 then
		minetest.log(LOGLEVEL_ERROR,"MOBF: function " .. fctname .. " took too long: " .. delta .. " ms")
	end
end

-------------------------------------------------------------------------------
-- name: mobf_bug_warning()
--
--! @brief make bug warnings configurable
--
--! @param level bug severity level to use for minetest.log
--! @param text data to print to log
-------------------------------------------------------------------------------
function mobf_bug_warning(level,text)
	if minetest.world_setting_get("mobf_log_bug_warnings") then
		minetest.log(level,text)
	end
end

-------------------------------------------------------------------------------
-- name: mobf_init_timesource()
--
--! @brief select timesource to be used by mobf
--
-------------------------------------------------------------------------------
function mobf_init_timesource()
	--try to get timesource with best accuracy
	if type(minetest.get_us_time) == "function" then
		mobf_get_time_ms = function()
				return minetest.get_us_time() / 1000
			end
		mobf_rtd.timesource = "minetest.get_us_time()"
	else
		if socket == nil then
			local status, module = pcall(require, 'socket')

			if status and type(module.gettime) == "function" then
				mobf_get_time_ms = function()
						return socket.gettime()*1000
					end
				mobf_rtd.timesource = "socket.gettime()"
			end
		end
	end
end

-------------------------------------------------------------------------------
-- name: mobf_init_statistics()
--
--! @brief initialize profiling/statistics support
--
-------------------------------------------------------------------------------
function mobf_init_statistics()

	--initialize statistics callback
	if minetest.world_setting_get("mobf_enable_statistics") then
		minetest.register_globalstep(mobf_statistic_calc)

		local abm_register_call = minetest.register_abm

		minetest.register_abm = function(spec)
			local modname = minetest.get_current_modname()

			local mob_start,mob_end = string.find(modname,"mob")
			local animal_start,animal_end = string.find(modname,"animal")
			local mobf_start,mobf_end = string.find(modname,"mobf")

			if mob_start == 1 or animal_start == 1 or mobf_start == 1 then
				local action = spec.action

				spec.action = function(pos, node, active_object_count, active_object_count_wider)
						local starttime = mobf_get_time_ms()
						local retval = action(pos, node, active_object_count, active_object_count_wider)
						mobf_warn_long_fct(starttime,"auto_abm","abm")
						return retval
					end

				minetest.log(LOGLEVEL_NOTICE,"MOBF: tracing enabled instrumenting abm for mod " .. modname)
			end
			abm_register_call(spec)
		end
	end

end
--!@}