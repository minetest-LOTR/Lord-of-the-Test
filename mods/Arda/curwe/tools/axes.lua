minetest.register_tool("curwe:copperaxe", {
	description = "Copper Axe",
	inventory_image = "curwe_copperaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:tinaxe", {
	description = "Tin Axe",
	inventory_image = "curwe_tinaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:silveraxe", {
	description = "Silver Axe",
	inventory_image = "curwe_silveraxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:goldaxe", {
	description = "Gold Axe",
	inventory_image = "curwe_goldaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("curwe:galvornaxe", {
	description = "Galvorn Axe",
	inventory_image = "curwe_galvornaxe.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})
minetest.register_tool("curwe:mithrilaxe", {
	description = "Mithril Axe",
	inventory_image = "curwe_mithrilaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.80, [2]=0.60, [3]=0.30}, uses=60, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})