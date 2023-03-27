-- Attempt to isolate essential worldedit functions used by structure generation
-- All code is directly copied from; https://github.com/Uberi/Minetest-worldedit
-- Credit: https://github.com/Uberi/Minetest-worldedit/graphs/contributors
-- License: GNU Affero General Public License
worldedit2 = {}

function worldedit2.keep_loaded(pos1, pos2)
	local manip = minetest.get_voxel_manip()
	manip:read_from_map(pos1, pos2)
end

--- Reads the header of serialized data.
-- @param value Serialized worldedit2 data.
-- @return The version as a positive natural number, or 0 for unknown versions.
-- @return Extra header fields as a list of strings, or nil if not supported.
-- @return Content (data after header).
function worldedit2.read_header(value)
	if value:find("^[0-9]+[%-:]") then
		local header_end = value:find(":", 1, true)
		local header = value:sub(1, header_end - 1):split(",")
		local version = tonumber(header[1])
		table.remove(header, 1)
		local content = value:sub(header_end + 1)
		return version, header, content
	end
	-- Old versions that didn't include a header with a version number
	if value:find("([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)") and not value:find("%{") then -- List format
		return 3, nil, value
	elseif value:find("^[^\"']+%{%d+%}") then
		if value:find("%[\"meta\"%]") then -- Meta flat table format
			return 2, nil, value
		end
		return 1, nil, value -- Flat table format
	elseif value:find("%{") then -- Raw nested table format
		return 4, nil, value
	end
	return nil
end

--- Loads the schematic in `value` into a node list in the latest format.
-- Contains code based on [table.save/table.load](http://lua-users.org/wiki/SaveTableToFile)
-- by ChillCode, available under the MIT license.
-- @return A node list in the latest format, or nil on failure.
local function load_schematic(value)
	local version, header, content = worldedit2.read_header(value)
	local nodes = {}
	if version == 1 or version == 2 then -- Original flat table format
		local tables = minetest.deserialize(content)
		if not tables then return nil end

		-- Transform the node table into an array of nodes
		for i = 1, #tables do
			for j, v in pairs(tables[i]) do
				if type(v) == "table" then
					tables[i][j] = tables[v[1]]
				end
			end
		end
		nodes = tables[1]

		if version == 1 then --original flat table format
			for i, entry in ipairs(nodes) do
				local pos = entry[1]
				entry.x, entry.y, entry.z = pos.x, pos.y, pos.z
				entry[1] = nil
				local node = entry[2]
				entry.name, entry.param1, entry.param2 = node.name, node.param1, node.param2
				entry[2] = nil
			end
		end
	elseif version == 3 then -- List format
		for x, y, z, name, param1, param2 in content:gmatch(
				"([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+" ..
				"([^%s]+)%s+(%d+)%s+(%d+)[^\r\n]*[\r\n]*") do
			param1, param2 = tonumber(param1), tonumber(param2)
			table.insert(nodes, {
				x = tonumber(x),
				y = tonumber(y),
				z = tonumber(z),
				name = name,
				param1 = param1 ~= 0 and param1 or nil,
				param2 = param2 ~= 0 and param2 or nil,
			})
		end
	elseif version == 4 or version == 5 then -- Nested table format
		if not (rawget(_G, "jit") and jit) then
			-- This is broken for larger tables in the current version of LuaJIT
			nodes = minetest.deserialize(content)
		else
			-- XXX: This is a filthy hack that works surprisingly well - in LuaJIT, `minetest.deserialize` will fail due to the register limit
			nodes = {}
			content = content:gsub("return%s*{", "", 1):gsub("}%s*$", "", 1) -- remove the starting and ending values to leave only the node data
			local escaped = content:gsub("\\\\", "@@"):gsub("\\\"", "@@"):gsub("(\"[^\"]*\")", function(s) return string.rep("@", #s) end)
			local startpos, startpos1, endpos = 1, 1
			while true do -- go through each individual node entry (except the last)
				startpos, endpos = escaped:find("},%s*{", startpos)
				if not startpos then
					break
				end
				local current = content:sub(startpos1, startpos)
				local entry = minetest.deserialize("return " .. current)
				table.insert(nodes, entry)
				startpos, startpos1 = endpos, endpos
			end
			local entry = minetest.deserialize("return " .. content:sub(startpos1)) -- process the last entry
			table.insert(nodes, entry)
		end
	else
		return nil
	end
	return nodes
end

--- Determines the volume the nodes represented by string `value` would occupy
-- if deserialized at `origin_pos`.
-- @return Low corner position.
-- @return High corner position.
-- @return The number of nodes.
function worldedit2.allocate(origin_pos, value)
	local nodes = load_schematic(value)
	if not nodes then return nil end
	return worldedit2.allocate_with_nodes(origin_pos, nodes)
end


-- Internal
function worldedit2.allocate_with_nodes(origin_pos, nodes)
	local huge = math.huge
	local pos1x, pos1y, pos1z = huge, huge, huge
	local pos2x, pos2y, pos2z = -huge, -huge, -huge
	local origin_x, origin_y, origin_z = origin_pos.x, origin_pos.y, origin_pos.z
	for i, entry in ipairs(nodes) do
		local x, y, z = origin_x + entry.x, origin_y + entry.y, origin_z + entry.z
		if x < pos1x then pos1x = x end
		if y < pos1y then pos1y = y end
		if z < pos1z then pos1z = z end
		if x > pos2x then pos2x = x end
		if y > pos2y then pos2y = y end
		if z > pos2z then pos2z = z end
	end
	local pos1 = {x=pos1x, y=pos1y, z=pos1z}
	local pos2 = {x=pos2x, y=pos2y, z=pos2z}
	return pos1, pos2, #nodes
end


--- Loads the nodes represented by string `value` at position `origin_pos`.
-- @return The number of nodes deserialized.
function worldedit2.deserialize(origin_pos, value)
	local nodes = load_schematic(value)
	if not nodes then return nil end

	local pos1, pos2 = worldedit2.allocate_with_nodes(origin_pos, nodes)
	worldedit2.keep_loaded(pos1, pos2)

	local origin_x, origin_y, origin_z = origin_pos.x, origin_pos.y, origin_pos.z
	local count = 0
	local add_node, get_meta = minetest.add_node, minetest.get_meta
	for i, entry in ipairs(nodes) do
		entry.x, entry.y, entry.z = origin_x + entry.x, origin_y + entry.y, origin_z + entry.z
		-- Entry acts as both position and node
		add_node(entry, entry)
		if entry.meta then
			get_meta(entry):from_table(entry.meta)
		end
	end
	return #nodes
end