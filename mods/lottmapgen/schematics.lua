lottmapgen = {}

local areas_mod = minetest.get_modpath("areas")
local protect_houses = minetest.settings:get_bool("protect_structures") or false

-- max number of nodes to try to fill below building
local fill_below_count = 16


-- list of building, with filename and bounding box
local lottmapgen_list = {
	["Angmar Fort"] =    {build="angmarfort",   area_owner = "Orc Guard",     area_name = "Angmar Fort",
		center = {x=9, y=2, z=3} },
	["Gondor Fort"] =    {build="gondorfort",   area_owner = "Gondor Guard",  area_name = "Gondor Castle",
		center = {x=1, y=1, z=9} },
	["Rohan Fort"] =     {build="rohanfort",    area_owner = "Rohan Guard",   area_name = "Rohan Fort",
		center = {x=1, y=1, z=9} },
	["Orc Fort"] =       {build="orcfort",      area_owner = "Orc Guard",     area_name = "Orc Fort",
		center = {x=15, y=2, z=1} },
	["Mallorn House"] =  {build="mallornhouse", area_owner = "Elven Guard",   area_name = "Elven House",
		center = {x=2, y=1, z=5} },
	["Lorien House"] =   {build="lorienhouse",  area_owner = "Elven Guard",   area_name = "Elven House",
		center = {x=2, y=1, z=5} },
	["Mirkwood House"] = {build="mirkhouse",    area_owner = "Elven Guard",   area_name = "Elven House",
		center = {x=5, y=2, z=1} },
	["Hobbit Hole"] =    {build="hobbithole",   area_owner = "Hobbit Family", area_name = "Hobbit Hole",
		center = {x=13, y=3, z=24} },
	["Dwarf House"] =    {build="dwarfhouse",   area_owner = "Dwarf Smith",   area_name = "Dwarf House",
		center = {x=16, y=1, z=3} },

}

-- load bounding box from files
for i, v in pairs(lottmapgen_list) do
	local file = io.open(minetest.get_modpath("lottmapgen").."/schems/"..v.build..".we")
	local value = file:read("*a")
	file:close()
	local pos1, pos2 = worldedit.allocate({x=0, y=0, z=0}, value)
	lottmapgen_list[i].bbox = {
			xmin = pos1.x-v.center.x, ymin = pos1.y-v.center.y, zmin = pos1.z-v.center.z,
			xmax = pos2.x-v.center.x, ymax = pos2.y-v.center.y, zmax = pos2.z-v.center.z}
end

