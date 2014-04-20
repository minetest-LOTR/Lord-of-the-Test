-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--
--! @file environment.lua
--! @brief component for environment related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup environment Environment subcomponent
--! @brief Environment check functions used by different subcomponents
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(environment == nil)
environment = {}

mobf_assert_backtrace(environment_list == nil)
--! @brief list of known environments
--! @memberof environment
environment_list = {}

-------------------------------------------------------------------------------
-- @function [parent=#environment] get_pos_same_level(pos_raw,maxsearcharea,entity,checkfunc)
--
--! @brief find a position suitable around a specific position
--! @ingroup environment
--
--! @param pos_raw position to look at
--! @param maxsearcharea max range to look for suitable position
--! @param entity mob to look for position
--! @param checkfunc function doing check if a pos is ok
--! @return {x,y,z} position found or nil
-------------------------------------------------------------------------------
function environment.get_pos_same_level(pos_raw,maxsearcharea,entity,checkfunc)
	dbg_mobf.environment_lvl2("MOBF: --> get_pos_same_level "
		.. printpos(pos_raw))
	local pos = mobf_round_pos(pos_raw)

	dbg_mobf.environment_lvl3("MOBF: Starting pos is "..printpos(pos)
	.." max search area is "..maxsearcharea)
		local e1 = "|"
	local e2 = "|"
	local e3 = "|"
	local e4 = "|"

	local possible_targets = {}

	--search next position on solid ground
	for search=1, maxsearcharea,1 do

		--find along edge 1
		for current=-search,search,1 do
			local pos_tocheck = { x= pos.x + current,y=pos.y,z=pos.z -search}
			local pos_quality = environment.pos_quality(pos_tocheck,entity)

			local pos_state = checkfunc(pos_quality)
			dbg_mobf.environment_lvl3("MOBF: state of "..printpos(pos_tocheck).." is "
				.. dump(pos_state))

			if pos_state then
				dbg_mobf.environment_lvl3("    -->found good pos")
				table.insert(possible_targets, pos_tocheck)
			else
				e1 = e1.."-|"
			end
		end

		--find along edge 2
		for current=-(search-1),(search-1),1 do
			local pos_tocheck = { x= pos.x + search,y=pos.y,z=pos.z + current}
			local pos_quality = environment.pos_quality(pos_tocheck,entity)

			local pos_state = checkfunc(pos_quality)
			dbg_mobf.environment_lvl3("MOBF: state of "..printpos(pos_tocheck).." is "
				.. dump(pos_state))

			if pos_state then
				dbg_mobf.environment_lvl3("    -->found good pos")
				table.insert(possible_targets, pos_tocheck)
			else
				e2 = e2.. "-|"
			end
		end

		--find along edge 3

		for current=search,-search,-1 do
			local pos_tocheck = { x= pos.x + current,y=pos.y,z=pos.z + search}
			local pos_quality = environment.pos_quality(pos_tocheck,entity)

			local pos_state = checkfunc(pos_quality)
			dbg_mobf.environment_lvl3("MOBF: state of "..printpos(pos_tocheck).." is "
				.. dump(pos_state))

			if pos_state then
				dbg_mobf.environment_lvl3("    -->found good pos")
				table.insert(possible_targets, pos_tocheck)
			else
				e3 = e3.."-|"
			end
		end

		--find along edge 4
		for current=(search-1),-(search-1),-1 do
			local pos_tocheck = { x= pos.x -search,y=pos.y,z=pos.z + current}
			local pos_quality = environment.pos_quality(pos_tocheck,entity)

			local pos_state = checkfunc(pos_quality)
			dbg_mobf.environment_lvl3("MOBF: state of "..printpos(pos_tocheck).." is "
				.. dump(pos_state))

			if pos_state then
				dbg_mobf.environment_lvl3("    -->found good pos")
				table.insert(possible_targets, pos_tocheck)
			else
				e4 = e4.."-|"
			end
		end
	end

--	print("MOBF: Bug !!! didn't find a suitable position to place mob")
--	print("Surrounding of " .. printpos(pos_raw) .. "was:")
--	print(e1)
--	print("          " .. e2)
--	print(e4)
--	print(e3)

	if #possible_targets > 0 then
		local i = math.random(1, #possible_targets)
		dbg_mobf.environment_lvl1("Found " .. #possible_targets
			.. " possible positions, selected: "
			.. i .. ": " .. printpos(possible_targets[i]))
		return possible_targets[i]
	end

	return nil
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] get_suitable_pos_same_level(pos_raw,maxsearcharea,entity)
--
--! @brief find a position suitable around a specific position
--! @ingroup environment
--
--! @param pos_raw position to look at
--! @param maxsearcharea max range to look for suitable position
--! @param entity mob to look for position
--! @param accept_possible return position thats possible only too
--! @return {x,y,z} position found or nil
-------------------------------------------------------------------------------
function environment.get_suitable_pos_same_level(pos_raw,maxsearcharea,entity,accept_possible)

	if accept_possible then
		return environment.get_pos_same_level(pos_raw,maxsearcharea,entity,
				function(quality)
					if entity.data.movement.canfly then
						return environment.evaluate_state(quality,LT_GOOD_FLY_POS)
					else
						return environment.evaluate_state(quality,LT_SAFE_POSSIBLE_EDGE_POS)
					end
				end)
	else
		return environment.get_pos_same_level(pos_raw,maxsearcharea,entity,
				function(quality)
					if entity.data.movement.canfly then
						return environment.evaluate_state(quality,LT_GOOD_FLY_POS)
					else
						return environment.evaluate_state(quality,LT_SAFE_EDGE_POS)
					end
				end)
	end
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] is_media_element(nodename,environment)
--
--! @brief check if nodename is in environment
--! @ingroup environment
--
--! @param nodename name to check
--! @param media environment of mob
--! @return true/false
------------------------------------------------------------------------------
function environment.is_media_element( nodename, media )

	--security check
	if media == false then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: BUG!!!! no environment specified!")
		return false
	end

	for i,v in ipairs(media) do
		if v == nodename then
			return true
		end
	end

	dbg_mobf.environment_lvl2("MOBF: " .. nodename .. " is not within environment list:")

	for i,v in ipairs(media) do
		dbg_mobf.environment_lvl3("MOBF: \t" .. v)
	end

	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] get_absolute_min_max_pos(env, pos)
