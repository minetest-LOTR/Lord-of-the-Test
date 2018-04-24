-- This folder contains all the "technical" backend of lottmapgen, such as
-- the biome and height maps, and the code for getting the biome/height at
-- a certain position.

local modpath = minetest.get_modpath("lottmapgen") .. "/technical"

-- These two files are compressed as they take up way too much space
-- if left raw (500 kb each). Their source can be found here:
-- https://gist.github.com/Amaz1/e3ab2d2259cdc254ec74bee8139caa6e

-- They were made by this code:
-- local biome_table = dofile(modpath .. "/biome_map.lua")
-- local file = io.open(modpath .. "/biomes.meta", "wb")
-- file:write(minetest.compress(minetest.serialize(biome_table), "deflate"))
-- file:close()

local biome_file = io.open(modpath .. "/biomes.meta", "rb")
local height_file = io.open(modpath .. "/height.meta", "rb")

local biome_data = biome_file:read("*a")
local height_data = height_file:read("*a")

biome_file:close()
height_file:close()

local biomes = minetest.deserialize(minetest.decompress(biome_data))
local height = minetest.deserialize(minetest.decompress(height_data))
dofile(modpath .. "/functions.lua")

function lottmapgen.register_biome(id, table)
	lottmapgen.biome[id] = table
end

local grassp2 = 0

local function gp2(value)
	if grassp2 and grassp2 > value then
		return
	end
	grassp2 = value
end

function lottmapgen.biomes(noisy_x, noisy_z)
	local small_x = math.floor(noisy_x / 160)
	local small_z = math.floor(noisy_z / 160)
	local dx = math.abs(small_x - (noisy_x / 160))
	local dz = math.abs(small_z - (noisy_z / 160))
	small_x = small_x + 200
	small_z = (small_z - 200) * -1
	grassp2 = 0
	if biomes[small_z] and biomes[small_z][small_x] then
		local biome = biomes[small_z][small_x]
		for nz = -1, 1 do
		for nx = -1, 1 do
			local b = biomes[small_z + nz][small_x +nx]
			if b and b ~= biome then
				if nz == -1 and nx == -1 then
					if dx < 0.4 and dz > 0.6 then
						local ndx = math.abs(dx - 1)
						local dt = (ndx + 0.2) + (dz + 0.2) - 1.4
						if dt < 0.6 then dt = 0.6 end
						if dt > 1 then dt = 1 end
						gp2(math.abs((dt * 160) - 96))
					end
				elseif nz == -1 and nx == 0 then
					if dz > 0.6 then
						gp2(math.abs((dz * 160) - 96))
					end
				elseif nz == -1 and nx == 1 then
					if dx > 0.6 and dz > 0.6 then
						local dt = ((dx + 0.2) + (dz + 0.2)) - 1.4
						if dt < 0.6 then dt = 0.6 end
						if dt > 1 then dt = 1 end
						gp2(math.floor(math.abs((dt * 160) - 96)))
					end
				elseif nz == 0 and nx == -1 then
					if dx < 0.4 then
						gp2(math.abs((dx * 160) - 63))
					end
				elseif nz == 0 and nx == 1 then
					if dx > 0.6 then
						gp2(math.abs((dx * 160) - 96))
					end
				elseif nz == 1 and nx == -1 then
					if dz < 0.4 and dx < 0.4 then
						-- I have no idea how this works
						-- It probably shouldn't, but it does.
						local dt = (dz - 0.2) + (dx - 0.2) + 0.4
						if dt < 0 then dt = 0 end
						if dt > 0.4 then dt = 0.4 end
						gp2(math.abs((dt * 160) - 63))
					end
				elseif nz == 1 and nx == 0 then
					if dz < 0.4 then
						gp2(math.abs((dz * 160) - 63))
					end
				elseif nz == 1 and nx == 1 then
					if dx > 0.6 and dz < 0.4 then
						local ndx = math.abs(dx - 1)
						local dt = (ndx - 0.2) + (dz - 0.2) + 0.4
						if dt < 0 then dt = 0 end
						if dt > 0.4 then dt = 0.4 end
						gp2(math.abs((dt * 160) - 63))
					end
				end
			end
		end
		end
		--print(grassp2)
		return biome, grassp2
	else
		return 99
	end
end

function lottmapgen.height(noisy_x, noisy_z)
	local small_x = math.floor(noisy_x / 160)
	local small_z = math.floor(noisy_z / 160)
	local dx = math.abs(small_x - (noisy_x / 160))
	local dz = math.abs(small_z - (noisy_z / 160))
	small_x = small_x + 200
	small_z = (small_z - 200) * -1
	if height[small_z] and height[small_z][small_x] then
		local noise = height[small_z][small_x] * 20
		for nz = -1, 1 do
		for nx = -1, 1 do
			local h = height[small_z + nz][small_x + nx]
			if h and h < height[small_z][small_x] then
				local mult = 20
				if nz == -1 and nx == -1 then
					mult =  math.floor(dx*20 + 1/dz)
				elseif nz == -1 and nx == 0 then
					mult = math.floor(1/dz)
				elseif nz == -1 and nx == 1 then
					mult = math.floor(1/dx + 1/dz)
				elseif nz == 0 and nx == -1 then
					mult = math.floor(dx*20)
				elseif nz == 0 and nx == 1 then
					mult = math.floor(1/dx)
				elseif nz == 1 and nx == -1 then
					mult = math.floor(dx*20 + dz*20)
				elseif nz == 1 and nx == 0 then
					mult = math.floor(dz*20)
				elseif nz == 1 and nx == 1 then
					mult = math.floor(1/dx + dz*20)
				end
				local new_noise = (height[small_z][small_x] - 1) * 20 + mult
				if new_noise < noise then
					noise = new_noise
				end
			end
		end
		end
		return noise
	else
		return 0
	end
