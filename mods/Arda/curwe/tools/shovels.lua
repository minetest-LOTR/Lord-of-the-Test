minetest.register_tool("curwe:coppershovel", {
	description = "Copper Shovel",
	inventory_image = "curwe_coppershovel.png",
	wield_image = "curwe_coppershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("curwe:tinshovel", {
	description = "Tin Shovel",
	inventory_image = "curwe_tinshovel.png",
	wield_image = "curwe_tinshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("curwe:silvershovel", {
	description = "Silver Shovel",
	inventory_image = "curwe_silvershovel.png",
	wield_image = "curwe_silvershovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("curwe:goldshovel", {
	description = "Gold Shovel",
	inventory_image = "curwe_goldshovel.png",
	wield_image = "curwe_goldshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("curwe:galvornshovel", {
	description = "Galvorn Shovel",
	inventory_image = "curwe_galvornshovel.png",
	wield_image = "curwe_galvornshovel.png^[transformR90",
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
minetest.register_tool("curwe:mithrilshovel", {
	description = "Mithril Shovel",
	inventory_image = "curwe_mithrilshovel.png",
	wield_image = "curwe_mithrilshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.20}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})