--
--! @brief check if nodename is in environment
--! @ingroup environment
--
--! @param env environment mob should be
--! @param pos position it is currently
--! @return { minpos,maxpos }
------------------------------------------------------------------------------
function environment.get_absolute_min_max_pos(env,pos)

	local node = minetest.get_node(pos)

	--if is not within environment it should be return current position
	--as min max
	if environment.is_media_element(node.name,env.media) == false then
		return pos.y,pos.y
	end

	local min_y = env.min_height_above_ground
	local max_y = env.max_height_above_ground


	--a fully generic check isn't possible here so we need to use media
	--specific ways ... it's ugly but works
	if node.name == "air" then
		min_y = min_y + ( pos.y - mobf_surface_distance(pos))
		max_y = max_y + ( pos.y - mobf_surface_distance(pos))
	end

	if node.name == "default:water" or
		node.name == "defailt:water_flowing" then
		-- water mobs do use min/max directly
	end

	if node.name == "default:lava" or
		node.name == "default:lava_flowing" then
		--TODO e.g. lava fish
		--not implemented by now
	end

	return min_y,max_y
end


-------------------------------------------------------------------------------
-- @function [parent=#environment] is_jumpable_surface(name)
--
--! @brief check if name is a surface an mob may jump onto
--! @ingroup environment
--
--! @param name name to check
--! @return true/false
-------------------------------------------------------------------------------
function environment.is_jumpable_surface(name)


	if 	name == "default:dirt" or
		name == "default:dirt_with_grass" or
		name == "default:stone" or
		name == "default:sand" or
		name == "default:clay"
		then
		return true
	end

	dbg_mobf.environment_lvl1("MOBF: is "..name.." a jumpable surface?")
	return false
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] checksurfacek(pos,surfaces)
--
--! @brief check if a position is suitable for an mob
--! @ingroup environment
--
--! @param pos position to check
--! @param surface surfaces valid
--! @return true on valid surface false if not
-------------------------------------------------------------------------------
function environment.checksurface(pos,surface)

	local pos_below = {x=pos.x,y=pos.y-1,z=pos.z}
	local node_below = minetest.get_node(pos_below)

	--if we couldn't even get the node count as wrong
	if node_below == nil then
		return "wrong_surface"
	end

	--if no surfaces are specified any surface is treated as ok
	if surface == nil then
		if minetest.registered_nodes[node_below.name] ~= nil then
			if minetest.registered_nodes[node_below.name].walkable then
				return "ok",node_below.name
			else
				return "wrong_surface",node_below.name
			end
		else
			dbg_mobf.environment_lvl1("ENV surface check: " .. node_below.name..
				" isn't even a registred node??")
			--not a registred nodename??? count as wrong surface
			return "wrong_surface",node_below.name
		end
	end

	for i,v in ipairs(surface.good) do
		if node_below.name == v then
			return "ok",node_below.name
		end
	end

	if surface.possible ~= nil then
		for i,v in ipairs(surface.possible) do
			if node_below.name == v then
				return "possible_surface",node_below.name
			end
		end
	end

	return "wrong_surface",node_below.name

