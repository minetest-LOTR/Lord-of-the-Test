minetest.register_tool("curwe:coppersword", {
	description = "Copper Sword",
	inventory_image = "curwe_coppersword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("curwe:tinsword", {
	description = "Tin Sword",
	inventory_image = "curwe_tinsword.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("curwe:silversword", {
	description = "Silver Sword",
	inventory_image = "curwe_silversword.png",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("curwe:goldsword", {
	description = "Gold Sword",
	inventory_image = "curwe_goldsword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.3, [2]=1.10, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool("curwe:galvornsword", {
	description = "Galvorn Sword",
	inventory_image = "curwe_galvornsword.png",
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
minetest.register_tool("curwe:mithrilsword", {
	description = "Mithril Sword",
	inventory_image = "curwe_mithrilsword.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=0.70, [2]=0.80, [3]=0.25}, uses=80, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})

--Special Swords

minetest.register_tool("curwe:elven_sword", {
	description = "Elven Sword",
	inventory_image = "curwe_elven_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=7.5},
	}
})

minetest.register_tool("curwe:orc_sword", {
	description = "Orcish Sword",
	inventory_image = "curwe_orc_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=2.25, [2]=1.80, [3]=1.30}, uses=17, maxlevel=3},
		},
		damage_groups = {fleshy=6.5},
	}
})