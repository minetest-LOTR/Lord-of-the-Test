
minetest.register_craft({
	output = 'lottores:tilkal',
	recipe = {
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:tilkal_ingot 9',
	recipe = {
		{'lottores:tilkal'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'lottores:tilkal_ingot',
	recipe = {
		'default:copper_ingot', 'lottores:silver_ingot', 'lottores:tin_ingot',
		'lottores:lead_ingot', 'default:steel_ingot', 'default:gold_ingot',
	}
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:marble",
	recipe = "lottores:limestone",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "lottores:geodes_crystal_1",
	recipe = "lottores:rough_rock_lump",
})

minetest.register_craft({
	output = 'lottores:silver_block',
	recipe = {
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:silver_ingot 9',
	recipe = {
		{'lottores:silver_block'},
	}
})

minetest.register_craft({
	output = 'lottores:tin_block',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:tin_ingot 9',
	recipe = {
		{'lottores:tin_block'},
	}
})

minetest.register_craft({
	output = 'lottores:lead_block',
	recipe = {
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:lead_ingot 9',
	recipe = {
		{'lottores:lead_block'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:mithril_ingot",
	recipe = "lottores:mithril_lump",
	time = 100,
})

minetest.register_craft({
	output = 'lottores:mithril_block',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:mithril_ingot 9',
	recipe = {
		{'lottores:mithril_block'},
	}
})

minetest.register_craft({
	output = 'lottores:galvorn_block',
	recipe = {
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:galvorn_ingot 9',
	recipe = {
		{'lottores:galvorn_block'},
	}
})

minetest.register_craft({
	output = 'lottores:tinaxe',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:silver_ingot",
	recipe = "lottores:silver_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:tin_ingot",
	recipe = "lottores:tin_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:lead_ingot",
	recipe = "lottores:lead_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:orc_steel_ingot",
	recipe = "lottores:orc_lump",
})

minetest.register_craft( {
	output = 'lottores:pearl_block',
	recipe = {
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
	}
})

minetest.register_craft({
	output = 'lottores:salt_block',
	recipe = {
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
	}
})

minetest.register_craft({
	output = 'lottores:salt 9',
	recipe = {
		{'lottores:salt_block'},
	}
})

minetest.register_craft({
	output = 'lottores:pearl_block',
	recipe = {
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
	}
})

minetest.register_craft({
	output = 'lottores:pearl 9',
	recipe = {
		{'lottores:pearl_block'},
	}
})

local materials = {
	{"copper", "default:copper_ingot"},
	{"tin", "lottores:tin_ingot"},
	{"silver", "lottores:silver_ingot"},
	{"gold", "default:gold_ingot"},
	{"galvorn", "lottores:galvorn_ingot"},
	{"mithril", "lottores:mithril_ingot"},
}

for i in ipairs(materials) do
	local name = materials[i][1]
	local craft = materials[i][2]
	
	minetest.register_craft({
		output = 'lottores:'..name..'pick',
		recipe = {
			{craft, craft, craft},
			{'', 'group:stick', ''},
			{'', 'group:stick', ''},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = craft,
		recipe = "lottores:"..name.."pick",
	})
	
	minetest.register_craft({
		output = 'lottores:'..name..'axe',
		recipe = {
			{craft, craft},
			{craft, 'group:stick'},
			{'', 'group:stick'},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = craft,
		recipe = "lottores:"..name.."axe",
	})

	minetest.register_craft({
		output = 'lottores:'..name..'sword',
		recipe = {
			{craft},
			{craft},
			{'group:stick'},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		cooktime = 30,
		output = craft,
		recipe = "lottores:"..name.."sword",
	})
	
	minetest.register_craft({
		output = 'lottores:'..name..'shovel',
		recipe = {
			{craft},
			{'group:stick'},
			{'group:stick'},
		}
	})
end