end

-------------------------------------------------------------------------------
-- @function [parent=#environment] get_min_max_ground_dist(entity)
--
--! @brief calculate absolute minimum and maximum height for a mob
--! @ingroup environment
--
--! @param entity mob to check
--! @return min y val,max y val
-------------------------------------------------------------------------------
function environment.get_min_max_ground_dist(entity)
	local min_ground_distance   = 0
	local max_ground_distance   = 0

	if entity.environment.max_height_above_ground ~= nil then
		max_ground_distance = entity.environment.max_height_above_ground
	end

	if entity.environment.min_height_above_ground ~= nil then
		min_ground_distance = entity.environment.min_height_above_ground
	end

	if entity.data.movement.canfly == nil or
		entity.data.movement.canfly == false then
		max_ground_distance = 1
	end

	return min_ground_distance,max_ground_distance
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] evaluate_pos_media(pos,media)
--
--! @brief check position media quality
--! @ingroup environment
--
--! @param pos position to check
--! @param media media description to check
--!
--! @return 100 = in media 10 collision 0 invalid, nodename
-------------------------------------------------------------------------------
function environment.evaluate_pos_media(pos,media)
	local node_to_check = minetest.get_node(pos)

	if node_to_check == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: BUG!!!! checking position with invalid node")
		return 0,nil
	end

	if not environment.is_media_element(node_to_check.name,media) then
		return 10,node_to_check
	end

	return 100,node_to_check
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] same_state(state1,state2)
--
--! @brief compare two states
--! @ingroup environment
--
--! @param state1
--! @param state2
--!
--! @return true/false
-------------------------------------------------------------------------------
function environment.same_state(state1,state2)
	environment.is_state(state1)
	environment.is_state(state2)

	if state1.valid == false or
		state2.valid == false then
		return false
	end

	if state1.media_quality ~= state2.media_quality then
		return false
	end

	if state1.geometry_quality ~= state2.geometry_quality then
		return false
	end

	if state1.surface_quality_min ~= state2.surface_quality_min then
		return false
	end

	if state1.surface_quality_max ~= state2.surface_quality_max then
		return false
	end

	if state1.level_quality ~= state2.level_quality then
		return false
	end

	return true
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] compare_state(state1,state2)
--
--! @brief compare state1 and state2
--! @ingroup environment
--
--! @param state1
--! @param state2
--!
--! @return -1, 0, 1
-------------------------------------------------------------------------------
function environment.compare_state(state1,state2)
	environment.is_state(state1)
	environment.is_state(state2)

	local right_better = false
	local left_better = false

	if state1.valid == false and state2.valid == true then
		return 1
	end

	if state1.valid == true and state2.valid == false then
		return -1
	end

	if	state1.media_quality < state2.media_quality or
		state1.geometry_quality < state2.geometry_quality or
		state1.surface_quality_min < state2.surface_quality_min or
		state1.surface_quality_max < state2.surface_quality_max or
		state1.level_quality < state2.level_quality
		then
		right_better = true
	end

	if	state1.media_quality > state2.media_quality or
		state1.geometry_quality > state2.geometry_quality or
		state1.surface_quality_min > state2.surface_quality_min or
		state1.surface_quality_max > state2.surface_quality_max or
		state1.level_quality > state2.level_quality
		then
		left_better = true
	end
	if right_better and not left_better then
		return 1
	end

	if left_better and not right_better then
		return -1
	end

	return 0
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] is_state(state)
--
--
--! @brief assert if state is something else than a state
--! @ingroup environment
-------------------------------------------------------------------------------
function environment.is_state(state)
	mobf_assert_backtrace(state ~= nil)
	mobf_assert_backtrace(type(state) == "table")
	mobf_assert_backtrace(state.valid ~= nil)
	mobf_assert_backtrace(state.media_quality ~= nil)
	mobf_assert_backtrace(state.geometry_quality ~= nil)
	mobf_assert_backtrace(state.center_geometry_quality ~= nil)
	mobf_assert_backtrace(state.surface_quality_min ~= nil)
	mobf_assert_backtrace(state.surface_quality_max ~= nil)
	mobf_assert_backtrace(state.level_quality ~= nil)
	mobf_assert_backtrace(state.surface_quality_center ~= nil)
