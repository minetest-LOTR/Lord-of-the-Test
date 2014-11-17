local ALDINT = 67
local ALDCHA = 11

local APPINT = 67
local APPCHA = 11

local BIRINT = 67
local BIRCHA = 11

local BEEINT = 67
local BEECHA = 11

local CULINT = 67
local CULCHA = 11

local ELMINT = 67
local ELMCHA = 11

local FIRINT = 67
local FIRCHA = 11

local LEBINT = 67
local LEBCHA = 11

local MALINT = 67
local MALCHA = 11

local PININT = 67
local PINCHA = 11

local PLUINT = 67
local PLUCHA = 11

local ROWINT = 67
local ROWCHA = 11

local WHIINT = 67
local WHICHA = 11

local YAVINT = 67
local YAVCHA = 11

-- LEAVES

minetest.register_node("olvar:alderleaf", {
	description = "Alder Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_alderleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:aldersapling'},
				rarity = 20,
			},
			{
				items = {'olvar:alderleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:appleleaf", {
	description = "Apple Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_appleleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:applesapling'},
				rarity = 20,
			},
			{
				items = {'olvar:appleleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:birchleaf", {
	description = "Birch Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_birchleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:birchsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:birchleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:beechleaf", {
	description = "Beech Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_beechleaf.png"},
	paramtype = "light",
	groups = {snappy=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:beechsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:beechleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:culumaldaleaf", {
	description = "Culumalda Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_culumaldaleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:culumaldasapling'},
				rarity = 20,
			},
			{
				items = {'olvar:culumaldaleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:yellowflowers", {
	description = "Yellow Flowers on Culumalda Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_yellowflowers.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    drop = {
	    	max_items = 3,
		    items = {
		        { items = {'olvar:culumaldaleaf'} },
		    	{ items = {'olvar:culumaldasapling'}, rarity = 20 },
		    	{ items = {'olvar:yellowflowers'} },
		    }
	    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:elmleaf", {
	description = "Elm Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_elmleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:elmsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:elmleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:firleaf", {
	description = "Fir Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_firleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:firsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:firleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:lebethronleaf", {
	description = "Lebethron Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_lebethronleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:lebethronsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:lebethronleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:mallornleaf", {
	description = "Mallorn Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_mallornleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:mallornsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:mallornleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:pineleaf", {
	description = "Pine Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_pineleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:pinesapling'},
				rarity = 20,
			},
			{
				items = {'olvar:pineleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:plumleaf", {
	description = "Plum Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_plumleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:plumsapling'},
				rarity = 20,
			},
			{
				items = {'olvar:plumleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:rowanleaf", {
	description = "Rowan Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_rowanleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    drop = {
	    	max_items = 1,
		    items = {
		    	{ items = {'olvar:rowansapling'}, rarity = 20 },
		    	{ items = {'olvar:berries'}, rarity = 200 },
		    	{ items = {'olvar:rowanleaf'} },
		    }
	    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:rowanberry", {
	description = "Rowan Leaf with Berries",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_rowanleaf.png^olvar_rowanberry.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    drop = {
	    	max_items = 2,
		    items = {
		          { items = {'olvar:rowanleaf'} },
		    	  { items = {'olvar:berries'} },
		    }
	    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:whiteleaf", {
	description = "White Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_whiteleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:whitesapling'},
				rarity = 20,
			},
			{
				items = {'olvar:whiteleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("olvar:yavannamireleaf", {
	description = "Yavannamire Leaf",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"olvar_yavannamireleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'olvar:yavannamiresapling'},
				rarity = 20,
			},
			{
				items = {'olvar:yavannamireleaf'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- TREE

minetest.register_node("olvar:aldertree", {
	description = "Alder Tree",
	tiles = {"olvar_aldertree_top.png", "olvar_aldertree_top.png", "olvar_aldertree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("olvar:birchtree", {
	description = "Birch Tree",
	tiles = {"olvar_birchtree_top.png", "olvar_birchtree_top.png", "olvar_birchtree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("olvar:lebethrontree", {
	description = "Lebethron Tree",
	tiles = {"olvar_lebethrontree_top.png", "olvar_lebethrontree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("olvar:mallorntree", {
	description = "Mallorn Tree",
	tiles = {"olvar_mallorntree_top.png", "olvar_mallorntree_top.png", "olvar_mallorntree.png"},
	paramtype2 = "facedir",
	groups = {tree=1,choppy=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

-- SAPLINGS

minetest.register_node("olvar:aldersapling", {
	description = "Alder Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_aldersapling.png"},
	inventory_image = "olvar_aldersapling.png",
	wield_image = "olvar_aldersapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:applesapling", {
	description = "Apple Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_applesapling.png"},
	inventory_image = "olvar_applesapling.png",
	wield_image = "olvar_applesapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:birchsapling", {
	description = "Birch Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_birchsapling.png"},
	inventory_image = "olvar_birchsapling.png",
	wield_image = "olvar_birchsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:beechsapling", {
	description = "Beech Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_beechsapling.png"},
	inventory_image = "olvar_beechsapling.png",
	wield_image = "olvar_beechsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:culumaldasapling", {
	description = "Culumalda Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_culumaldasapling.png"},
	inventory_image = "olvar_culumaldasapling.png",
	wield_image = "olvar_culumaldasapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:elmsapling", {
	description = "Elm Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_elmsapling.png"},
	inventory_image = "olvar_elmsapling.png",
	wield_image = "olvar_elmsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:firsapling", {
	description = "Fir Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_firsapling.png"},
	inventory_image = "olvar_firsapling.png",
	wield_image = "olvar_firsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:lebethronsapling", {
	description = "Lebethron Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_lebethronsapling.png"},
	inventory_image = "olvar_lebethronsapling.png",
	wield_image = "olvar_lebethronsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:mallornsapling", {
	description = "Mallorn Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_mallornsapling.png"},
	inventory_image = "olvar_mallornsapling.png",
	wield_image = "olvar_mallornsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:pinesapling", {
	description = "Pine Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_pinesapling.png"},
	inventory_image = "olvar_pinesapling.png",
	wield_image = "olvar_pinesapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:plumsapling", {
	description = "Plum Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_plumsapling.png"},
	inventory_image = "olvar_plumsapling.png",
	wield_image = "olvar_plumsapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:rowansapling", {
	description = "Rowan Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_rowansapling.png"},
	inventory_image = "olvar_rowansapling.png",
	wield_image = "olvar_rowansapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:whitesapling", {
	description = "White Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_whitesapling.png"},
	inventory_image = "olvar_whitesapling.png",
	wield_image = "olvar_whitesapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("olvar:yavannamiresapling", {
	description = "Yavannamire Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_yavannamiresapling.png"},
	inventory_image = "olvar_yavannamiresapling.png",
	wield_image = "olvar_yavannamiresapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

-- FRUITS

minetest.register_node("olvar:plum", {
	description = "Plum",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_plum.png"},
	inventory_image = "olvar_plum.png",
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
			minetest.set_node(pos, {name="olvar:plum", param2=1})
		end
	end,
})

minetest.register_node("olvar:yavannamirefruit", {
	description = "Yavannamire Fruit",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"olvar_yavannamirefruit.png"},
	inventory_image = "olvar_yavannamirefruit.png",
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
			minetest.set_node(pos, {name="olvar:yavannamirefruit", param2=1})
		end
	end,
})

--Wood

minetest.register_node("olvar:alderwood", {
	description = "Alder Planks",
	tiles = {"olvar_alderwood.png"},
	groups = {choppy=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("olvar:birchwood", {
	description = "Birch Planks",
	tiles = {"olvar_birchwood.png"},
	groups = {choppy=3,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("olvar:lebethronwood", {
	description = "Lebethron Planks",
	tiles = {"olvar_lebethronwood.png"},
	groups = {choppy=1,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("olvar:mallornwood", {
	description = "Mallorn Planks",
	tiles = {"olvar_mallornwood.png"},
	groups = {choppy=1,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

--Stairs & Slabs

stairs.register_stair_and_slab("alderwood", "olvar:alderwood",
		{snappy=2,choppy=2,flammable=3},
		{"olvar_alderwood.png"},
		"Alder Wood Stair",
		"Alder Wood Slab",
		default.node_sound_wood_defaults())
	
stairs.register_stair_and_slab("birchwood", "olvar:birchwood",
		{snappy=2,choppy=3,flammable=3},
		{"olvar_birchwood.png"},
		"Birch Wood Stair",
		"Birch Wood Slab",
		default.node_sound_wood_defaults())
	
stairs.register_stair_and_slab("lebethronwood", "olvar:lebethronwood",
		{snappy=2,choppy=1,flammable=3},
		{"olvar_lebethronwood.png"},
		"Lebethron Wood Stair",
		"Lebethron Wood Slab",
		default.node_sound_wood_defaults())
	
stairs.register_stair_and_slab("mallornwood", "olvar:mallornwood",
		{snappy=2,choppy=1,flammable=3},
		{"olvar_mallornwood.png"},
		"Mallorn Wood Stair",
		"Mallorn Wood Slab",
		default.node_sound_wood_defaults())
--Crafting

minetest.register_craft({
	output = 'olvar:birchwood 4',
	recipe = {
		{'olvar:birchtree'},
	}
})

minetest.register_craft({
	output = 'olvar:alderwood 4',
	recipe = {
		{'olvar:aldertree'},
	}
})

minetest.register_craft({
	output = 'olvar:lebethronwood 4',
	recipe = {
		{'olvar:lebethrontree'},
	}
})

minetest.register_craft({
	output = 'olvar:mallornwood 4',
	recipe = {
		{'olvar:mallorntree'},
	}
})

--Fireflies

minetest.register_node("olvar:fireflies", {
	description = "Fireflies",
	drawtype = "glasslike",
	tiles = {
		{
			name = "olvar_fireflies.png",
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
		"olvar_elanor",
		"olvar:niphredil",
	},
	interval = 15,
	chance = 600,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.74 or minetest.get_timeofday() < 0.22 then
			--local water_nodes = minetest.find_nodes_in_area(minp, maxp, "group:water")
			--if #water_nodes > 0 then
			if minetest.find_node_near(pos, 3, "olvar:fireflies") == nil then
				minetest.set_node(pos, {name = "olvar:fireflies"})
			end
		end
	end,
})
