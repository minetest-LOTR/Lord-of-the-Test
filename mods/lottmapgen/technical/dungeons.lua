local bitty = dofile(minetest.get_modpath("lottmapgen") .. "/technical/bitwise.lua")

local prand = PseudoRandom(os.time())
local c_ignore = minetest.get_content_id("ignore")
local n_stairs = minetest.get_content_id("lottplants:oak_tree")
local n_air = minetest.get_content_id("air")

local function rand_ortho_dir(diagonal_dirs)
	-- Make diagonal directions somewhat rare
	if (diagonal_dirs and (prand:next() % 4 == 0)) then
		local dir = {x = 0, y = 0, z = 0}
		local trycount = 0
		while ((dir.x == 0 or dir.z == 0) and trycount < 10) do
			trycount = trycount + 1

			dir.z = prand:next() % 3 - 1
			dir.y = 0
			dir.x = prand:next() % 3 - 1
		end

		return dir
	end

	if (prand:next() % 2 == 0) then
		if prand:next() % 2 then
			return {x = -1, y = 0, z = 0}
		else
			return {x = 1,  y = 0, z = 0}
		end
	end
	
	if prand:next() % 2 then
		return {x = 0, y = 0, z = -1}
	else
		return {x = 0, y = 0, z = 1}
	end
end

local function turn_xz(olddir, t)
	local dir = {}
	if t == 0 then
		-- Turn right
		dir.x = olddir.z
		dir.z = -olddir.x
		dir.y = olddir.y
	else 
		-- Turn left
		dir.x = -olddir.z
		dir.z = olddir.x
		dir.y = olddir.y
	end
	return dir
end

local function random_turn(olddir)
	local turn = math.random(0, 2)
	if turn == 0 then
		return olddir
	elseif turn == 1 then
		-- Turn right
		return turn_xz(olddir, 0)
	else
		-- Turn left
		return turn_xz(olddir, 1)
	end
end

local function dir_to_facedir(d)
	if math.abs(d.x) > math.abs(d.z) then
		if d.x < 0 then
			return 3 
		else
			return 1
		end
	end
	if d.z < 0 then
		return 2 
	else
		return 0
	end
end

local m_pos = {x = 0, y = 0, z = 0}
local m_dir = rand_ortho_dir(false)

local function makeFill(place, size, avoid_flags, n, or_flags, area, data)
	for z = 0, size.z do
	for y = 0, size.y do
	for x = 0, size.x do
		local p = vector.add(place, {x = x, y = y, z = z})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = n
			end
		end
	end
	end
	end
end


local function makeHole(place, area, data)
	makeFill(place, {x = 1, y = 2, z = 1}, 0, n_air, nil, area, data) --VMANIP_FLAG_DUNGEON_INSIDE);
end

local function makeDoor(doorplace, doordir, area, data)
	makeHole(doorplace, area, data)
--#ifdef DGEN_USE_TORCHES
--	// Place torch (for testing)
--	vm->m_data[vm->m_area.index(doorplace)] = MapNode(c_torch);
--#endif
end


local function findPlaceForDoor(area, data, wall)
	for i = 0, 99 do
		local continue = true
		local p = vector.add(m_pos, m_dir)
		local p1 = vector.add(p, {x = 0, y = 1, z = 0})
		if not area:containsp(p) or not area:containsp(p1) or i % 4 == 0 then
			m_dir = rand_ortho_dir(false)
			continue = false
		end
		if continue == true then
		if data[area:indexp(p)] == wall and data[area:indexp(p1)] == wall then
			-- Found wall, this is a good place!
			local result_place = p
			local result_dir = m_dir
			-- Randomize next direction
			m_dir = rand_ortho_dir(false)
			return true, result_place, result_dir
		end
		-- Determine where to move next
		-- Jump one up if the actual space is there
		if data[area:indexp(vector.add(p,
				{x = 0, y = 0, z = 0}))] == wall and
				data[area:indexp(vector.add(p,
				{x = 0, y = 1, z = 0}))] == n_air and
				data[area:indexp(vector.add(p,
				{x = 0, y = 2, z = 0}))] == n_air then
			p = vector.add(p, {x = 0, y = 1, z = 0})
		end
		-- Jump one down if the actual space is there
		if data[area:indexp(vector.add(p,
				{x = 0, y = 1, z = 0}))] == wall  and
				data[area:indexp(vector.add(p,
				{x = 0, y = 0, z = 0}))] == n_air  and
				data[area:indexp(vector.add(p,
				{x = 0, y = - 1, z = 0}))] == n_air then
			p = vector.add(p, {x = 0, y = -1, z = 0})
		end
		-- Check if walking is now possible
		if (data[area:indexp(p)] ~= n_air or
				data[area:indexp(vector.add(p,
				{x = 0, y = 1, z = 0}))] ~= n_air) then
			-- Cannot continue walking here
			m_dir = rand_ortho_dir(false)
			continue = false
		end
		if continue == true then
		-- Move there
		m_pos = p
		end
		end
	end
	return false