end
-------------------------------------------------------------------------------
-- @function [parent=#environment] evaluate_state(state,old_state, min_media,
--                     min_geom,min_geom_center,min_min_surface,min_max_surface)
--
--! @brief evaluate a position
--! @ingroup environment
--
-- @param state verify this state
-- @param limits = {
--					old_state if set new state needs to be better or equal to this state only
--					min_media minimum media quality required
--					min_geom minimum geometry quality required
--					min_geom_center minimum geometry quality at center
--					min_min_surface minimum value for minimal surface quality
--					min_max_surface minimum value for maximal surface quality
--					min_center_surface minimum value for surface quality at center
--				   }
--
-- @return true/false
-------------------------------------------------------------------------------
function environment.evaluate_state(state,limits)

	mobf_assert_backtrace(type(limits) == "table")
	environment.is_state(state)

	if state.valid == false then return false end

	if limits.min_media ~= nil and state.media_quality < limits.min_media
		then return false end

	if limits.min_geom_center ~= nil and state.center_geometry_quality < limits.min_geom_center
		then return false end

	if limits.old_state ~= nil then
		if environment.compare_state(state,limits.old_state) == -1 then
			return true
		end
	end

	local retval = true

	if limits.min_geom ~= nil and state.geometry_quality < limits.min_geom
		then retval = false end
	if limits.min_min_surface ~= nil and state.surface_quality_min < limits.min_min_surface
		then retval = false end
	if limits.min_max_surface ~= nil and state.surface_quality_max < limits.min_max_surface
		then retval = false end
	if limits.min_center_surface ~= nil and state.surface_quality_center < limits.min_center_surface
		then retval = false end

	return retval
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] pos_quality(pos,entity)
--
--! @brief check position quality
--! @ingroup environment
--
--! @param pos position to check
--! @param entity mob to check
--! @return position quality
--! {
--!    media_quality             100 = in media
--!                               30 = collision (not passed outside)
--!                               20 = special in_water
--!                               10 = special in_air
--!                                5 = solid
--!                                0 = not evaluated
--!    geometry_quality =        100 = full contact
--!                               60 = partial contact
--!                               30 = no contact
--!                                0 = not evaluated
--!    center_geometry_quality = 100 = contact
--!                               30 = no contact
--!                                0 = not evaluated
--!    surface_quality_min =     100 = all ok
--!                               60 = worst is possible
--!                               30 = worst is wrong
--!                               10 = special "above_water"
--!                                0 = not evaluated
--!    surface_quality_max =     100 = all ok
--!                               60 = best is possible
--!                               30 = best is wrong
--!                               10 = special "above_water"
--!                                0 = not evaluated
--!    surface_quality_center =  100 = ok
--!                               60 = best is possible
--!                               30 = best is wrong
--!                               10 = special "above_water"
--!                                0 = not evaluated
--!    level_quality     =       100 = ok
--!                               60 = above_limit
--!                               30 = below_limit
--!                                0 = not evaluated
--!    valid             =      true = data is valid
--!                            false = no valid data
-------------------------------------------------------------------------------
function environment.pos_quality(pos,entity)
	mobf_assert_backtrace(pos ~= nil)
	mobf_assert_backtrace(entity ~= nil)
	mobf_assert_backtrace(entity.collisionbox ~= nil)
	mobf_assert_backtrace(entity.environment ~= nil)

	local retval = {
					media_quality           =  100,
					geometry_quality        =    0,
					center_geometry_quality =    0,
					surface_quality_min     =  100,
					surface_quality_max     =    0,
					surface_quality_center  =    0,
					level_quality           =  100,
					valid                   = true,

					tostring = function(state)
						environment.is_state(state)

						local retval = "\nState: ".. dump(state.valid) .. "\n"
						retval = retval .."\tmedia_quality: (" .. state.media_quality ..") "
						if state.media_quality == 100 then retval = retval .. "in media" end
						if state.media_quality ==  30 then retval = retval .. "collision" end
						if state.media_quality ==  20 then retval = retval .. "in water" end
						if state.media_quality ==  10 then retval = retval .. "in air" end
						if state.media_quality ==   5 then retval = retval .. "solid" end
						if state.media_quality ==   0 then retval = retval .. "not evaluated" end

						retval = retval .."\n\tgeometry_quality: (" .. state.geometry_quality .. ") "
						if state.geometry_quality == 100 then retval = retval .. "full contact" end
						if state.geometry_quality ==  60 then retval = retval .. "partial contact" end
						if state.geometry_quality ==  30 then retval = retval .. "no contact" end
						if state.geometry_quality ==   0 then retval = retval .. "not evaluated" end

						retval = retval .."\n\tcenter_geometry_quality: (" .. state.center_geometry_quality .. ") "
						if state.center_geometry_quality == 100 then retval = retval .. "contact" end
						if state.center_geometry_quality ==  30 then retval = retval .. "no contact" end
						if state.center_geometry_quality ==   0 then retval = retval .. "not evaluated" end

						retval = retval .."\n\tsurface_quality_min: (" .. state.surface_quality_min ..") "
						if state.surface_quality_min == 100 then retval = retval .. "ok" end
						if state.surface_quality_min ==  60 then retval = retval .. "possible" end
						if state.surface_quality_min ==  30 then retval = retval .. "wrong" end
						if state.surface_quality_min ==  10 then retval = retval .. "above water" end
						if state.surface_quality_min ==   0 then retval = retval .. "not evaluated" end

						retval = retval .."\n\tsurface_quality_max: (" .. state.surface_quality_max .. ") "
						if state.surface_quality_max == 100 then retval = retval .. "ok" end
						if state.surface_quality_max ==  60 then retval = retval .. "possible" end
						if state.surface_quality_max ==  30 then retval = retval .. "wrong" end
						if state.surface_quality_max ==  10 then retval = retval .. "above water" end
						if state.surface_quality_max ==   0 then retval = retval .. "not evaluated" end

						retval = retval .."\n\tsurface_quality_center: (" .. state.surface_quality_center .. ") "
						if state.surface_quality_center == 100 then retval = retval .. "ok" end
						if state.surface_quality_center ==  60 then retval = retval .. "possible" end
						if state.surface_quality_center ==  30 then retval = retval .. "wrong" end
						if state.surface_quality_center ==  10 then retval = retval .. "above water" end
						if state.surface_quality_center ==   0 then retval = retval .. "not evaluated" end

						retval = retval .."\n\tlevel_quality: (" .. state.level_quality .. ") "
						if state.level_quality == 100 then retval = retval .. "ok" end
						if state.level_quality ==  60 then retval = retval .. "above limit" end
						if state.level_quality ==  30 then retval = retval .. "below limit" end
						if state.level_quality ==   0 then retval = retval .. "not evaluated" end
						retval = retval .. "\n"

						return retval
					end,
					shortstring = function(state)
						return dump(state.valid) .. ":" ..
							state.media_quality .. ";" ..
							state.geometry_quality .. "," .. state.center_geometry_quality .. ";" ..
							state.surface_quality_min .. "," .. state.surface_quality_center .. "," ..state.surface_quality_max .. ";" ..
							state.level_quality
					end
				}



	local cornerpositions = {}
	local lastpos = nil -- performance improvement to skip checking same pos multiple times

	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[4] -0.01,y=pos.y,z=pos.z + entity.collisionbox[6] -0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[4] -0.01,y=pos.y,z=pos.z + entity.collisionbox[3] +0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[1] +0.01,y=pos.y,z=pos.z + entity.collisionbox[6] -0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[1] +0.01,y=pos.y,z=pos.z + entity.collisionbox[3] +0.01})

	local min_ground_distance,max_ground_distance = environment.get_min_max_ground_dist(entity)

	--check if mob at pos will be in correct environment
	for i=1,#cornerpositions,1 do
		if not mobf_pos_is_same(lastpos,cornerpositions[i]) then
			local med_quality,node_to_check =
				environment.evaluate_pos_media(cornerpositions[i],
												entity.environment.media)
			--if current result is worse than old one
			if med_quality < retval.media_quality then
				if med_quality == 0 then
					retval.valid = false
				end

				if node_to_check.name == "default:water_source" or
					node_to_check.name == "default:water_flowing" then
					retval.media_quality = 20
				end

				if node_to_check.name == "air" then
					retval.media_quality = 10
					break
				end

				if med_quality < retval.media_quality then
					retval.media_quality = 5
				end
			end
		end
		lastpos = cornerpositions[i]
	end

	--check height level for flying mobs
	if entity.data.movement.canfly == true then
		lastpos = nil
		for i=1,#cornerpositions,1 do
			if not mobf_pos_is_same(lastpos,cornerpositions[i]) then
				local miny,maxy = environment.get_absolute_min_max_pos(entity.environment,cornerpositions[i])

				dbg_mobf.environment_lvl2("MOBF: \tflying mob detected, min: "
					.. miny .. " max: " .. maxy .. " current: " .. pos.y)


				if cornerpositions[i].y < miny then
					retval.level_quality = 30
				end

				if cornerpositions[i].y > maxy then
					retval.level_quality = 60
				end

				if retval.level_quality < 100 then
					break
				end
			end

		lastpos = cornerpositions[i]
		end
	else

		--check geometry and surface quality
		lastpos = nil
		local have_contact    = false
		local have_no_contact = false

		table.insert(cornerpositions,pos)

		for i=1,#cornerpositions,1 do
			if not mobf_pos_is_same(lastpos,cornerpositions[i]) then

				local ground_distance = mobf_ground_distance(cornerpositions[i], entity.environment.media)


				--first check if on surface or not
				if ground_distance <= max_ground_distance then
					local is_center = false
					if mobf_pos_is_same(pos,cornerpositions[i]) then
						retval.center_geometry_quality = 100
						is_center = true
					end
					have_contact = true

					local current_surface,belowname =
						environment.checksurface(cornerpositions[i],entity.environment.surfaces)

					if current_surface == "ok" then
						if retval.surface_quality_max < 100 then
							retval.surface_quality_max = 100
						end

						if is_center then
							retval.surface_quality_center = 100
						end
					end

					if current_surface == "possible_surface" then
						if retval.surface_quality_max < 60 then
							retval.surface_quality_max = 60
						end

						if retval.surface_quality_min > 60 then
							retval.surface_quality_min = 60
						end

						if is_center then
							retval.surface_quality_center = 60
						end
					end

					if current_surface == "wrong_surface" then
						if	belowname == "default:water_source" or
							belowname == "default:water_flowing" then
							if retval.surface_quality_max < 10 then
								retval.surface_quality_max = 10
							end

							if retval.surface_quality_min > 10 then
								retval.surface_quality_min = 10
							end

							if is_center then
								retval.surface_quality_center = 10
							end
						else
							if retval.surface_quality_max < 30 then
								retval.surface_quality_max = 30
							end

							if retval.surface_quality_min > 30 then
								retval.surface_quality_min = 30
							end

							if is_center then
								retval.surface_quality_center = 30
							end
						end
					end
				else
					if mobf_pos_is_same(pos,cornerpositions[i]) then
						retval.center_geometry_quality = 30
					end
					have_no_contact = true
				end
			end

			lastpos = cornerpositions[i]
		end

		if have_contact and not have_no_contact then
			retval.geometry_quality = 100
		end

		if have_contact and have_no_contact then
			retval.geometry_quality = 60
		end

		if not have_contact and have_no_contact then
			retval.geometry_quality = 30
		end
	end

	return retval
