local materials = {
	{"wood", "group:wood"},
	{"stone", "group:stone", "default:stone"},
	{"copper", "default:copper_ingot"},
	{"tin", "lottores:tin_ingot"},
	{"steel", "default:steel_ingot"},
	{"bronze", "default:bronze_ingot"},
	{"silver", "lottores:silver_ingot"},
	{"gold", "default:gold_ingot"},
	{"galvorn", "lottores:galvorn_ingot"},
	{"mithril", "lottores:mithril_ingot"},
}

for i in ipairs(materials) do
	local name = materials[i][1]
	local craft = materials[i][2]
	local subcraft = materials[i][3] or craft

	minetest.register_craft({
		output = 'lottweapons:'..name..'_battleaxe',
		recipe = {
			{craft, 'group:stick', craft},
			{craft, 'group:stick', craft},
			{'', 'group:stick', ''},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = subcraft.." 2",
		recipe = "lottweapons:"..name.."_battleaxe",
	})
	
	minetest.register_craft({
		output = 'lottweapons:'..name..'_warhammer',
		recipe = {
			{craft, craft, craft},
			{craft, 'group:stick', craft},
			{'', 'group:stick', ''},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = subcraft.." 3",
		recipe = "lottweapons:"..name.."_warhammer",
	})

	minetest.register_craft({
		output = 'lottweapons:'..name..'_spear',
		recipe = {
			{'', craft, ''},
			{craft, 'group:stick', craft},
			{'', 'group:stick', ''},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = subcraft,
		recipe = "lottweapons:"..name.."_spear",
	})

	minetest.register_craft({
		output = 'lottweapons:'..name..'_dagger',
		recipe = {
			{craft},
			{'group:stick'},
		}
	})
end

minetest.register_craft({
	output = 'lottweapons:elven_sword',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot'},
		{'default:mese_crystal', 'group:stick', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "default:mese_crystal",
	recipe = "lottweapons:elven_sword",
})

minetest.register_craft({
	output = 'lottweapons:orc_sword',
	recipe = {
		{'', 'lottores:orc_steel_ingot', 'lottores:orc_steel_ingot'},
		{'', 'lottores:orc_steel_ingot', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "lottores:orc_steel_ingot",
	recipe = "lottweapons:orc_sword",
})