end

local function findPlaceForRoomDoor(roomsize, area, data)
	local continue = true
	for trycount = 0, 29 do
		local r, doorplace, doordir = findPlaceForDoor(area, data)
		if not r then
			continue = false
		end
		if continue then
		local roomplace
		-- X east, Z north, Y up
		if vector.equals(doordir, {x = 1, y = 0, z = 0}) then -- X+
			roomplace = vector.add(doorplace,
				{x = 0, y = -1, z = math.random(-roomsize.z + 2, -2)})
		elseif vector.equals(doordir, {x = -1, y = 0, z = 0}) then -- X-
			roomplace = vector.add(doorplace,
				{x = -roomsize.x + 1, y = -1, z = math.random(-roomsize.z + 2, -2)})
		elseif vector.equals(doordir, {x = 0, y = 0, z = 1}) then -- Z+
			roomplace = vector.add(doorplace,
				{x = math.random(-roomsize.x + 2, -2), y = -1, z = 0})
		elseif vector.equals(doordir, {x = 0, y = 0, z = -1}) then -- Z-
			roomplace = vector.add(doorplace,
				{x = math.random(-roomsize.x + 2, -2), y = -1, z = -roomsize.z + 1})
		end

		-- Check fit
		local fits = true
		for z = 1, roomsize.z - 2 do
		for y = 1, roomsize.y - 2 do
		for x = 1, roomsize.x - 2 do
			local p = vector.add(roomplace, {x = x, y = y, z = z})
			if not area:containsp(p) then
				fits = false
				break
			end
			--[[if (vm->m_flags[vm->m_area.index(p)] & VMANIP_FLAG_DUNGEON_INSIDE) {
				fits = false;
				break;
			end]]
		end
		end
		end
		if not fits then
			continue = false
		end
		if continue then
		return true, doorplace, doordir, roomplace
		end
		end
	end
	return false
end

local function makeRoom(roomsize, roomplace, area, data, wall)
	-- Make +-X walls
	for z = 0, roomsize.z - 1 do
	for y = 0, roomsize.y - 1 do
		local p = vector.add(roomplace, {x = 0, y = y, z = z})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = wall
			end
		end
		local p = vector.add(roomplace, {x = roomsize.x - 1, y = y, z = z})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = wall
			end
		end
	end
	end

	-- Make +-Z walls
	for x = 0, roomsize.x - 1 do
	for y = 0, roomsize.y - 1 do
		local p = vector.add(roomplace, {x = x, y = y, z = 0})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = wall
			end
		end
		local p = vector.add(roomplace, {x = x, y = y, z = roomsize.z - 1})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = wall
			end
		end
	end
	end

	-- Make +-Y walls (floor and ceiling)
	for z = 0, roomsize.z - 1 do
	for x = 0, roomsize.x - 1 do
		local p = vector.add(roomplace, {x = x, y = 0, z =z})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = wall
			end
		end
		local p = vector.add(roomplace, {x = x, y = roomsize.y - 1, z = z})
		if area:containsp(p) then
			local vi = area:indexp(p)
			if data[vi] ~= n_air then
				data[vi] = wall
			end
		end
	end
	end

	-- Fill with air
	for z = 1, roomsize.z - 2 do
	for y = 1, roomsize.y - 2 do
	for x = 1, roomsize.x - 2 do
		local p = vector.add(roomplace, {x = x, y = y, z = z})
		if area:containsp(p) then
			local vi = area:indexp(p)
			data[vi] = n_air
		end
	end
	end
	end
end

local function makeCorridor(doorplace, doordir, area, data, wall)
	makeHole(doorplace, area, data)
	local p0 = doorplace
	local dir = doordir
	local length = math.random(1, 13)
	local partlength = math.random(1, 13)
	local partcount = 0
	local make_stairs = 0

	if (prand:next() % 2 == 0 and partlength >= 3) then
		if prand:next() % 2 then
			make_stairs = 1
		else
			make_stairs = -1
		end
	end

	for i = 0, length - 1 do
		local continue = true
		local p = vector.add(p0, dir)
		if partcount ~= 0 then
			p.y = p.y + make_stairs
		end

		-- Check segment of minimum size corridor is in voxelmanip
		if area:containsp(p) and area:containsp(vector.add(p, {x = 0, y = 1, z = 0})) then
			if make_stairs then
				makeFill(vector.add(p, {x = -1, y = -1, z = -1}),
					vector.add({x = 1, y = 2, z = 1}, {x = 2, y = 3, z = 2}),
					0,
					wall,
					0, area, data)
				makeHole(p, area, data)
				makeHole(vector.subtract(p, dir), area, data)

				-- TODO: fix stairs code so it works 100%
				-- (quite difficult)

				-- exclude stairs from the bottom step
				-- exclude stairs from diagonal steps
				if --[[bitty.band(bitty.bxor(dir.x, dir.z), 1) and]]
					(((make_stairs ==  1) and i ~= 0) 
					or ((make_stairs == -1) and i ~= length - 1)) then
					-- rotate face 180 deg if
					-- making stairs backwards
					local facedir = dir_to_facedir(vector.multiply(dir, 
						{x = make_stairs, y = make_stairs, z = make_stairs}))
					local ps = p
					local stair_width 
					if dir.Z ~= 0 then
						stair_width = 1 -- dp.holesize.X
					else
						stair_width = 1 -- dp.holesize.Z
					end
					-- Stair width direction vector
					local swv
					if dir.z ~= 0 then
						swv = {x = 1, y = 0, z = 0}
					else
						swv = {x = 0, y = 0, z = 1}
					end
					for st = 0, stair_width - 1 do
						local vi = area:index(ps.x - dir.x, ps.y - 1, ps.z - dir.z)
						if area:containsp(vector.add(ps, {x = -dir.x, y = -1, z = -dir.z}))
							and data[vi] == wall then
							data[vi] = n_stairs--MapNode(dp.c_stair, 0, facedir)
						end
						vi = area:index(ps.x, ps.y, ps.z)
						if area:containsp(ps) and
								data[vi] == wall then
							data[vi] = n_stairs--MapNode(dp.c_stair, 0, facedir);
						end

						ps = vector.add(ps, swv)
					end
				end
			else
				makeFill(vector.add(p, {x = -1, y = -1, z = -1}),
					vector.add(dp.holesize, {x = 1, y = 1, z = 1}),
					0,
					wall,
					0, area, data)
				makeHole(p, area, data)
			end

			p0 = p;
		else
			-- Can't go here, turn away
			dir = turn_xz(dir, math.random(0, 1))
			make_stairs = -make_stairs
			partcount = 0
			partlength = math.random(1, length)
			continue = false
		end
		
		if continue then
			partcount = partcount + 1
			if partcount >= partlength then
				partcount = 0

				dir = random_turn(dir)

				partlength = math.random(1, length)

				make_stairs = 0
				if (prand:next() % 2 == 0 and partlength >= 3) then
					if prand:next() % 2 then
						make_stairs = 1
					else
						make_stairs = -1
					end
				end
			end
		end
	end
	return p0, dir
end

function lottmapgen.generate_dungeon(vm, area, data, emin, wall)
	local start_padding = {x = 16, y = 16, z = 16}
	local areasize = area:getExtent()
	local roomsize = {}
	local roomplace = {}

	--[[
		Find place for first room.
		There is a 1 in 4 chance of the first room being 'large',
		all other rooms are not 'large'.
	]]--
	local fits = false;
	local i = 1
	while (i < 100 and not fits) do
		local is_large_room = math.random(4) == 1
		if is_large_room then
			roomsize.z = math.random(8, 16)
			roomsize.y = math.random(8, 16)
			roomsize.x = math.random(8, 16)
		else
			roomsize.z = math.random(6, 10)
			roomsize.y = math.random(4, 6)
			roomsize.x = math.random(6, 10)
		end

		-- start_padding is used to disallow starting the generation of
		-- a dungeon in a neighboring generation chunk
		roomplace = vector.add(emin, start_padding)
		roomplace.z = roomplace.z + math.random(0, areasize.z - roomsize.z - start_padding.z)
		roomplace.y = roomplace.y + math.random(0, areasize.y - roomsize.y - start_padding.y)
		roomplace.x = roomplace.x + math.random(0, areasize.x - roomsize.x - start_padding.x)

		--[[/*
			Check that we're not putting the room to an unknown place,
			otherwise it might end up floating in the air
		*/]]
		fits = true;
		for z = 0, roomsize.z - 1 do
		for y = 0, roomsize.y - 1 do
		for x = 0, roomsize.x - 1 do
			local p = vector.add(roomplace, {x = x, y = y, z = z})
			local vi = area:indexp(p)
			if data[vi] == c_ignore then
				fits = false
				break
			end
		end
		end
		end
		i = i + 1
	end
	--No place found
	if not fits then
		return
	end

	--[[
		Stores the center position of the last room made, so that
		a new corridor can be started from the last room instead of
		the new room, if chosen so.
	]]--
	local last_room_center = vector.add(roomplace, {x = roomsize.x / 2, y = 1, z = roomsize.z / 2})

	local room_count = math.random(4, 16)
	for i = 0, room_count - 1 do
		-- Make a room to the determined place
		makeRoom(roomsize, roomplace, area, data, wall)

		local room_center = vector.add(roomplace, {x = roomsize.x / 2, y = 1, z = roomsize.z / 2})
		--if (gennotify)
		--	gennotify->addEvent(dp.notifytype, room_center);

--#ifdef DGEN_USE_TORCHES
--		// Place torch at room center (for testing)
--		vm->m_data[vm->m_area.index(room_center)] = MapNode(c_torch);
--#endif

		-- Quit if last room
		if i == room_count - 1 then
			break
		end
		-- Determine walker start position

		local start_in_last_room = math.random(2) ~= 0

		local walker_start_place = {}

		if (start_in_last_room) then
			walker_start_place = last_room_center
		else
			walker_start_place = room_center
			last_room_center = room_center
		end

		-- Create walker and find a place for a door
		m_pos = walker_start_place

		local is_door, doorplace, doordir = findPlaceForDoor(area, data, wall)
		if not is_door then
			return
		end
		--if math.random(0, 1) == 0 then
			-- Make the door
			makeDoor(doorplace, doordir, area, data)
		--else
		--	-- Don't actually make a door
		--	doorplace = vector.subtract(doorplace, doordir)
		--end

		-- Make a random corridor starting from the door
		local corridor_end, corridor_end_dir = makeCorridor(doorplace, doordir, area, data, wall)

		-- Find a place for a random sized room
		roomsize.z = math.random(4, 8)
		roomsize.y = math.random(4, 6)
		roomsize.x = math.random(4, 8)

		m_pos = corridor_end
		m_dir = corridor_end_dir
		local is_room_door, doorplace, doordir, roomplace = findPlaceForRoomDoor(roomsize, area, data)
		if not is_room_door then
			return
		end

		if math.random(0, 1) == 0 then
			-- Make the door
			makeDoor(doorplace, doordir, area, data);
		--else
			-- Don't actually make a door
		--	roomplace = vector.subtract(roomplace, doordir)
		end
	end
end