end


-------------------------------------------------------------------------------
-- @function [parent=#environment] pos_is_ok(pos,entity) DEPRECATED
--
--! @brief check if a position is suitable for an mob
--! @ingroup environment
--
--! @param pos position to check
--! @param entity mob to check
--! @param dont_do_jumpcheck
--! @return suitability of position for mob values:
--!           -ok                    -@>position is ok
--!           -collision             -@>position is within a node
--!           -collision_jumpable    -@>position is within a node that can be jumped onto
--!           -drop                  -@>position is a drop
--!           -drop_above_water      -@>position is to far above water
--!           -above_water           -@>position is right over water
--!           -in_water              -@>position is within a water node(source or flow)
--!			  -in_air                -@>position is in air
--!           -above_limit           -@>position is above level limit
--!           -below_limit           -@>position is below level limit
--!           -wrong_surface         -@>position is above surface mob shouldn't be
--!           -invalid               -@>unable to check position
-------------------------------------------------------------------------------
function environment.pos_is_ok(pos,entity,dont_do_jumpcheck)

	local min_ground_distance,max_ground_distance = environment.get_min_max_ground_dist(entity)

	local cornerpositions = {}

	table.insert(cornerpositions,pos)
	--read positions at corners
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[4] -0.01,y=pos.y,z=pos.z + entity.collisionbox[6] -0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[4] -0.01,y=pos.y,z=pos.z + entity.collisionbox[3] +0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[1] +0.01,y=pos.y,z=pos.z + entity.collisionbox[6] -0.01})
	table.insert(cornerpositions,{x=pos.x + entity.collisionbox[1] +0.01,y=pos.y,z=pos.z + entity.collisionbox[3] +0.01})

	local lastpos = nil

	local retval = "temp_ok"

	--check if mob at pos will be in correct environment
	for i=1,#cornerpositions,1 do
		if not mobf_pos_is_same(lastpos,cornerpositions[i]) then
			local node_to_check = minetest.get_node(cornerpositions[i])

			if node_to_check == nil then
				mobf_bug_warning(LOGLEVEL_ERROR,"MOBF: BUG!!!! checking position with invalid node")
				retval = "invalid"
				break
			end

			if not environment.is_media_element(node_to_check.name,entity.environment.media) == true then
				dbg_mobf.environment_lvl3("MOBF: " .. i .. ": " ..
					printpos(cornerpositions[i]) .. " -- " .. printpos(pos) ..
					" not within environment")

				if mobf_pos_is_same(pos,cornerpositions[i]) then
					if node_to_check.name == "default:water_source" or
						node_to_check.name == "default:water_flowing" then
						retval = "in_water"
						break
					end

					if node_to_check.name == "air" then
						retval = "in_air"
						break
					end

					--TODO maybe replace by "invalid medium"
				else
					retval = "collision"
				end
			end
		end
		lastpos = cornerpositions[i]
	end

	--
	if retval == "temp_ok" then
		dbg_mobf.environment_lvl3("MOBF: \tin environment")
		local ground_distance = mobf_ground_distance(pos,entity.environment.media)

		--following return codes are only usefull for non flying
		if entity.data.movement.canfly == nil or
			entity.data.movement.canfly == false then

			if mobf_above_water(pos) then

				if ground_distance > max_ground_distance then
					dbg_mobf.environment_lvl2("MOBF: \tdropping above water")
					retval = "drop_above_water"
				end
				dbg_mobf.environment_lvl2("MOBF: \tabove water")
				retval = "above_water"
			end

			if ground_distance > max_ground_distance then
				dbg_mobf.environment_lvl2("MOBF: \tdropping "
					.. ground_distance .. " / " .. max_ground_distance)
				retval = "drop"
			else
				dbg_mobf.environment_lvl2("MOBF: \tsurface dependent")
				retval = environment.checksurface(pos,entity.environment.surfaces)
			end
		else
			local miny,maxy = environment.get_absolute_min_max_pos(entity.environment,pos)
			dbg_mobf.environment_lvl2("MOBF: \tflying mob detected, min: "
				.. miny .. " max: " .. maxy .. " current: " .. pos.y)
			if pos.y < miny then
				retval = "below_limit"
			else if pos.y > maxy then
				retval = "above_limit"
			else
				retval = environment.checksurface(pos,entity.environment.surfaces)
			end end
		end
	end

	if retval == "collision" and not dont_do_jumpcheck then
		dbg_mobf.environment_lvl2("MOBF: check if pos is jumpable")
		local upper_pos_state = environment.pos_is_ok({x=pos.x,
																y=pos.y+1,
																z=pos.z},
																entity,true)
		if  upper_pos_state == "ok" then
			retval = "collision_jumpable"
		else
			dbg_mobf.environment_lvl2("MOBF: upper pos state was: " .. upper_pos_state)
		end
	end

	return retval
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] get_default_gravity(pos,environment,canfly)
--
--! @brief get default acceleration depending on mobs medium and pos
--! @ingroup environment
--
--! @param pos position where to check gravity
--! @param media mobs movement medium
--! @param canfly is mob capable of flying?
--! @return y-acceleration
------------------------------------------------------------------------------
function environment.get_default_gravity(pos,media,canfly)

	if pos == nil then
		return nil
	end

	local node = minetest.get_node(pos)

	--if an mob can't fly or isn't within it's medium default acceleration
	-- for it's current medium is applied
	if  canfly == nil or
		canfly == false or
		environment.is_media_element(node.name,media) == false
		then
		if (node.name == "air") then
			return -9.81
		end

		if node.name == "default:water_source" or
			node.name == "default:water_flowing" then
			return -2.5
		end

		if node.name == "default:lava" then
			return 0.1
		end

		--mob is at invalid position thus returning default air acceleration
		return -9.81
	end

	return 0
