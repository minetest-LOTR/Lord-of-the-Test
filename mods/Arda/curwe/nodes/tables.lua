minetest.register_node("curwe:bedside_table",
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



minetest.register_node("curwe:wood_table",
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
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2,flammable=2}
}) 
minetest.register_craft({
	output = 'curwe:wood_table',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("curwe:wood_chair",
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
groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2,flammable=2}
})
minetest.register_craft({
	output = 'curwe:wood_chair',
	recipe = {
		{'group:stick', ''},
		{'default:wood', 'default:wood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("curwe:alder_table",
	{description = 'Alder Table',
	tiles = {"olvar_alderwood.png"},
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
	output = 'curwe:alder_table',
	recipe = {
		{'olvar:alderwood', 'olvar:alderwood', 'olvar:alderwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("curwe:alder_chair",
	{ description = 'Alder Chair',
	tiles = {"olvar_alderwood.png"},
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
	output = 'curwe:alder_chair',
	recipe = {
		{'group:stick', ''},
		{'olvar:alderwood', 'olvar:alderwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("curwe:birch_table",
	{description = 'Birch Table',
	tiles = {"olvar_birchwood.png"},
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
	groups = {snappy=2,choppy=3,flammable=2}
}) 
minetest.register_craft({
	output = 'curwe:birch_table',
	recipe = {
		{'olvar:birchwood', 'olvar:birchwood', 'olvar:birchwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("curwe:birch_chair",
	{ description = 'Birch Chair',
	tiles = {"olvar_birchwood.png"},
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
groups = {snappy=2,choppy=3,flammable=2}
})
minetest.register_craft({
	output = 'curwe:birch_chair',
	recipe = {
		{'group:stick', ''},
		{'olvar:birchwood', 'olvar:birchwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("curwe:lebethron_table",
	{description = 'Lebethron Table',
	tiles = {"olvar_lebethronwood.png"},
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
	output = 'curwe:lebethron_table',
	recipe = {
		{'olvar:lebethronwood', 'olvar:lebethronwood', 'olvar:lebethronwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("curwe:lebethron_chair",
	{ description = 'Lebethron Chair',
	tiles = {"olvar_lebethronwood.png"},
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
	output = 'curwe:lebethron_chair',
	recipe = {
		{'group:stick', ''},
		{'olvar:lebethronwood', 'olvar:lebethronwood'},
		{'group:stick', 'group:stick'},
	}
})
minetest.register_node("curwe:mallorn_table",
	{description = 'Mallorn Table',
	tiles = {"olvar_mallornwood.png"},
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
	output = 'curwe:mallorn_table',
	recipe = {
		{'olvar:mallornwood', 'olvar:mallornwood', 'olvar:mallornwood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})
minetest.register_node("curwe:mallorn_chair",
	{ description = 'Mallorn Chair',
	tiles = {"olvar_mallornwood.png"},
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
	output = 'curwe:mallorn_chair',
	recipe = {
		{'group:stick', ''},
		{'olvar:mallornwood', 'olvar:mallornwood'},
		{'group:stick', 'group:stick'},
	}
})

minetest.register_node("curwe:strategy_table", {
	description = "Strategy Table",
	tiles = {
		"curwe_strategy_table_top.png",
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
	groups = {choppy = 2, flamable = 2}
})
minetest.register_craft({
	output = "curwe:strategy_table",
	recipe = {
		{"default:paper", "group:wood", "default:paper"},
		{"", "group:wood", ""},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_node("curwe:hobbit_table", {
	description = "Hobbit Table",
	tiles = {"olvar_aldertree.png"},
	groups = {choppy = 2, flamable = 2},
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
	output = "curwe:hobbit_table",
	recipe = {
		{"olvar:aldertree", "olvar:aldertree", "olvar:aldertree"},
		{"", "default:stick", ""},
		{"olvar:aldertree", "olvar:aldertree", "olvar:aldertree"},
	}
})
