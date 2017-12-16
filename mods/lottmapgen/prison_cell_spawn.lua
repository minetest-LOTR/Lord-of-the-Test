--Code extracted and modifed from slemonide's roomgen mod.
local corridors = {}
local placed_corridors = {}
local serialize = minetest.serialize
local MIN_GENERATION_HEIGHT = -500
local coordinates = {"x", "y", "z"}
local A = 9
local path = minetest.get_modpath("lottmapgen")
local function spawn_prison_cell(ctr, rotation, vm)
	local schematic = path .. "/schems/prison_cell.mts"
	minetest.place_schematic_on_vmanip(vm, schematic)
end
local function compare(cor1, cor2)
	for index, item in pairs(cor1) do
		if not ((item == cor2[index]) or (cor2[index] == nil and item == false)) then
			return false
		end
	end
	return true
end
local function register_spawn(name, connect_to, rotate, staircase, after)
	local function rotate_connect(connect_to)
		local rsf = {}
		local connection, state
		for connection, state in pairs(connect_to) do
			if connection == "px" and state then
				rsf.nz = true
			end
			if connection == "nz" and state then
		        	rsf.nx = true
		        end
			if connection == "nx" and state then
		        	rsf.pz = true
			end
	                if connection == "pz" and state then
	                	rsf.px = true
	                end
		end
		return rsf
	end

   local rsf = {}
   table.insert(rsf, {name=name, connect_to = connect_to})
   if rotate then
       	local A = rotate_connect(connect_to)
        local B = rotate_connect(A)
        local C = rotate_connect(B)
		table.insert(rsf, {name=name, connect_to = A, rotation =  90})
		table.insert(rsf, {name=name, connect_to = B, rotation = 180})
		table.insert(rsf, {name=name, connect_to = C, rotation = 270})
    end

    if after then
        for n,i in ipairs(rsf) do
            i.after = after
        end
    end

    for _,i in ipairs(rsf) do
        table.insert(corridors, i)
    end
end
register_corridor("corridor_X", {px=true, pz=true, nx=true, nz=true}, true, true)
register_corridor("corridor_I", {px=true, nx=true}, true, true)
register_corridor("corridor_L", {px=true, nz=true}, true, true)
register_corridor("corridor_E", {px=true}, true, true)
register_corridor("corridor_T", {px=true, pz=true, nz=true}, true, true)
register_corridor("corridor_S", {}, false, false)
register_corridor("prison_cell", {px=true}, false, false, spawn_prison_cell)
local function check_neighbours(corridor_pos)
	local x = corridor_pos.x
	local y = corridor_pos.y
	local z = corridor_pos.z

	local px = x + 1
	local py = y + 1
	local pz = z + 1
	local nx = x - 1
	local ny = y - 1
	local nz = z - 1

	local connect_to = {}

	if placed_corridors[px] then
		if placed_corridors[px][y] then
			if placed_corridors[px][y][z] then
				if placed_corridors[px][y][z].nx then
					connect_to.px = true
				else
					connect_to.px = false
				end
			end
		end
	end
	if placed_corridors[x] then
		if placed_corridors[x][py] then
			if placed_corridors[x][py][z] then
				if placed_corridors[x][py][z].ny then
					connect_to.py = true
				else
					connect_to.py = false
				end
			end
		end
	end
	if placed_corridors[x] then
		if placed_corridors[x][y] then
			if placed_corridors[x][y][pz] then
				if placed_corridors[x][y][pz].nz then
					connect_to.pz = true
				else
					connect_to.pz = false
				end
			end
		end
	end
	if placed_corridors[nx] then
		if placed_corridors[nx][y] then
			if placed_corridors[nx][y][z] then
				if placed_corridors[nx][y][z].px then
					connect_to.nx = true
				else
					connect_to.nx = false
				end
			end
		end
	end
	if placed_corridors[x] then
		if placed_corridors[x][ny] then
			if placed_corridors[x][ny][z] then
				if placed_corridors[x][ny][z].py then
					connect_to.ny = true
				else
					connect_to.ny = false
				end
			end
		end
	end
	if placed_corridors[x] then
		if placed_corridors[x][y] then
			if placed_corridors[x][y][nz] then
				if placed_corridors[x][y][nz].pz then
					connect_to.nz = true
				else
					connect_to.nz = false
				end
			end
		end
	end

	local possible_corridors = {}
	for _, corridor in pairs(corridors) do
		if compare(connect_to, corridor.connect_to) then
			table.insert(possible_corridors, corridor)
		end
	end

	if #possible_corridors > 1 then
	    for position, corridor in pairs(possible_corridors) do
			local number_of_connections = 0
			for _, dir in pairs(corridor.connect_to) do
				number_of_connections = number_of_connections + 1
			end
			if number_of_connections == 1 then
				table.remove(possible_corridors, position)
			end
		end
	end

	for position, corridor in pairs(possible_corridors) do
		    if corridor.connect_to.py or corridor.connect_to.ny then
		        table.remove(possible_corridors, position)
		    end
	end

	local corridor
	if #possible_corridors == 1 then
		corridor = possible_corridors[1]
	else
	if #possible_corridors == 0 then
	    print("ERROR: NOT ENOUGH CORRIDORS")
	    return {name="corridor_S", connect_to = {}}
	end
		corridor = possible_corridors[math.random(#possible_corridors)]
		for position, itr_corridor in pairs(possible_corridors) do
			if itr_corridor.name == "S" and math.random(10) ~= 1 then
				corridor = itr_corridor
				break
			end
		end
	end

	if not corridor then
		print("SAVE ME FROM MY LONELINESS. I AM AT " .. serialize(corridor_pos) .. " AND I HAVE " .. serialize(connect_to))
		corridor = corridors[math.random(#corridors)]
	end

	return corridor
end
local function place_room(center, vm)
	local corridor_pos = {}
	for _,coordinate in pairs(coordinates) do
		corridor_pos[coordinate] = center[coordinate]/A
	end
	local corridor = check_neighbours(corridor_pos)
	local name = corridor.name
	if not placed_corridors[corridor_pos.x] then
		placed_corridors[corridor_pos.x] = {}
	end
	if not placed_corridors[corridor_pos.x][corridor_pos.y] then
		placed_corridors[corridor_pos.x][corridor_pos.y] = {}
	end
	placed_corridors[corridor_pos.x][corridor_pos.y][corridor_pos.z] = corridor.connect_to
	check_neighbours(corridor_pos)
	if corridor.name == "S" then
		return
	end
	local rotation = corridor.rotation
	if not rotation then
		rotation = 0
	end
		local schematic = path .. "/schems/prison_cell.mts"
		minetest.place_schematic_on_vmanip(vm, center, schematic, rotation)

	if corridor.after then
	    corridor.after(center, rotation, vm)
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
    if (maxp.y > MIN_GENERATION_HEIGHT) then
        return
    end

	local t1 = os.clock()
	local geninfo = "[mg] generates..."

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")

	local center = {}
	for x=minp.x,maxp.x do
		if x % A == 0 then
			center.x = x
			for z=minp.z,maxp.z do
				if z % A == 0 then
					center.z = z
					for y=minp.y,maxp.y do
						if y % A == 0 then
							center.y = y
							place_room(center, vm)
						end
					end
				end
			end
		end
	end
end)
