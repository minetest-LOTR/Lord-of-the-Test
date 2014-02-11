--Weapons!
minetest.register_tool("lottweapons:steel_battleaxe", {
	description = "Steel Battleaxe",
	inventory_image = "steel_battleaxe_invit.png",
	tool_capabilities = {
		full_punch_interval = 1.25,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3, [2]=1.90, [3]=1.50}, uses=20, maxlevel=2},
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_tool("lottweapons:steel_warhammer", {
	description = "Steel War Hammer",
	inventory_image = "steel_warhammer.png",
	tool_capabilities = {
		full_punch_interval = 1.50,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.45, [3]=0.60}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_tool("lottweapons:steel_spear", {
	description = "Steel Spear",
	inventory_image = "stonespear.png",
	wield_image = "stonespear.png^[transformFX",
	tool_capabilities = {
		full_punch_interval = 1.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.4, [2]=1.4, [3]=0.40}, uses=15, maxlevel=1},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("lottweapons:steel_dagger", {
	description = "Steel Dagger",
	inventory_image = "steel_dagger.png",
	tool_capabilities = {
		full_punch_interval = .5,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=.75, [3]=0.25}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	}
})

minetest.register_tool("lottweapons:elven_sword", {
	description = "Elven Sword",
	inventory_image = "elven_sword.png",
	tool_capabilities = {
		full_punch_interval = .90,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.30, [3]=0.90}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=6.5},
	}
})

--And the crafts...
minetest.register_craft({
	output = 'lottweapons:steel_battleaxe',
	recipe = {
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
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
	output = 'lottweapons:steel_spear',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'group:stick', ''},
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
	output = 'lottweapons:elven_sword',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot'},
		{'default:diamond', 'group:stick', 'default:diamond'},
	}
})
