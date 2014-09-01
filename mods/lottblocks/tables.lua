minetest.register_node("lottblocks:bedside_table",
	{description = 'Bedside Table',
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.1,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.1,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.1,0.4},
			{0.3,-0.5,0.3, 0.4,0.1,0.4},
			{-0.5,0.2,-0.5, 0.5,0.1,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.3,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.4,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.4,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.4,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 



minetest.register_node("lottblocks:wood_table",
	{description = 'Wooden Table',
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:wood_table',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:wood_chair",
	{ description = 'Wooden Chair',
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:wood_chair',
	recipe = {
		{'group:stick', ''},
		{'default:wood', 'default:wood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:alder_table",
	{description = 'Alder Table',
	tiles = {"lottplants_alderwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:alder_table',
	recipe = {
		{'lottplants:alderwood', 'lottplants:alderwood', 'lottplants:alderwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:alder_chair",
	{ description = 'Alder Chair',
	tiles = {"lottplants_alderwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:alder_chair',
	recipe = {
		{'group:stick', ''},
		{'lottplants:alderwood', 'lottplants:alderwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:birch_table",
	{description = 'Birch Table',
	tiles = {"lottplants_birchwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:birch_table',
	recipe = {
		{'lottplants:birchwood', 'lottplants:birchwood', 'lottplants:birchwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:birch_chair",
	{ description = 'Birch Chair',
	tiles = {"lottplants_birchwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=2,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:birch_chair',
	recipe = {
		{'group:stick', ''},
		{'lottplants:birchwood', 'lottplants:birchwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:lebethron_table",
	{description = 'Lebethron Table',
	tiles = {"lottplants_lebethronwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=1,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:lebethron_table',
	recipe = {
		{'lottplants:lebethronwood', 'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:lebethron_chair",
	{ description = 'Lebethron Chair',
	tiles = {"lottplants_lebethronwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=1,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:lebethron_chair',
	recipe = {
		{'group:stick', ''},
		{'lottplants:lebethronwood', 'lottplants:lebethronwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("lottblocks:mallorn_table",
	{description = 'Mallorn Table',
	tiles = {"lottplants_mallornwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=1,flammable=2}
}) 
minetest.register_craft({
	output = 'lottblocks:mallorn_table',
	recipe = {
		{'lottplants:mallornwood', 'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("lottblocks:mallorn_chair",
	{ description = 'Mallorn Chair',
	tiles = {"lottplants_mallornwood.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
groups = {snappy=2,choppy=1,flammable=2}
})
minetest.register_craft({
	output = 'lottblocks:mallorn_chair',
	recipe = {
		{'group:stick', ''},
		{'lottplants:mallornwood', 'lottplants:mallornwood'},
		{'group:stick', 'group:stick'},
	}
})

minetest.register_node("lottblocks:strategy_table", {
	description = "Strategy Table",
	tiles = {
		"lottblocks_strategy_table_top.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox2
			{-0.375, 0.3125, -0.375, 0.375, 0.375, 0.375}, -- NodeBox3
			{-0.1875, -0.5, -0.1875, 0.1875, 0.4375, 0.1875}, -- NodeBox4
			{-0.0625, -0.0625, -0.5, 0.0625, 0.4375, -0.125}, -- NodeBox7
			{-0.5, -0.0625, -0.0625, -0.1875, 0.4375, 0.0625}, -- NodeBox8
		}
	},
	groups = {choppy = 2}
})
minetest.register_craft({
	output = "lottblocks:strategy_table",
	recipe = {
		{"default:paper", "group:wood", "default:paper"},
		{"", "group:wood", ""},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_node("lottblocks:hobbit_table", {
	description = "Hobbit Table",
	tiles = {"lottplants_aldertree.png"},
	groups = {choppy = 2},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox1
			{-0.25, 0.3125, -0.375, 0.25, 0.375, 0.375}, -- NodeBox2
			{-0.375, 0.3125, -0.25, 0.375, 0.375, 0.25}, -- NodeBox3
			{-0.125, -0.5, -0.125, 0.125, 0.3125, 0.125}, -- NodeBox4
			{-0.4375, -0.5, -0.125, 0.4375, -0.4375, 0.125}, -- NodeBox5
			{-0.125, -0.5, -0.4375, 0.125, -0.4375, 0.4375}, -- NodeBox6
			{-0.125, -0.4375, -0.3125, 0.125, -0.3125, 0.3125}, -- NodeBox7
			{-0.125, -0.5, -0.375, 0.125, -0.375, 0.375}, -- NodeBox8
			{-0.375, -0.5, -0.125, 0.375, -0.375, 0.125}, -- NodeBox9
			{-0.3125, -0.5, -0.125, 0.3125, -0.3125, 0.125}, -- NodeBox10
			{-0.4375, 0.3125, -0.1875, 0.4375, 0.375, 0.1875}, -- NodeBox12
			{-0.1875, 0.3125, -0.4375, 0.1875, 0.375, 0.4375}, -- NodeBox13
		}
	}
})
minetest.register_craft({
	output = "lottblocks:hobbit_table",
	recipe = {
		{"lottplants:aldertree", "lottplants:aldertree", "lottplants:aldertree"},
		{"", "default:stick", ""},
		{"lottplants:aldertree", "lottplants:aldertree", "lottplants:aldertree"},
	}
})
