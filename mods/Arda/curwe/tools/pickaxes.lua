minetest.register_tool("curwe:copperpick", {
	description = "Copper Pickaxe",
	inventory_image = "curwe_copperpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:tinpick", {
	description = "Tin Pickaxe",
	inventory_image = "curwe_tinpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:silverpick", {
	description = "Silver Pickaxe",
	inventory_image = "curwe_silverpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:goldpick", {
	description = "Gold Pickaxe",
	inventory_image = "curwe_goldpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:galvornpick", {
	description = "Galvorn Pickaxe",
	inventory_image = "curwe_galvornpick.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})
minetest.register_tool("curwe:mithrilpick", {
	description = "Mithril Pickaxe",
	inventory_image = "curwe_mithrilpick.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.5, [2]=0.8, [3]=0.40}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})