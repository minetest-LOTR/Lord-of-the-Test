--Weapons!

-- Battle axes:
minetest.register_tool("lottweapons:wood_battleaxe", {
	description = "Training Battleaxe",
	inventory_image = "lott_wood_battleaxe.png",
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
	description = "Stone Battleaxe",
	inventory_image = "lott_stone_battleaxe.png",
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
	description = "Copper Battleaxe",
	inventory_image = "lott_copper_battleaxe.png",
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
	description = "Tin Battleaxe",
	inventory_image = "lott_tin_battleaxe.png",
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
	description = "Steel Battleaxe",
	inventory_image = "lott_steel_battleaxe.png",
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
	description = "Bronze Battleaxe",
	inventory_image = "lott_bronze_battleaxe.png",
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
	description = "Silver Battleaxe",
	inventory_image = "lott_silver_battleaxe.png",
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
	description = "Gold Battleaxe",
	inventory_image = "lott_gold_battleaxe.png",
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
	description = "Galvorn Battleaxe",
	inventory_image = "lott_galvorn_battleaxe.png",
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
	description = "Mithril Battleaxe",
	inventory_image = "lott_mithril_battleaxe.png",
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
	description = "Training Warhammer",
	inventory_image = "lott_wood_warhammer.png",
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
	description = "Stone Warhammer",
	inventory_image = "lott_stone_warhammer.png",
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
	description = "Copper Warhammer",
	inventory_image = "lott_copper_warhammer.png",
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
	description = "Tin Warhammer",
	inventory_image = "lott_tin_warhammer.png",
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
	description = "Steel Warhammer",
	inventory_image = "lott_steel_warhammer.png",
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
	description = "Bronze Warhammer",
	inventory_image = "lott_bronze_warhammer.png",
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
	description = "Silver Warhammer",
	inventory_image = "lott_silver_warhammer.png",
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
	description = "Gold Warhammer",
	inventory_image = "lott_gold_warhammer.png",
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
	description = "Galvorn Warhammer",
	inventory_image = "lott_galvorn_warhammer.png",
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
	description = "Mithril Warhammer",
	inventory_image = "lott_mithril_warhammer.png",
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
	description = "Training Spear",
	inventory_image = "lott_wood_spear.png",
	wield_image = "lott_wood_spear.png^[transformFX",
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
	description = "Stone Spear",
	inventory_image = "lott_stone_spear.png",
	wield_image = "lott_stone_spear.png^[transformFX",
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
	description = "Copper Spear",
	inventory_image = "lott_copper_spear.png",
	wield_image = "lott_copper_spear.png^[transformFX",
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
	description = "Tin Spear",
	inventory_image = "lott_tin_spear.png",
	wield_image = "lott_tin_spear.png^[transformFX",
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
	description = "Steel Spear",
	inventory_image = "lott_steel_spear.png",
	wield_image = "lott_steel_spear.png^[transformFX",
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
	description = "Bronze Spear",
	inventory_image = "lott_bronze_spear.png",
	wield_image = "lott_bronze_spear.png^[transformFX",
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
	description = "Silver Spear",
	inventory_image = "lott_silver_spear.png",
	wield_image = "lott_silver_spear.png^[transformFX",
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
	description = "Gold Spear",
	inventory_image = "lott_gold_spear.png",
	wield_image = "lott_gold_spear.png^[transformFX",
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
	description = "Galvorn Spear",
	inventory_image = "lott_galvorn_spear.png",
	wield_image = "lott_galvorn_spear.png^[transformFX",
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
	description = "Mithril Spear",
	inventory_image = "lott_mithril_spear.png",
	wield_image = "lott_mithril_spear.png^[transformFX",
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
	description = "Training Dagger",
	inventory_image = "lott_wood_dagger.png",
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
	description = "Stone Dagger",
	inventory_image = "lott_stone_dagger.png",
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
	description = "Copper Dagger",
	inventory_image = "lott_copper_dagger.png",
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
	description = "Tin Dagger",
	inventory_image = "lott_tin_dagger.png",
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
	description = "Steel Dagger",
	inventory_image = "lott_steel_dagger.png",
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
	description = "Bronze Dagger",
	inventory_image = "lott_bronze_dagger.png",
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
	description = "Silver Dagger",
	inventory_image = "lott_silver_dagger.png",
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
	description = "Gold Dagger",
	inventory_image = "lott_gold_dagger.png",
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
	description = "Galvorn Dagger",
	inventory_image = "lott_galvorn_dagger.png",
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
	description = "Mithril Dagger",
	inventory_image = "lott_mithril_dagger.png",
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

-- Special weapons

minetest.register_tool("lottweapons:elven_sword", {
	description = "Elven Sword",
	inventory_image = "lott_elven_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=7.5},
	}
})

minetest.register_tool("lottweapons:orc_sword", {
	description = "Orcish Sword",
	inventory_image = "lott_orc_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=2.25, [2]=1.80, [3]=1.30}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=6.5},
	}
})
--And the crafts...
minetest.register_craft({
	output = 'lottweapons:wood_battleaxe',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:stone_battleaxe',
	recipe = {
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:copper_battleaxe',
	recipe = {
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:tin_battleaxe',
	recipe = {
		{'lottores:tin_ingot', 'group:stick', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'group:stick', 'lottores:tin_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:steel_battleaxe',
	recipe = {
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:bronze_battleaxe',
	recipe = {
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:silver_battleaxe',
	recipe = {
		{'lottores:silver_ingot', 'group:stick', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'group:stick', 'lottores:silver_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:gold_battleaxe',
	recipe = {
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:galvorn_battleaxe',
	recipe = {
		{'lottores:galvorn_ingot', 'group:stick', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'group:stick', 'lottores:galvorn_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:mithril_battleaxe',
	recipe = {
		{'lottores:mithril_ingot', 'group:stick', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'group:stick', 'lottores:mithril_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:wood_warhammer',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:stone_warhammer',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:copper_warhammer',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:tin_warhammer',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'group:stick', 'lottores:tin_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:steel_warhammer',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:bronze_warhammer',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:silver_warhammer',
	recipe = {
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'group:stick', 'lottores:silver_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:gold_warhammer',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:galvorn_warhammer',
	recipe = {
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'group:stick', 'lottores:galvorn_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:mithril_warhammer',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'group:stick', 'lottores:mithril_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:wood_spear',
	recipe = {
		{'', 'group:wood', ''},
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:stone_spear',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'group:stick', 'default:cobble'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:copper_spear',
	recipe = {
		{'', 'default:copper_ingot', ''},
		{'default:copper_ingot', 'group:stick', 'default:copper_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:tin_spear',
	recipe = {
		{'', 'lottores:tin_ingot', ''},
		{'lottores:tin_ingot', 'group:stick', 'lottores:tin_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:steel_spear',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:bronze_spear',
	recipe = {
		{'', 'default:bronze_ingot', ''},
		{'default:bronze_ingot', 'group:stick', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:gold_spear',
	recipe = {
		{'', 'default:gold_ingot', ''},
		{'default:gold_ingot', 'group:stick', 'default:gold_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:silver_spear',
	recipe = {
		{'', 'lottores:silver_ingot', ''},
		{'lottores:silver_ingot', 'group:stick', 'lottores:silver_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:galvorn_spear',
	recipe = {
		{'', 'lottores:galvorn_ingot', ''},
		{'lottores:galvorn_ingot', 'group:stick', 'lottores:galvorn_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:mithril_spear',
	recipe = {
		{'', 'lottores:mithril_ingot', ''},
		{'lottores:mithril_ingot', 'group:stick', 'lottores:mithril_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'lottweapons:wood_dagger',
	recipe = {
		{'group:wood'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:stone_dagger',
	recipe = {
		{'default:cobble'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:copper_dagger',
	recipe = {
		{'default:copper_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:tin_dagger',
	recipe = {
		{'lottores:tin_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:steel_dagger',
	recipe = {
		{'default:steel_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:bronze_dagger',
	recipe = {
		{'default:bronze_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:silver_dagger',
	recipe = {
		{'lottores:silver_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:gold_dagger',
	recipe = {
		{'default:gold_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:galvorn_dagger',
	recipe = {
		{'lottores:galvorn_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'lottweapons:mithril_dagger',
	recipe = {
		{'lottores:mithril_ingot'},
		{'group:stick'},
	}
})


minetest.register_craft({
	output = 'lottweapons:elven_sword',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot'},
		{'default:mese_crystal', 'group:stick', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'lottweapons:orc_sword',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'', 'group:stick', ''},
	}
})
