-- The code in this file, and in village_schems.lua comes from the mg mod,
-- by nore (https://github.com/Ekdohibs) and sfan5 (https://github.com/sfan5)
-- Most of it comes from villages.lua of that mod, and some is taken from
-- init.lua, buildings.lua and rotate.lua. https://github.com/minetest-mods/mg
-- It has been considerably modified to work with MTTA's mapgen.

local buildings = {}

VILLAGE_CHECK_RADIUS = 2
VILLAGE_CHECK_COUNT = 1
VILLAGE_CHANCE = 28
VILLAGE_MIN_SIZE = 20
VILLAGE_MAX_SIZE = 40
FIRST_ROADSIZE = 3
BIG_ROAD_CHANCE = 0

-- Enable that for really big villages (there are also really slow to generate)
--[[VILLAGE_CHECK_RADIUS = 3
VILLAGE_CHECK_COUNT = 3
VILLAGE_CHANCE = 28
VILLAGE_MIN_SIZE = 100
VILLAGE_MAX_SIZE = 150
FIRST_ROADSIZE = 5
BIG_ROAD_CHANCE = 50]]

local function get_vn(x, z, noise, village)
	local vx, vz, vs = village.vx, village.vz, village.vs
	return (noise - 2) * 20 +
		(40 / (vs * vs)) * ((x - vx) * (x - vx) + (z - vz) * (z - vz))
end

function inside_village(x, z, village, vnoise)
	return get_vn(x, z, vnoise:get_2d({x = x, y = z}), village) <= 40
end

local seed = minetest.get_mapgen_setting("seed")
local wseed = math.floor(seed / 10000000000)


function get_bseed(minp)
	return wseed + math.floor(5*minp.x/47) + math.floor(873*minp.z/91)
end

local function is_village_block(minp)
	local x, z = math.floor(minp.x/80), math.floor(minp.z/80)
	local vcc = VILLAGE_CHECK_COUNT
	return (x%vcc == 0) and (z%vcc == 0)
end

function villages_at_point(minp, noise1)
	if not is_village_block(minp) then return {} end
	local vcr, vcc = VILLAGE_CHECK_RADIUS, VILLAGE_CHECK_COUNT
	-- Check if there's another village nearby
	for xi = -vcr, vcr, vcc do
	for zi = -vcr, 0, vcc do
		if xi ~= 0 or zi ~= 0 then
			local mp = {x = minp.x + 80*xi, z = minp.z + 80*zi}
			local pi = PseudoRandom(get_bseed(mp))
			local s = pi:next(1, 400)
			local x = pi:next(mp.x, mp.x + 79)
			local z = pi:next(mp.z, mp.z + 79)
			if s <= VILLAGE_CHANCE and noise1:get_2d({x = x, y = z}) >= -0.3 then return {} end
		end
	end
	end
	local pr = PseudoRandom(get_bseed(minp))
	if pr:next(1, 400) > VILLAGE_CHANCE then return {} end -- No village here
	local x = pr:next(minp.x, minp.x + 79)
	local z = pr:next(minp.z, minp.z + 79)
	if noise1:get_2d({x = x, y = z}) < -0.3 then return {} end -- Deep in the ocean
	local type = pr:next(1, 1) -- TODO: actually make them
	local size = pr:next(VILLAGE_MIN_SIZE, VILLAGE_MAX_SIZE) -- TODO: change to type-dependant sizes
	local height = lottmapgen.get_y_at_pos({x = x, y = 10, z = z})
	--print("A village spawned at: x = " .. x .. ", z = " .. z)
	return {{vx = x, vz = z, vs = size, vh = height, type = type}}
end

local function inside_village2(bx, sx, bz, sz, village, vnoise)
	return inside_village(bx, bz, village, vnoise) and inside_village(bx+sx, bz, village, vnoise) and inside_village(bx, bz+sz, village, vnoise) and inside_village(bx+sx, bz+sz, village, vnoise)
end

local function choose_building(l, pr)
	local btype
	while true do
		local p = pr:next(1, 3000)
		for b, i in ipairs(lottmapgen.village_schems) do
			if i.max_weight >= p then
				btype = b
				break
			end
		end
		if lottmapgen.village_schems[btype].pervillage ~= nil then
			local n = 0
			for j=1, #l do
				if l[j].btype == btype then
					n = n + 1
				end
			end
			if n < lottmapgen.village_schems[btype].pervillage then
				return btype
			end
		else
			return btype
		end
	end
end

local function choose_building_rot(l, pr, orient)
	local btype = choose_building(l, pr)
	local rotation
	if lottmapgen.village_schems[btype].no_rotate then
		rotation = 0
	else
		if lottmapgen.village_schems[btype].orients == nil then
			lottmapgen.village_schems[btype].orients = {0,1,2,3}
		end
		rotation = (orient+lottmapgen.village_schems[btype].orients[pr:next(1, #lottmapgen.village_schems[btype].orients)])%4
	end
	local bsizex = lottmapgen.village_schems[btype].sizex
	local bsizez = lottmapgen.village_schems[btype].sizez
	if rotation%2 == 1 then
		bsizex, bsizez = bsizez, bsizex
	end
	return btype, rotation, bsizex, bsizez
end

local function placeable(bx, bz, bsizex, bsizez, l, exclude_roads)
	for _, a in ipairs(l) do
		if (a.btype ~= "road" or not exclude_roads) and math.abs(bx+bsizex/2-a.x-a.bsizex/2)<=(bsizex+a.bsizex)/2 and math.abs(bz+bsizez/2-a.z-a.bsizez/2)<=(bsizez+a.bsizez)/2 then return false end
	end
	return true
end

local function road_in_building(rx, rz, rdx, rdz, roadsize, l)
	if rdx == 0 then
		return not placeable(rx-roadsize+1, rz, 2*roadsize-2, 0, l, true)
	else
		return not placeable(rx, rz-roadsize+1, 0, 2*roadsize-2, l, true)
	end
end

local function when(a, b, c)
	if a then return b else return c end
end

local calls
local function generate_road(village, l, pr, roadsize, rx, rz, rdx, rdz, vnoise, a)
	local vx, vz, vh, vs = village.vx, village.vz, village.vh, village.vs
	local heightmap = minetest.get_mapgen_object("heightmap")
	local calls_to_do = {}
	local rxx = rx
	local rzz = rz
	local mx, m2x, mz, m2z, mmx, mmz
	mx, m2x, mz, m2z = rx, rx, rz, rz
	local orient1, orient2
	if rdx == 0 then
		orient1 = 0
		orient2 = 2
	else
		orient1 = 3
		orient2 = 1
	end
	while inside_village(rx, rz, village, vnoise) and not road_in_building(rx, rz, rdx, rdz, roadsize, l) do
		if roadsize > 1 and pr:next(1, 4) == 1 then
			calls_to_do[#calls_to_do+1] = {rx=rx+(roadsize - 1)*rdx, rz=rz+(roadsize - 1)*rdz, rdx=math.abs(rdz), rdz=math.abs(rdx)}
			m2x = rx + (roadsize - 1)*rdx
			m2z = rz + (roadsize - 1)*rdz
			rx = rx + (2*roadsize - 1)*rdx
			rz = rz + (2*roadsize - 1)*rdz
		end
		local exitloop = false
		local tries = 0
		local btype, rotation, bsizex, bsizez
		local bx, bz
		while true do
			if not inside_village(rx, rz, village, vnoise) or road_in_building(rx, rz, rdx, rdz, roadsize, l) then
				exitloop = true
				break
			end
			btype, rotation, bsizex, bsizez = choose_building_rot(l, pr, orient1)
			bx = rx + math.abs(rdz) * (roadsize + 1) - when(rdx == -1, bsizex - 1, 0)
			bz = rz + math.abs(rdx) * (roadsize + 1) - when(rdz == -1, bsizez - 1, 0)
			if placeable(bx, bz, bsizex, bsizez, l) and inside_village2(bx, bsizex, bz, bsizez, village, vnoise) then
				break
			end
			if tries > 5 then
				rx = rx + rdx
				rz = rz + rdz
				tries = 0
			else
				tries = tries + 1
			end
		end
		if exitloop then break end
		rx = rx + (bsizex + 1) * rdx
		rz = rz + (bsizez + 1) * rdz
		mx = rx - 2 * rdx
		mz = rz - 2 * rdz
		vh = lottmapgen.get_y_at_pos({x = bx, y = 10, z = bz}) + 1
		l[#l + 1] = {x = bx, y = vh, z = bz, btype = btype, bsizex = bsizex, bsizez = bsizez, brotate = rotation}
	end
	rx = rxx
	rz = rzz
	while inside_village(rx, rz, village, vnoise) and not road_in_building(rx, rz, rdx, rdz, roadsize, l) do
		if roadsize > 1 and pr:next(1, 4) == 1 then
			calls_to_do[#calls_to_do+1] = {rx=rx+(roadsize - 1)*rdx, rz=rz+(roadsize - 1)*rdz, rdx=-math.abs(rdz), rdz=-math.abs(rdx)}
			m2x = rx + (roadsize - 1)*rdx
			m2z = rz + (roadsize - 1)*rdz
			rx = rx + (2*roadsize - 1)*rdx
			rz = rz + (2*roadsize - 1)*rdz
		end
		local exitloop = false
		local tries = 0
		local btype, rotation, bsizex, bsizez
		local bx, bz
		while true do
			if not inside_village(rx, rz, village, vnoise) or road_in_building(rx, rz, rdx, rdz, roadsize, l) then
				exitloop = true
				break
			end
			btype, rotation, bsizex, bsizez = choose_building_rot(l, pr, orient2)
			bx = rx - math.abs(rdz) * (bsizex + roadsize) - when(rdx == -1, bsizex - 1, 0)
			bz = rz - math.abs(rdx) * (bsizez + roadsize) - when(rdz == -1, bsizez - 1, 0)
			if placeable(bx, bz, bsizex, bsizez, l) and inside_village2(bx, bsizex, bz, bsizez, village, vnoise) then
				break
			end
			if tries > 5 then
				rx = rx + rdx
				rz = rz + rdz
				tries = 0
			else
				tries = tries + 1
			end
		end
		if exitloop then break end
		rx = rx + (bsizex + 1) * rdx
		rz = rz + (bsizez + 1) * rdz
		m2x = rx - 2 * rdx
		m2z = rz - 2 * rdz
		vh = lottmapgen.get_y_at_pos({x = bx, y = 10, z = bz}) + 1
		l[#l + 1] = {x = bx, y = vh, z = bz, btype = btype, bsizex = bsizex, bsizez = bsizez, brotate = rotation}
	end
	if road_in_building(rx, rz, rdx, rdz, roadsize, l) then
		mmx = rx - 2*rdx
		mmz = rz - 2*rdz
	end
	mx = mmx or rdx*math.max(rdx*mx, rdx*m2x)
	mz = mmz or rdz*math.max(rdz*mz, rdz*m2z)
	local rxmin, rxmax, rzmin, rzmax
	if rdx == 0 then
		rxmin = rx - roadsize + 1
		rxmax = rx + roadsize - 1
		rzmin = math.min(rzz, mz)
		rzmax = math.max(rzz, mz)
		for i = rzmin, rzmax do
			vh = lottmapgen.get_y_at_pos({x = rxmin, y = 10, z = i})
			l[#l + 1] = {x = rxmin, y = vh, z = i, btype = "road",
				bsizex = rxmax - rxmin + 1, bsizez = 1, brotate = 0}
		end
	else
		rzmin = rz - roadsize + 1
		rzmax = rz + roadsize - 1
		rxmin = math.min(rxx, mx)
		rxmax = math.max(rxx, mx)
		for i = rxmin, rxmax do
			vh = lottmapgen.get_y_at_pos({x = i, y = 10, z = rzmin})
			l[#l + 1] = {x = i, y = vh, z = rzmin, btype = "road",
				bsizex = 1, bsizez = rzmax - rzmin + 1, brotate = 0}
		end
	end
	for _, i in ipairs(calls_to_do) do
		local new_roadsize = roadsize - 1
		if pr:next(1, 100) <= BIG_ROAD_CHANCE then
			new_roadsize = roadsize
		end
		calls[calls.index] = {village, l, pr, new_roadsize, i.rx, i.rz, i.rdx, i.rdz, vnoise, a}
		calls.index = calls.index+1
	end
end

local function generate_bpos(village, pr, vnoise, a)
	local vx, vz, vh, vs = village.vx, village.vz, village.vh, village.vs
	local l = {}
	local rx = vx - vs
	local rz = vz
	while inside_village(rx, rz, village, vnoise) do
		rx = rx - 1
	end
	rx = rx + 5
	calls = {index = 1}
	generate_road(village, l, pr, FIRST_ROADSIZE, rx, rz, 1, 0, vnoise, a)
	local i = 1
	while i < calls.index do
		generate_road(unpack(calls[i]))
		i = i + 1
	end
	return l
end

local schempath = minetest.get_modpath("lottmapgen") .. "/schems/villages/"

local function generate_building(pos, minp, maxp, data, a, pr, extranodes)
	local binfo = lottmapgen.village_schems[pos.btype]
	local scm
	if type(binfo.scm) == "string" then
		scm = schempath .. binfo.scm .. ".mts"
		table.insert(buildings, {scm, 
			{x = pos.x, y = pos.y + binfo.yoff, z = pos.z}})
	else
		local rot = 0
		local z = pos.bsizez
		if pos.bsizez == 1 then
			rot = 90
			z = pos.bsizex
		end
		scm = lottmapgen.village_road_schems[z]
		table.insert(buildings, {scm, 
			{x = pos.x, y = pos.y + binfo.yoff, z = pos.z}, rot})
	end
end

function generate_village(village, minp, maxp, data, a, vnoise)
	local vx, vz, vs, vh = village.vx, village.vz, village.vs, village.vh
	local seed = get_bseed({x=vx, z=vz})
	local pr_village = PseudoRandom(seed)
	local bpos = generate_bpos(village, pr_village, vnoise, a)

	local pr = PseudoRandom(seed)

	local extranodes = {}
	for _, pos in ipairs(bpos) do
		local coords = {"x", "y", "z"}
		local add_building = true
		for _, coord in pairs(coords) do
			if pos[coord] < minp[coord] or pos[coord] > maxp[coord] then
				add_building = false
			end
		end
		if add_building then
			generate_building(pos, minp, maxp, data, a, pr_village, extranodes)
		end
	end
	return extranodes
end

function lottmapgen.generate_villages(minp, maxp, emin, emax, vm, a, data)
	
	local noise1raw = minetest.get_perlin(12345, 6, 0.5, 256)
	buildings = {}
	
	local vcr = VILLAGE_CHECK_RADIUS
	local villages = {}
	for xi = -vcr, vcr do
	for zi = -vcr, vcr do
		for _, village in ipairs(villages_at_point({x = minp.x + xi * 80, z = minp.z + zi * 80}, noise1raw)) do
			villages[#villages+1] = village
		end
	end
	end
	
	local pr = PseudoRandom(get_bseed(minp))
	
	local village_noise = minetest.get_perlin(7635, 3, 0.5, 16)

	local ni = 0
	
	for _, village in ipairs(villages) do
		village.to_add = generate_village(village, minp, maxp, data, a, village_noise)
	end
	
	for _, tab in pairs(buildings) do
		minetest.place_schematic_on_vmanip(vm, tab[2],
			tab[1], tab[3] or 0,
			{["lottitems:ignore"] = "ignore"})
	end

	--[[local meta
	for _, village in ipairs(villages) do
	for _, n in pairs(village.to_add) do
		minetest.set_node(n.pos, n.node)
		if n.meta ~= nil then
			meta = minetest.get_meta(n.pos)
			meta:from_table(n.meta)
			if n.node.name == "default:chest" then
				local inv = meta:get_inventory()
				local items = inv:get_list("main")
				for i = 1, inv:get_size("main") do
					inv:set_stack("main", i, ItemStack(""))
				end
				local numitems = pr:next(3, 20)
				for i = 1, numitems do
					local ii = pr:next(1, #items)
					local prob = items[ii]:get_count() % 2 ^ 8
					local stacksz = math.floor(items[ii]:get_count() / 2 ^ 8)
					if pr:next(0, prob) == 0 and stacksz>0 then
						local stk = ItemStack({
							name = items[ii]:get_name(),
							count = pr:next(1, stacksz),
							wear = items[ii]:get_wear(),
							metadata = items[ii]:get_metadata()
						})
						local ind = pr:next(1, inv:get_size("main"))
						while not inv:get_stack("main", ind):is_empty() do
							ind = pr:next(1, inv:get_size("main"))
						end
						inv:set_stack("main", ind, stk)
					end
				end
			end
		end
	end
	end]]
end
