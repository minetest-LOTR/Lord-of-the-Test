-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file debug.lua
--! @brief contains debug functions for mob framework
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

mobf_assert_backtrace(mobf_debug == nil)
--! @defgroup debug_in_game In game debugging functions
--! @brief debugging functions to be called from in game
--! @ingroup framework_int
--! @{
mobf_debug = {}

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] print_usage(player,command,toadd)
--
--! @brief send errormessage to player
--
--! @param player name of player to print usage
--! @param command display usage for this command
--! @param toadd additional information to transfer to player
-------------------------------------------------------------------------------
function mobf_debug.print_usage(player, command, toadd)

	if toadd == nil then
		toadd = ""
	end

	if command == "spawnmob" then
		print("CMD: ".. player .."> ".. "Usage: /spawnmob <mobname> <X,Y,Z> " .. toadd)
		minetest.chat_send_player(player, "Usage: /spawnmob <mobname> <X,Y,Z> " .. toadd)
	end

	if command == "ukn_mob" then
		print("CMD: ".. player .."> "..  "Unknown mob name "..toadd)
		minetest.chat_send_player(player, "Unknown mob name "..toadd)
	end

	if command == "inv_pos" then
		print("CMD: ".. player .."> "..  "Invalid position "..toadd)
		minetest.chat_send_player(player, "Invalid position "..toadd)
	end

	if command == "mob_spawned" then
		print("CMD: ".. player .."> "..  "Mob successfully spawned "..toadd)
		minetest.chat_send_player(player, "Mob successfully spawned "..toadd)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] spawn_mob(name,param)
--
--! @brief handle a spawn mob command
--
--! @param name name of player
--! @param param parameters received
------------------------------------------------------------------------------
function mobf_debug.spawn_mob(name,param)
	print("name: " .. name .. " param: " .. dump(param))

	local parameters = param:split(" ")

	if #parameters ~= 1 and
		#parameters ~= 2 then
		mobf_debug.print_usage(name,"spawnmob")
		return
	end

	if mobf_is_known_mob(parameters[1]) ~= true then
		mobf_debug.print_usage(name,"ukn_mob", ">"..parameters[1].."<")
		return true
	end

	if #parameters == 2 then
		local pos_strings = parameters[2]:split(",")

		if #pos_strings ~= 3 then
			mobf_debug.print_usage(name,"spawmob")
			return
		end



		local spawnpoint = {
							x=tonumber(pos_strings[1]),
							y=tonumber(pos_strings[2]),
							z=tonumber(pos_strings[3])
							}

		if spawnpoint.x == nil or
			spawnpoint.y == nil or
			spawnpoint.z == nil then
			mobf_debug.print_usage(name,"spawnmob")
			return
		end

		spawning.spawn_and_check(parameters[1],spawnpoint,"mobf_debug_spawner")
	else
		--todo find random pos

		local player = minetest.get_player_by_name(name)

		if player == nil then

			return
		end

		local pos = player:getpos()

		if pos == nil then
			return
		end

		local found = false
		local maxtries = 10

		while (found == false) and (maxtries > 0) do
			local toadd = {}
			toadd.x = pos.x + (math.random(20) -10)
			toadd.z = pos.z + (math.random(20) -10)

			local y = mobf_get_surface(toadd.x,toadd.z,pos.y-10,pos.y+10)

			if y ~= nil then
				toadd.y = y +2
				if spawning.spawn_and_check(parameters[1],toadd,"mobf_debug_spawner") then
					found = true
				end
			end

			maxtries = maxtries -1
		end
	end


end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] list_active_mobs(name,param)
--
--! @brief print list of all current active mobs
--
--! @param name name of player
--! @param param parameters received
------------------------------------------------------------------------------
function mobf_debug.list_active_mobs(name,param)

	local count = 1
	for index,value in pairs(minetest.luaentities) do
		if value.data ~= nil and value.data.name ~= nil then
			local tosend = count .. ": " .. value.data.name .. " at "
				.. printpos(value.object:getpos())
			print(tosend)
			minetest.chat_send_player(name,tosend)
			count = count +1
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] list_spawners(name,param)
--
--! @brief print list of all spawners around player
--
--! @param name name of player
--! @param param parameters received
------------------------------------------------------------------------------
function mobf_debug.list_spawners(name,param)

	for index,value in pairs(minetest.luaentities) do
		if value ~= nil and value.spawner_mob_name ~= nil then
			local resultline = "SPW: "
				.. mobf_fixed_size_string(value.spawner_mob_name,24) .. " "
				.. mobf_fixed_size_string(printpos(value.object:getpos()),16)
				.. "  STATE: "
				.. mobf_fixed_size_string(dump(value.spawner_last_result),32)
				.. " TIME: " .. value.spawner_time_passed

			print(resultline)
		end
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] mob_count(name,param)
--
--! @brief count active mobs
--
--! @param name name of player
--! @param param parameters received
------------------------------------------------------------------------------
function mobf_debug.mob_count(name,param)

	local count = 1
	for index,value in pairs(minetest.luaentities) do
		if value.data ~= nil and value.data.name ~= nil then
			count = count +1
		end
	end

	minetest.chat_send_player(name,"Active mobs: " .. count)
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] add_tools(name,param)
--
--! @brief add toolset for testing
--
--! @param name name of player
--! @param param parameters received
------------------------------------------------------------------------------
function mobf_debug.add_tools(name,param)
	local player = minetest.get_player_by_name(name)

	if player ~= nil then
		player:get_inventory():add_item("main", "animalmaterials:lasso 20")
		player:get_inventory():add_item("main", "animalmaterials:net 20")
		player:get_inventory():add_item("main", "animalmaterials:scissors 1")
		player:get_inventory():add_item("main", "vessels:drinking_glass 10")
	end