end


-------------------------------------------------------------------------------
-- @function [parent=#environment] fix_base_pos(entity, middle_to_bottom)
--
--! @brief fix the mobs y position according to model or sprite height
--! @ingroup environment
--
--! @param entity mob to fix base position
--! @param center_to_bottom distance from center of mob to its bottom (absolute value)
--! @return new position set by function
------------------------------------------------------------------------------
function environment.fix_base_pos(entity, center_to_bottom)

	if center_to_bottom > 0.5 then

		local pos = entity.object:getpos()

		local node_pos = minetest.get_node(pos)

		local pos_to_check = {x=pos.x,y=pos.y-center_to_bottom+0.1,z=pos.z}
		local node_pos_check = minetest.get_node(pos_to_check)

		if node_pos ~= nil and
			node_pos_check ~= nil then
			dbg_mobf.environment_lvl3("MOBF: fixing y position / base position required? "
				.. node_pos.name .. " " .. node_pos_check.name)
			if node_pos.name ~= node_pos_check.name then
				local distance_to_ground = mobf_surface_distance(pos)

				pos.y = pos.y + (center_to_bottom - distance_to_ground +0.5)
				dbg_mobf.environment_lvl2("MOBF: fixing y position of " .. entity.data.name
					.. " got distance " .. center_to_bottom .. " moving to " ..printpos(pos))
				entity.object:moveto(pos)
				entity.dynamic_data.spawning.spawnpoint = pos
			end
		end
	end

	return entity.getbasepos(entity)
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] register(name, environment)
--
--! @brief register an environment to mob framework
--! @ingroup environment
--
--! @param name id of environment
--! @param environment description of environment
--! @return true/false succesfully registred environment
-------------------------------------------------------------------------------
function environment.register(name, environment)

	if environment_list[name] ~= nil then
		return false
	end

	environment_list[name] = environment
	return true
end

-------------------------------------------------------------------------------
-- @function [parent=#environment] pos_state_is_impossible(entity,pos)
--
--! @brief checks if a entity can be there (not if it would move there by its own)
--! @ingroup environment
--
--! @param entity entity to check
--! @param pos position to check
--! @return true entity may be there, entity can never be there
-------------------------------------------------------------------------------
function environment.possible_pos(entity,pos)
	local state = environment.pos_is_ok(pos,entity)

	if 	state == "collision" or
		state == "collision_jumpable" or
		state == "invalid" then
		return false
	end

	return true
end

--!@}

dofile (mobf_modpath .. "/environments/general_env_sets.lua")
dofile (mobf_modpath .. "/environments/flight_1.lua")
dofile (mobf_modpath .. "/environments/meadow.lua")
dofile (mobf_modpath .. "/environments/on_ground_1.lua")
dofile (mobf_modpath .. "/environments/on_ground_2.lua")
dofile (mobf_modpath .. "/environments/open_waters.lua")
dofile (mobf_modpath .. "/environments/shallow_waters.lua")
dofile (mobf_modpath .. "/environments/deep_water.lua")
dofile (mobf_modpath .. "/environments/simple_air.lua")