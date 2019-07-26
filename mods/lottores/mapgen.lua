local wl = minetest.get_mapgen_setting("water_level")

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = wl - 60,
	y_max     = wl - 10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone",
	wherein        = "default:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl - 61,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 15,
	clust_size     = 6,
	y_min     = wl - 31000,
	y_max     = wl - 50,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:silver_ore",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 200,
	y_max     = wl - 50,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:silver_ore",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 201,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = wl - 60,
	y_max     = wl - 20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 10,
	clust_size     = 5,
	y_min     = wl - 31000,
	y_max     = wl - 61,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = wl - 60,
	y_max     = wl - 30,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 61,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:rough_rock",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 300,
	y_max     = wl - 70,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:rough_rock",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = wl - 31000,
	y_max     = wl - 301,
})

--[[
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = wl - 255,
	y_max     = wl - 128,
})]]

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 7,
	clust_size     = 3,
	y_min     = wl - 31000,
	y_max     = wl - 20000,
})
