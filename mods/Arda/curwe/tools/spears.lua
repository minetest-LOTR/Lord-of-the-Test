minetest.register_tool("curwe:wood_spear", {
	description = "Training Spear",
	inventory_image = "curwe_wood_spear.png",
	wield_image = "curwe_wood_spear.png^[transformFX",
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

minetest.register_tool("curwe:stone_spear", {
	description = "Stone Spear",
	inventory_image = "curwe_stone_spear.png",
	wield_image = "curwe_stone_spear.png^[transformFX",
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

minetest.register_tool("curwe:copper_spear", {
	description = "Copper Spear",
	inventory_image = "curwe_copper_spear.png",
	wield_image = "curwe_copper_spear.png^[transformFX",
	tool_capabilities = {
		full_punch_interval = 1.30,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.70, [2]=1.70, [3]=0.70}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	}
})

minetest.register_tool("curwe:tin_spear", {
	description = "Tin Spear",
	inventory_image = "curwe_tin_spear.png",
	wield_image = "curwe_tin_spear.png^[transformFX",
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

minetest.register_tool("curwe:steel_spear", {
	description = "Steel Spear",
	inventory_image = "curwe_steel_spear.png",
	wield_image = "curwe_steel_spear.png^[transformFX",
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

minetest.register_tool("curwe:bronze_spear", {
	description = "Bronze Spear",
	inventory_image = "curwe_bronze_spear.png",
	wield_image = "curwe_bronze_spear.png^[transformFX",
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

minetest.register_tool("curwe:silver_spear", {
	description = "Silver Spear",
	inventory_image = "curwe_silver_spear.png",
	wield_image = "curwe_silver_spear.png^[transformFX",
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

minetest.register_tool("curwe:gold_spear", {
	description = "Gold Spear",
	inventory_image = "curwe_gold_spear.png",
	wield_image = "curwe_gold_spear.png^[transformFX",
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

minetest.register_tool("curwe:galvorn_spear", {
	description = "Galvorn Spear",
	inventory_image = "curwe_galvorn_spear.png",
	wield_image = "curwe_galvorn_spear.png^[transformFX",
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

minetest.register_tool("curwe:mithril_spear", {
	description = "Mithril Spear",
	inventory_image = "curwe_mithril_spear.png",
	wield_image = "curwe_mithril_spear.png^[transformFX",
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