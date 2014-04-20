-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file harvesting.lua
--! @brief component for all harvesting related mob features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup harvesting Harvesting subcomponent
--! @brief Component handling harvesting
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(harvesting == nil)
--! @class harvesting
--! @brief harvesting features
harvesting = {}

--!@}

-------------------------------------------------------------------------------
-- @function [parent=#harvesting] init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by harvesting
--! @memberof harvesting
--
--! @param entity mob to initialize harvest dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function harvesting.init_dynamic_data(entity,now)
	dbg_mobf.harvesting_lvl1("MOBF: " .. entity.data.name
		.. " initializing harvesting dynamic data")
	local data =  {
		ts_last 				= now,
	}
	entity.dynamic_data.harvesting = data
end

-------------------------------------------------------------------------------
-- @function [parent=#harvesting] callback(entity,player,now)
--
--! @brief callback handler for harvest by player
--! @memberof harvesting
--
--! @param entity mob being harvested
--! @param player player harvesting
--! @param now the current time
--! @return true/false if handled by harvesting or not
-------------------------------------------------------------------------------
function harvesting.callback(entity,player,now)

	dbg_mobf.harvesting_lvl1("MOBF: harvest function called")

	local now = mobf_get_current_time()

	--handle catching of mob
	if entity.data.catching ~= nil and
		entity.data.catching.tool ~= "" then

		--grief protection
		if minetest.world_setting_get("mobf_grief_protection") and
			entity.dynamic_data.spawning.player_spawned and
			entity.dynamic_data.spawning.spawner ~= player:get_player_name() then
			dbg_mobf.harvesting_lvl1("MOBF: anti gief triggered catching aborted")
			return true
		end

		-- what's wielded by player
		local tool = player:get_wielded_item()

		if tool:get_name() == entity.data.catching.tool then
			dbg_mobf.harvesting_lvl1("MOBF: player wearing ".. entity.data.catching.tool)

			--play catch sound
			if entity.data.sound ~= nil then
				sound.play(entity.object:getpos(),entity.data.sound.catch);
			end

			if entity.data.catching.consumed == true then
					if player:get_inventory():contains_item("main",entity.data.catching.tool.." 1") then
						dbg_mobf.harvesting_lvl2("MOBF: removing: "
							.. entity.data.catching.tool.." 1")
						player:get_inventory():remove_item("main",
							entity.data.catching.tool.." 1")
					else
						mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: BUG!!! player is"
						.. " wearing a item he doesn't have in inventory!!!")
						--handled but not ok so don't attack
						return true
					end
			end

			--TODO check if player has enough room

			if entity.data.generic.addoncatch ~= nil then
				player:get_inventory():add_item("main",
					entity.data.generic.addoncatch.." 1")
			else
				player:get_inventory():add_item("main",
					entity.data.modname ..":"..entity.data.name.." 1")
			end
			spawning.remove(entity, "cought")
			return true
		end
	end


	--handle harvestable mobs, check if player is wearing correct tool
	if entity.data.harvest ~= nil then

		dbg_mobf.harvesting_lvl1("MOBF: trying to harvest harvestable mob")
		if (entity.data.harvest.tool ~= "") then
			local tool = player:get_wielded_item()
			if tool ~= nil then
				dbg_mobf.harvesting_lvl1("MOBF: Player is wearing >"
					.. tool:get_name() .. "< required is >".. entity.data.harvest.tool
					.. "< wear: " .. tool:get_wear())

				if (tool:get_name() ~=  entity.data.harvest.tool) then
					--player is wearing wrong tool do an attack
					return false
				else
					--tool is completely consumed
					if entity.data.harvest.tool_consumed == true then
						if player:get_inventory():contains_item("main",entity.data.harvest.tool.." 1") == false then
							dbg_mobf.harvesting_lvl1("MOBF: Player doesn't have"
								.. " at least 1 of ".. entity.data.harvest.tool)
							--handled but not ok so don't attack
							return true
						end
					else
						--damage tool
						local tool_wear = tool:get_wear()

						dbg_mobf.harvesting_lvl1("MOBF: tool " .. tool:get_name()
							.. " wear: " ..  tool_wear)
						-- damage used tool
						if tool_wear ~= nil and
							entity.data.harvest.max_tool_usage ~= nil then

							local todamage = (65535/entity.data.harvest.max_tool_usage)
							dbg_mobf.harvesting_lvl1("MOBF: tool damage calculated: "
								.. todamage);
							if tool:add_wear(todamage) ~= true then
								dbg_mobf.harvesting_lvl3("MOBF: Tried to damage non tool item "
									.. tool:get_name() .. "!");
							end
							player:set_wielded_item(tool)
						end
					end
				end
			else
				--player isn't wearing a tool so this has to be an attack
				return false
			end
		else
			--no havest tool defined so this has to be an attack
			return false
		end


		--transformation and harvest delay is exclusive

		--harvest delay mode
		if entity.data.harvest.min_delay < 0 or
			entity.dynamic_data.harvesting.ts_last + entity.data.harvest.min_delay < now then

			--TODO check if player has enough room
			player:get_inventory():add_item("main", entity.data.harvest.result.." 1")

			--check if tool is consumed by action
			if entity.data.harvest.tool_consumed then
				dbg_mobf.harvesting_lvl2("MOBF: removing "
					..entity.data.harvest.tool.." 1")
				player:get_inventory():remove_item("main",entity.data.harvest.tool.." 1")
			end
		else
			dbg_mobf.harvesting_lvl1("MOBF: " .. entity.data.name
				.. " not ready to be harvested")
		end

		-- check if mob is transformed by harvest
		if entity.data.harvest.transforms_to ~= "" then
			local transformed = spawning.replace_entity(entity,
											entity.data.harvest.transforms_to)
		else
			entity.dynamic_data.harvesting.ts_last = mobf_get_current_time()
		end


		--play harvest sound
		if entity.data.sound ~= nil then
			sound.play(entity.object:getpos(),entity.data.sound.harvest);
		end

		--harvest done
		return true
	end

	return false
end


-------------------------------------------------------------------------------
-- @function transform(entity)
--
--! @brief self transform callback for mob
--! @ingroup harvesting
--
--! @param entity mob calling
--! @param now current time
-------------------------------------------------------------------------------
function transform(entity,now)

	--check if it's a transformable mob
	if entity.data.auto_transform ~= nil then

		if now - entity.dynamic_data.spawning.original_spawntime
			> entity.data.auto_transform.delay then
			spawning.replace_entity(entity,entity.data.auto_transform.result)
			return false
		end

	end

end
