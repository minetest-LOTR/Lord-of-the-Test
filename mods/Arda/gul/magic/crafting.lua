-- Elven Rings
minetest.register_craft({
	type = "shapeless",
	output = "gul:ringsilver_lump",
	recipe = {"cemen:mithril_lump", "default:gold_lump", "cemen:silver_lump", "cemen:silver_lump"},
})
minetest.register_craft({
	type = "cooking",
	output = "gul:ringsilver_ingot",
	recipe = "gul:ringsilver_lump",
	cooktime = 35,
})
minetest.register_craft({
	output = "gul:ring",
	recipe = {
	{"gul:ringsilver_ingot", "gul:ringsilver_ingot", "gul:ringsilver_ingot"},
	{"gul:ringsilver_ingot", "", "gul:ringsilver_ingot"},
	{"gul:ringsilver_ingot", "gul:ringsilver_ingot", "gul:ringsilver_ingot"},
	},
})
minetest.register_craft({
	type = "shapeless",
	output = "gul:purple_gem",
	recipe = {"cemen:blue_gem", "cemen:red_gem"},
})

minetest.register_craft({
	output = "gul:blue_gem_ring",
	recipe = {
	{"cemen:blue_gem"},
	{"gul:ring"},
	},
})
minetest.register_craft({
	output = "gul:blue_am_ring",
	recipe = {
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "gul:blue_gem_ring", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "gul:vilya",
	recipe = "gul:blue_am_ring",
	cooktime = 1000,
})

minetest.register_craft({
	output = "gul:red_gem_ring",
	recipe = {
	{"cemen:red_gem"},
	{"gul:ring"},
	},
})
minetest.register_craft({
	output = "gul:red_am_ring",
	recipe = {
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "gul:red_gem_ring", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "gul:narya",
	recipe = "gul:red_am_ring",
	cooktime = 1000,
})

minetest.register_craft({
	output = "gul:white_gem_ring",
	recipe = {
	{"cemen:white_gem"},
	{"gul:ring"},
	},
})
minetest.register_craft({
	output = "gul:white_am_ring",
	recipe = {
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "gul:white_gem_ring", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "gul:nenya",
	recipe = "gul:white_am_ring",
	cooktime = 1000,
})

--Dwarven Ring
minetest.register_craft({
	output = "gul:purple_gem_ring",
	recipe = {
	{"gul:purple_gem"},
	{"gul:ring"},
	},
})
minetest.register_craft({
	output = "gul:purple_gem_mithril_ring",
	recipe = {
	{"cemen:mithril_ingot", "cemen:mithril_ingot", "cemen:mithril_ingot"},
	{"cemen:mithril_ingot", "gul:purple_gem_ring", "cemen:mithril_ingot"},
	{"cemen:mithril_ingot", "cemen:mithril_ingot", "cemen:mithril_ingot"},
	},
})
minetest.register_craft({
	output = "gul:purple_am_ring",
	recipe = {
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "gul:purple_gem_mithril_ring", "cemen:rough_rock_lump"},
	{"cemen:rough_rock_lump", "cemen:rough_rock_lump", "cemen:rough_rock_lump"},
	},
})
minetest.register_craft({
	type = "cooking",
	output = "gul:dwarf_ring",
	recipe = "gul:purple_am_ring",
	cooktime = 1000,
})

--Dwarf ring crafts...
minetest.register_craft({
	type = "shapeless",
	output = "cemen:limestone_lump 2",
	recipe = {"cemen:limestone_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "cemen:silver_lump 2",
	recipe = {"cemen:silver_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "cemen:tin_lump 2",
	recipe = {"cemen:tin_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "cemen:lead_lump 2",
	recipe = {"cemen:lead_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:coal_lump 2",
	recipe = {"default:coal_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:iron_lump 2",
	recipe = {"default:iron_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:copper_lump 2",
	recipe = {"default:copper_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:gold_lump 2",
	recipe = {"default:gold_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})
minetest.register_craft({
	type = "shapeless",
	output = "cemen:rough_rock_lump 2",
	recipe = {"cemen:rough_rock_lump", "gul:dwarf_ring"},
	replacements = {{ "gul:dwarf_ring", "gul:dwarf_ring"}},
})