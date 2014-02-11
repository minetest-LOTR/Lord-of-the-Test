--Blocks

minetest.register_node("lottseaores:mineral_pearl", {
	description = "Pearl Ore",
	tiles = {"default_sand.png^lottseaores_mineral_pearl.png"},
	paramtype = "light",
	light_source = 5,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

	drop = {
		items = {
			{
				items = {'lottseaores:pearl'},
			},
			{
				items = {'default:sand'},
			}
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("lottseaores:mineral_salt", {
	description = "Salt Mineral",
	tiles = {"default_dirt.png^lottseaores_mineral_salt.png"},
	paramtype = "light",
	light_source = 6,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

	drop = {
		items = {
			{
				items = {'lottseaores:salt'},
			},
			{
				items = {'default:dirt'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults,
})

minetest.register_node( "lottseaores:pearl_block", {
	description = "Pearl Block",
    alpha = 200,
	tile_images = { "default_sand.png^lottseaores_pearl_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

        sounds = default.node_sound_glass_defaults(),

	drop = 'node "lottseaores:pearl" 9',
})

minetest.register_node( "lottseaores:salt_block", {
	description = "Salt Block",
	tile_images = { "default_clay.png^lottseaores_salt_block.png" },
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},

	on_use = minetest.item_eat(8),
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "lottseaores:salt" 9',
})

minetest.register_node("lottseaores:salt", {
	description = "Salt",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottseaores_salt.png"},
	inventory_image = "lottseaores_salt.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=1},
	on_use = minetest.item_eat(8),
	sounds = default.node_sound_defaults(),
})

-- Craft items

minetest.register_craftitem("lottseaores:pearl", {
	description = "Pearl",
	inventory_image = "lottseaores_pearl.png",
})	

-- Crafting

minetest.register_craft( {
        output = 'node "lottseaores:salt_block" 1',
	recipe = {
		{ 'craft "lottseaores:salt"', 'craft "lottseaores:salt"', 'craft "lottseaores:salt"' },
		{ 'craft "lottseaores:salt"', 'craft "lottseaores:salt"', 'craft "lottseaores:salt"' },
		{ 'craft "lottseaores:salt"', 'craft "lottseaores:salt"', 'craft "lottseaores:salt"' },
	}
})

minetest.register_craft( {
	output = 'node "lottseaores:pearl_block" 1',
	recipe = {
		{ 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"' },
		{ 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"' },
		{ 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"', 'craft "lottseaores:pearl"' },
	}
})

stairs.register_stair_and_slab("pearl", "lottseaores:pearl_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"lottseaores_pearl_block.png"},
		"Pearl Stair",
		"Pearl Slab",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("salt", "lottseaores:salt_block",
		{cracky=3,oddly_breakable_by_hand=3},
		{"lottseaores_salt_block.png"},
		"Salt Stair",
		"Salt Slab",
		default.node_sound_stone_defaults())

-- Ore generation

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
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
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
	generate_ore("lottseaores:mineral_salt", "default:dirt", minp, maxp, seed+20, 1/7/7/7, 1, 1, -31000, -6)
	generate_ore("lottseaores:mineral_pearl", "default:sand", minp, maxp, seed+21, 1/7/7/7, 1, 1, -31000, -6)
end)