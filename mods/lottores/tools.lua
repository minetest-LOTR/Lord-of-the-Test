-- Pickaxe

minetest.register_tool("lottores:copperpick", {
	description = "Copper Pickaxe",
	inventory_image = "lottores_copperpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:tinpick", {
	description = "Tin Pickaxe",
	inventory_image = "lottores_tinpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:silverpick", {
	description = "Silver Pickaxe",
	inventory_image = "lottores_silverpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:goldpick", {
	description = "Gold Pickaxe",
	inventory_image = "lottores_goldpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.40, [3]=0.70}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:galvornpick", {
	description = "Galvorn Pickaxe",
	inventory_image = "lottores_galvornpick.png",
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

minetest.register_tool("lottores:mithrilpick", {
	description = "Mithril Pickaxe",
	inventory_image = "lottores_mithrilpick.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.5, [2]=0.8, [3]=0.40}, uses=60, maxlevel=3},
			very_hard = {times={[1]=3.5, [2]=1.5, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

-- Axe

minetest.register_tool("lottores:copperaxe", {
	description = "Copper Axe",
	inventory_image = "lottores_copperaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:tinaxe", {
	description = "Tin Axe",
	inventory_image = "lottores_tinaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:silveraxe", {
	description = "Silver Axe",
	inventory_image = "lottores_silveraxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:goldaxe", {
	description = "Gold Axe",
	inventory_image = "lottores_goldaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.20, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:galvornaxe", {
	description = "Galvorn Axe",
	inventory_image = "lottores_galvornaxe.png",
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

minetest.register_tool("lottores:mithrilaxe", {
	description = "Mithril Axe",
	inventory_image = "lottores_mithrilaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.80, [2]=0.60, [3]=0.30}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

-- Sword

minetest.register_tool("lottores:coppersword", {
	description = "Copper Sword",
	inventory_image = "lottores_coppersword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottores:tinsword", {
	description = "Tin Sword",
	inventory_image = "lottores_tinsword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottores:silversword", {
	description = "Silver Sword",
	inventory_image = "lottores_silversword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottores:goldsword", {
	description = "Gold Sword",
	inventory_image = "lottores_goldsword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottores:galvornsword", {
	description = "Galvorn Sword",
	inventory_image = "lottores_galvornsword.png",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})

minetest.register_tool("lottores:mithrilsword", {
	description = "Mithril Sword",
	inventory_image = "lottores_mithrilsword.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.70, [2]=0.80, [3]=0.25}, uses=80, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})

-- Shovel

minetest.register_tool("lottores:coppershovel", {
	description = "Copper Shovel",
	inventory_image = "lottores_coppershovel.png",
	wield_image = "lottores_coppershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottores:tinshovel", {
	description = "Tin Shovel",
	inventory_image = "lottores_tinshovel.png",
	wield_image = "lottores_tinshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottores:silvershovel", {
	description = "Silver Shovel",
	inventory_image = "lottores_silvershovel.png",
	wield_image = "lottores_silvershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottores:goldshovel", {
	description = "Gold Shovel",
	inventory_image = "lottores_goldshovel.png",
	wield_image = "lottores_goldshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("lottores:galvornshovel", {
	description = "Galvorn Shovel",
	inventory_image = "lottores_galvornshovel.png",
	wield_image = "lottores_galvornshovel.png^[transformR90",
     groups = {forbidden=1},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("lottores:mithrilshovel", {
	description = "Mithril Shovel",
	inventory_image = "lottores_mithrilshovel.png",
	wield_image = "lottores_mithrilshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.20}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})
