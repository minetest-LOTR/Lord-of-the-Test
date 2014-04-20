-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allowed to pretend you have written it.
--
--! @file generic_functions.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup gen_func Generic functions
--! @brief functions for various tasks
--! @ingroup framework_int
--! @{

-------------------------------------------------------------------------------
-- name: mobf_get_time_ms()
--
--! @brief get current time in ms
--
--! @return current time in ms
-------------------------------------------------------------------------------
function mobf_get_time_ms()
	--this fct is overwritten on init with best timesource available atm
	return os.clock() * 1000
end

-------------------------------------------------------------------------------
-- name: mobf_contains(cur_table,element)
--
--! @brief check if element is in table
--
--! @param cur_table table to look in
--! @param element element to look for
--! @return true/false
-------------------------------------------------------------------------------
function mobf_contains(cur_table,element)

    if cur_table == nil then
        return false
    end

    for i,v in ipairs(cur_table) do
        if v == element then
            return true
        end
    end

    return false
end

-------------------------------------------------------------------------------
-- name: MIN(a,b)
--
--! @brief minimum of two numbers
--
--! @param a number 1
--! @param b number 2
--! @return minimum
-------------------------------------------------------------------------------
function MIN(a,b)
	mobf_assert_backtrace(type(a) == "number")
	mobf_assert_backtrace(type(b) == "number")
	if a > b then
		return b
	else
		return a
	end
end

-------------------------------------------------------------------------------
-- name: MAX(a,b)
--
--! @brief maximum of two numbers
--
--! @param a number 1
--! @param b number 2
--! @return maximum
-------------------------------------------------------------------------------
function MAX(a,b)
	mobf_assert_backtrace(type(a) == "number")
	mobf_assert_backtrace(type(b) == "number")
	if a > b then
		return a
	else
		return b
	end
end

-------------------------------------------------------------------------------
-- name: DELTA(a,b)
--
--! @brief delta of two numbers
--
--! @param a number 1
--! @param b number 2
--! @return delta
-------------------------------------------------------------------------------
function DELTA(a,b)
	return math.abs(a-b)
end
-------------------------------------------------------------------------------
-- name: mobf_is_walkable(node)
--
--! @brief check if walkable flag is set for a node
--
--! @param node to check
--! @return true/false
-------------------------------------------------------------------------------
function mobf_is_walkable(node)
	return (node and node.name and minetest.registered_nodes[node.name] and
			minetest.registered_nodes[node.name].walkable == false)
end

-------------------------------------------------------------------------------
-- name: mobf_get_current_time()
--
--! @brief alias to get current time
--
--! @return current time in seconds
-------------------------------------------------------------------------------
function mobf_get_current_time()
	if type(minetest.get_time) == "function" then
		return minetest.get_time()
	else
		return os.time(os.date('*t'))
	end
end

-------------------------------------------------------------------------------
-- name: mobf_round_pos(pos)
--
--! @brief calculate integer position
--
--! @param pos position to be rounded
--! @return rounded position
-------------------------------------------------------------------------------
function mobf_round_pos(pos)
	if pos == nil then
		return pos
	end

	return { 	x=math.floor(pos.x + 0.5),
			y=math.floor(pos.y + 0.5),
			z=math.floor(pos.z + 0.5)
		 }
end

-------------------------------------------------------------------------------
-- name: mobf_find_entity(newobject) DEPRECATED
--
--! @brief find entity by object reference
--
--! @param newobject r object reference
--! @return entity object reference points at or nil on error
-------------------------------------------------------------------------------
function mobf_find_entity(newobject)
	return newobject:get_luaentity()
end

-------------------------------------------------------------------------------
-- name: mobf_max_light_around(pos,range,daytime)
--
--! @brief get maximum light level around specified position
--
--! @param pos center of area to search
--! @param distance radius of area
--! @param daytime time of day to check
--! @return highest detected light level
-------------------------------------------------------------------------------
function mobf_max_light_around(pos,distance,daytime)
	mobf_assert_validpos(pos)
	local max_light = 0

	for y_run=pos.y-distance,pos.y+distance,1 do
	for z_run=pos.z-distance,pos.z+distance,1 do
	for x_run=pos.x-distance,pos.x+distance,1 do
		local current_pos = {x=x_run,y=y_run,z=z_run }
		local node = minetest.get_node(current_pos)

		if node.name == "air" then
			local current_light = minetest.get_node_light(current_pos,daytime)

			if current_light > max_light then
				max_light = current_light
			end
		end
	end
	end
	end

	return max_light
end

-------------------------------------------------------------------------------
-- name: mobf_min_light_around(pos,range,daytime)
--
--! @brief get minimum light level around specified position
--
--! @param pos center of area to search
--! @param distance radius of area
--! @param daytime time of day to check
--! @return highest detected light level
-------------------------------------------------------------------------------
function mobf_min_light_around(pos,distance,daytime)
	mobf_assert_validpos(pos)
	local min_light = LIGHT_MAX+1

	for y_run=pos.y-distance,pos.y+distance,1 do
	for z_run=pos.z-distance,pos.z+distance,1 do
	for x_run=pos.x-distance,pos.x+distance,1 do
		local current_pos = {x=x_run,y=y_run,z=z_run }
		local node = minetest.get_node(current_pos)

		if node.name == "air" then
			local current_light = minetest.get_node_light(current_pos,daytime)

			if current_light < min_light then
				min_light = current_light
			end
		end
	end
	end
	end

	return min_light
end

-------------------------------------------------------------------------------
-- name: mobf_mob_around(mob_name,mob_transform_name,pos,range,)
--
--! @brief get number of mobs of specified type within range of pos
--
--! @param mob_name basic name of mob
--! @param mob_transform secondary name of mob
--! @param pos position to check
--! @param range range to check
--! @param ignore_playerspawned ignore mob spawned by players for check
--! @return number of mob found
-------------------------------------------------------------------------------
function mobf_mob_around(mob_name,mob_transform,pos,range,ignore_playerspawned)
	local count = 0
	local objectcount = 0

	mobf_assert_backtrace(range ~= nil)
	mobf_assert_backtrace(pos ~= nil)

	local objectlist = minetest.get_objects_inside_radius(pos,range)

	if mob_transform == nil then
		mob_transform = ""
	end

	local objcount = 0
	if objectlist ~= nil then
		objcount = #objectlist
	end

	dbg_mobf.generic_lvl1("MOBF: entity at "..printpos(pos)..
					" looking for: "..mob_name ..
					" or " .. mob_transform ..
					" within " .. objcount .. " objects" )

	for index,value in pairs(objectlist) do

		local entity = mobf_find_entity(value)

		--any mob is required to have a name so we may use this to decide
		--if an entity is an mob or not
		if 	entity ~= nil and
			entity.data ~= nil and
			entity.dynamic_data ~= nil then

			if entity.removed == false then

				if entity.data.modname..":"..entity.data.name == mob_name or
					entity.data.modname..":"..entity.data.name == mob_transform then

					-- oops we don't yet know if this is playerspawned,
					-- for performance reasons assume it isn't
					if entity.dynamic_data.spawning == nil then
						count = count + 1
					else
						if (ignore_playerspawned and entity.dynamic_data.spawning.player_spawned) or
							ignore_playerspawned ~= false then
							dbg_mobf.generic_lvl1("MOBF: Found "..mob_name.. " or "
								..mob_transform .. " within specified range of "..range)
							count = count + 1
						end
					end
				end
			end
		end
		objectcount = objectcount +1
	end

	dbg_mobf.generic_lvl2("MOBF: found " .. objectcount .. " within range "
		.. count .. " of them are relevant mobs ")

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_spawner_around(mob_name,pos,range)
--
--! @brief get number of mobs of specified type within range of pos
--
--! @param mob_name basic name of mob
--! @param pos position to check
--! @param range range to check
--! @return number of mob found
-------------------------------------------------------------------------------
function mobf_spawner_around(mob_name,pos,range)
	mobf_assert_validpos(pos)
	dbg_mobf.generic_lvl2("MOBF: mobf_spawner_around param: ".. dump(mob_name)
		.. " "..dump(pos).. " " .. dump(range))

	local count = 0
	local objectcount = 0

	local objectlist = minetest.get_objects_inside_radius(pos,range)

	for index,value in pairs(objectlist) do

		local entity = value:get_luaentity()

		dbg_mobf.generic_lvl3("MOBF: entity at: "..dump(value:getpos())..
							" looking for: "..mob_name .. " " ..
							dump(value) .. " " ..
							dump(entity))

		--any mob is required to have a name so we may use this to decide
		--if an entity is an mob or not
		if 	entity ~= nil and
			entity.spawner_mob_name ~= nil then

			if entity.spawner_mob_name == mob_name then
				dbg_mobf.generic_lvl2("MOBF: Found "..mob_name
					.. " within specified range of "..range)
				count = count + 1
			end
		end

		objectcount = objectcount +1
	end

	dbg_mobf.generic_lvl2("MOBF: found " .. objectcount .. " within range "
		.. count .. " of them are relevant spawners ")

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_line_of_sight(pos1,pos2)
--
--! @brief is there a line of sight between two specified positions
--
--! @param pos1 start position of los check
--! @param pos2 end position of los check
--! @return: true/false
-------------------------------------------------------------------------------
function mobf_line_of_sight(pos1,pos2)

	--print("Checking line of sight between "..printpos(pos1).." and "..printpos(pos2))
	local distance = mobf_calc_distance(pos1,pos2)

	local normalized_vector = {	x=(pos2.x-pos1.x)/distance,
					y=(pos2.y-pos1.y)/distance,
					z=(pos2.z-pos1.z)/distance}


	local line_of_sight = true

	for i=1,distance, 1 do
		local tocheck = { x=pos1.x + (normalized_vector.x * i),
					y=pos1.y + (normalized_vector.y *i),
					z=pos1.z + (normalized_vector.z *i)}

		local node = minetest.env:get_node(tocheck)


		if minetest.registered_nodes[node.name] == nil or
			minetest.registered_nodes[node.name].sunlight_propagates ~= true then
			line_of_sight = false
			break
		end
	end

	return line_of_sight
end

function mobf_line_of_sightX(pos1,pos2)
	return minetest.line_of_sight(pos1,pos2)
end

-------------------------------------------------------------------------------
-- name: mobf_pos_is_zero(pos)
--
--! @brief check if position is (0,0,0)
--
--! @param pos position to check
--! @return true/false
-------------------------------------------------------------------------------

function mobf_pos_is_zero(pos)

	if pos.x ~= 0 then return false end
	if pos.y ~= 0 then return false end
	if pos.z ~= 0 then return false end

	return true
end

-------------------------------------------------------------------------------
-- name: mobf_air_above(pos,height)
--
--! @brief check if theres at least height air abov pos
--
--! @param pos position to check
--! @param height min number of air to check
--! @return true/false
-------------------------------------------------------------------------------
function mobf_air_above(pos,height)
	mobf_assert_validpos(pos)
	for i=0, height, 1 do
		local pos_above = {
			x = pos.x,
			y = pos.y + 1,
			z = pos.z
			}
		local node_above = minetest.get_node(pos_above)

		if node_above.name ~= "air" then
			return false
		end
	end

	return true
end


-------------------------------------------------------------------------------
-- name: mobf_ground_distance(pos,media)
--
--! @brief get number of blocks above solid ground
--
--! @param pos_raw position to check
--! @param media table of blocks not considered to be ground
--! @param max_check_height abort looking for ground after this number of nodes
--
--! @return number of blocks to ground
-------------------------------------------------------------------------------
function mobf_ground_distance(pos_raw,media,max_check_height)

	local pos = {
					x=pos_raw.x,
					y=math.floor(pos_raw.y + 0.5),
					z=pos_raw.z
				}

	local node_to_check = minetest.get_node(pos)

	local count = 0

	if max_check_height == nil then
		max_check_height = 32
	end

	while node_to_check ~= nil and mobf_contains(media,node_to_check.name) and
			count < max_check_height do
		count = count +1
		pos = {x=pos.x,y=pos.y-1,z=pos.z};
		node_to_check = minetest.get_node(pos)
	end

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_surface_distance(pos)
--
--! @brief get number of blocks above surface (solid or fluid!)
--
--! @param pos position to check
--! @return number of blocks to ground
-------------------------------------------------------------------------------
function mobf_surface_distance(pos)

	local node_to_check = minetest.get_node(pos)

	local count = 0

	while node_to_check ~= nil and
			node_to_check.name == "air" and
			count < 32 do

		count = count +1

		pos = {x=pos.x,y=pos.y-1,z=pos.z};
		node_to_check = minetest.get_node(pos)
	end

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_air_distance(pos)
--
--! @brief get number of blocks below waterline
--
--! @param pos position to check
--! @return number of blocks to air
-------------------------------------------------------------------------------
function mobf_air_distance(pos)
	mobf_assert_validpos(pos)

	local node_to_check = minetest.get_node(pos)

	local count = 0

	while node_to_check ~= nil and (
			node_to_check.name == "default:water_source" or
			node_to_check.name == "default:water_flowing") do

		count = count +1
		pos = {x=pos.x,y=pos.y+1,z=pos.z};
		node_to_check = minetest.get_node(pos)
	end

	if node_to_check.name == "air" then
		return count
	else
		return -1
	end
end

-------------------------------------------------------------------------------
-- name: mobf_above_water(pos)
--
--! @brief check if next non-air block below mob is a water block
--
--! @param pos position to check
--! @return true/false
-------------------------------------------------------------------------------
function mobf_above_water(pos)

	local node_to_check = minetest.get_node(pos)

	while node_to_check ~= nil and
			node_to_check.name == "air" do

			pos = {x=pos.x,y=pos.y-1,z=pos.z};
			node_to_check = minetest.get_node(pos)
	end

	if node_to_check.name == "default:water_source" or
		node_to_check.name == "default:water_flowing" then
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: get_sunlight_surface(x,z, min_y, max_y)
--
--! @brief get surface for x/z coordinates
--
--! @param x x-coordinate
--! @param z z-coordinate
--! @param min_y minimum y-coordinate to consider
--! @param max_y maximum y-coordinate to consider
--! @return y value of surface or nil
-------------------------------------------------------------------------------
function mobf_get_sunlight_surface(x,z, min_y, max_y)
    for runy = min_y, max_y,1 do
        local pos = { x=x,y=runy, z=z }
        local node_to_check = minetest.get_node(pos)

        if node_to_check.name == "default:dirt_with_grass" then
            return pos.y
        end
    end

    return nil
end

-------------------------------------------------------------------------------
-- name: get_surface(x,z, min_y, max_y)
--
--! @brief get surface for x/z coordinates
--
--! @param x x-coordinate
--! @param z z-coordinate
--! @param min_y minimum y-coordinate to consider
--! @param max_y maximum y-coordinate to consider
--! @return y value of surface (first air node) or nil
-------------------------------------------------------------------------------
function mobf_get_surface(x,z, min_y, max_y)
	mobf_assert_backtrace(min_y ~= nil)
	mobf_assert_backtrace(max_y ~= nil)
	mobf_assert_backtrace(x ~= nil)
	mobf_assert_backtrace(z ~= nil)

	if type(minetest.get_surface) == "function" then
		local basepos = {x=x,y=min_y,z=z}
		local offset = max_y-min_y
		local retval = minetest.get_surface(basepos,offset)
		return retval
	end

	local last_node = minetest.get_node({ x=x,y=min_y, z=z })
	for runy = min_y+1, max_y,1 do
		local pos = { x=x,y=runy, z=z }
		local node_to_check = minetest.get_node(pos)
		if node_to_check.name == "air" and
			last_node.name ~= "air" and
			last_node.mame ~= "ignore" then
			return pos.y
		end
		last_node = node_to_check
	end
	return nil
end

-------------------------------------------------------------------------------
-- name: entity_at_loaded_pos(entity.mobname)
--
--! @brief check if entity is activated at already loaded pos
--
--! @param pos to check
--! @param mobname name of mob
--! @return true/false
-------------------------------------------------------------------------------
function entity_at_loaded_pos(pos,mobname)

	local current_node = minetest.get_node(pos)
	if mobname == nil then
		mobname = ""
	end

	if current_node ~= nil then
		if current_node.name == "ignore" then
			minetest.log(LOGLEVEL_WARNING,"MOBF: " ..mobname .. " spawned at unloaded pos! : "
			.. dump(pos))
			return false
		else
			return true
		end
	end
	minetest.log(LOGLEVEL_WARNING,"MOBF: spawned at invalid pos!")
	return false
end

-------------------------------------------------------------------------------
-- name: mobf_random_direction()
--
--! @brief get a random (blocked) 3d direction
--
--! @return 3d dir value
-------------------------------------------------------------------------------
function mobf_random_direction()

	local retval = {}

	retval.x=math.random(-1,1)
	retval.y=math.random(-1,1)
	retval.z=math.random(-1,1)

	return retval
end

-------------------------------------------------------------------------------
-- name: mobf_pos_is_same(pos1,pos2)
--
--! @brief check if two positions are equal
--
--! @param pos1
--! @param pos2
--
--! @return true/false
-------------------------------------------------------------------------------
function mobf_pos_is_same(pos1,pos2)
	if pos1 == nil or
		pos2 == nil then
		return false
	end

	if pos1.x ~= pos2.x or
		pos1.y ~= pos2.y or
		pos1.z ~= pos2.z or
		pos1.x == nil or
		pos1.y == nil or
		pos1.z == nil or
		pos2.x == nil or
		pos2.y == nil or
		pos2.z == nil then
		return false
	end

	return true
end

-------------------------------------------------------------------------------
-- name: mobf_is_pos(value)
--
--! @brief check if a given value is a position
--
--! @param value to check
--
--! @return true/false
-------------------------------------------------------------------------------
function mobf_is_pos(value)

	if value == nil or
		type(value) ~= "table" then
		return false
	end

	if value.x == nil or
		tonumber(value.x) == nil then
		return false
	end

	if value.y == nil or
		tonumber(value.y) == nil then
		return false
	end

	if value.z == nil or
		tonumber(value.z) == nil then
		return false
	end


	return true
end

--!@}