end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] list_defined_mobs(name,param)
--
--! @brief list all registred mobs
--
--! @param name name of player
--! @param param parameters received
------------------------------------------------------------------------------
function mobf_debug.list_defined_mobs(name,param)

	local text = ""
	for i,val in ipairs(mobf_rtd.registred_mob) do
		text = text .. val .. " "
	end
	minetest.chat_send_player(name, "MOBF: "..text)
end

-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] init()
--
--! @brief initialize debug commands chat handler
--
------------------------------------------------------------------------------
function mobf_debug.init()

	minetest.register_chatcommand("spawnmob",
		{
			params		= "<name> <pos>",
			description = "spawn a mob at position(optional)" ,
			privs		= {mobfw_admin=true},
			func		= mobf_debug.spawn_mob
		})

	minetest.register_chatcommand("listactivemobs",
		{
			params		= "",
			description = "list all currently active mobs" ,
			privs		= {mobfw_admin=true},
			func		= mobf_debug.list_active_mobs
		})

	minetest.register_chatcommand("listdefinedmobs",
		{
			params		= "",
			description = "list all currently defined mobs" ,
			privs		= {mobfw_admin=true},
			func		= mobf_debug.list_defined_mobs
		})

	minetest.register_chatcommand("mob_add_tools",
		{
			params		= "",
			description = "add some mob specific tools to player" ,
			privs		= {mobfw_admin=true},
			func		= mobf_debug.add_tools
		})

	minetest.register_chatcommand("mobf_version",
		{
			params		= "",
			description = "show mobf version number" ,
			privs		= {},
			func		= function(name,param)
								minetest.chat_send_player(name,"MOBF version: " .. mobf_version)
							end
		})

	minetest.register_chatcommand("listspawners",
		{
			params		= "",
			description = "debug info about spawner entities" ,
			privs		= {mobfw_admin=true},
			func		= mobf_debug.list_spawners
		})

	minetest.register_chatcommand("mobf_count",
		{
			params		= "",
			description = "number of active mobs" ,
			privs		= {},
			func		= mobf_debug.mob_count
		})


	if mobf_rtd.luatrace_enabled then
		minetest.register_chatcommand("traceon",
			{
				params		= "",
				description = "start luatrace tracing" ,
				privs		= {mobfw_admin=true},
				func		= function()
					luatrace.tron(nil)
					end
			})

		minetest.register_chatcommand("traceoff",
			{
				params		= "",
				description = "stop luatrace tracing" ,
				privs		= {mobfw_admin=true},
				func		= function()
					luatrace.troff()
					end
			})
	end
end


