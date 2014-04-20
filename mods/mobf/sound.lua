-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file sound.lua
--! @brief component containing sound related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup grp_sound Sound subcomponent
--! @brief Component handling all sound related actions
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(sound == nil)
--! @class sound
sound =  {}

--!@}

-------------------------------------------------------------------------------
-- @function [parent=#sound] play(entity)
--
--! @brief play a sound at a specified position
--! @memberof sound
--
--! @param pos position to play sound at
--! @param soundspec sound to play
-------------------------------------------------------------------------------
function sound.play(pos,soundspec)

	if (soundspec ~= nil) then

		local toplay =  {
						gain = soundspec.gain,
						pos = pos,
						max_hear_distance = soundspec.max_hear_distance,
						loop = false,
						}

		minetest.sound_play(soundspec.name,toplay)
	else
		dbg_mobf.sound_lvl2("MOBF: no soundspec")
		--todo add log entry
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#sound] play_random(entity,now)
--
--! @brief play a random sound for mob
--! @memberof sound
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function sound.play_random(entity,now)

	if entity.dynamic_data == nil or
		entity.dynamic_data.sound == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!!: >" ..entity.data.name .. "< removed=" .. dump(entity.removed) .. " entity=" .. tostring(entity) .. " sound callback without dynamic data")
		return
	end

	if entity.data.sound ~= nil and
		entity.data.sound.random ~= nil then

		if (entity.dynamic_data.sound.random_last + entity.data.sound.random.min_delta < now) then

			if math.random() < entity.data.sound.random.chance then
				local toplay = nil
				if type(entity.data.sound.random) == "table" and
					#entity.data.sound.random > 0 then
					local current_random_sound = math.floor(math.random(1,#entity.data.sound.random) + 0.5)
					toplay = entity.data.sound.random[current_random_sound]
				else
					toplay = entity.data.sound.random
				end
				sound.play(entity.object:getpos(),toplay)
				entity.dynamic_data.sound.random_last = now
				dbg_mobf.sound_lvl1("MOBF: playing sound")
			else
				dbg_mobf.sound_lvl1("MOBF: not playing sound")
			end
		end
	end

end

-------------------------------------------------------------------------------
-- @function [parent=#sound] sound.init_dynamic_data(entity)
--
--! @brief initialize all dynamic data for sound on activate
--! @memberof sound
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function sound.init_dynamic_data(entity,now)
	local data = {
		random_last					= now,
	}

	entity.dynamic_data.sound = data
end