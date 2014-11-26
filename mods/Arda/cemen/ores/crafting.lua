minetest.register_craft({
	output = 'cemen:galvorn_ingot',
	recipe = {
		{'cemen:lead_ingot', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'cemen:tilkal',
	recipe = {
		{'cemen:tilkal_ingot', 'cemen:tilkal_ingot', 'cemen:tilkal_ingot'},
		{'cemen:tilkal_ingot', 'cemen:tilkal_ingot', 'cemen:tilkal_ingot'},
		{'cemen:tilkal_ingot', 'cemen:tilkal_ingot', 'cemen:tilkal_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:tilkal_ingot 9',
	recipe = {
		{'cemen:tilkal'},
	}
})

minetest.register_craft({
	output = 'cemen:tilkal_ingot',
	recipe = {
		{'default:copper_ingot', 'cemen:silver_ingot', 'cemen:tin_ingot'},
		{'cemen:lead_ingot', 'default:steel_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:limestone',
	recipe = {
		{'cemen:limestone_lump', 'cemen:limestone_lump', 'cemen:limestone_lump'},
		{'cemen:limestone_lump', 'cemen:limestone_lump', 'cemen:limestone_lump'},
		{'cemen:limestone_lump', 'cemen:limestone_lump', 'cemen:limestone_lump'},
	}
})

minetest.register_craft({
	output = 'cemen:limestone_lump 9',
	recipe = {
		{'cemen:limestone'},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "cemen:marble",
	recipe = "cemen:limestone",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:geodes_crystal_1",
	recipe = "cemen:rough_rock_lump",
})

minetest.register_craft({
	output = 'cemen:silver_block',
	recipe = {
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
		{'cemen:silver_ingot', 'cemen:silver_ingot', 'cemen:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:silver_ingot 9',
	recipe = {
		{'cemen:silver_block'},
	}
})

minetest.register_craft({
	output = 'cemen:tin_block',
	recipe = {
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
		{'cemen:tin_ingot', 'cemen:tin_ingot', 'cemen:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:tin_ingot 9',
	recipe = {
		{'cemen:tin_block'},
	}
})

minetest.register_craft({
	output = 'cemen:lead_block',
	recipe = {
		{'cemen:lead_ingot', 'cemen:lead_ingot', 'cemen:lead_ingot'},
		{'cemen:lead_ingot', 'cemen:lead_ingot', 'cemen:lead_ingot'},
		{'cemen:lead_ingot', 'cemen:lead_ingot', 'cemen:lead_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:lead_ingot 9',
	recipe = {
		{'cemen:lead_block'},
	}
})

minetest.register_craft({
	output = 'cemen:mithril_block',
	recipe = {
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
		{'cemen:mithril_ingot', 'cemen:mithril_ingot', 'cemen:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:mithril_ingot 9',
	recipe = {
		{'cemen:mithril_block'},
	}
})

minetest.register_craft({
	output = 'cemen:galvorn_block',
	recipe = {
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
		{'cemen:galvorn_ingot', 'cemen:galvorn_ingot', 'cemen:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'cemen:galvorn_ingot 9',
	recipe = {
		{'cemen:galvorn_block'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:silver_ingot",
	recipe = "cemen:silver_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:tin_ingot",
	recipe = "cemen:tin_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:lead_ingot",
	recipe = "cemen:lead_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "cemen:mithril_ingot",
	recipe = "cemen:mithril_lump",
})

minetest.register_craft( {
	output = 'cemen:pearl_block',
	recipe = {
		{ 'craft "cemen:pearl"', 'craft "cemen:pearl"', 'craft "cemen:pearl"' },
		{ 'craft "cemen:pearl"', 'craft "cemen:pearl"', 'craft "cemen:pearl"' },
		{ 'craft "cemen:pearl"', 'craft "cemen:pearl"', 'craft "cemen:pearl"' },
	}
})

minetest.register_craft({
	output = 'cemen:salt_block',
	recipe = {
		{'cemen:salt', 'cemen:salt', 'cemen:salt'},
		{'cemen:salt', 'cemen:salt', 'cemen:salt'},
		{'cemen:salt', 'cemen:salt', 'cemen:salt'},
	}
})

minetest.register_craft({
	output = 'cemen:salt 9',
	recipe = {
		{'cemen:salt_block'},
	}
})

minetest.register_craft({
	output = 'cemen:pearl_block',
	recipe = {
		{'cemen:pearl', 'cemen:pearl', 'cemen:pearl'},
		{'cemen:pearl', 'cemen:pearl', 'cemen:pearl'},
		{'cemen:pearl', 'cemen:pearl', 'cemen:pearl'},
	}
})

minetest.register_craft({
	output = 'cemen:pearl 9',
	recipe = {
		{'cemen:pearl_block'},
	}
})