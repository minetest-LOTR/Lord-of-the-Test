-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file job_queue.lua
--! @brief asynchronous job queue
--! @copyright Sapier
--! @author Sapier
--! @date 2013-08-18
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(mobf_job_queue == nil)

--! @class mobf_job_queue
--! @brief delayed job handling features
mobf_job_queue = {}

-------------------------------------------------------------------------------
-- @function [parent=#mobf_job_queue] add_job(job)
--
--! @brief queue a job to asynchronous job handling
--! @memberof mobf_job_queue
--
--! @param job to do
-------------------------------------------------------------------------------
function mobf_job_queue.add_job(job)
	table.insert(mobf_job_queue.queue, job)
	statistics.data.queue.maxabs = MAX(statistics.data.queue.maxabs,#mobf_job_queue.queue)
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_job_queue] process(dtime)
--
--! @brief job processing handler
--! @memberof mobf_job_queue
--
--! @param dtime time since last call
-------------------------------------------------------------------------------
function mobf_job_queue.process(dtime)
	local starttime = mobf_get_time_ms()
	mobf_job_queue.current_interval = mobf_job_queue.current_interval + dtime

	if mobf_job_queue.current_interval < mobf_job_queue.queue_interval then
		return
	end

	mobf_job_queue.current_interval = 0

	local jobs_processed = 0

	local jobs_before = #mobf_job_queue.queue

	while (#mobf_job_queue.queue > 0) and
			(mobf_get_time_ms() - starttime) < MIN(20,mobf_step_quota.remaining()) do
		local action = table.remove(mobf_job_queue.queue)

		mobf_assert_backtrace(type(action.callback) == "function")
		action.callback(action.data)
		jobs_processed = jobs_processed + 1
	end
	mobf_warn_long_fct(starttime,"job_processing","delayed_processing")
--	print("Queue processed " .. jobs_processed .. " of " .. jobs_before
--			.. " jobs in " .. string.format("%4.2f",(mobf_get_time_ms() - starttime)) .. "ms")
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_job_queue] cleanup()
--
--! @brief handle all jobs queued
--! @memberof mobf_job_queue
--
-------------------------------------------------------------------------------
function mobf_job_queue.cleanup()
	local starttime = mobf_get_time_ms()
	local processed = 0
	while (#mobf_job_queue.queue > 0) do
		if processed % 10 == 0 then
			--TODO log and broadcast
		end

		local action = table.remove(mobf_job_queue.queue)

		mobf_assert_backtrace(type(action.callback) == "function")
		action.callback(action.data)

		processed = processed + 1
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_job_queue] initialize()
--
--! @brief initialize job queue
--! @memberof mobf_job_queue
--
-------------------------------------------------------------------------------
function mobf_job_queue.initialize(queue_interval)

	mobf_job_queue.queue = {}
	mobf_job_queue.current_interval = 0
	mobf_job_queue.queue_interval = queue_interval or 0.040

	--register async handler to global step
	minetest.register_globalstep(mobf_job_queue.process)

	--register cleanup handler
	minetest.register_on_shutdown(mobf_job_queue.cleanup)
end
