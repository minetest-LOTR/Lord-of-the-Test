local MP = minetest.get_modpath(
    minetest.get_current_modname(
    )
)

local S, NS = dofile(
    MP .. "/intllib.lua"
)

dofile(minetest.get_modpath("lottweapons") .. "/special.lua")
dofile(minetest.get_modpath("lottweapons") .. "/crafting.lua")

--Weapons!

-- Battle axes:
minetest.register_tool("lottweapons:wood_battleaxe", {
	description = S("Training Battleaxe"),
	inventory_image = "lottweapons_wood_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.75, [2]=2.75, [3]=2.05}, uses=5, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=.50},
	},
})

minetest.register_tool("lottweapons:stone_battleaxe", {
	description = S("Stone Battleaxe"),
	inventory_image = "lottweapons_stone_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.50,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.35, [2]=2.10, [3]=1.85}, uses=5, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=1.50},
	},
})

minetest.register_tool("lottweapons:copper_battleaxe", {
	description = S("Copper Battleaxe"),
	inventory_image = "lottweapons_copper_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.25, [2]=2.00, [3]=1.75}, uses=5, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottweapons:tin_battleaxe", {
	description = S("Tin Battleaxe"),
	inventory_image = "lottweapons_tin_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.25, [2]=2.00, [3]=1.75}, uses=5, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottweapons:steel_battleaxe", {
	description = S("Steel Battleaxe"),
	inventory_image = "lottweapons_steel_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.05,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3, [2]=1.90, [3]=1.50}, uses=15, maxlevel=2},
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4.5},
	},
})

minetest.register_tool("lottweapons:bronze_battleaxe", {
	description = S("Bronze Battleaxe"),
	inventory_image = "lottweapons_bronze_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.90,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.80, [2]=1.70, [3]=1.30}, uses=20, maxlevel=2},
			snappy={times={[1]=2.55, [2]=1.25, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("lottweapons:silver_battleaxe", {
	description = S("Silver Battleaxe"),
	inventory_image = "lottweapons_silver_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.80, [2]=1.70, [3]=1.30}, uses=15, maxlevel=2},
			snappy={times={[1]=2.60, [2]=1.30, [3]=0.50}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=5.5},
	},
})

minetest.register_tool("lottweapons:gold_battleaxe", {
	description = S("Gold Battleaxe"),
	inventory_image = "lottweapons_gold_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.80, [2]=1.70, [3]=1.30}, uses=20, maxlevel=2},
			snappy={times={[1]=2.60, [2]=1.30, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=5.5},
	},
})

minetest.register_tool("lottweapons:galvorn_battleaxe", {
	description = S("Galvorn Battleaxe"),
	inventory_image = "lottweapons_galvorn_battleaxe.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.50, [3]=.90}, uses=25, maxlevel=2},
			snappy={times={[1]=2.50, [2]=1.50, [3]=0.85}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("lottweapons:mithril_battleaxe", {
	description = S("Mithril Battleaxe"),
	inventory_image = "lottweapons_mithril_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = .25,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2, [2]=1, [3]=.50}, uses=35, maxlevel=3},
			snappy={times={[1]=1, [2]=1.10, [3]=0.50}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

--Warhammers:
minetest.register_tool("lottweapons:wood_warhammer", {
	description = S("Training Warhammer"),
	inventory_image = "lottweapons_wood_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3.40, [2]=2.40, [3]=1.30}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=.75},
	},
})

minetest.register_tool("lottweapons:stone_warhammer", {
	description = S("Stone Warhammer"),
	inventory_image = "lottweapons_stone_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.85, [2]=1.85, [3]=1.10}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottweapons:copper_warhammer", {
	description = S("Copper Warhammer"),
	inventory_image = "lottweapons_copper_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3, [2]=1.80, [3]=1.00}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=4.5},
	},
})

minetest.register_tool("lottweapons:tin_warhammer", {
	description = S("Tin Warhammer"),
	inventory_image = "lottweapons_tin_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3, [2]=1.80, [3]=1.00}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=4.5},
	},
})

minetest.register_tool("lottweapons:steel_warhammer", {
	description = S("Steel Warhammer"),
	inventory_image = "lottweapons_steel_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("lottweapons:bronze_warhammer", {
	description = S("Bronze Warhammer"),
	inventory_image = "lottweapons_bronze_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6.5},
	},
})

minetest.register_tool("lottweapons:silver_warhammer", {
	description = S("Silver Warhammer"),
	inventory_image = "lottweapons_silver_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.60, [2]=1.40, [3]=0.50}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=7.5},
	},
})

minetest.register_tool("lottweapons:gold_warhammer", {
	description = S("Gold Warhammer"),
	inventory_image = "lottweapons_gold_warhammer.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.60, [2]=1.40, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7.5},
	},
})

minetest.register_tool("lottweapons:galvorn_warhammer", {
	description = S("Galvorn Warhammer"),
	inventory_image = "lottweapons_galvorn_warhammer.png",
	range = 2,
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.50,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.50, [2]=1.30, [3]=0.45}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=8},
	},
})

minetest.register_tool("lottweapons:mithril_warhammer", {
	description = S("Mithril Warhammer"),
	inventory_image = "lottweapons_mithril_warhammer.png",
	range = 2,
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.60, [2]=1.40, [3]=0.50}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
})