end

local n_ter = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 543213,
	octaves = 4,
	persist = 0.7
}

local n_terflat = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 543213,
	octaves = 1,
	persist = 0.5
}

local n_x = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 3,
	persist = 0.
}

local n_z = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -5500,
	octaves = 3,
	persist = 0.5
}

function lottmapgen.get_biome_at_pos(pos)
	local nx = math.floor(minetest.get_perlin(n_x):get2d({x=pos.x,y=pos.z}) * 128)
	local nz = math.floor(minetest.get_perlin(n_z):get2d({x=pos.x,y=pos.z}) * 128)
	local x = math.floor((pos.x + nx) / 160) + 200
	local z = (math.floor((pos.z + (nz - 1)) / 160) - 200) * -1
	if biomes[z] and biomes[z][x] then
		local id = biomes[z][x]
		local biome
		if lottmapgen.biome[id] then
			biome = lottmapgen.biome[id].name
		else
			biome = "Sea"
		end
		return id, biome
	end
	return nil
end

function lottmapgen.spawn_player(pos, player, rand)
	if rand ~= false then
		pos.x = pos.x + math.random(-100, 100)
		pos.z = pos.z + math.random(-100, 100)
	end
	local nx = math.floor(minetest.get_perlin(n_x):get2d({x=pos.x,y=pos.z}) * 128) + pos.x
	local nz = math.floor(minetest.get_perlin(n_z):get2d({x=pos.x,y=pos.z}) * 128) + pos.z
	local height = lottmapgen.height(nx, nz)
	local t = minetest.get_perlin(n_ter):get2d({x=pos.x,y=pos.z})
	local tf = minetest.get_perlin(n_terflat):get2d({x=pos.x,y=pos.z})
	local y = math.floor(((t + 1)) *
		(height * math.abs(math.abs(tf / (height / 20)) - 1.01)))
	if height == 0 then
		y = 0
	end
	player:set_pos({x = pos.x, y = y + 2, z = pos.z})
end

minetest.register_chatcommand("tpb", {
	params = "<image coords>",
	func = function(name, param)
		local x, z = string.match(param, "([^ ]+) (.+)")
		x = x - 200
		x = x * 160
		z = z * -1
		z = z + 200
		z = z * 160
		lottmapgen.spawn_player({x = x, y = 30, z = z},
			minetest.get_player_by_name(name), false)
	end,
})

minetest.register_chatcommand("bap", {
	func = function(name)
		local id, biome = lottmapgen.get_biome_at_pos(minetest.get_player_by_name(name):get_pos())
		minetest.chat_send_player(name, biome .. "\n(id = " .. id .. ")")
	end
})

minetest.register_chatcommand("tp", {
	params = "<biome>",
	func = function(name, param)
		param = string.lower(param)
		local player = minetest.get_player_by_name(name)
		if param == "lorien" or param == "l" then
			lottmapgen.spawn_player({x = 475, y = 30, z = -4175}, player)
		elseif param == "lindon" or param == "li" then
			lottmapgen.spawn_player({x = -25200, y = 30, z = 4700}, player)
		elseif param == "iron hills" or param == "iron_hills" or param == "ih" then
			lottmapgen.spawn_player({x = 18400, y = 30, z = 7500}, player)
		elseif param == "breeland" or param == "bree" or param == "b" then
			lottmapgen.spawn_player({x = -11680, y = 30, z = 2400}, player)
		elseif param == "eregion" or param == "e" then
			lottmapgen.spawn_player({x = -2900, y = 30, z = -700}, player)
		elseif param == "blue mountains" or param == "blue_mountains" or param == "bm" then
			lottmapgen.spawn_player({x = -24000, y = 60, z = 12000}, player)
		elseif param == "ettenmoors" or param == "em" or param == "et" then
			lottmapgen.spawn_player({x = -4800, y = 30, z = 8000}, player)
		elseif param == "harad" or param == "h" then
			lottmapgen.spawn_player({x = 28800, y = 30, z = -28800}, player)
		elseif param == "mirkwoord" or param == "mw" or param == "m" or param == "mirk" then
			lottmapgen.spawn_player({x = 6400, y = 30, z = 4800}, player)
		elseif param == "dunland" or param == "d" then
			lottmapgen.spawn_player({x = -11200, y = 30, z = -9600}, player)
		elseif param == "shire" or param == "s" then
			lottmapgen.spawn_player({x = -15200, y = 30, z = 1600}, player)
		elseif param == "fangorn" or param == "f" then
			lottmapgen.spawn_player({x = -800, y = 30, z = -8000}, player)
		elseif param == "rohan" or param == "r" then
			lottmapgen.spawn_player({x = 960, y = 30, z = -11200}, player)
		elseif param == "angmar" or param == "a" then
			lottmapgen.spawn_player({x = -5600, y = 30, z = 10400}, player)
		else
			minetest.chat_send_player(name, "List of places to teleport to:\n" ..
				minetest.colorize("orange", "lorien    iron hills    breeland    eregion    lindon" ..
					"    blue mountains    ettenmoors    harad    mirkwood    dunland    shire" ..
					"    fangorn    angmar    rohan"))
		end
	end
})
