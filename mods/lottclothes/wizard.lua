-- Clothes made for wizards


-- gandalf the grey:
-- big black dwarf boots
minetest.register_tool("lottclothes:boots_dwarf", {
	description = "Dwarven Boots",
	inventory_image = "lottclothes_inv_boots_dwarf.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_feet=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:boots_dwarf",
	recipe = {
		{"lottclothes:felt_black", "", "lottclothes:felt_black"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

-- cloak
minetest.register_tool("lottclothes:cloak_wizard_grey", {
	description = "Grey Wizard Cloak",
	inventory_image = "lottclothes_inv_cloak_wizard_grey.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_cloak=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:cloak_wizard_grey",
	recipe = {
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"}
	}
})

-- hood
minetest.register_tool("lottclothes:hood_wizard_blue", {
	description = "Blue Wizard Hood",
	inventory_image = "lottclothes_inv_hood_wizard_blue.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_head=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:hood_wizard_blue",
	recipe = {
		{"lottclothes:felt_blue", "lottclothes:felt_blue", "lottclothes:felt_blue"},
		{"lottclothes:felt_blue", "", "lottclothes:felt_blue"}
	}
})

-- robe
minetest.register_tool("lottclothes:robe_wizard_grey", {
	description = "Grey Wizard Robe",
	inventory_image = "lottclothes_inv_robe_wizard_grey.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_torso=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:robe_wizard_grey",
	recipe = {
		{"lottclothes:felt_grey", "", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"}
	}
})








-- gandalf the white
-- hood
minetest.register_tool("lottclothes:hood_wizard_white", {
	description = "White Wizard Hood",
	inventory_image = "lottclothes_inv_hood_wizard_white.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_head=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:hood_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "", "lottclothes:felt_white"}
	}
})

-- robe
minetest.register_tool("lottclothes:robe_wizard_white", {
	description = "White Wizard Robe",
	inventory_image = "lottclothes_inv_robe_wizard_white.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_torso=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:robe_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"}
	}
})

-- trousers
minetest.register_tool("lottclothes:trousers_wizard_white", {
	description = "White Wizard Trousers",
	inventory_image = "lottclothes_inv_trousers_wizard_white.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_legs=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:trousers_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "", "lottclothes:felt_white"}
	}
})

-- cloak
minetest.register_tool("lottclothes:cloak_wizard_white", {
	description = "White Wizard Cloak",
	inventory_image = "lottclothes_inv_cloak_wizard_white.png",
	groups = {armor_heal=0, clothes=1, no_preview=1, clothes_cloak=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:cloak_wizard_white",
	recipe = {
		{"lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white"},
		{"lottclothes:felt_white", "lottclothes:felt_white"}
	}
})