--Spears:
minetest.register_tool("lottweapons:wood_spear", {
	description = S("Training Spear"),
	inventory_image = "lottweapons_wood_spear.png",
	wield_image = "lottweapons_wood_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3.70, [2]=2.70, [3]=1.70}, uses=3, maxlevel=1},
		},
		damage_groups = {fleshy=.75},
	}
})

minetest.register_tool("lottweapons:stone_spear", {
	description = S("Stone Spear"),
	inventory_image = "lottweapons_stone_spear.png",
	wield_image = "lottweapons_stone_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 1.50,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	}
})

minetest.register_tool("lottweapons:copper_spear", {
	description = S("Copper Spear"),
	inventory_image = "lottweapons_copper_spear.png",
	wield_image = "lottweapons_copper_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 1.30,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.70, [2]=1.70, [3]=0.70}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	}
})

minetest.register_tool("lottweapons:tin_spear", {
	description = S("Tin Spear"),
	inventory_image = "lottweapons_tin_spear.png",
	wield_image = "lottweapons_tin_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 1.30,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.70, [2]=1.70, [3]=0.70}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	}
})

minetest.register_tool("lottweapons:steel_spear", {
	description = S("Steel Spear"),
	inventory_image = "lottweapons_steel_spear.png",
	wield_image = "lottweapons_steel_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 1.20,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.40, [2]=1.40, [3]=0.40}, uses=15, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	}
})

minetest.register_tool("lottweapons:bronze_spear", {
	description = S("Bronze Spear"),
	inventory_image = "lottweapons_bronze_spear.png",
	wield_image = "lottweapons_bronze_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 1.10,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.40, [2]=1.40, [3]=0.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=5.5},
	}
})

minetest.register_tool("lottweapons:silver_spear", {
	description = S("Silver Spear"),
	inventory_image = "lottweapons_silver_spear.png",
	wield_image = "lottweapons_silver_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.2, [2]=1.2, [3]=0.20}, uses=15, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottweapons:gold_spear", {
	description = S("Gold Spear"),
	inventory_image = "lottweapons_gold_spear.png",
	wield_image = "lottweapons_gold_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.2, [2]=1.2, [3]=0.20}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottweapons:galvorn_spear", {
	description = S("Galvorn Spear"),
	inventory_image = "lottweapons_galvorn_spear.png",
	wield_image = "lottweapons_galvorn_spear.png^[transformFX",
	range = 7,
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.50,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.3, [3]=0.30}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=7},
	}
})

minetest.register_tool("lottweapons:mithril_spear", {
	description = S("Mithril Spear"),
	inventory_image = "lottweapons_mithril_spear.png",
	wield_image = "lottweapons_mithril_spear.png^[transformFX",
	range = 7,
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.00, [2]=1.00, [3]=0.20}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=8},
	}
})

--Daggers:
minetest.register_tool("lottweapons:wood_dagger", {
	description = S("Training Dagger"),
	inventory_image = "lottweapons_wood_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=2.25, [3]=1.75}, uses=2, maxlevel=1},
		},
		damage_groups = {fleshy=.10},
	}
})

minetest.register_tool("lottweapons:stone_dagger", {
	description = S("Stone Dagger"),
	inventory_image = "lottweapons_stone_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.35, [3]=0.85}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=.90},
	}
})

minetest.register_tool("lottweapons:copper_dagger", {
	description = S("Copper Dagger"),
	inventory_image = "lottweapons_copper_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.25, [3]=0.75}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2.5},
	}
})

minetest.register_tool("lottweapons:tin_dagger", {
	description = S("Tin Dagger"),
	inventory_image = "lottweapons_tin_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.25, [3]=0.75}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2.5},
	}
})

minetest.register_tool("lottweapons:steel_dagger", {
	description = S("Steel Dagger"),
	inventory_image = "lottweapons_steel_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.00, [3]=0.50}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	}
})

minetest.register_tool("lottweapons:bronze_dagger", {
	description = S("Bronze Dagger"),
	inventory_image = "lottweapons_bronze_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.00, [3]=0.50}, uses=15, maxlevel=1},
		},
		damage_groups = {fleshy=4.5},
	}
})

minetest.register_tool("lottweapons:silver_dagger", {
	description = S("Silver Dagger"),
	inventory_image = "lottweapons_silver_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=.80, [3]=0.40}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	}
})

minetest.register_tool("lottweapons:gold_dagger", {
	description = S("Gold Dagger"),
	inventory_image = "lottweapons_gold_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = .6,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=.80, [3]=0.40}, uses=15, maxlevel=1},
		},
		damage_groups = {fleshy=5},
	}
})

minetest.register_tool("lottweapons:galvorn_dagger", {
	description = S("Galvorn Dagger"),
	inventory_image = "lottweapons_galvorn_dagger.png",
	range = 3,
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = .5,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=.90, [3]=0.45}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=5.5},
	}
})

minetest.register_tool("lottweapons:mithril_dagger", {
	description = S("Mithril Dagger"),
	inventory_image = "lottweapons_mithril_dagger.png",
	range = 3,
	tool_capabilities = {
		full_punch_interval = .25,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=.75, [3]=0.35}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=6.5},
	}
})
