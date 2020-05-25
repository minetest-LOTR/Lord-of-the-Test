-- Code based on paramat's "highlandpools" mod:
-- https://forum.minetest.net/viewtopic.php?f=11&t=8400
-- https://github.com/paramat/highlandpools

local YMAX = 33000 -- Maximum altitude for pools
local FLOW = 256

local function get_walkable(c_id)
	if not c_id then
		return false
	end
	local node = minetest.get_name_from_content_id(c_id)
	if minetest.registered_nodes[node].walkable == false then -- If grass/flower
		return true
	end
	return false
end

local function get_grass(c_id)
	if not c_id then
		return false
	end
	local node = minetest.get_name_from_content_id(c_id)
	if minetest.registered_nodes[node].groups.dirt_with_grass == 1 then
		return true
	end
	return false
end

local function get_tree(c_id)
	if not c_id then
		return false
	end
	local node = minetest.get_name_from_content_id(c_id)
	if minetest.registered_nodes[node].groups.tree == 1 then
		return 1
	elseif minetest.registered_nodes[node].groups.leaves == 1 then
		return 2
	end
	return false
end

-- TODO: Support fruit trees when added
local function remove_tree(c_tree, x, y, z, area, data)
	-- Find leaves
	local node = minetest.get_name_from_content_id(c_tree)
	local c_leaves = minetest.get_content_id(node:sub(1, -6) .. "leaves")
	local c_rowan
	if node:find("rowan") then
		c_rowan = minetest.get_content_id("lottplants:rowan_berries")
	end
	local c_dirt = minetest.get_content_id("lottitems:dirt")
	local c_air = minetest.get_content_id("air")
	for j = -5, 15 do
	for i = -4, 4 do
	for k = -4, 4 do
		local vi = area:index(x + i, y + j, z + k)
		if data[vi] == c_tree or data[vi] == c_leaves then
			data[vi] = c_air
		elseif c_rowan and data[vi] == c_rowan then
			data[vi] = c_air
		end
	end
	end
	end
end

function lottmapgen.generate_pools(x0, y0, z0, x1, y1, z1, vm, area, data)
	if y0 < -32 then
		return
	end
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_watsour = minetest.get_content_id("lottitems:water_source")
	local c_grass = minetest.get_content_id("lottitems:wilderland_grass")
	local c_dirt = minetest.get_content_id("lottitems:dirt")
	local water_map = {}

	for xcen = x0 + 8, x1 - 7, 8 do
	for zcen = z0 + 8, z1 - 7, 8 do
		local yasurf = false -- y of above surface node
		for y = y1, 2, -1 do
			local vi = area:index(xcen, y, zcen)
			local c_node = data[vi]
			if y == y1 and c_node ~= c_air then -- if top node solid
				break
			elseif c_node == c_watsour then
				break
			elseif get_grass(c_node) then
				yasurf = y + 1
				break
			end
		end
		if yasurf then
			local abort = false
			for ser = 1, 80 do
				local vi = area:index(xcen + ser, yasurf, zcen)
				local c_node = data[vi]
				if xcen + ser == x1 then
					abort = true
				elseif c_node ~= c_air
				and not get_walkable(c_node) then
					break
				end
			end
			for ser = 1, 80 do
				local vi = area:index(xcen - ser, yasurf, zcen)
				local c_node = data[vi]
				if xcen - ser == x0 then
					abort = true
				elseif c_node ~= c_air
				and not get_walkable(c_node) then
					break
				end
			end
			for ser = 1, 80 do
				local vi = area:index(xcen, yasurf, zcen + ser)
				local c_node = data[vi]
				if zcen + ser == z1 then
					abort = true
				elseif c_node ~= c_air
				and not get_walkable(c_node) then
					break
				end
			end
			for ser = 1, 80 do
				local vi = area:index(xcen, yasurf, zcen - ser)
				local c_node = data[vi]
				if zcen - ser == z0 then
					abort = true
				elseif c_node ~= c_air
				and not get_walkable(c_node) then
					break
				end
			end
			if abort then
				break
			end

			local vi = area:index(xcen, yasurf, zcen)
			water_map[vi] = 1
			local flab = false -- flow abort
			for flow = 1, FLOW do
				for z = z0, z1 do
					for x = x0, x1 do
						local vif = area:index(x, yasurf, z)
						if water_map[vif] == 1 then
							if x == x0 or x == x1 or z == z0 or z == z1 then
								flab = true -- if water at chunk edge abort flow
								break
							else -- flow water
								local vie = area:index(x + 1, yasurf, z)
								local viw = area:index(x - 1, yasurf, z)
								local vin = area:index(x, yasurf, z + 1)
								local vis = area:index(x, yasurf, z - 1)
								if data[vie] == c_air
								or get_walkable(data[vie])
								or get_tree(data[vie]) then
									water_map[vie] = 1
								end
								if data[viw] == c_air
								or get_walkable(data[viw])
								or get_tree(data[viw]) then
									water_map[viw] = 1
								end
								if data[vin] == c_air
								or get_walkable(data[vin])
								or get_tree(data[vin]) then
									water_map[vin] = 1
								end
								if data[vis] == c_air
								or get_walkable(data[vis])
								or get_tree(data[vis]) then
									water_map[vis] = 1
								end
							end
						end
					end
					if flab then
						break
					end
				end
				if flab then
					break
				end
			end
			if flab then -- erase water from this y level
				water_map = {}
			else -- flow downwards add dirt
				for z = z0, z1 do
				for x = x0, x1 do
					local vi = area:index(x, yasurf, z)
					if water_map[vi] == 1 then
						if get_tree(data[vi]) == 1 then
							remove_tree(data[vi], x, yasurf, z, area, data)
						end
						data[vi] = c_watsour
						local viia = area:index(x, yasurf + 1, z)
						data[viia] = c_air
						for y = yasurf + 1, yasurf + 9 do
							local via = area:index(x, y, z)
							if get_tree(data[via]) then
								data[via] = c_air
							end
						end
						for y = yasurf - 1, y0, -1 do
							local viu = area:index(x, y, z)
							if data[viu] == c_air
							or get_walkable(data[viu])
							or get_tree(data[viu]) then
								data[viu] = c_watsour
							else
								data[viu] = c_dirt
								break
							end
						end
					end
				end
				end
			end
		end
	end
	end
end