-- queue to store the buildings which are waiting to be built (queue structure from https://www.lua.org/pil/11.4.html)
lottmapgen.queue = {first = 0, last = -1}

local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/building_queue", "r")
if file then
	lottmapgen.queue = minetest.deserialize(file:read("*all"))
	file:close()
end

minetest.register_on_shutdown(function()
	local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/building_queue", "w")
	if (file) then
		file:write(minetest.serialize(lottmapgen.queue))
		file:close()
	end
end)

function lottmapgen.enqueue_building(name, pos)
	local first = lottmapgen.queue.first - 1
	lottmapgen.queue.first = first
    lottmapgen.queue[first] = {name = name, pos = pos}
end

-- request to fill some node below buildings
function lottmapgen.enqueue_fill(fill)
	local first = lottmapgen.queue.first - 1
	lottmapgen.queue.first = first
    lottmapgen.queue[first] = {fill=fill}
end


function lottmapgen.dequeue_building()
	local last = lottmapgen.queue.last
	if lottmapgen.queue.first > last then return nil end
	local value = lottmapgen.queue[last]
	lottmapgen.queue[last] = nil         -- to allow garbage collection
	lottmapgen.queue.last = last - 1
	return value
end

-- check if all the blocks that intersect the building are genrated
function lottmapgen.check_building(bbox, pos)
	--mapgen chuncks generate 80 blocks at a time, so we only need to checks the limits of the bounding box and
	-- each 80 inside nodes
	for z=bbox.zmin, bbox.zmax+80, 80 do
		local cur_z = pos.z + math.min(z, bbox.zmax)
		for y=bbox.ymin, bbox.ymax+80, 80 do
			local cur_y = pos.y + math.min(y, bbox.ymax)
			for x=bbox.xmin, bbox.xmax+80, 80 do
				local cur_x = pos.x + math.min(x, bbox.xmax)
				if minetest.get_node({x = cur_x, y = cur_y, z = cur_z}).name =="ignore" then
					return false
				end
			end
		end
	end

	return true
end


function lottmapgen.check_fill(fill)
	local bbox = {
		xmin = fill.xmin, ymin = fill.y-fill_below_count, zmin = fill.zmin,
		xmax = fill.xmax, ymax = fill.y,                  zmax = fill.zmax}
	return lottmapgen.check_building(bbox, {x=0, y=0, z=0})
end

-- place building using worldedit
function lottmapgen.place_building(building, pos)
	--print(building.build.." placed at "..pos.x..' '..pos.y..' '..pos.z)
	local file = io.open(minetest.get_modpath("lottmapgen").."/schems/"..building.build..".we")
	local value = file:read("*a")
	file:close()
	local p = {x = pos.x-building.center.x, y = pos.y-building.center.y, z = pos.z-building.center.z}
	local pos1 = {x = pos.x + building.bbox.xmin, y = pos.y + building.bbox.ymin, z = pos.z + building.bbox.zmin}
	local pos2 = {x = pos.x + building.bbox.xmax, y = pos.y + building.bbox.ymax, z = pos.z + building.bbox.zmax}
	local count = worldedit.deserialize(p, value)
	if areas_mod ~= nil and protect_houses == true then
                areas:add(building.area_owner, building.area_name, pos1, pos2, nil)
                areas:save()
	end

	lottmapgen.enqueue_fill({xmin = pos1.x, zmin = pos1.z, xmax = pos2.x, zmax = pos2.z, y = pos1.y})
end


minetest.register_globalstep(function(dtime)

	-- parse the next 50 building in the queue (while not empty)
	for count= 1, 50 do
		local queued = lottmapgen.dequeue_building()
		if not queued then return end

		if queued.fill then
			if not lottmapgen.check_fill(queued.fill) then
				lottmapgen.enqueue_fill(queued.fill)
			else
				lottmapgen.fill_bellow(queued.fill)
			end
		else

			local building = lottmapgen_list[queued.name];

			-- not all the building will be placed, ask to replace it later
			if not lottmapgen.check_building(building.bbox, queued.pos) then
				lottmapgen.enqueue_building(queued.name, queued.pos)
			else
				-- place the building on generated nodes
				lottmapgen.place_building(building, queued.pos)
			end
		end
	end
end)

-- fill of the botom nodes to avoid empty space.

lottmapgen.fill_bellow = function(fill)


	local pos1 = {x = fill.xmin, y = fill.y-fill_below_count, z = fill.zmin}
	local pos2 = {x = fill.xmax, y = fill.y,                  z = fill.zmax}

	local replace_node = {}
	replace_node[minetest.get_content_id("lottother:dirt")]=minetest.get_content_id("default:dirt")
	replace_node[minetest.get_content_id("lottother:snow")]=minetest.get_content_id("default:snowblock")
	replace_node[minetest.get_content_id("lottother:mordor_stone")]=minetest.get_content_id("lottmapgen:mordor_stone")

	local c_air = 	minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_water = minetest.get_content_id("default:water_source")
	local c_river_water = minetest.get_content_id("default:river_water_source")
	local c_morwat = minetest.get_content_id("lottmapgen:blacksource")
	local c_morrivwat = minetest.get_content_id("lottmapgen:black_river_source")

	local water_level = minetest.get_mapgen_setting("water_level")

	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(pos1, pos2)
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

	local bottom_reached = false

	for x = pos1.x, pos2.x do
		for z = pos1.z, pos2.z do
			local top_index = area:index(x, pos2.y, z)
			local top = data[top_index]
			local replace_to = replace_node[top]
			if replace_to then
				data[top_index] = replace_to
				if pos2.y > water_level-1000 then
					for y = pos2.y-1, pos1.y, -1 do
						local index = area:index(x, y, z)
						local cur = data[index]
						if cur  == c_air or cur == c_water or cur == c_river_water
								or cur == c_morwat or cur == c_morrivwat then
							data[index] = replace_to
						else
							break
						end
						if y==pos1.y then
							data[index] = top
							bottom_reached = true
						end
					end
				end
			end
		end
	end

	vm:set_data(data)
	vm:update_map()
	vm:write_to_map()


	if pos2.y > water_level-1000 and bottom_reached then
		lottmapgen.enqueue_fill({xmin = fill.xmin, zmin = fill.zmin, xmax = fill.xmax, zmax = fill.zmax, y = fill.y-fill_below_count})
	end
end

-- folowing function let as a way to "hack" building placement, but shouldn't be needed
for builddesc, v in ipairs(lottmapgen_list) do
    local build = v.build
    minetest.register_node("lottmapgen:"..build, {
        description = builddesc,
        drawtype = "glasslike",
        walkable = false,
        tiles = {"lottother_air.png"},
        pointable = false,
        sunlight_propagates = true,
        is_ground_content = true,
        groups = {not_in_creative_inventory = 1},
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above then
                local file = io.open(minetest.get_modpath("lottmapgen").."/schems/"..build..".we")
                local value = file:read("*a")
                file:close()
		local p = pointed_thing.above
		p.x = p.x-v.center.x
		p.y = p.y-v.center.y
		p.z = p.z-v.center.z
                local count = worldedit.deserialize(p, value)
                itemstack:take_item()
            end
            return itemstack
        end,
    })
end


minetest.register_abm({
	nodenames = {"lottmapgen:gondorfort","lottmapgen:hobbithole","lottmapgen:orcfort","lottmapgen:rohanfort","lottmapgen:mallornhouse","lottmapgen:lorienhouse"},
	interval = 4,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.remove_node(pos)
	end,
})

minetest.register_abm({
	nodenames = {"lottmapgen:angmarfort","lottmapgen:mirkhouse"},
	interval = 8,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.remove_node(pos)
	end,
})
