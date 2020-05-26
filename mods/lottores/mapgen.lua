
-- Coal Ore
minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:coal_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 4,
	clust_size = 5,
	y_min = 0,
	y_max = 80,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:coal_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 5,
	clust_size = 4,
	y_min = -250,
	y_max = -1,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:coal_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 7,
	clust_size = 4,
	y_min = -31000,
	y_max = -250,
})

-- Tin Ore
-- Occurs in bands. 1st, -70 - -90. 2nd, -240 - -270. 3rd, -470 - -520.
-- 4th, -750 - -820, 5th, -1000 - -1100 (def of the last one at the end, so that
-- other ores can spawn in it)
minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:tin_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 3,
	clust_size = 3,
	y_min = -90,
	y_max = -70,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:tin_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 9,
	clust_size = 3,
	y_min = -270,
	y_max = -240,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:tin_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 5 * 5 * 5,
	clust_num_ores = 2,
	clust_size = 6,
	y_min = -520,
	y_max = -470,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:tin_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 27,
	clust_size = 4,
	y_min = 260,
	y_max = 330,
	y_min = -820,
	y_max = -750,
})

-- Copper Ore
-- Occurs in rare, small patches from -150, and in fairly large, but rareish, patches from -330 downward
minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:copper_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 35 * 35 * 35,
	clust_num_ores = 9,
	clust_size = 3,
	y_min = -330,
	y_max = -150,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:copper_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 25 * 25 * 25,
	clust_num_ores = 19,
	clust_size = 4,
	y_min = -31000,
	y_max = -330,
})

-- Lead ore: The reverese of most other ores - it's more common higher, and decreases as you go down!
-- Can be found almost anywhere above sea-level to -50, and then more rarely
-- from -50 to -150
minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:lead_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 7,
	clust_size = 3,
	y_min = -50,
	y_max = 200,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:lead_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size = 3,
	y_min = -150,
	y_max = -50,
})

-- Gold Ore
-- Quite a deep occuring ore, -300 downwards, with higher quantities from -500
-- There are areas where there's quite a bit of it, and others where it can't
-- be found at all.
minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:gold_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 20 * 20 * 20,
	clust_size = 2,
	clust_num_ores = 2,
	y_min = -500,
	y_max = -300,
	noise_threshold = 0.0,
	noise_params = {
		scale = 1,
		spread = {x = 94, y = 256, z = 94},
		seed = 32879,
		octaves = 2,
		persist = 0.6,
	},
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:gold_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 10 * 10 * 10,
	clust_size = 3,
	clust_num_ores = 4,
	y_min = -31000,
	y_max = -500,
	noise_threshold = 0.0,
	noise_params = {
		scale = 1,
		spread = {x = 94, y = 256, z = 94},
		seed = 32879,
		octaves = 2,
		persist = 0.6,
	},
})

-- Silver: Very small amounts, but not that rare, all over the world
minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:silver_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 12 * 12 * 12,
	clust_size = 2,
	clust_num_ores = 2,
	y_min = -31000,
	y_max = 31000,
})

-- Iron... Hmm, what to do?

minetest.register_ore({
	ore_type = "scatter",
	ore = "lottores:iron_ore",
	wherein = {"air"},
	clust_scarcity = 12 * 12 * 12,
	clust_size = 2,
	clust_num_ores = 2,
	y_min = 260,
	y_max = 300,
})

-- Should be last/one of the last ores defined
minetest.register_ore({
	ore_type = "sheet",
	ore = "lottores:tin_ore",
	wherein = {"lottitems:stone"},
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 5,
	clust_size = 3,
	noise_params = {
        offset = 0,
        scale = 1,
        spread = {x = 64, y = 64, z = 64},
        seed = 219,
        octaves = 4,
        persist = 0.5,
    },
	column_height_min = 4,
	column_height_max = 7,
	noise_threshold = 0.9,
	column_midpoint_factor = 0.75,
	y_min = -1100,
	y_max = -1000,
})
