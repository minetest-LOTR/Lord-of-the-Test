-- LEAVES

minetest.register_node("lottplants:alderleaf", {
	description = "Alder Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_alderleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:aldersapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:alderleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:appleleaf", {
	description = "Apple Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_appleleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:applesapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:appleleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:birchleaf", {
	description = "Birch Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_birchleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:birchsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:birchleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:beechleaf", {
	description = "Beech Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_beechleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:beechsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:beechleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:culumaldaleaf", {
	description = "Culumalda Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_culumaldaleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:culumaldasapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:culumaldaleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:yellowflowers", {
	description = "Yellow Flowers on Culumalda Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_yellowflowers.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    drop = {
	    	max_items = 3,
		    items = {
		        { items = {'lottplants:culumaldaleaf'} },
		    	{ items = {'lottplants:culumaldasapling'}, rarity = 20 },
		    	{ items = {'lottplants:yellowflowers'} },
		    }
	    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:elmleaf", {
	description = "Elm Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_elmleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:elmsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:elmleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:firleaf", {
	description = "Fir Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_firleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:firsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:firleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:lebethronleaf", {
	description = "Lebethron Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_lebethronleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:lebethronsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:lebethronleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:mallornleaf", {
	description = "Mallorn Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_mallornleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:mallornsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:mallornleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:pineleaf", {
	description = "Pine Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_pineleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:pinesapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:pineleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:plumleaf", {
	description = "Plum Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_plumleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:plumsapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:plumleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:rowanleaf", {
	description = "Rowan Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_rowanleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    drop = {
	    	max_items = 1,
		    items = {
		    	{ items = {'lottplants:rowansapling'}, rarity = 20 },
		    	{ items = {'lottfarming:berries'}, rarity = 200 },
		    	{ items = {'lottplants:rowanleaf'} },
		    }
	    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:rowanberry", {
	description = "Rowan Leaf with Berries",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_rowanleaf.png^lottplants_rowanberry.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    drop = {
	    	max_items = 2,
		    items = {
		          { items = {'lottplants:rowanleaf'} },
		    	  { items = {'lottfarming:berries'} },
		    }
	    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:whiteleaf", {
	description = "White Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_whiteleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:whitesapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:whiteleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:yavannamireleaf", {
	description = "Yavannamire Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_yavannamireleaf.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:yavannamiresapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:yavannamireleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_alias("lottmapgen:mirkleaves", "lottplants:mirkleaf")
minetest.register_node("lottplants:mirkleaf", {
	description = "Mirkwood Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"lottplants_mirkleaf.png"},
	paramtype = "light",
	sunlight_propagates = false,
	waving = 1,
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'lottplants:mirksapling'},
				rarity = 20,
			},
			{
				items = {'lottplants:mirkleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- TREE

minetest.register_node("lottplants:pinetree", {
	description = "Pine Tree",
	tiles = {"lottplants_pinetree_top.png", "lottplants_pinetree_top.png", "lottplants_pinetree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:pinetree", digger, 13, 2)
	end,
})

minetest.register_node("lottplants:birchtree", {
	description = "Birch Tree",
	tiles = {"lottplants_birchtree_top.png", "lottplants_birchtree_top.png", "lottplants_birchtree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:birchtree", digger, 12, 3)
	end,
})

minetest.register_node("lottplants:aldertree", {
	description = "Alder Tree",
	tiles = {"lottplants_aldertree_top.png", "lottplants_aldertree_top.png", "lottplants_aldertree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:aldertree", digger, 10, 2)
	end,
})

minetest.register_node("lottplants:lebethrontree", {
	description = "Lebethron Tree",
	tiles = {"lottplants_lebethrontree_top.png", "lottplants_lebethrontree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:lebethrontree", digger, 10, 2)
	end,
})

minetest.register_node("lottplants:mallorntree", {
	description = "Mallorn Tree",
	tiles = {"lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree", digger, 30, 5)
	end,
})

minetest.register_node("lottplants:mallorntree_young", {
	description = "Young Mallorn Trunk",
	tiles = {"lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.1875, 0.125, 0.5, 0.1875},
			{-0.1875, -0.5, -0.125, 0.1875, 0.5, 0.125},
		},
	},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2,fuel=1},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree_young", digger, 10, 1)
	end,
})

-- SAPLINGS

minetest.register_node("lottplants:aldersapling", {
	description = "Alder Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_aldersapling.png"},
	inventory_image = "lottplants_aldersapling.png",
	wield_image = "lottplants_aldersapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:applesapling", {
	description = "Apple Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_applesapling.png"},
	inventory_image = "lottplants_applesapling.png",
	wield_image = "lottplants_applesapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:birchsapling", {
	description = "Birch Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_birchsapling.png"},
	inventory_image = "lottplants_birchsapling.png",
	wield_image = "lottplants_birchsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:beechsapling", {
	description = "Beech Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_beechsapling.png"},
	inventory_image = "lottplants_beechsapling.png",
	wield_image = "lottplants_beechsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:culumaldasapling", {
	description = "Culumalda Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_culumaldasapling.png"},
	inventory_image = "lottplants_culumaldasapling.png",
	wield_image = "lottplants_culumaldasapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:elmsapling", {
	description = "Elm Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_elmsapling.png"},
	inventory_image = "lottplants_elmsapling.png",
	wield_image = "lottplants_elmsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:firsapling", {
	description = "Fir Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_firsapling.png"},
	inventory_image = "lottplants_firsapling.png",
	wield_image = "lottplants_firsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:lebethronsapling", {
	description = "Lebethron Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_lebethronsapling.png"},
	inventory_image = "lottplants_lebethronsapling.png",
	wield_image = "lottplants_lebethronsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:mallornsapling", {
	description = "Mallorn Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_mallornsapling.png"},
	inventory_image = "lottplants_mallornsapling.png",
	wield_image = "lottplants_mallornsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:mallorntree_young_grower", {
	description = "Young Mallorn Trunk",
	tiles = {"lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.1875, 0.125, 0.5, 0.1875},
			{-0.1875, -0.5, -0.125, 0.1875, 0.5, 0.125},
		},
	},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2,fuel=1, not_in_creative_inventory=1,sapling=1},
	sounds = default.node_sound_wood_defaults(),
	drop = "lottplants:mallorntree_young",
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree_young", digger, 10, 1)
	end,
})

minetest.register_node("lottplants:mallorntree_grower", {
	description = "Mallorn Tree",
	tiles = {"lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2, not_in_creative_inventory=1,sapling=1},
	sounds = default.node_sound_wood_defaults(),
	drops = "lottplants:mallorntree",
	on_place = minetest.rotate_node,
	on_dig = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree", digger, 30, 5)
	end,
})

minetest.register_node("lottplants:pinesapling", {
	description = "Pine Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_pinesapling.png"},
	inventory_image = "lottplants_pinesapling.png",
	wield_image = "lottplants_pinesapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:plumsapling", {
	description = "Plum Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_plumsapling.png"},
	inventory_image = "lottplants_plumsapling.png",
	wield_image = "lottplants_plumsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:rowansapling", {
	description = "Rowan Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_rowansapling.png"},
	inventory_image = "lottplants_rowansapling.png",
	wield_image = "lottplants_rowansapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:whitesapling", {
	description = "White Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_whitesapling.png"},
	inventory_image = "lottplants_whitesapling.png",
	wield_image = "lottplants_whitesapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:yavannamiresapling", {
	description = "Yavannamire Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_yavannamiresapling.png"},
	inventory_image = "lottplants_yavannamiresapling.png",
	wield_image = "lottplants_yavannamiresapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("lottplants:mirksapling", {
	description = "Mirkwood Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_mirksapling.png"},
	inventory_image = "lottplants_mirksapling.png",
	wield_image = "lottplants_mirksapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2,sapling=1},
	sounds = default.node_sound_defaults(),
})

-- FRUITS

minetest.register_node("lottplants:plum", {
	description = "Plum",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_plum.png"},
	inventory_image = "lottplants_plum.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="lottplants:plum", param2=1})
		end
	end,
})

minetest.register_node("lottplants:yavannamirefruit", {
	description = "Yavannamire Fruit",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"lottplants_yavannamirefruit.png"},
	inventory_image = "lottplants_yavannamirefruit.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="lottplants:yavannamirefruit", param2=1})
		end
	end,
})

--Wood

minetest.register_node("lottplants:pinewood", {
	description = "Pine Planks",
	tiles = {"lottplants_pinewood.png"},
	groups = {choppy=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottplants:birchwood", {
	description = "Birch Planks",
	tiles = {"lottplants_birchwood.png"},
	groups = {choppy=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottplants:alderwood", {
	description = "Alder Planks",
	tiles = {"lottplants_alderwood.png"},
	groups = {choppy=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottplants:lebethronwood", {
	description = "Lebethron Planks",
	tiles = {"lottplants_lebethronwood.png"},
	groups = {choppy=1,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottplants:mallornwood", {
	description = "Mallorn Planks",
	tiles = {"lottplants_mallornwood.png"},
	groups = {choppy=1,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

--Lorien grass

minetest.register_node("lottplants:lorien_grass_1", {
	description = "Lorien Grass",
	drawtype = "plantlike",
	tiles = {"lottplants_lorien_grass_1.png"},
	-- use a bigger inventory image
	inventory_image = "lottplants_lorien_grass_3.png",
	wield_image = "lottplants_lorien_grass_3.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	waving = 1,
	is_ground_content = true,
	buildable_to = true,
	groups = {snappy=3,flammable=3,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("lottplants:lorien_grass_"..math.random(1,4))
		local ret = minetest.item_place(stack, placer, pointed_thing, 40)
		return ItemStack("lottplants:lorien_grass_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
})

for i = 2, 4 do
	minetest.register_node("lottplants:lorien_grass_" .. i, {
		description = "Lorien Grass",
		drawtype = "plantlike",
		tiles = {"lottplants_lorien_grass_" .. i .. ".png"},
		inventory_image = "lottplants_lorien_grass_" .. i .. ".png",
		wield_image = "lottplants_lorien_grass_" .. i .. ".png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		walkable = false,
		buildable_to = true,
		waving = 1,
		is_ground_content = true,
		drop = "lottplants:lorien_grass_1",
		groups = {snappy=3,flammable=3,flora=1,attached_node=1,not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	})
end

--Stairs & Slabs

stairs.register_stair_and_slab("birchwood", "lottplants:birchwood",
		{choppy=3,flammable=3},
		{"lottplants_birchwood.png"},
		"Birch Wood Stair",
		"Birch Wood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("birchtree", "lottplants:birchtree",
		{choppy=3,flammable=2},
		{"lottplants_birchtree_top.png", "lottplants_birchtree_top.png", "lottplants_birchtree.png",
		"lottplants_birchtree.png", "lottplants_birchtree.png", "lottplants_birchtree_stair.png"},
		"Birch Tree Stair",
		"Birch Tree Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("pinewood", "lottplants:pinewood",
		{choppy=3,flammable=3},
		{"lottplants_pinewood.png"},
		"Pine Wood Stair",
		"Pine Wood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("pinetree", "lottplants:pinetree",
		{choppy=3,flammable=2},
		{"lottplants_pinetree_top.png", "lottplants_pinetree_top.png", "lottplants_pinetree.png",
		"lottplants_pinetree.png", "lottplants_pinetree.png", "lottplants_pinetree_stair.png"},
		"Pine Tree Stair",
		"Pine Tree Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("alderwood", "lottplants:alderwood",
		{choppy=2,flammable=3},
		{"lottplants_alderwood.png"},
		"Alder Wood Stair",
		"Alder Wood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("aldertree", "lottplants:aldertree",
		{choppy=2,flammable=2},
		{"lottplants_aldertree_top.png", "lottplants_aldertree_top.png", "lottplants_aldertree.png",
		"lottplants_aldertree.png", "lottplants_aldertree.png", "lottplants_aldertree_stair.png"},
		"Alder Tree Stair",
		"Alder Tree Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("lebethronwood", "lottplants:lebethronwood",
		{choppy=1,flammable=3},
		{"lottplants_lebethronwood.png"},
		"Lebethron Wood Stair",
		"Lebethron Wood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("lebethrontree", "lottplants:lebethrontree",
		{choppy=1,flammable=2},
		{"lottplants_lebethrontree_top.png", "lottplants_lebethrontree_top.png", "default_tree.png",
		"default_tree.png", "default_tree.png", "lottplants_lebethrontree_stair.png"},
		"Lebethron Tree Stair",
		"Lebethron Tree Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("mallornwood", "lottplants:mallornwood",
		{choppy=1,flammable=3},
		{"lottplants_mallornwood.png"},
		"Mallorn Wood Stair",
		"Mallorn Wood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("mallorntree", "lottplants:mallorntree",
		{choppy=1,flammable=2},
		{"lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png",
		"lottplants_mallorntree.png", "lottplants_mallorntree.png", "lottplants_mallorntree_stair.png"},
		"Mallorn Tree Stair",
		"Mallorn Tree Slab",
		default.node_sound_wood_defaults())

--Crafting

minetest.register_craft({
	output = 'lottplants:birchwood 4',
	recipe = {
		{'lottplants:birchtree'},
	}
})

minetest.register_craft({
	output = 'lottplants:pinewood 4',
	recipe = {
		{'lottplants:pinetree'},
	}
})

minetest.register_craft({
	output = 'lottplants:alderwood 4',
	recipe = {
		{'lottplants:aldertree'},
	}
})

minetest.register_craft({
	output = 'lottplants:lebethronwood 4',
	recipe = {
		{'lottplants:lebethrontree'},
	}
})

minetest.register_craft({
	output = 'lottplants:mallornwood 4',
	recipe = {
		{'lottplants:mallorntree'},
	}
})

minetest.register_craft({
	output = 'lottplants:mallornwood 2',
	recipe = {
		{'lottplants:mallorntree_young'},
	}
})

--Fireflies

minetest.register_node("lottplants:fireflies", {
	description = "Fireflies",
	drawtype = "glasslike",
	tiles = {
		{
			name = "lottplants_fireflies.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	alpha = 100,
	paramtype = "light",
	light_source = 8,
	walkable = false,
	pointable = true,
	diggable = true,
	climbable = false,
	buildable_to = true,
	drop = "",
})

minetest.register_abm({
	nodenames = {"air"},
	neighbors = {
		"lottplants_elanor",
		"lottplants:niphredil",
	},
	interval = 15,
	chance = 600,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.74 or minetest.get_timeofday() < 0.22 then
			--local water_nodes = minetest.find_nodes_in_area(minp, maxp, "group:water")
			--if #water_nodes > 0 then
			if minetest.find_node_near(pos, 3, "lottplants:fireflies") == nil then
				minetest.set_node(pos, {name = "lottplants:fireflies"})
			end
		end
	end,
})
