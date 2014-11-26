minetest.register_tool("curwe:wood_warhammer", {
	description = "Training Warhammer",
	inventory_image = "curwe_wood_warhammer.png",
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

minetest.register_tool("curwe:stone_warhammer", {
	description = "Stone Warhammer",
	inventory_image = "curwe_stone_warhammer.png",
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

minetest.register_tool("curwe:copper_warhammer", {
	description = "Copper Warhammer",
	inventory_image = "curwe_copper_warhammer.png",
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

minetest.register_tool("curwe:tin_warhammer", {
	description = "Tin Warhammer",
	inventory_image = "curwe_tin_warhammer.png",
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

minetest.register_tool("curwe:steel_warhammer", {
	description = "Steel Warhammer",
	inventory_image = "curwe_steel_warhammer.png",
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

minetest.register_tool("curwe:bronze_warhammer", {
	description = "Bronze Warhammer",
	inventory_image = "curwe_bronze_warhammer.png",
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

minetest.register_tool("curwe:silver_warhammer", {
	description = "Silver Warhammer",
	inventory_image = "curwe_silver_warhammer.png",
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

minetest.register_tool("curwe:gold_warhammer", {
	description = "Gold Warhammer",
	inventory_image = "curwe_gold_warhammer.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.60, [2]=1.40, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7.5},
	},
})

minetest.register_tool("curwe:galvorn_warhammer", {
	description = "Galvorn Warhammer",
	inventory_image = "curwe_galvorn_warhammer.png",
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

minetest.register_tool("curwe:mithril_warhammer", {
	description = "Mithril Warhammer",
	inventory_image = "curwe_mithril_warhammer.png",
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