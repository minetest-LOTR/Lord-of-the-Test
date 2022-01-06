-- mods/default/mapgen.lua

local mapgen_name = minetest.get_mapgen_setting("mg_name")

if mapgen_name == "singlenode" then
	minetest.set_mapgen_setting("mg_name", "v7", true)
elseif mapgen_name == "v6" then
	minetest.log("warning", "[LOTT] v6 mapgen is not fully tested, use at own risk or use other mapgens!")
end

local flags = minetest.get_mapgen_setting("mgv7_spflags")

if flags ~= nil then
	local c1, c2 = flags:find("floatlands")

	if c1 and c2 and not flags:find("nofloatlands") then
		minetest.set_mapgen_setting("mgv7_spflags",
			flags:sub(1, c1-1) .. flags:sub(c2+1), true)
	end
end

--
-- Aliases for map generator outputs
--

-- stone replecment node
minetest.register_node("default:mapgen_stone", {
	description = "Mapgen Stone",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_tree", "air")
minetest.register_alias("mapgen_leaves", "air")
minetest.register_alias("mapgen_jungletree", "air")
minetest.register_alias("mapgen_jungleleaves", "air")
minetest.register_alias("mapgen_apple", "air")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")
minetest.register_alias("mapgen_dirt", "default:mapgen_stone")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_clay", "default:mapgen_stone")
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_mossycobble", "default:mossycobble")
minetest.register_alias("mapgen_dirt_with_grass", "default:mapgen_stone")
minetest.register_alias("mapgen_junglegrass", "air")
minetest.register_alias("mapgen_stone_with_coal", "default:stone_with_coal")
minetest.register_alias("mapgen_stone_with_iron", "default:stone_with_iron")
minetest.register_alias("mapgen_mese", "default:mese")
minetest.register_alias("mapgen_sand", "default:stone")
minetest.register_alias("mapgen_sandstone", "default:sandstone")
minetest.register_alias("mapgen_desert_sand", "default:mapgen_stone")
-- This is needed because we don't want desert stone in v6, in desert areas,
-- and in other mapgens, it messes dungeon gen up. Mapgen madness!
if mapgen_name == "v6" then
	minetest.register_alias("mapgen_desert_stone", "default:stone")
else
	minetest.register_alias("mapgen_desert_stone", "default:desert_stone")
end
minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
minetest.register_alias("mapgen_sandstonebrick", "default:cobble")
minetest.register_alias("mapgen_stair_sandstonebrick", "stairs:stair_cobble")

--
-- Ore generation
--

local wl = tonumber(minetest.get_mapgen_setting("water_level")) or 1

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 8*8*8,
	clust_num_ores = 8,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl + 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_min     = wl - 31000,
	y_max     = wl,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 15,
	y_max     = wl + 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = wl - 63,
	y_max     = wl - 16,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_min     = wl - 31000,
	y_max     = wl - 64,
})

--[[
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 255,
	y_max     = wl - 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:mese",
	wherein        = "default:stone",
	clust_scarcity = 36*36*36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl- 1024,
})
]]

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 255,
	y_max     = wl - 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = wl - 63,
	y_max     = wl - 16,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:clay",
	wherein        = "default:sand",
	clust_scarcity = 15*15*15,
	clust_num_ores = 64,
	clust_size     = 5,
	y_max     = wl,
	y_min     = wl - 10,
})

function default.generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, y_min, y_max)
	minetest.log('action', "WARNING: default.generate_ore is deprecated")

	if maxp.y < y_min or minp.y > y_max then
		return
	end
	local y_min = math.max(minp.y, y_min)
	local y_max = math.min(maxp.y, y_max)
	if chunk_size >= y_max - y_min + 1 then
		return
	end
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= y_min and y0 <= y_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end