-------------------------------------------------------------------------------
-- @function [parent=#mobf_debug] handle_spawnhouse(name,message)
--
--! @brief spawn small house
--
--! @param entity entity rightclicked
--! @param player player doing rightclick
------------------------------------------------------------------------------
function mobf_debug.rightclick_callback(entity,player)
	local basepos  = entity.getbasepos(entity)
	local lifetime = mobf_get_current_time() - entity.dynamic_data.spawning.original_spawntime
	print("MOBF: " .. entity.data.name .. " " .. tostring(entity) .. " is alive for " .. lifetime .. " seconds")
	print("MOBF: \tAbsolute spawntime:          " .. entity.dynamic_data.spawning.original_spawntime)
	print("MOBF: \tCurrent state:               " .. entity.dynamic_data.state.current.name )
	print("MOBF: \tCurrent movgen:              " .. entity.dynamic_data.current_movement_gen.name )
	if entity.dynamic_data.current_movement_gen.name == "follow_mov_gen" or
		entity.dynamic_data.current_movement_gen.name == "mgen_path" then

			local targetpos = entity.dynamic_data.spawning.spawnpoint
			if entity.dynamic_data.movement.target ~= nil then
				if not mobf_is_pos(entity.dynamic_data.movement.target) then
					targetpos = entity.dynamic_data.movement.target:getpos()
				else
					targetpos = entity.dynamic_data.movement.target
				end
			end
			if targetpos ~= nil then
				print("MOBF: \t\tmovement state:              " .. mgen_follow.identify_movement_state(basepos,targetpos) )
			else
				print("MOBF: \t\tmovement state:              invalid")
			end
			print("MOBF: \t\tguard spawnpoint:            " .. dump(entity.dynamic_data.movement.guardspawnpoint))
			print("MOBF: \t\ttarget:                      " .. dump(entity.dynamic_data.movement.target))
	end
	if entity.dynamic_data.current_movement_gen.name == "mgen_path" then
			print("MOBF: \t\tpath index:                  " .. entity.dynamic_data.p_movement.next_path_index)
			print("MOBF: \t\tpath:                        " .. dump(entity.dynamic_data.p_movement.path))
		if entity.dynamic_data.p_movement.path ~= nil then
			for i,v in ipairs(entity.dynamic_data.p_movement.path) do
				local objects = minetest.get_objects_inside_radius(v,0.5)
				local found = false;
				for i=1,#objects,1 do
					local luaentity = objects[i]:get_luaentity()
					if luaentity ~= nil and
						luaentity.name == "mobf:path_marker_entity" then
						found = true
						break
					end
				end

				local node_at = minetest.get_node(v)

				if not found and
					node_at.name ~= nil and
					node_at.name ~= "ignore" then
					spawning.spawn_and_check("mobf:path_marker_entity",v,"mark_path")
				end
			end
			print("MOBF: \t\tdistance to next point:      " .. p_mov_gen.distance_to_next_point(entity,entity.object:getpos()))
		end
	end

	local predicted_pos = movement_generic.predict_next_block(
			basepos,
			entity.object:getvelocity(),
			entity.object:getacceleration())
	if not ( entity.data.movement.canfly == true) then
		predicted_pos.y = basepos.y
	end
	local pos_state  = environment.pos_is_ok(predicted_pos,entity)
	local pos_quality = environment.pos_quality(basepos,entity)
	local predicted_quality = environment.pos_quality(predicted_pos,entity)

	print("MOBF: \tTime to state change:        " .. entity.dynamic_data.state.time_to_next_change .. " seconds")
	print("MOBF: \tCurrent environmental state: " .. environment.pos_is_ok(entity.getbasepos(entity),entity))
	if mobf_rtd.detailed_state then
	print("MOBF: \tCurrent detailed state:      " .. pos_quality:shortstring())
	end
	print("MOBF: \tCan fly:                     " .. dump(entity.data.movement.canfly))
	print("MOBF: \tCurrent accel:               " .. printpos(entity.object:getacceleration()))
	print("MOBF: \tCurrent speed:               " .. printpos(entity.object:getvelocity()))
	print("MOBF: \tSpawnpoint:                  " .. printpos(entity.dynamic_data.spawning.spawnpoint))
	print("MOBF: \tSpawner:                     " .. dump(entity.dynamic_data.spawning.spawner))
	print("MOBF: \tCurrent pos:                 " .. printpos(basepos))
	print("MOBF: \tPredicted pos:               " .. printpos(predicted_pos))
	print("MOBF: \tPredicted state:             " .. pos_state)
	if mobf_rtd.detailed_state then
	print("MOBF: \tPredicted detail:            " .. predicted_quality:shortstring())
	end
	if entity.dynamic_data.combat ~= nil then
		print("MOBF: \tCurrent combat target:       " .. fighting.get_target_name(entity.dynamic_data.combat.target))
	end
	if entity.dynamic_data.attention ~= nil then
		print("MOBF: \t Current attention table:")
		for k,v in pairs(entity.dynamic_data.attention.watched_objects) do
			print("MOBF: \t\t " .. k .. ": " .. v.value)
		end

		if entity.dynamic_data.attention.most_relevant_target ~= nil then
			local attention_name = tostring(entity.dynamic_data.attention.most_relevant_target)

			if (entity.dynamic_data.attention.most_relevant_target:is_player()) then
				attention_name = entity.dynamic_data.attention.most_relevant_target:get_player_name()
			end
			print("MOBF: \tTop attention object:       " .. attention_name)
		end
	end

	if entity.dynamic_data.graphics.last_fps ~= nil then
		print("MOBF: Animating with: " .. entity.dynamic_data.graphics.last_fps .. " fps")
	end
	return false
end


--!@}
